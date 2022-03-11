import ErrorCustom "error";
import ResultBase "mo:base/Result";
import PrincipalBase "mo:base/Principal";

actor class Minter(mainCanisterPrincipal: Principal) {
    public type MainActor = actor { mint : () -> async ResultBase.Result<(), ErrorCustom.Error> };

    public func mint() {
        let callerActor: MainActor = actor(PrincipalBase.toText(mainCanisterPrincipal));
        ignore await callerActor.mint();
    };
};
