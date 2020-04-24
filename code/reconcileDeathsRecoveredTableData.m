function [D_rec, R_rec ] = reconcileDeathsRecoveredTableData(D,R)

  global G S;

  % D = G.tDeaths9April;
  % R = G.tRecovered9April;

  % split deaths table into rows without Canada and rows with (should be 15)
  D_Can_0   = D(~contains(D.Location(:,1),"Canada"),:);
  D_Can_15  = D(contains(D.Location(:,1),"Canada"),:);

  % reconcile ~15 Canadian entries into 1  
  numDeathsCanada   = sum(D_Can_15.Deaths);

  % get Canada on its own from recoveries and use it create a deaths entry 
  D_Can_1           = R(contains(R.Location(:,1),"Canada"),:);
  D_Can_1.Recovered = []; % delete
  D_Can_1.Deaths    = numDeathsCanada;

  D_ = sortrows([D_Can_0; D_Can_1]);
  R_ = sortrows(R);

  % locations in each
  locsD  = D_{:,1};
  locsR  = R_{:,1};

  % see if any other locations are missing from the other set
  DnotinR     = setdiff(locsD,locsR);
  RnotinD     = setdiff(locsR,locsD);

  % filter out any locs not present in both sets
  % keep a record of which locs got filtered
  G.gb = {};
  DF                         = D_(ismember(D_.Location, DnotinR),:);
  RF                         = R_(ismember(R_.Location, RnotinD),:);
  G.gb.deathsFilteredOut     = DF;
  G.gb.recoveredFilteredOut  = RF;

  FilteredCountD = numel(DF{:,1});
  FilteredCountR = numel(RF{:,1});

  D_rec = D_(~ismember(D_.Location, DnotinR),:);
  R_rec = R_(~ismember(R_.Location, RnotinD),:);

  % final sanity check: make sure rows match by name and in order
  mismatches = sum(~strcmp(D_rec{:,1},R_rec{:,1}));
  if mismatches > 0
    msg = "Reconcilition failed. " + num2str(mismatches) + " remaining.";
  else
    msg = "Reconciliation successful. Deaths and Recovered tables contain " + num2str(numel(D_rec{:,1})) + " rows.";
  end

  disp(msg);

end