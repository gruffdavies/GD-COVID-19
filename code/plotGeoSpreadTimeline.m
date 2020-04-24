function plotGeoSpreadTimeline(T, granularity)
  global G;
  % G.tLocationFirstReports

  T_ = T(T.FirstReportDay>=0,:);

  catnums = (0:granularity:90-7)';

  CatLabels = "Day "+num2str(catnums) + " to " + num2str(granularity - 1 + catnums);
  [Y, E] = discretize(T_.FirstReportDay,[0:granularity:90], 'categorical', CatLabels);
  
  gb = geobubble(T_, 'Latitude', 'Longitude');
  gb.SourceTable.FirstReportDay = Y;
  gb.ColorVariable = 'FirstReportDay';
  gb.BubbleWidthRange = [12 12];
  gb.BubbleColorList = hsv(14 / (granularity/7) -1);

  % gb.SizeLegendTitle = sprintf("ESI %s Scale",strScale);    
  gb.title("COVID-19 Visual Timeline of Spread");

  f         = gcf;
  f.Color   = 'white';
  screenpos = 'frontscreen-full';
  moveFigureToScreenPosition(screenpos);

  gb.ColorLegendTitle = '1st Report (D,R)';
  
  pause(1);
  fname  = G.pathFigures + "geobubble-visual-timeline-of-spread.png"
  exportgraphics(f, fname, 'Resolution',300);

end