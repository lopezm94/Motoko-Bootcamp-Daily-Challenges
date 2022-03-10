import DebugBase "mo:base/Debug";
import NatBase "mo:base/Nat";
import PrincipalBase "mo:base/Principal";
import CyclesBase "mo:base/ExperimentalCycles";
import HashMapBase "mo:base/HashMap";

actor {
    let favoriteNumber = HashMapBase.HashMap<Principal, Nat>(0, PrincipalBase.equal, PrincipalBase.hash);

    public func get_balance() : async Nat {
        return CyclesBase.balance();
    };

    public shared({caller}) func is_anonymous() : async Bool {
        return caller == PrincipalBase.fromText("2vxsx-fae");
    };

    public shared({caller}) func add_favorite_number(n: Nat): async Text {
        let storedFavNumber = favoriteNumber.get(caller);
        return switch(storedFavNumber) {
            case(null) {
                favoriteNumber.put(caller, n);
                "You've successfully registered your number"
            }; case(?storedFavNumber) {
                "You've already registered your number"
            }
        };
    };

    public shared({caller}) func show_favorite_number() : async ?Nat {
        return favoriteNumber.get(caller);
    };

    public shared({caller}) func update_favorite_number(n: Nat) {
        favoriteNumber.put(caller, n);
    };

    public shared({caller}) func delete_favorite_number() {
        ignore favoriteNumber.remove(caller);
    };

    public func deposit_cycles() : async Nat {
        let received = CyclesBase.accept(CyclesBase.available());
        DebugBase.print("Main canister received " # NatBase.toText(received) # " cycles.");
        return received;
    };

    public shared({caller}) func withdraw_cycles(n: Nat) {
        let callerActor: actor { deposit_cycles : (Nat) -> async Nat } = actor(PrincipalBase.toText(caller));
        CyclesBase.add(n);
        let withdrawn = await callerActor.deposit_cycles(n);
        DebugBase.print("Main canister withdrew " # NatBase.toText(withdrawn) # " cycles.")
    };
};
