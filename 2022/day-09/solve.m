
H = head( readcell( 'input.txt' ) );

size( unique( tail( H ), 'rows' ), 1 )

%%

size( unique( tail(tail(tail(tail(tail(tail(tail(tail(tail( H ))))))))), 'rows' ), 1 )
