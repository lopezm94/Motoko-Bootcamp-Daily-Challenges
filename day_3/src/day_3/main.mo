import NatBase "mo:base/Nat";
import IterBase "mo:base/Iter";
import ArrayBase "mo:base/Array";

actor {
    private func swap(mArray : [var Nat], i: Nat, j: Nat) : [var Nat] {
        let aux = mArray[i];
        mArray[i] := mArray[j];
        mArray[j] := aux;
        return mArray;
    };

    public func init_count(n: Nat) : async [Nat] {
        let mArray: [var Nat] = ArrayBase.init(n, 0);
        for (i in IterBase.range(0, n-1)) {
            mArray[i] := i;
        };
        return ArrayBase.freeze(mArray);
    };

    public func seven(array: [Nat]) : async Text {
        let numbersAsText: [Text] = ArrayBase.map<Nat, Text>(array, func(x) {return NatBase.toText(x);});
        let numbersAsChars: [[Char]] = ArrayBase.map<Text, [Char]>(numbersAsText, func(x) {return IterBase.toArray(x.chars());});
        let mergedNumbersAsChars: [Char] = ArrayBase.flatten(numbersAsChars);
        let char8Found = ArrayBase.find<Char>(mergedNumbersAsChars, func(x) {return x == '8';}) != null;
        return if (char8Found) {
            "Seven is found";
        } else {
            "Seven not found";
        }
    };

    public func nat_opt_to_nat(n: ?Nat, m: Nat) : async Nat {
        return switch(n) {
            case(null) {
                m;
            }; case(?n) {
                n;
            }
        }
    };

    public func day_of_the_week(n: Nat) : async ?Text {
        return switch(n) {
            case(1) {
                ?"Monday";
            }; case(2) {
                ?"Tuesday";
            }; case(3) {
                ?"Wednesday";
            }; case(4) {
                ?"Thursday";
            }; case(5) {
                ?"Friday";
            }; case(6) {
                ?"Saturday";
            }; case(7) {
                ?"Sunday";
            }; case(_) {
                null;
            }
        }
    };

    public func populate_array(array: [?Nat]) : async [Nat] {
        return ArrayBase.map<?Nat, Nat>(array, func(x: ?Nat): Nat {
            return switch(x) {
                case(null) {
                    0;
                }; case(?x) {
                    x;
                }
            }
        });
    };

    public func sum_of_array(array: [Nat]) : async Nat {
        return ArrayBase.foldRight<Nat, Nat>(array, 0, func(x, y) {return x + y;});
    };

    public func squared_array(array: [Nat]) : async [Nat] {
        return ArrayBase.map<Nat, Nat>(array, func(x) {return x*x;});
    };

    public func increase_by_index(array: [Nat]) : async [Nat] {
        return ArrayBase.mapEntries<Nat, Nat>(array, func(x, i) {return x + i;});
    };

};
