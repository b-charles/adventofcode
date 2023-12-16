function E = beaming( h, M, E )

SM = size(M);

mN = @(h) [ h(1)-1 h(2) 1 ];
mE = @(h) [ h(1) h(2)+1 2 ];
mS = @(h) [ h(1)+1 h(2) 3 ];
mW = @(h) [ h(1) h(2)-1 4 ];

EMPTY = { mN, mE, mS, mW };
MIRROR_1 = { mE, mN, mW, mS }; % /
MIRROR_2 = { mW, mS, mE, mN }; % \

while 1 <= h(1) && h(1) <= SM(1) && 1 <= h(2) && h(2) <= SM(2) && ~E( h(1), h(2), h(3) )

  E( h(1), h(2), h(3) ) = true;

  if M(h(1), h(2)) == '/'
    h = MIRROR_1{h(3)}( h );
  elseif M(h(1), h(2)) == '\'
    h = MIRROR_2{h(3)}( h );
  elseif M(h(1), h(2)) == '|'

    if h(3) == 1 || h(3) == 3 % N|S
      h = EMPTY{h(3)}( h );
    else % E|W -> N+S
      E = beaming( mN(h), M, E );
      E = beaming( mS(h), M, E );
      return
    end

  elseif M(h(1), h(2)) == '-'

    if h(3) == 2 || h(3) == 4 % E|W
      h = EMPTY{h(3)}( h );
    else % N|S -> E+W
      E = beaming( mE(h), M, E );
      E = beaming( mW(h), M, E );
      return
    end

  else % .
    h = EMPTY{h(3)}( h );
  end

end