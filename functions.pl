% $Id: functions.pl, Kevin Crum - CMPS 112 -- ASG4

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

 %minToDeg( M ) :-

% isAirport( X )
% Takes in airport abreviation and finds corresponding
% values of Latitude and Longitude.  It converts
% said values minutes -> degrees -> radians.
%   DegAndMin1 is first lat converted and summed
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
  write('North Lat in Radians '), write(D1asPi), nl,

  % Get West Longitutde of X
  Frac2 is Min2 / 60,
  DegAndMin2 is Deg2 + Frac2,
  D2asPi is DegAndMin2 *(pi / 180),
  write('West Long in Radians '), write(D2asPi), nl.


  %airport( Y, Name, degmin( yDeg1, yMin1), degmin( yDeg2, yMin2)), nl,
  %write(yDeg1), nl,
  %write(yMin1),

  


% is sea -- group0.test asks fly(sea,lax)
fly( X, Y ) :-
   % write('this q'),
   % write('y equal'),
   write(Y), nl,
   isAirport( X ).
 



% 60 min = 1 deg.  (deg= deg + min/60?) rad=pi/180 * deg
