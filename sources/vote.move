module underwriter::vote {
    use std::option::{Self};
    use std::string::{String};
    use sui::transfer;
    use sui::sui::SUI;
    use sui::coin::{Self, Coin};
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    /// For when Coin balance is too low.
    const ENotEnough: u64 = 0;


    /// Capability that allows an owner to create a new poll.
    struct PollCreationCap has key { id: UID }

    /// A new Poll.
    struct Poll has key { 
        id: UID,
        title: String,
        description:String,
        yes:u64,
        no:u64
        }


    public entry fun create_poll(_: &PollCreationCap,
    title:String,description:String, ctx: &mut TxContext){
        let newPoll = Poll{
            id:object::new(ctx),
            title:title,
            description:description,
            yes:0,
            no:0
        };
        transfer::share_object(newPoll);
    }
    public entry fun vote(poll: &mut Poll, token: &mut Coin<SUI>,vote:u8,ctx: &mut TxContext){
        let coinVal = coin::value(token);
         assert!(coinVal>0, ENotEnough);
         if(vote==1){
            poll.yes=poll.yes+coinVal;
         }
         else{
            poll.no=poll.no+coinVal;
        }
    }

    /// Init function is often ideal place for initializing
    /// a shared object as it is called only once.
    ///
    /// To share an object `transfer::share_object` is used.
    fun init(ctx: &mut TxContext) {
        transfer::transfer(PollCreationCap {
            id: object::new(ctx)
        }, tx_context::sender(ctx));

    }

  
    // public entry fun delete_poll(d: Poll) {
    //     let Poll { id, yes,title,no,link,description } = d;
    //     yes=0;
    //     object::delete(id);
    // }

}