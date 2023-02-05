/* 
    Dakota Sadler
    Prolog 8 Puzzle Solution
*/

use_module(library(lists)).

/* Index Moves */
up([X,I1,I2,0,I4,I5,I6,I7,I8],[0,I1,I2,X,I4,I5,I6,I7,I8]). % Index 3 -> 0
up([I0,X,I2,I3,0,I5,I6,I7,I8],[I0,0,I2,I3,X,I5,I6,I7,I8]). % Index 4 -> 1
up([I0,I1,X,I3,I4,0,I6,I7,I8],[I0,I1,0,I3,I4,X,I6,I7,I8]). % Index 5 -> 2
up([I0,I1,I2,X,I4,I5,0,I7,I8],[I0,I1,I2,0,I4,I5,X,I7,I8]). % Index 6 -> 3
up([I0,I1,I2,I3,X,I5,I6,0,I8],[I0,I1,I2,I3,0,I5,I6,X,I8]). % Index 7 -> 4
up([I0,I1,I2,I3,I4,X,I6,I7,0],[I0,I1,I2,I3,I4,0,I6,I7,X]). % Index 8 -> 5

down([0,I1,I2,I3,I4,I5,I6,I7,I8],[I3,I1,I2,0,I4,I5,I6,I7,I8]). % Index 0 -> 3
down([I0,0,I2,I3,I4,I5,I6,I7,I8],[I0,I4,I2,I3,0,I5,I6,I7,I8]). % Index 1 -> 4
down([I0,I1,0,I3,I4,I5,I6,I7,I8],[I0,I1,I5,I3,I4,0,I6,I7,I8]). % Index 2 -> 5
down([I0,I1,I2,0,I4,I5,I6,I7,I8],[I0,I1,I2,I6,I4,I5,0,I7,I8]). % Index 3 -> 6
down([I0,I1,I2,I3,0,I5,I6,I7,I8],[I0,I1,I2,I3,I7,I5,I6,0,I8]). % Index 4 -> 7
down([I0,I1,I2,I3,I4,0,I6,I7,I8],[I0,I1,I2,I3,I4,I8,I6,I7,0]). % Index 5 -> 8

left([X,0,I2,I3,I4,I5,I6,I7,I8],[0,X,I2,I3,I4,I5,I6,I7,I8]). % Index 1 -> 0
left([I0,I1,I2,X,0,I5,I6,I7,I8],[I0,I1,I2,0,X,I5,I6,I7,I8]). % Index 4 -> 3
left([I0,I1,I2,I3,I4,I5,X,0,I8],[I0,I1,I2,I3,I4,I5,0,X,I8]). % Index 7 -> 6
left([I0,X,0,I3,I4,I5,I6,I7,I8],[I0,0,X,I3,I4,I5,I6,I7,I8]). % Index 2 -> 1
left([I0,I1,I2,I3,X,0,I6,I7,I8],[I0,I1,I2,I3,0,X,I6,I7,I8]). % Index 5 -> 4
left([I0,I1,I2,I3,I4,I5,I6,X,0],[I0,I1,I2,I3,I4,I5,I6,0,X]). % Index 8 -> 7

right([0,X,I2,I3,I4,I5,I6,I7,I8],[X,0,I2,I3,I4,I5,I6,I7,I8]). % Index 0 -> 1
right([I0,I1,I2,0,X,I5,I6,I7,I8],[I0,I1,I2,X,0,I5,I6,I7,I8]). % Index 3 -> 4
right([I0,I1,I2,I3,I4,I5,0,X,I8],[I0,I1,I2,I3,I4,I5,X,0,I8]). % Index 6 -> 7
right([I0,0,X,I3,I4,I5,I6,I7,I8],[I0,X,0,I3,I4,I5,I6,I7,I8]). % Index 1 -> 2
right([I0,I1,I2,I3,0,X,I6,I7,I8],[I0,I1,I2,I3,X,0,I6,I7,I8]). % Index 4 -> 5
right([I0,I1,I2,I3,I4,I5,I6,0,X],[I0,I1,I2,I3,I4,I5,I6,X,0]). % Index 7 -> 8

move(Current, Next) :-
    up(Current,Next);
    down(Current,Next);
    left(Current,Next);
    right(Current,Next).
    
/*Depth First Search*/
pprint([]) :- nl.
pprint([H|T]) :- write(H), nl, pprint(T).

% Initial
  ep(PresentState,GoalState,SolutionPath) :- 
  	ep1(PresentState,GoalState,[PresentState],SolutionPath).
  
  % base case
  ep1(PresentState,Goalstate,PathSoFar,SolutionPath) :- 
	 Goalstate=PresentState,
  	 reverse(PathSoFar,SolutionPath).
  
  % recursive case
  ep1(PresentState, GoalState, PathSoFar, Path) :- 
    move(PresentState,Next), 
    not(member(Next, PathSoFar)),
    length(PathSoFar, D), D=<15, % Change value to search more outcomes
  	ep1(Next,GoalState,[Next|PathSoFar],Path).
    

/*
    Example
    ?- ep([1,3,4,8,6,2,7,0,5], [1,2,3,8,0,4,7,6,5], Path),pprint(Path).

    Limit set to 15 passes, so output may be larger
*/