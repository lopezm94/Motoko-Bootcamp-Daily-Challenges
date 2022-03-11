import HTTP "http";
import NatBase "mo:base/Nat";
import TextBase "mo:base/Text";
import HashBase "mo:base/Hash";
import IterBase "mo:base/Iter";
import ArrayBase "mo:base/Array";
import ResultBase "mo:base/Result";
import HashMapBase "mo:base/HashMap";
import PrincipalBase "mo:base/Principal";

actor {
    public type TokenIndex = Nat;
    public type Error = {
        #internal_error;
        #not_found;
        #unauthorized;
    };

    let anonymousPrincipal = PrincipalBase.fromText("2vxsx-fae");

    var nextTokenIndex: TokenIndex = 0;
    let registry = HashMapBase.HashMap<TokenIndex, Principal>(0, NatBase.equal, HashBase.hash);

    public shared({caller}) func mint(): async ResultBase.Result<(), Error> {
        return if (caller == anonymousPrincipal) {
            #err(#unauthorized);
        } else {
            registry.put(nextTokenIndex, caller);
            nextTokenIndex+=1;
            #ok;
        }
    };

    public shared({caller}) func transfer(to: Principal, tokenIndex: Nat): async ResultBase.Result<(), Error> {
        let currentOwner = registry.get(tokenIndex);
        return switch(currentOwner) {
            case(null) {
                #err(#not_found);
            }; case(?currentOwner) {
                if (currentOwner == caller) {
                    registry.put(tokenIndex, to);
                    #ok;
                } else {
                    #err(#unauthorized);
                }
            };
        }
    };

    public shared({caller}) func balance(): async [TokenIndex] {
        let entries: [(TokenIndex, Principal)] = IterBase.toArray(registry.entries());
        let entriesOwned = ArrayBase.filter<(TokenIndex, Principal)>(entries, func (entry) {return entry.1 == caller;});
        return ArrayBase.map<(TokenIndex, Principal), TokenIndex>(entriesOwned, func (entry) {return entry.0;});
    };

    public query func http_request(request : HTTP.Request) : async HTTP.Response {
        if (nextTokenIndex == 0) {
            let response = {
                body = TextBase.encodeUtf8("{\n" #
                    "\t\"minted\": " # NatBase.toText(nextTokenIndex) # ",\n" #
                    "\t\"lastMinter\": null,\n" #
                    "}");
                headers = [("Content-Type", "application/json; charset=UTF-8")];
                status_code = 200 : Nat16;
                streaming_strategy = null;
            };
            return(response);
        };
        let lastMinter = registry.get(nextTokenIndex-1);
        switch(lastMinter) {
            case(null) {
                let response = {
                    body = TextBase.encodeUtf8("{\n" #
                        "\t\"message\": \"Internal Server Error\",\n" #
                        "}");
                    headers = [("Content-Type", "application/json; charset=UTF-8")];
                    status_code = 500 : Nat16;
                    streaming_strategy = null;
                };
                return(response);
            }; case(?lastMinter) {
                let response = {
                    body = TextBase.encodeUtf8("{\n" #
                        "\t\"minted\": " # NatBase.toText(nextTokenIndex) # ",\n" #
                        "\t\"lastMinter\": \"" # PrincipalBase.toText(lastMinter) # "\",\n" #
                        "}");
                    headers = [("Content-Type", "application/json; charset=UTF-8")];
                    status_code = 200 : Nat16;
                    streaming_strategy = null;
                };
                return(response);
            }
        }
    };
};
