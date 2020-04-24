% data and variables loaded in loadData.m
% reconcile_missing_extra_cols

function reconcile_missing_extra_cols()
global G;
  % 1. deaths has 14 more columns
  % data for canada is split out into counties 

  % This script combines them into one Canada to match recoveries

  D = G.tDeathsByDate;
  LD = G.tLatitudesD;

  R = G.tRecoveredByDate;
  LR = G.tLatitudesR;

  %C = setdiff(A,B) returns the data in A that is not in B, with no repe titions. C is in sorted order.
  DV    = D.Properties.VariableNames;
  locsD = DV(2:size(DV,2));
  RV    = R.Properties.VariableNames;
  locsR = RV(2:size(RV,2));

  % shouldn't do this here but technical debt for now
  G.locsD = locsD;
  G.locsR = locsR;

  D_NotIn_R = setdiff( G.locsD, G.locsR); % 15 canandian states
  R_NotIn_D = setdiff( G.locsR, G.locsD); % Canada

  % sum all R_NotIn_D into a single col for Canada

  tD_Canada     = D(:,D_NotIn_R);
  aD_CanadaCols = table2array(tD_Canada);
  aD_CanadaCol  = sum(aD_CanadaCols,2);
  tD_CanadaCol = array2table(aD_CanadaCol, 'VariableNames', R_NotIn_D);

  % remove the 15 Canadas
  D__   = removevars(D,D_NotIn_R);
  LD__  = removevars(LD,D_NotIn_R);

  % find the place to put it
  MissingColNumber = find(ismember(R.Properties.VariableNames, R_NotIn_D) == 1);

  % insert the summed Canada col data
  D__.Canada  = aD_CanadaCol;
  % add latitude from the recovery data
  LD__.Canada = LR.Canada;

  D_ = movevars(D__,R_NotIn_D,'Before',MissingColNumber);
  L_ = movevars(LD__,R_NotIn_D,'Before',MissingColNumber);

  % STORE THE NEW DATA in G
  G.tDeathsByDate_reconciled = D_;
  G.tLatitudesD_reconciled = L_;

  DV    = D.Properties.VariableNames;
  locsD = DV(2:size(DV,2));
  RV    = R.Properties.VariableNames;
  locsR = RV(2:size(RV,2));

  
  DV_ = D_.Properties.VariableNames;
  RV = R.Properties.VariableNames;
  
  % STORE THE NEW LOCS  in G
  G.locsD_new = DV_(2:size(DV_,2));
  
  % --------------------------------------------------------------------------------
  % Sanity check - differences should be sort order for places with identical lats

  isSame = string(strcmp(DV_,RV));
  comp = [(1:240)', isSame(:), DV_(:), RV(:)];

  % list mismatches in the locations
  'Deaths vs recovery table mismatches (sort order for places with identical lats?)'
  mismatches = comp (~strcmp(DV_,RV),:)

  % check the latitudes - should be pairs of identical values
  G.tLatitudesR{1,mismatches(:,3)}

  % fix by swapping each pair - step=2 
  D_    = G.tDeathsByDate_reconciled;
  L_  = G.tLatitudesD_reconciled;
  for i = 1:2:size(mismatches,1)

    index1 = str2num(mismatches(i,1));
    index2 = str2num(mismatches(i+1,1));

    % sanity check they're one apart
    {index1, index2, '1 apart?'}
    
    if index2-index1 ~= 1 
      print "ERROR";
      return;
    end 

    % swap the pairs in the new deaths table and the latitudes table
    D_ = movevars(D_,index2,'Before',index1);
    L_ = movevars(L_,index2,'Before',index1);

  end

  % STORE THE RESULTS IN G
  G.tDeathsByDate_reconciled  = D_;
  G.tLatitudesD_reconciled    = L_;

  % update locs
  DV_ = D_.Properties.VariableNames;
  G.locsD_new = DV_(2:size(DV_,2));

  isSame = string(strcmp(DV_,RV));
  comp2 = [(1:240)', isSame(:), DV_(:), RV(:)];

  % list mismatches in the locations
  'After fixing should be no Deaths vs recovery table mismatches:'
  mismatches2 = comp2 (~strcmp(DV_,RV),:)
  if size(mismatches2,1) == 0
    'Successful reconciliation of death and recovery data'
  end 

end