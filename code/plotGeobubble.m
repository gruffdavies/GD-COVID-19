function plotGeobubble(T, whatToPlot, strScale, titlePrefix, filenameEnd)
  global G S;

  % strScale = "Linear";
  switch lower(strScale)
    case "linear"
      szVarE  = 'TentoESI_abs';
      % szVarE2 = 'TentoPeakESI';
      szVarR  = 'Recovered';
      szVarD  = 'Deaths';
    case "log"
      szVarE  = 'ESI_abs';
      % szVarE2 = 'PeakESI';
      szVarR  = 'RecoveredLog10';
      szVarD  = 'DeathsLog10';
    otherwise
      disp("invalid scale type: " + strSCale); 
  end

  strTitle  = sprintf("%s - %s Scale %s ", titlePrefix, strScale, whatToPlot)
  fname     = G.pathFigures + "geobubble-"+strScale+"-scale-"+whatToPlot+"-"+filenameEnd+".png"

  switch lower(whatToPlot)

    case "deaths"
      szVar = szVarD;
      gb    = geobubble(T, 'Latitude', 'Longitude', 'SizeVariable', szVar, 'BubbleColorList', [1 0 0], 'BubbleWidthRange', [1 60]);

    case "recovered" 
      szVar = szVarR;
      gb    = geobubble(T, 'Latitude', 'Longitude', 'SizeVariable', szVar, 'BubbleColorList', [0 0 1], 'BubbleWidthRange', [1 100]);

    case "esi" 
      szVar     = szVarE;
      Severity  = discretize(T.ESI,[-10 -1 1 2.5 10],'categorical', {'ESI < -1', '-1 <= ESI < +1','+1 <= ESI < +2.5', 'ESI >= +2.5'});
      gb        = geobubble(T, 'Latitude', 'Longitude', 'SizeVariable', szVar, 'BubbleWidthRange', [1 60]);
      gb.SizeLegendTitle = sprintf("ESI %s Scale",strScale);
      gb.SourceTable.Severity = Severity;
      gb.ColorVariable = 'Severity';
      gb.BubbleColorList = [rgb('blue'); rgb('green'); rgb('Orange'); rgb('red')];
      
      % add S param details to the title
      S_RD      = mode(T.S_RD); % should all be the same value but just in case take the modal average
      strTitle  = sprintf("%s (S = %.1f)", strTitle, S_RD);


    otherwise
      disp("invalid plot type: " + whatToPlot);

  end % switch

  gb.title(strTitle);
  f         = gcf;
  f.Color   = 'white';
  screenpos = 'frontscreen-full';
  moveFigureToScreenPosition(screenpos);
  pause(2);
  exportgraphics(f, fname, 'Resolution',300);

end % function

