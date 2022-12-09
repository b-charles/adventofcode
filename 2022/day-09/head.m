function P = head( M )

P = [0 0];

for i = 1:size(M,1)

  if M{i,1} == 'U'
    P = [ P ; [ P(end,1)+(1:M{i,2})' P(end,2)+zeros(M{i,2},1) ] ]; %#ok<*AGROW>
  elseif M{i,1} == 'D'
    P = [ P ; [ P(end,1)-(1:M{i,2})' P(end,2)+zeros(M{i,2},1) ] ];
  elseif M{i,1} == 'R'
    P = [ P ; [ P(end,1)+zeros(M{i,2},1) P(end,2)+(1:M{i,2})'  ] ];
  elseif M{i,1} == 'L'
    P = [ P ; [ P(end,1)+zeros(M{i,2},1) P(end,2)-(1:M{i,2})'  ] ];
  end

end
