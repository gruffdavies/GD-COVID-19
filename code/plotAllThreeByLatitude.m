clf;

hSubPlot = subplot(1,3,1);

hold on;

plotDeathsByLatitudeHBar;
grid on;

hSubPlot = subplot(1,3,2);
plotPopulationByLatitudeHBar;
grid on;

hSubPlot = subplot(1,3,3);
plotDeathsPer100MPeopleByLatitude;
grid on;