% $Id: functions.pl, Kevin Crum - CMPS 112 -- ASG4


% $Id: graphpaths.pl,v 1.3 2011-05-19 19:53:59-07 - - $ */

%
% Prolog version of not.
%

not( X ) :- X, !, fail.
not( _ ).



% degrees:minute -> degrees
%   min * 1/60 = degrees
degmin_to_degrees( Deg, Min, Degrees ) :-
  Degrees is Deg + (Min/60).





%
% Is there a path from one node to another?
% Find a path from one node to another.
%

fly( Node, Node ) :-
   write( Node ), write( ' is ' ), write( Node ), nl.
fly( Node, Next ) :-
   listpath( Node, Next, [Node], List ),
   write( Node ), write( ' to ' ), write( Next ), write( ' is ' ),
   writepath( List ),
   fail.

writepath( [] ) :-
   nl.
writepath( [Head|Tail] ) :-
   write( ' ' ), write( Head ), writepath( Tail ).

listpath( Node, End, Outlist ) :-
   listpath( Node, End, [Node], Outlist ).

listpath( Node, Node, _, [Node] ).
listpath( Node, End, Tried, [Node|List] ) :-
   flight( Node, Next, time( Hour, Min ) ),
   
   airport( Node, _, _, _ ),
   airport( Next, _, _, _ ),


   not( member( Next, Tried )),
   % cut at the end of vvv list path below stops at first success
   listpath( Next, End, [Next|Tried], List ).


/*

mathfns( X, List ) :-
   S is sin( X ),
   C is cos( X ),
   Q is sqrt( X ),
   List = [S, C, Q].

constants( List ) :-
   Pi is pi,
   E is e,
   Epsilon is epsilon,
   List = [Pi, E, Epsilon].

sincos( X, Y ) :-
   Y is sin( X ) ** 2 + cos( X ) ** 2.

haversine_radians( Lat1, Lon1, Lat2, Lon2, Distance ) :-
   Dlon is Lon2 - Lon1,
   Dlat is Lat2 - Lat1,
   A is sin( Dlat / 2 ) ** 2
      + cos( Lat1 ) * cos( Lat2 ) * sin( Dlon / 2 ) ** 2,
   Dist is 2 * atan2( sqrt( A ), sqrt( 1 - A )),
   Distance is Dist * 3961,
   write( Distance ), 
   nl.


% isAirport( X )
% Takes in airport abreviation and finds corresponding
% values of Latitude and Longitude.  It converts
% said values minutes -> degrees -> radians.
%   min = 1deg/60     rad = deg*pi/180 
isAirport( X ) :-
  airport( X, Name, degmin( Deg1, Min1), degmin( Deg2, Min2)), nl,
      
  % Get North Latitude of X
  write(Deg1), nl,
  write(Min1), nl,
  Frac1 is Min1 / 60,
  write(Frac1), nl,
  DegAndMin1 is Deg1 + Frac1,
  write(DegAndMin1), nl,
  D1asPi is DegAndMin1 *(pi / 180),
  write('North Lat in Radians for X '), write(D1asPi), nl,

  % Get West Longitutde of X
  Frac2 is Min2 / 60,
  DegAndMin2 is Deg2 + Frac2,
  D2asPi is DegAndMin2 *(pi / 180),
  write('West Long in Radians for X '), write(D2asPi), nl.
  
  % Get North Latitude of Y
  %airport( Y, Name, degmin( yDeg1, yMin1), degmin( yDeg2, yMin2)), nl,
  %write(yDeg1), nl,
  %write(yMin1),

  


% is sea -- group0.test asks fly(sea,lax)
%fly( X, Y ) :-
  % write('this q'),
  % write('y equal'),
  %write(Y), nl,
  %isAirport( X ).
*/    




