function ok = check( P )

  function varargout = match( v, p, varargin )
    
    varargout = varargin;
    if isempty( v )
      return;
    end
    
    T = regexp( v, [ '^' p '$' ], 'tokens' );
    if isempty( T ) || length( T{1} ) ~= length( varargin )
      return;
    end
    
    varargout = T{1};
    
  end

  function ok = checkYear( v, min, max )
    v = str2double( match( v, '(\d\d\d\d)', '' ) );
    ok = ~isnan( v ) && min <= v && v <= max;
  end

  function ok = checkHGT( v )
    [ v, u ] = match( v, '(\d+)(cm|in)', '0', 'cm' );
    mm = [ 150, 193 ];
    if strcmp( u, 'in' )
      mm = [ 59, 76 ];
    end
    v = str2double( v );
    ok = ~isnan( v ) && mm(1) <= v && v <= mm(2);
  end

  function ok = checkHCL( v )
    ok = ~isempty( match( v, '(#[0-9a-f]{6})', '' ) );
  end

  function ok = checkECL( v )
    ok = any( cellfun( @(c)strcmp( v, c ), { 'amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth' } ) );
  end

  function ok = checkPID( v )
    ok = ~isempty( match( v, '([0-9]{9})', '' ) );
  end

ok = [ ...
  cellfun( @(v) checkYear( v, 1920, 2002 ), { P.byr } ); ...
  cellfun( @(v) checkYear( v, 2010, 2020 ), { P.iyr } ); ...
  cellfun( @(v) checkYear( v, 2020, 2030 ), { P.eyr } ); ...
  cellfun( @checkHGT, { P.hgt } ); ...
  cellfun( @checkHCL, { P.hcl } ); ...
  cellfun( @checkECL, { P.ecl } ); ...
  cellfun( @checkPID, { P.pid } ) ];

end