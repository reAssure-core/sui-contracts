module underwriter::projectcoin {
    use sui::object::UID;
        use sui::object;

 use std::option::{Self, Option};
     use sui::coin::{Self,Coin,TreasuryCap};
    use sui::transfer;
    use sui::sui::SUI;
        use sui::url::{Self, Url};

    use sui::tx_context::{Self, TxContext};
    use sui::balance::{Self, Balance};


    /// The type identifier of coin. The coin will have a type
    /// tag of kind: `Coin<package_object::mycoin::MYCOIN>`
    /// Make sure that the name of the type matches the module's name.
    struct PROJECTCOIN has drop {}
    struct ProjectDetails has key{
        id:UID,
        price: u64,
        balance: Balance<SUI>,
        treasury: TreasuryCap<PROJECTCOIN>
    }
        const ENotEnough: u64 = 0;


    public entry fun buy_share( projectDetail: &mut ProjectDetails,
        payment: &mut Coin<SUI>, ctx: &mut TxContext
    ) {
        assert!(coin::value(payment) >= 1,ENotEnough);

        // Take amount = `shop.price` from Coin<SUI>
        let coin_balance = coin::balance_mut(payment);
        let paid = balance::split(coin_balance, 1);

        // Put the coin to the Shop's balance
        balance::join(&mut projectDetail.balance, paid);
        coin::mint_and_transfer(&mut projectDetail.treasury,coin::value(payment),tx_context::sender(ctx),ctx);

       
    }
        public entry fun buy_share_f(projectDetail: &mut ProjectDetails, ctx: &mut TxContext
    ) {
      
        coin::mint_and_transfer(&mut projectDetail.treasury,800,tx_context::sender(ctx),ctx);

       
    }



    /// Module initializer is called once on module publish. A treasury
    /// cap is sent to the publisher, who then controls minting and burning
    fun init(witness: PROJECTCOIN, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(witness, 6, b"PROJECTCOIN",b"PC",b"PROJECTCOIN",option::none(),  ctx);
        transfer::public_freeze_object(metadata);
        let projectDetails = ProjectDetails{id:object::new(ctx),price:1,balance:balance::zero(),treasury:treasury} ;
        transfer::share_object(projectDetails);
        // transfer::public_transfer(treasury, tx_context::sender(ctx))
    }
}
