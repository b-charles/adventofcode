function [ acc, loop ] = rundebug( INS )

  [ INS.run ] = deal( false );
  loop = false;

  acc = 0;
  ptr = 1;

  while ptr < length( INS )

    if INS(ptr).run
      loop = true;
      return
    end
    INS(ptr).run = true;

    if strcmp( INS(ptr).op, 'acc' )
      acc = acc + INS(ptr).arg;
      ptr = ptr + 1;

    elseif strcmp( INS(ptr).op, 'jmp' )
      ptr = ptr + INS(ptr).arg;

    elseif strcmp( INS(ptr).op, 'nop' )
      ptr = ptr + 1;

    end

  end

end