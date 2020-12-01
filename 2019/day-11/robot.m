function  [ G, out, POS ] = robot( codes, start )

POS = [1;1];

d = [0; 1];
  function p = move( p, t )

    if t == 0
      d = [0 -1;1 0]*d;
    else
      d = [0 1;-1 0]*d;
    end

    p = p + d;

  end

  G = [ start ];

  [ state, ask ] = intcode( codes, [] );

  ask = true;
  while ask

    if POS(1,end) <= 0
      G = [ zeros( size(G,1), 1 ) G ];
      POS(1,:) = POS(1,:) + 1;
    end
    if POS(1,end) > size(G,2)
      G = [ G zeros( size(G,1), 1 ) ];
    end
    if POS(2,end) <= 0
      G = [ G ; zeros( 1, size(G,2) ) ];
      POS(2,:) = POS(2,:) + 1;
    end
    if POS(2,end) > size(G,1)
      G = [ zeros( 1, size(G,2) ) ; G ];
    end

    p = 1 + size(G,1)*POS(1,end) - POS(2,end);

%     D = G + 1;
%     D(p) = -D(p);
%     clc;
%     disp(D);
%     disp( out );

    state.in = [ state.in G( p ) ];

    [ state, ask] = intcode( state );

    out = reshape( double( state.out ), 2, [] )';
    G( p ) = out( end, 1 );
    POS = [ POS move( POS(:,end), out( end, 2 ) ) ];

  end

end
