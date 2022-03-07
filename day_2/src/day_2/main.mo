import NatBase "mo:base/Nat";
import Nat8Base "mo:base/Nat8";
import CharBase "mo:base/Char";
import IterBase "mo:base/Iter";
import TextBase "mo:base/Text";
import ArrayBase "mo:base/Array";

actor {
    public func nat_to_nat8(n : Nat) : async Nat8 {
        return Nat8Base.fromNat(n);
    };

    public func max_number_with_n_bits(n : Nat) : async Nat {
        var powerIndex: Nat = 1;
        var powerResult: Nat = 1;
        while (powerIndex <= n) {
            powerResult*=2;
            powerIndex+=1;
        };
        return powerResult-1;
    };

    public func decimal_to_bits(n : Nat) : async Text {
        var depoweredValue: Nat = n;
        var bitsResult: Text = "";
        if (n == 0) bitsResult := "0";
        while (depoweredValue != 0) {
            let roundResidue = depoweredValue % 2;
            depoweredValue := depoweredValue / 2;
            bitsResult := NatBase.toText(roundResidue) # bitsResult;
        };
        return bitsResult;
    };

    public func capitalize_character(c : Char) : async Char {
        return _capitalize_character(c);
    };

    public func capitalize_text(t : Text) : async Text {
        var capitalizedText = "";
        for (c in t.chars()) {
            let capitalizedCharacterAsText = CharBase.toText(_capitalize_character(c));
            capitalizedText := capitalizedText # capitalizedCharacterAsText;
        };
        return capitalizedText;
    };

    public func is_inside(t : Text, c: Char) : async Bool {
        for (c2 in t.chars()) {
            if (c2 == c) return true;
        };
        return false;
    };

    public func trim_whitespace(t : Text) : async Text {
        let whitespaceCharsAsNat32: [Nat32] = [9, 10, 11, 12, 13, 32, 133, 160];
        let whitespaceChars: [Char] = ArrayBase.map(whitespaceCharsAsNat32, CharBase.fromNat32);
        let charArray = IterBase.toArray(t.chars());
        let isNotWhitespace: Char -> Bool = (func(x: Char): Bool { return ArrayBase.find<Char>(whitespaceChars, func(y: Char): Bool { return y == x }) == null });
        let filteredCharArray = ArrayBase.filter(charArray, isNotWhitespace);
        return TextBase.fromIter(IterBase.fromArray(filteredCharArray));
    };

    public func duplicated_character(t : Text) : async Text {
        var partialText: Text = "";
        for (c in t.chars()) {
            if (await is_inside(partialText, c)) return CharBase.toText(c);
            partialText := partialText # CharBase.toText(c);
        };
        return t;
    };

    public func size_in_bytes(t : Text) : async Nat {
        return t.size() * 32 / 8;
    };

    public func bubble_sort(array : [Nat]) : async [Nat] {
        let mutableArray: [var Nat] = ArrayBase.thaw(array);
        for (i in IterBase.range(0, array.size()-1)) {
            for (j in IterBase.range(0, array.size()-2)) {
                if (mutableArray[j] > mutableArray[j+1]) {
                    let aux = mutableArray[j];
                    mutableArray[j] := mutableArray[j+1];
                    mutableArray[j+1] := aux;
                }
            };
        };
        return ArrayBase.freeze(mutableArray);
    };

    private func _capitalize_character(c : Char) : Char {
        let charAsNat32 = CharBase.toNat32(c);
        return CharBase.fromNat32(charAsNat32 - 32);
    };
};
