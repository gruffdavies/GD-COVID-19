p = G.tPopulation;
rowsFiltered = (p.Latitude >= -40 & p.Latitude <= 70 );

popUnfiltered   = G.tPopulation{:,1}/1e6;
pLatsUnfiltered = G.tPopulation{:,2};

pop   = popUnfiltered(rowsFiltered);
pLats = pLatsUnfiltered(rowsFiltered);

popByLats = [pLats pop];


colRGB = [0 0 1];

h = barh( pLats, pop, 'DisplayName', 'Population (2020)') %,'LineWidth',2 ))
h.BarWidth = 1;
h.FaceColor = colRGB;
h.EdgeColor = colRGB*.5;
legend('Location','northeast');
title('Population by Latitude');
xlabel(sprintf("Population (millions)"));
ylabel('Latitude');

% ax1 = gca; % current axes
% ax1_pos = ax1.Position;

%ax1.XColor = 'r';
set(gcf,'Position',[-2159 1884 1430 1194])

%set(gcf,'color','w');
% set(gcf,'Position',[-2159 604 1430 1194])