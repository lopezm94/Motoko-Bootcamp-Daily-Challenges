actor {

    var counter : Nat = 0;

    public func add(n : Nat, m : Nat) : async Nat {
        return n + m;
    };

    public func square(n : Nat) : async Nat {
        return n*n;
    };

    public func days_to_second(n : Nat) : async Nat {
        return n*24*60*60;
    };

    public func increment_counter(n : Nat) : async Nat {
        counter := counter + n;
        return counter;
    };

    public func clear_counter(n : Nat) {
        counter := 0;
    };

    public func divide(n : Nat, m : Nat): async Nat {
        return n / m;
    };

    public func is_even(n : Nat): async Bool {
        return n % 2 == 0;
    };

    public func sum_of_array(array : [Nat]): async Nat {
        var sum : Nat = 0;
        for (value in array.vals()) {
            sum := sum + value;
        };
        return sum;
    };

    public func maximum(array : [Nat]): async Nat {
        var max : Nat = 0;
        for (value in array.vals()) {
            if (value > max) {
                max := value;
            }
        };
        return max;
    };
};
