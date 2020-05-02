

% deathsSensitivityScale, minRecoveriesToDeathsRatio, saveAsFilename

setUpRegions;

% choose regions:
regions = regionsA;

% baseFileName = G.pathFigures+'20200502-ESI-six-regions';
baseFileName = G.pathFigures+'\ESI\20200410-ESI-six-regions';

plotPortrait = true;

% set to true to use zeroDayOffsets
plotRelativeStates = [false true];
aS_RD  = [4.4 6.5 13];
% aS_RD  = [6.5];

% plotRelativeStates = [true];
% aS_RD  = [6.5];

plotcount = numel(aS_RD);

for i = 1:numel(plotRelativeStates)

  plotRelative = plotRelativeStates(i);

  if plotRelative
    strRel = "rel-day0";
  else
    strRel = "by-date";
  end


  for j = 1:plotcount

    disp(sprintf("Generating plot %d of %d", j, plotcount));

    S_RD  = aS_RD(j);

    saveAsFilename = sprintf("%s-S_RD-%.1f-%s.png", baseFileName, S_RD, strRel);

    PlotSeveritySixRegionsParameterised(S_RD, plotRelative, plotPortrait, saveAsFilename);

  end

end