function firstDates = findFirstDateGreaterThanThreshold(aReports, aDates, threshold)

  % setup 1xN array of Dates (NaT = "Not a time")
  NumCols     = size(aReports,2);
  firstDates  = NaT(1, NumCols);

  for i = 1:NumCols
    % assumes dates in ascending order:
    first = find(aReports(:,i)  > threshold,1,'first');
    if ~isempty(first)
      firstDates(i) = aDates(first);
    end
  end

end
