import DebugBase "mo:base/Debug";
import NatBase "mo:base/Nat";
import IterBase "mo:base/Iter";
import PrincipalBase "mo:base/Principal";
import CyclesBase "mo:base/ExperimentalCycles";
import HashMapBase "mo:base/HashMap";

actor {
    stable var version_number : Nat = 0;
    stable var entries: [(Principal, Nat)] = [];

    let favoriteNumber = HashMapBase.fromIter<Principal, Nat>(entries.vals(), entries.size(), PrincipalBase.equal, PrincipalBase.hash);

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

    system func preupgrade() {
        entries := IterBase.toArray(favoriteNumber.entries());
    };

    system func postupgrade() {
        entries := [];
        version_number += 1;
    };
};
