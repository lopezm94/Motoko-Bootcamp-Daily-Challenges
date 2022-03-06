import Iter "mo:base/Iter";
import Array "mo:base/Array";
import Debug "mo:base/Debug";

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
        return _maximum(array, 0, array.size()-1).0;
    };

    public func remove_from_array(array : [Nat], n: Nat): async [Nat] {
        var filteredArray : [Nat] = [];
        for (value in array.vals()) {
            if (value != n) {
                filteredArray := Array.append(filteredArray, [value]);
            }
        };
        return filteredArray;
    };

    public func selection_sort(array : [Nat]): async [Nat] {
        var endIndex: Nat = array.size()-1;
        let thawedArray : [var Nat] = Array.thaw(array);
        Debug.print("Pre");
        while (endIndex > 0) {
            let (max, maxIndex) = _maximum(Array.freeze(thawedArray), 0, endIndex);
            Debug.print("Hola");
            Debug.print(debug_show(endIndex));
            Debug.print(debug_show(max));
            Debug.print(debug_show(maxIndex));
            thawedArray[maxIndex] := thawedArray[endIndex];
            thawedArray[endIndex] := max;
            endIndex -= 1;
        };
        return Array.freeze(thawedArray);
    };

    private func _maximum(array : [Nat], startIndex : Nat, finalIndex : Nat): (Nat, Nat) {
        var max : Nat = 0;
        var index : Nat = 0;
        for (i in Iter.range(startIndex, finalIndex)) {
            let value = array[i];
            if (value > max) {
                max := value;
                index := i;
            }
        };
        return (max, index);
    };

};
