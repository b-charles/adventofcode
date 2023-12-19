function N = poss( R, C )

persistent memposs;
if isempty( memposs )
  memposs = memoize( @poss );
end

if isempty( C )
  N = all( R ~= '#' );
  return
end

N = 0;

i = find( R ~= '.', 1 );
if isempty( i )
  return
end

R = R(i:end);

if R(1) == '?'
  N = N + memposs( R(2:end), C );
end

if length(R) >= C(1) && all( R(1:C(1)) ~= '.' ) && ( length(R) == C(1) || R(C(1)+1) ~= '#' )
  N = N + memposs( R(C(1)+2:end), C(2:end) );
end
