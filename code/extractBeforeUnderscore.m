function c = extractBeforeUnderscore(cell)

  % c = left(cell,5);
  c = extractBefore(cell,"_");
  if size(c) == 0
    c = cell;
  end 


end 