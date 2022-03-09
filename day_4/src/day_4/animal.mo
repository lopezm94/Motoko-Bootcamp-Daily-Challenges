module {
    public type Animal = {
        specie: Text;
        energy: Nat;
    };

    public func animal_sleep(a: Animal): Animal {
        return {
            specie = a.specie;
            energy = a.energy + 10;
        };
    }
};
