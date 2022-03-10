import NatBase "mo:base/Nat";
import DebugBase "mo:base/Debug";
import PrincipalBase "mo:base/Principal";
import CyclesBase "mo:base/ExperimentalCycles";

actor class Withdrawer(mainCanisterPrincipal: Principal) {

    public func get_balance() : async Nat {
        return CyclesBase.balance();
    };

    public func withdraw_cycles_from_main(n: Nat) {
        let callerActor: actor { withdraw_cycles : (Nat) -> async () } = actor(PrincipalBase.toText(mainCanisterPrincipal));
        await callerActor.withdraw_cycles(n);
    };

    public func deposit_cycles() : async Nat {
        let received = CyclesBase.accept(CyclesBase.available());
        DebugBase.print("Withdrawer canister received " # NatBase.toText(received) # " cycles.");
        return received;
    };
};
