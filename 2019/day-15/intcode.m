function [ state, ask_input ] = intcode( varargin )

  if length( varargin ) == 2
    state = struct( ...
      'codes', int64( varargin{1} ), ...
      'ptr', 1, ...
      'in', varargin{2}, ...
      'i', 1, ...
      'base', 0, ...
      'out', [] );
  else
    state = varargin{1};
  end

  ask_input = false;

  function m = mode( index, arg )
    m = rem( floor( state.codes(index) / (10^(arg+1)) ), 10 );
  end

  function value = get( index, arg )

    function v = safeget( index )
      if( index > length( state.codes ) )
        state.codes( index ) = 0;
      end
      v = state.codes( index );
    end

    m = mode( index, arg );

    value = safeget( index + arg );
    if( m == 0 )
      value = safeget( value + 1 );
    elseif( m == 2 )
      value = safeget( state.base + value + 1 );
    end

  end

  function set( index, arg, value )
    m = mode( index, arg );

    varg = state.codes( index + arg ) + 1;
    if( m == 0 )
      state.codes( varg ) = value;
    elseif( m == 1 )
      error( 'Can not assign to constant.' );
    elseif( m == 2 )
      state.codes( state.base + varg ) = value;
    end
  end

  while( true )

    code = rem( state.codes(state.ptr), 100 );

    if code == 1
      set( state.ptr, 3, get( state.ptr, 1 ) + get( state.ptr, 2 ) );
      state.ptr = state.ptr+4;

    elseif code == 2
      set( state.ptr, 3, get( state.ptr, 1 ) * get( state.ptr, 2 ) );
      state.ptr = state.ptr+4;

    elseif code == 3
      if( state.i > length( state.in ) )
        ask_input = true;
        break;
      end
      set( state.ptr, 1, state.in(state.i) );
      state.i = state.i+1;
      state.ptr = state.ptr+2;

    elseif code == 4
      state.out = [state.out get( state.ptr, 1 )];
      state.ptr = state.ptr+2;

    elseif code == 5
      if get( state.ptr, 1 ) ~= 0
        state.ptr = get( state.ptr, 2 )+1;
      else
        state.ptr = state.ptr+3;
      end

    elseif code == 6
      if get( state.ptr, 1 ) == 0
        state.ptr = get( state.ptr, 2 )+1;
      else
        state.ptr = state.ptr+3;
      end

    elseif code == 7
      set( state.ptr, 3, get( state.ptr, 1 ) < get( state.ptr, 2 ) );
      state.ptr = state.ptr+4;

    elseif code == 8
      set( state.ptr, 3, get( state.ptr, 1 ) == get( state.ptr, 2 ) );
      state.ptr = state.ptr+4;

    elseif code == 9
      state.base = state.base + get( state.ptr, 1 );
      state.ptr = state.ptr+2;

    elseif code == 99
      break;
    else
      error( 'Unexpected code: %d at %d', state.codes(state.ptr), state.ptr )
    end

  end

end
