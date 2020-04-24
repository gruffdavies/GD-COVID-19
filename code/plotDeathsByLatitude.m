
interval = 7;
daterange = interval*8;
yesterday = datetime('today')-1;
startDate = (yesterday-daterange);


hold on;
grid on;
%yyaxis left;
for plotDate = startDate:interval:yesterday

  deaths        = G.tDeathsByDate;
  dates         = deaths{:,1};
  % dates         = G.aDatesD;
  
  dateIndex     = find(deaths{:,1} == plotDate);
  deathsOnDate =  deaths(dateIndex,:);

  vecDeaths = table2array( deathsOnDate(:, 2:width(deathsOnDate) ) );
  vecLats = table2array( latitudes(:, 2:width(latitudes) ) ); 
  m = [vecLats(:), vecDeaths(:)];
  sm = sortrows(m,1);

  histOnDate = histogramDeaths(sm);
  str = append( 'Deaths (',datestr(plotDate,'local'),")");
  alpha =(plotDate-startDate)/(yesterday - startDate);
  colRGB = hsv2rgb([alpha/40 alpha .25 + alpha*3/4]);

  h = plot(histOnDate(:,2)/1e3, histOnDate(:,1), 'DisplayName', str, 'Color' ,colRGB,'LineWidth',2 )
  % h = barh(histOnDate(:,2)/1e3, histOnDate(:,1), 'DisplayName', str, 'Color' ,colRGB,'LineWidth',2 )
  %area(histOnDate);
end
%view(90,90) %rotate area plot
legend('Location','northeast');
title('Covid-19 Deaths by Latitude over time');
xlabel(sprintf("Covid-19 deaths (thousands)\nPopulation (100s millions)"));
ylabel('Latitude');

ax1 = gca; % current axes
ax1_pos = ax1.Position;
%ax1.XColor = 'r';
set(gcf,'Position',[-2159 604 1430 1194])


