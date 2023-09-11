
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

//Creat a contract
//Create a mapping betwen user and tweet
//add function to create tweet and save it in max

contract twitter{

    struct Tweet{
        uint256 id;
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }
    mapping(address=> Tweet[]) public tweets;

    uint56 public Max_tweet_length = 280;
    address public owner;

    constructor(){
        owner = msg.sender;

    }

    modifier onlyOwner(){
        require(msg.sender == owner,"You are not the owner");
        _;
    }


    function changeTweetlength(uint16 newTweetlength) public onlyOwner{
        Max_tweet_length = newTweetlength;
    }

    

    function CreateTweet(string memory _tweet) public {

        require(bytes(_tweet).length <= Max_tweet_length, "This tweet is too long bro!!");
        Tweet memory newTweet = Tweet({
            id: tweets[msg.sender].length,
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });
        tweets[msg.sender].push(newTweet);
    }

    function getTweet(uint i) public view returns (Tweet memory){
        return tweets[msg.sender][i];
    }

    function getAllTweets(address _owner) public view returns (Tweet[] memory ){
        return tweets[_owner];
    }

    function likeTweet(address author, uint256 id) external {
        require(tweets[author][id].id == id,"Not present");
        tweets[author][id].likes++;
    }

    function unlikeTweet(address author, uint256 id) external {
        require(tweets[author][id].id == id,"Not present");
        require(tweets[author][id].likes > 0,"there are no likes associated to this tweet");
        tweets[author][id].likes--;
    }
}