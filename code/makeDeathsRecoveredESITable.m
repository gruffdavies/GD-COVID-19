function TC = makeDeathsRecoveredESITable(D, R, S_RD)

  global G S;

  ESIs  = f_ESI(D.Deaths(:), R.Recovered(:), S_RD);
  tESIs = array2table(ESIs,'VariableNames',{'ESI'});

  TC                  = D;                     % copy the whole table as starting point
  TC.Recovered        = R.Recovered;           % add Recovered
  TC.DeathsLog10      = log10(1+TC.Deaths);
  TC.RecoveredLog10   = log10(1+TC.Recovered);

  TC.ESI              = tESIs.ESI;             % add ESI
  TC.ESI_abs          = abs(TC.ESI(:));        % add abs(ESI) for plotting (can't plot negatives)
  TC.TentoESI_abs     = 10.^TC.ESI_abs(:);     % add linearised log values
  TC.S_RD             = S_RD .* ones(height(TC),1);
  
end