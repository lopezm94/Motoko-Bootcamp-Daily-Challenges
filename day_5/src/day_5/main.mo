import PrincipalBase "mo:base/Principal";
import HashMapBase "mo:base/HashMap";

actor {

    let favoriteNumber = HashMapBase.HashMap<Principal, Nat>(0, PrincipalBase.equal, PrincipalBase.hash);

    public shared({caller}) func is_anonymous() : async Bool {
        return caller == PrincipalBase.fromText("2vxsx-fae");
    };

    public shared({caller}) func add_favorite_number(n: Nat) {
        favoriteNumber.put(caller, n);
    };

    public shared({caller}) func show_favorite_number() : async ?Nat {
        return favoriteNumber.get(caller);
    };
};
