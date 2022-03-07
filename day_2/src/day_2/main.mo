import NatBase "mo:base/Nat";
import Nat8Base "mo:base/Nat8";
import CharBase "mo:base/Char";

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

    private func _capitalize_character(c : Char) : Char {
        let charAsNat32 = CharBase.toNat32(c);
        return CharBase.fromNat32(charAsNat32 - 32);
    };
};
