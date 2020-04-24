

% deathsSensitivityScale, minRecoveriesToDeathsRatio, saveAsFilename

baseFileName = 'figures\20200410-ESI-six-regions';

plotPortrait = true;

% set to true to use zeroDayOffsets
plotRelativeStates = [false true];
aS_RD  = [4.4 6.5 13];

% plotRelativeStates = [true];
% aS_RD  = [6.5];

plotcount = numel(aS_RD);

for i = 1:numel(plotRelativeStates)

  plotRelative = plotRelativeStates(i);

  if plotRelative
    strRel = "relativeto-dayzero";
  else
    strRel = "absolute-date";
  end


  for j = 1:plotcount

    disp(sprintf("Generating plot %d of %d", j, plotcount));

    S_RD  = aS_RD(j);

    saveAsFilename = sprintf("%s-S_RD-%.1f-%s.png", baseFileName, S_RD, strRel);

    PlotSeveritySixRegionsParameterised(S_RD, plotRelative, plotPortrait, saveAsFilename);

  end

end