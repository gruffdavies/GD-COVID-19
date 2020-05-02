%function T = makeLocationFirstReportsPeakAndLatestESITable(F, PE, LE, L)
function T = combineFirstReportsPeakESILatestESIAndLocationsTables(F, PE, LE, D, R, L)
% NB: similar makeLocationFirstReportsPeakESITable() but I don't have time to refactor common code
% this version makes a table for output to Excel rather than plotting 
% F:  (1 x N) table of location first report dates  
% PE: (1 x N) table of Peak ESI values              
% LE: (1 x N) table of date-specific ESI values       
% D:  (1 x N) table of date-specific Deaths
% R:  (1 x N) table of date-specific Recoveries
% L:  (N x 3) table of location coordinates 
  
  F_ = rows2vars(F);
  F_.Properties.VariableNames = {'Location', 'FirstReportDate'};

  PE_ = rows2vars(PE);
  PE_.Properties.VariableNames = {'Location', 'ESI_peak'};

  LE_ = rows2vars(LE);
  LE_.Properties.VariableNames = {'Location', 'ESI_last'};

  D_ = rows2vars(D);
  D_.Properties.VariableNames = {'Location', 'Deaths'};

  R_ = rows2vars(R);
  R_.Properties.VariableNames = {'Location', 'Recovered'};

  L_  = sortrows(L);
  F_  = sortrows(F_);
  PE_ = sortrows(PE_);
  LE_ = sortrows(LE_);
  D_  = sortrows(D_);
  R_  = sortrows(R_);

  % for sanity checking everything matches after sorting (not checking every table since they all use the same source locations) 
  L_.Loc1 = cellfun(@stringClean, L_.Location,'UniformOutput',false);
  L_.Loc2 = cellfun(@stringClean, F_.Location,'UniformOutput',false);
  L_.Loc3 = cellfun(@stringClean, PE_.Location,'UniformOutput',false);
  L_.Loc4 = cellfun(@stringClean, LE_.Location,'UniformOutput',false);
  
  L_.FirstReportDate  = F_.FirstReportDate;
  dayZero             = min(datenum(L_.FirstReportDate));
  L_.FirstReportDay   = datenum(L_.FirstReportDate) - dayZero;

  L_.ESI_peak = PE_.ESI_peak;
  L_.ESI_last = LE_.ESI_last;

  L_.Deaths        = D_.Deaths;           
  L_.Recovered     = R_.Recovered;        
  L_.DeathsLog10   = log10(1+D_.Deaths);
  L_.RecovsLog10   = log10(1+R_.Recovered);


  disp("Check First date possible mismatches:");
  L_(~strcmp(L_.Loc1,L_.Loc2),:)
  L_(~strcmp(L_.Loc1,L_.Loc3),:)
  L_(~strcmp(L_.Loc1,L_.Loc4),:)

  % comment out if mismatches to debug:
  L_.Loc1 = [];
  L_.Loc2 = [];
  L_.Loc3 = [];
  L_.Loc4 = [];

  T = L_;

end
