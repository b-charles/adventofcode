
INS = readin( 'data.in' );

disp( rundebug( INS ) );

%%

for i = find( strcmp( { INS.op }, 'jmp' ) | strcmp( { INS.op }, 'nop' ) )
  
  [ acc, loop ] = rundebug( switchop( INS, i ) );
  if ~loop
    disp( acc );
  end
  
end

function INS = switchop( INS, idx )
  if strcmp( INS(idx).op, 'jmp' )
    INS(idx).op = 'nop';
  else
    INS(idx).op = 'jmp';
  end
end
