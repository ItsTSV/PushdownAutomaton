% Usage:
%   Set initial state, initial stack symbol and transition rules.
%   Call accepts('input string') to check if the input string is accepted by the automaton.
%   The automaton accepts by reading the input string and emptying the stack.

% Initial state and stack symbol
initial_state(q0).
initial_stack_symbol(z0).

% Transition rules (state, input, stack_top, new_state, new stack symbols)
% Words of the form a^n b^n where n >= 1
transition(q0, a, z0, q0, [a]).
transition(q0, a, a, q0, [a,a]).
transition(q0, b, a, q1, []).
transition(q1, b, a, q1, []).

% Stack operations
pop([Top|Rest], Top, Rest).

% Helper function to atomize the input string
accepts(Input) :-
    atom_chars(Input, Chars),
    run_automaton(Chars).

% Run the automaton
run_automaton(Input) :-
    initial_state(State),
    initial_stack_symbol(StackSym),
    run(State, [StackSym], Input).

% Final state check
run(_, [], []) :-
    write('Accepted'), nl.

% Normal transition
run(State, Stack, [Input|Rest]) :-
    write_info(State, Stack, [Input|Rest]),
    transition(State, Input, StackTop, NewState, NewStackSymbols),
    pop(Stack, StackTop, PoppedStack),
    append(NewStackSymbols, PoppedStack, NewStack),
    run(NewState, NewStack, Rest).

% Epsilon transition
run(State, Stack, Input) :-
    write('Epsilon transition'), nl,
    write_info(State, Stack, Input),
    transition(State, '', StackTop, NewState, NewStackSymbols),
    pop(Stack, StackTop, PoppedStack),
    append(NewStackSymbols, PoppedStack, NewStack),
    run(NewState, NewStack, Input).

% Prints current state, stack and input for debugging
write_info(State, Stack, Input) :-
    write('State: '), write(State), nl,
    write('Stack: '), write(Stack), nl,
    write('Input: '), write(Input), nl, nl.
