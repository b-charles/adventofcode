
[ R, S ] = readin( 'input.txt' );

[Ri, Rj] = size(R);

sandfill( [ false(Ri,3) R false(Ri,3) ; false(1,Rj+6) ], S+[0 3], @(F)F(1) > Ri ) - 1

%%

sandfill( [ false(Ri,Ri+3) R false(Ri,Ri+3) ; false(1,Rj+2*Ri+6) ], S+[0 Ri], @(F)F(1) == 1 )
