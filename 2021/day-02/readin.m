function M = readin( str )

    dir = struct( ...
        'forward', [ 1 0 ]', ...
        'up', [ 0 -1 ]', ...
        'down', [ 0 1 ] );

    if isfile( str )
        str = fileread( str );
    end

    C = textscan( str, '%s %f' );
    n = length( C{1} );

    M = zeros( 2, n );
    for i = 1:n
        M(:,i) = dir.(C{1}{i}) * C{2}(i);
    end

end