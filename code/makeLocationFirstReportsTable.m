function T = makeLocationFirstReportsTable(F, L)
  
  F_ = rows2vars(F);
  F_.Properties.VariableNames = {'Location', 'FirstReportDate'};

  L_ = sortrows(L);
  F_ = sortrows(F_);
  L_.Loc1 = cellfun(@stringClean, L_.Location,'UniformOutput',false);
  L_.Loc2 = cellfun(@stringClean, F_.Location,'UniformOutput',false);
  L_.FirstReportDate = F_.FirstReportDate;
  dayZero = min(datenum(L_.FirstReportDate));
  L_.FirstReportDay = datenum(L_.FirstReportDate) - dayZero;

  disp("Check First date possible mismatches:");
  L_(~strcmp(L_.Loc1,L_.Loc2),:)

  T = L_;

end
