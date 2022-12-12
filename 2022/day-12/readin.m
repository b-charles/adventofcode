function [H, S, E] = readin( filename )

C = cell2mat( convertStringsToChars( readlines( filename, "EmptyLineRule", "skip" ) ) );

S = find( C(:) == 'S' );

E = find( C(:) == 'E' );

H = C - 'a';
H(S) = 0;
H(E) = 25;

end