// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

interface TokenInterface{
    function mint (address account, uint256 amount) external; 
}

contract TokenShop {

    error PriceFeedDdosed();
    error InvalidRoundId();
    error StalePriceFeed();

    address owner;
    AggregatorV3Interface private immutable i_priceFeed;
    TokenInterface private immutable i_minter;
    uint256 private constant HEARTBEAT = 86400;
    uint256 tokenPrice = 200;

    constructor(address _priceFeed , address _minter){
        owner =  msg.sender;
        i_priceFeed = AggregatorV3Interface(_priceFeed);
        i_minter = TokenInterface(_minter);
    }

    receive() external payable {
        uint256 amount = calculateTokenAmount(msg.value);
        i_minter.mint(msg.sender,amount);   
     }

    function calculateTokenAmount(uint256 ethAmount)internal view returns (uint256) {
        
        uint256 price = getChainlinkDataFeedLatestAnswer() * 1e10;
        uint256 usdAmount = (ethAmount * price) / 1e18;
        uint256 amountToken = usdAmount / tokenPrice / 10**(8/2);  
        return amountToken;
    }

    function getChainlinkDataFeedLatestAnswer() public view returns (uint256) {
        uint80 _roundId;
        int256 _price;
        uint256 _updatedAt;
        try  i_priceFeed.latestRoundData() returns(
             uint80 roundId ,
            int256 price,
            uint256, /*startedAt*/
            uint256 updatedAt,
           uint80 /*answeredInRound*/
        ) {
            _roundId = roundId;
            _price =  price;
            _updatedAt  = updatedAt;
        } catch{
           revert PriceFeedDdosed();
        }
        if(_roundId == 0 ) revert InvalidRoundId();
        if(_updatedAt < block.timestamp - HEARTBEAT){
            revert StalePriceFeed();
        }

        return uint256(_price);

    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function withdraw() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    } 
}
 
