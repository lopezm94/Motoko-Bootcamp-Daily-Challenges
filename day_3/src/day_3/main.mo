import Support "support";
import ArrayBase "mo:base/Array";

actor {
    public func publicSwap(array : [Nat], i: Nat, j: Nat) : async [Nat] {
        return ArrayBase.freeze(swap(ArrayBase.thaw(array), i, j));
    };

    private func swap(mArray : [var Nat], i: Nat, j: Nat) : [var Nat] {
        let aux = mArray[i];
        mArray[i] := mArray[j];
        mArray[j] := aux;
        return mArray;
    };

    public func init_count(n: Nat) : async [Nat] {
        return await Support.init_count(n);
    };

    public func seven(array: [Nat]) : async Text {
        return await Support.seven(array);
    };

    public func nat_opt_to_nat(n: ?Nat, m: Nat) : async Nat {
        return await Support.nat_opt_to_nat(n, m);
    };

    public func day_of_the_week(n: Nat) : async ?Text {
        return await Support.day_of_the_week(n);
    };

    public func populate_array(array: [?Nat]) : async [Nat] {
        return await Support.populate_array(array);
    };

    public func sum_of_array(array: [Nat]) : async Nat {
        return await Support.sum_of_array(array);
    };

    public func squared_array(array: [Nat]) : async [Nat] {
        return await Support.squared_array(array);
    };

    public func increase_by_index(array: [Nat]) : async [Nat] {
        return await Support.increase_by_index(array);
    };

};
