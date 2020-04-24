function zeroDayOffsets = calculateZeroDayOffsets(aDates, tFirstReports)

  aFirsts   = table2array(tFirstReports);
  NumDates  = numel(aDates);
  NumLocs   = size(tFirstReports,2);

  % expand 1 x N locations into M x N
  mOffsets = ones(NumDates,1) * datenum(aFirsts);

  % expand M x 1 dates into M x N datenumbers
  mDateNums = datenum(aDates) * ones(1,NumLocs);

  aZeroDayOffsets =  mDateNums - mOffsets;

  % convert to table 
  zeroDayOffsets = array2table(aZeroDayOffsets ,'VariableNames', tFirstReports.Properties.VariableNames() );

end  