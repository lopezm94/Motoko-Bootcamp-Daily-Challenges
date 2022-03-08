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
};
