// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

// Deploy this contract on Fuji

import {IRouterClient} from "@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/IRouterClient.sol";
import {Client} from "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";
import {LinkTokenInterface} from "@chainlink/contracts/src/v0.8/interfaces/LinkTokenInterface.sol";

contract CrossSourceMinter{

    error balanceNotenugh();
    error NothingToWithdraw();

    event MessageSent(bytes32);

    IRouterClient private immutable i_router;
    LinkTokenInterface private immutable i_linkToken;
    uint64 destinationChainSelector;
    address public destinationMinter;
    address owner;

    constructor(address destMinterAddress){
        i_router = IRouterClient(0xF694E193200268f9a4868e4Aa017A0118C9a8177);
        i_linkToken = LinkTokenInterface(0x0b9d5D9136855f6FEc3c0993feE6E9CE8a297846);
        destinationChainSelector=16015286601757825753;
        destinationMinter = destMinterAddress;

        owner = msg.sender;
    }

    function mintSepolia() external returns(bytes32 messageId) {
        Client.EVM2AnyMessage memory message = Client.EVM2AnyMessage({

            receiver:abi.encode(destinationMinter),
            data : abi.encodeWithSignature("mintFrom(address,uint256)",msg.sender,1), 
            tokenAmounts: new Client.EVMTokenAmount[](0),
            extraArgs : Client._argsToBytes(
                Client.EVMExtraArgsV1({gasLimit: 980_000})
            ),
            feeToken:address(i_linkToken)
        });

        uint256 gasFee = i_router.getFee(destinationChainSelector, message);
        if(i_linkToken.balanceOf(address(this)) < gasFee){
            revert balanceNotenugh();
        }

        i_linkToken.approve(address(i_router), gasFee);

        messageId = i_router.ccipSend(destinationChainSelector, message);

        emit MessageSent(messageId);
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function linkBalance (address account) public view returns (uint256) {
        return i_linkToken.balanceOf(account);
    }

    function withdrawLINK(
        address beneficiary
    ) public onlyOwner {
        uint256 amount = i_linkToken.balanceOf(address(this));
        if (amount == 0) revert NothingToWithdraw();
        i_linkToken.transfer(beneficiary, amount);
    }
}  