pragma solidity ^0.4.11;

contract VerifiedWallet {

  struct Wallet {
    bool registered; // if the address/wallet is registered
    uint8 identityRating; // a rating based on how trustworthy is owner of the wallet
    uint8 creditRating; // a rating based on how financially capable is the owner of the wallet
  }

  address public superuser; // the superuser; one who deployed this contract
  mapping (address => Wallet) wallets; // the ledger, the table, the mapping of wallets

  // this is contructor; this function is called on deployment of the contract
  function VerifiedWallet() {
    superuser = msg.sender; // the one who deployed the contract serves as the superuser
  }

  // modifier are like inherited functions
  modifier isSuper {
      require(msg.sender == superuser);
      _; // the content of the modified function will be placed in here
  }

  // anyone can registered a wallet
  function registerWallet(address wallet) {
    wallets[wallet] = Wallet(true, 0, 0);
  }

  // notice the isSuper modifier
  // only super user can increese the rating
  // also verify that the wallet is registered
  function increaseIdentityRating(address wallet, uint8 unit) isSuper {
    Wallet storage w = wallets[wallet];
    if (!w.registered) {
      return;
    }
    w.identityRating += unit;
  }

  // notice the isSuper modifier
  // only super user can increese the rating
  // also verify that the wallet is registered
  function increaseCreditRating(address wallet, uint8 unit) isSuper {
    Wallet storage w = wallets[wallet];
    if (!w.registered) {
      return;
    }
    w.identityRating += unit;
  }

  // anyone can check the identity rating
  function checkIdentityRating(address wallet, uint8 limit) returns (bool) {
    Wallet storage w = wallets[wallet];
    if (!w.registered) {
      return false;
    }
    return w.identityRating >= limit;
  }

  // anyone can check the identity rating
  function checkCreditRating(address wallet, uint8 limit) returns (bool) {
    Wallet storage w = wallets[wallet];
    if (!w.registered) {
      return false;
    }
    return w.creditRating >= limit;
  }

}