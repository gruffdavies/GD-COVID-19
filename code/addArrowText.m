function arrow = addArrowtext(pDate, pOffset, pChartMinDate, y, yOffset, yChartMax, pText, pArrowColour)
global deaths;
global latitudes;
global hFigure;

    dateMax = datenum(max(deaths.Date));
    dateMin = datenum(pChartMinDate);
    dateRange = dateMax - dateMin;

    axesHandles = findall(hFigure,'type','axes');
    areaPosition = get(axesHandles,'position');

    xPosition = datenum(pDate);
    yPosition = y;

    pos1 = [((xPosition - dateMin + pOffset)/dateRange) * areaPosition(3) + areaPosition(1),...
         ((xPosition - dateMin)/dateRange) * areaPosition(3) + areaPosition(1) ];
    pos2 =  [(yPosition+yOffset)/yChartMax * areaPosition(4) + areaPosition(2),...
         (yPosition)/yChartMax * areaPosition(4) + areaPosition(2)];
    
    arrow = annotation('textarrow', pos1, pos2);
    arrow.String = pText;
    arrow.HorizontalAlignment = 'center';
    arrow.Color = pArrowColour;

