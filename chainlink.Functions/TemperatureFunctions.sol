// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

// Deploy on Fuji

import {FunctionsClient} from "@chainlink/contracts/src/v0.8/functions/dev/v1_0_0/FunctionsClient.sol";
import {FunctionsRequest} from "@chainlink/contracts/src/v0.8/functions/dev/v1_0_0/libraries/FunctionsRequest.sol";


contract TemperatureFunctions is FunctionsClient{
    using FunctionsRequest for FunctionsRequest.Request;

    bytes32 public s_lastRequestId;
    bytes public s_lastResponse;
    bytes public s_lastError;

    // Custom error type
    error UnexpectedRequestID(bytes32 requestId);

    // Event to log responses
    event Response(
        bytes32 indexed requestId,
        string temperature,
        bytes response,
        bytes err
    );

    address private constant ROUTER = 0xA9d587a00A31A52Ed70D6026794a8FC5E2F5dCb0;
    bytes32 private DONID = 0x66756e2d6176616c616e6368652d66756a692d31000000000000000000000000;
    uint32 GAS = 300000;

    uint64 public s_subscriptionId;

    string public source =
        "const city = args[0];"
        "const apiResponse = await Functions.makeHttpRequest({"
        "url: `https://wttr.in/${city}?format=3`,"
        "responseType: 'text'"
        "});"
        "if (apiResponse.error) {"
        "throw Error('Request failed');"
        "}"
        "const { data } = apiResponse;"
        "return Functions.encodeString(data);";

    string public lastCity;    
    string public lastTemperature;


    constructor(uint64 subcription)FunctionsClient(ROUTER){
        s_subscriptionId = subcription;
    }

    function getTemperature(
        string memory _city
    ) external returns (bytes32 requestId) {

        string[] memory args = new string[](1);
        args[0]=_city;

        FunctionsRequest.Request memory req;
        req.initializeRequestForInlineJavaScript(source);
        if(args.length > 0){
            req.setArgs(args);
        }

        s_lastRequestId = _sendRequest(
            req.encodeCBOR(),
            s_subscriptionId,
            GAS,
            DONID
        );
        lastCity=_city;

        return s_lastRequestId;
    }

    function fulfillRequest(
        bytes32 requestId,
        bytes memory response,
        bytes memory err
    ) internal override {
        if (s_lastRequestId != requestId) {
            revert UnexpectedRequestID(requestId); // Check if request IDs match
        }        
        s_lastError = err;

        // Update the contract's state variables with the response and any errors
        s_lastResponse = response;
        lastTemperature = string(response);

        // Emit an event to log the response
        emit Response(requestId, lastTemperature, s_lastResponse, s_lastError);
    }    
}