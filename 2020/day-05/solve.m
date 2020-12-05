
% T = [ ...
%   'FBFBBFFRLR' ;
%   'BFFFBBFRRR' ;
%   'FFFBBBFRRR' ;
%   'BBFFBBFRLL' ];

T = cell2mat( split( fileread( 'data.in' ) ) );

S = ( T == 'B' | T == 'R' )';

P = [
  64 32 16 8 4 2 1 0 0 0 ; ...
   0  0  0 0 0 0 0 4 2 1 ];
I = [ 8 1 ];

ID = I * P * S;

disp( max( ID ) );

%%

V = setdiff( 0:1023, ID );
disp( V( ismember( V-1, ID ) & ismember( V+1, ID ) ) );
