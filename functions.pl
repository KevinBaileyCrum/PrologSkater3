% $Id: functions.pl, Kevin Crum - CMPS 112 -- ASG4


% Prolog version of not.
not( X ) :- X, !, fail.
not( _ ).
    
% Distance functions & Time Conversion fcn --------------------------

%getHourMin( Hour, Min, ThisDep ) :-
% ThisDep is Hour + (Min/60).

%getArrivalTime
getArrivalTime( Distance, ThisArrival ) :-
  ThisArrival is 500/Distance. 

% converts degrees:minute -> degrees
%   min * 1/60 = degrees
degminToDegrees( Deg, Min, Degrees ) :-
  Degrees is Deg + (Min/60).


% converts degrees -> radians
%   degree * (pi/180) = rad
degreesToRadians( Degrees, Radians ) :-
  Pi is pi, 
  Radians is ( Degrees * pi ) / 180.


haversine_radians( Lat1, Lon1, Lat2, Lon2, Distance ) :-
  Dlon is Lon2 - Lon1,
  Dlat is Lat2 - Lat1,
  A is sin( Dlat / 2 ) ** 2
     + cos( Lat1 ) * cos( Lat2 ) * sin( Dlon / 2 ) ** 2,
  Dist is 2 * atan2( sqrt( A ), sqrt( 1 - A )),
  Distance is Dist * 3961.
  %write('in haversine '), write( Distance ),
  %nl.


getDistance( To, From, Distance ) :-
  airport( To, _, degmin( LatD1, LatM1 ), degmin( LonD1, LonM1 ) ),
  airport( From, _, degmin( LatD2, LatM2 ), degmin( LonD2, LonM2) ),
  
  % convert Lat and Long
  % LatD1, LatM1 - conversion to degrees > LatDegs1
  degminToDegrees( LatD1, LatM1, LatDegs1),
  % LatDegs1 - conversion to radians > Lat1
  degreesToRadians( LatDegs1, Lat1),
  
  degminToDegrees( LonD1, LonM1, LonDegs1),
  degreesToRadians( LonDegs1, Lon1 ),
  
  degminToDegrees( LatD2, LatM2, LatDegs2 ), 
  degreesToRadians( LatDegs2, Lat2 ),

  degminToDegrees( LonD2, LonM2, LonDegs2 ),
  degreesToRadians( LonDegs2, Lon2 ),
  
  haversine_radians( Lat1, Lon1, Lat2, Lon2, Distance ).


% -------------------------------------------------------------------
% Database node traversal
% -------------------------------------------------------------------

fly( Node, Node ) :-
  write( Node ), write( ' is ' ), write( Node ), nl.
fly( Node, Next ) :-                        
  % start time as 0
  listpath( Node, Next, [Node], List, Time ),
  write( Node ), write( ' to ' ), write( Next ), write( ' is ' ),
  writepath( List ),
  fail.

writepath( [] ) :-
  nl.
writepath( [Head|Tail] ) :-
  write( ' ' ), write( Head ), writepath( Tail ).

listpath( Node, End, Outlist ) :-
  listpath( Node, End, [Node], Outlist ).

listpath( Node, Node, _, [Node], Time ).
listpath( Node, End, Tried, [Node|List], Time ) :-
  
  flight( Node, Next, time( DepHour, DepMin ) ),
  
  % getHourMin conversion for depart time
  %getHourMin( Hour, Min, ThisDep ),
  %write('depart '), write(ThisDep),

  airport( Node, _, _, _ ),
  airport( Next, _, _, _ ),
 
  getDistance( Node, Next, Distance),
  getArrivalTime( Distance, ThisArrive ),  
  write(' '),write(ThisArrive),

  not( member( Next, Tried )),
  % cut at the end of vvv list path below stops at first success
  listpath( Next, End, [Next|Tried], List, Time ).



