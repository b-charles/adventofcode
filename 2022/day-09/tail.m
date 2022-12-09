function T = tail( H )

T = [0 0];

for i = 1:size(H,1)

  d = T(end,:) - H(i,:);

  if d(1)>1 && d(2)<-1
    T = [ T ; H(i,:)+[1 -1] ]; %#ok<*AGROW>
  elseif d(1)>1 && d(2)>1
    T = [ T ; H(i,:)+[1 1] ];
  elseif d(1)<-1 && d(2)>1
    T = [ T ; H(i,:)+[-1 1] ];
  elseif d(1)<-1 && d(2)<-1
    T = [ T ; H(i,:)+[-1 -1] ];
  elseif d(1)>1
    T = [ T ; H(i,:)+[1 0] ];
  elseif d(1)<-1
    T = [ T ; H(i,:)-[1 0] ];
  elseif d(2)>1
    T = [ T ; H(i,:)+[0 1] ];
  elseif d(2)<-1
    T = [ T ; H(i,:)-[0 1] ];
  else
    T = [ T ; T(end,:) ];
  end

end

T = T(2:end,:);