module {
    public type List<T> = ?(T, List<T>);

    public func is_null<T>(l: List<T>): Bool {
        return switch(l) {
            case(null) {
                return true;
            }; case(?l) {
                return false;
            }
        };
    };

    public func last<T>(l: List<T>): List<T> {
        return switch(l) {
            case(null) {
                null;
            }; case(?l) {
                let l2 = l.1;
                switch(l2) {
                    case(null) {
                        ?l;
                    }; case(?l2) {
                        last<T>(?l2);
                    }
                }
            }
        }
    };

    public func size<T>(l: List<T>): Nat {
        var counter: Nat = 0;
        var currentElement: List<T> = l;
        var nextElement: List<T> = null;
        var lastElementFound: Bool = is_null(currentElement);
        while (not lastElementFound) {
            switch(currentElement) {
                case(null) {
                    lastElementFound := true;
                }; case(?currentElement) {
                    nextElement := currentElement.1;
                    counter += 1;
                }
            };
            currentElement := nextElement;
        };
        return counter;
    };

    public func get<T>(l: List<T>, n: Nat): List<T> {
        return switch(l) {
            case(null) {
                null;
            }; case(?l) {
                switch(n) {
                    case(0) {
                        ?l;
                    }; case(_) {
                        get<T>(l.1, n-1);
                    }
                }
            }
        }
    };

    public func reverse<T>(l: List<T>): List<T> {
        if (is_null(l)) return null;
        var lastIndex: Nat = size<T>(l)-1;
        var reversedList: List<T> = null;
        while (lastIndex >= 0) {
            let elementFound: List<T> = get<T>(l, lastIndex);
            switch(elementFound) {
                case(?elementFound) {
                   reversedList := ?(elementFound.0, reversedList);
                }
            };
            lastIndex -= 1;
        };
        return reversedList;
    }

};
