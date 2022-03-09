import ListBase "mo:base/List";
import Custom "custom";
import Animal "animal";
import ListCustom "list";

actor {
    public type Harambe = Custom.Harambe;
    public type Animal = Animal.Animal;

    public type List<T> = ListBase.List<T>;

    let apexPredator: Harambe = { isBulletProof = true; dancesBachata = true; };
    var lackeyAnimal: Animal = { specie = "Hyena"; energy = 100; };

    var animals: List<Animal> = ListBase.fromArray([]);

    public func get_bullet_proof_dirty_dancing_harambe(): async Harambe {
        return apexPredator;
    };

    public func create_animal_then_takes_a_break(specie: Text, energy: Nat): async Animal {
        let animal: Animal = { specie = specie; energy = energy; };
        return Animal.animal_sleep(animal);
    };

    public func push_animal(specie: Text, energy: Nat) {
        let animal: Animal = { specie = specie; energy = energy; };
        animals := ListBase.push<Animal>(animal, animals);
    };

    public func get_animals(): async [Animal] {
        return ListBase.toArray(animals);
    };
};
