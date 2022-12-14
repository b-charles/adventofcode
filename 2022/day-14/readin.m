function [ R, S ] = readin( filename )

col = @(a,b) a:sign(b-a+0.1):b;

R = false;
offset_x = 499;

fid = fopen( filename );

line = fgetl( fid );
while ischar( line )

  P = cellfun( @str2double, split( split( line, ' -> ' ), ',' ) );
  P(:,1) = P(:,1) - offset_x;
  P(:,2) = P(:,2) + 1;

  min_x = min(P(:,1));
  if min_x < 1
    % Px + o = m
    R = [ false( size(R,1), -min_x + 1 ) R ]; %#ok<*AGROW>
    offset_x = offset_x + min_x - 1;
    P(:,1) = P(:,1) - min_x + 1;
  end

  max_x = max(P(:,1));
  if max_x > size(R,2)
    R = [ R false( size(R,1), max_x - size(R,2) ) ]; %#ok<*AGROW>
  end

  max_y = max(P(:,2));
  if max_y > size(R,1)
    R = [ R; false( max_y - size(R,1), size(R,2) ) ];
  end

  C = P(1,:);
  for p = 2:size( P, 1 )
    R( col(C(2),P(p,2)), col(C(1),P(p,1)) ) = true;
    C = P(p,:);
  end

  line = fgetl( fid );

end

S = [ 1 500-offset_x ];

fclose( fid );
