% The same, just parametrized
accepts(InputAtom, InitialState, InitialStackSymbol, Transitions) :-
    atom_chars(InputAtom, InputList),
    run(InputList, InitialState, [InitialStackSymbol], Transitions).

% Accept state
run([], _, [], _) :-
    write('Accepted'), nl.

% Normal transition
run([Symbol|RestInput], CurrentState, [StackTop|RestStack], Transitions) :-
    member(transition(CurrentState, Symbol, StackTop, NewState, NewStackPush), Transitions),
    append(NewStackPush, RestStack, NewStack),
    run(RestInput, NewState, NewStack, Transitions).

% Epsilon transition
run(Input, CurrentState, [StackTop|RestStack], Transitions) :-
    member(transition(CurrentState, epsilon, StackTop, NewState, NewStackPush), Transitions),
    append(NewStackPush, RestStack, NewStack),
    run(Input, NewState, NewStack, Transitions).
