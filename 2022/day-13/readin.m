function P = readin( filename )

  function [ pack, i ] = parse( l, i )
    pack = cell(1,0);
    while l(i) ~= ']'
      if l(i) == '['
        [ pack{end+1}, i ] = parse( l, i+1 ); %#ok<*AGROW>
        i = i + 1;
      elseif l(i) >= '0' && l(i) <= '9'
        s = i;
        while l(i) ~= ']' && l(i) ~= ','
          i = i + 1;
        end
        pack{end+1} = str2double( l(s:i-1) );
      end
      if l(i) == ','
        i = i+1;
      end
    end
  end

fid = fopen( filename );

P = cell(2,0);

line = fgetl( fid );
while ischar( line )
  P(:,end+1) = { parse( line, 2 ) ; parse( fgetl( fid ), 2 ) };
  fgetl( fid );
  line = fgetl( fid );
end

fclose( fid );

end