import PrincipalBase "mo:base/Principal";
import HashMapBase "mo:base/HashMap";

actor {

    let favoriteNumber = HashMapBase.HashMap<Principal, Nat>(0, PrincipalBase.equal, PrincipalBase.hash);

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
        let a = favoriteNumber.remove(caller);
    }
};
