pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

/// @title Simple wallet
/// @author Tonlabs
contract Wallet {
    /*
     Exception codes:
      100 - message sender is not a wallet owner.
      101 - invalid transfer value.
     */

    /// @dev Contract constructor.
    constructor() public {
        // check that contract's public key is set
        require(tvm.pubkey() != 0, 101);
        // Check that message has signature (msg.pubkey() is not zero) and message is signed with the owner's private key
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }


   

    /// @dev Allows to transfer tons to the destination account.
    /// @param dest Transfer target address.
    /// @param value Nanotons value to transfer.
    /// @param bounce Flag that enables bounce message in case of target contract error.
    function sendTransaction(address dest, uint128 value, bool bounce) public view {
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        dest.transfer(value, bounce, 0);
    }

    function sendvalwithoutfee(address dest, uint128 value) public view {
         require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        dest.transfer(value, true, 0);
    }
    function sendvalwithfee(address dest, uint128 value) public view {
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        dest.transfer(value, true, 1);
    }

    function sendallvalanddestroywallet(address dest, uint128 value) public view {
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        dest.transfer(value, true, 160);
    }
}