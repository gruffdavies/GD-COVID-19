function T = makeLocationFirstReportsPeakESITable(F, E, L)
  
  F_ = rows2vars(F);
  F_.Properties.VariableNames = {'Location', 'FirstReportDate'};

  E_ = rows2vars(E);
  E_.Properties.VariableNames = {'Location', 'ESI'};

  L_ = sortrows(L);
  F_ = sortrows(F_);
  E_ = sortrows(E_);

  L_.Loc1 = cellfun(@stringClean, L_.Location,'UniformOutput',false);
  L_.Loc2 = cellfun(@stringClean, F_.Location,'UniformOutput',false);
  L_.Loc3 = cellfun(@stringClean, E_.Location,'UniformOutput',false);
  
  L_.FirstReportDate  = F_.FirstReportDate;
  dayZero             = min(datenum(L_.FirstReportDate));
  L_.FirstReportDay   = datenum(L_.FirstReportDate) - dayZero;

  L_.ESI = E_.ESI;

  disp("Check First date possible mismatches:");
  L_(~strcmp(L_.Loc1,L_.Loc2),:)
  L_(~strcmp(L_.Loc1,L_.Loc3),:)

  T = L_;

end
