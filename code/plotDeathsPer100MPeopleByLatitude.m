
% depends on 2 previous plots running first 
% so data is set up 


setUpColours;

d = deathsHistFinal; % [lats DESC, deaths]

deathsPer100M = d(:,2)./popByLats(:,2);

colRGB = colourSetsRGB.WhiteToRed(5,:);

h = barh( d(:,1), deathsPer100M, 'DisplayName', "28-Mar-2020") %,'LineWidth',2 ))
h.FaceColor = colRGB;
h.EdgeColor = colRGB*.5;
h.BarWidth = 1;

legend('Location','northeast');
title('Deaths Per Million people by Latitude');
xlabel(sprintf("Deaths per million people"));
ylabel('Latitude');

set(gcf,'Position',[-2159 1884 1430 1194])
