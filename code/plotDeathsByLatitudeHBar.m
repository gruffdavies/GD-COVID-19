
interval  = 14;
daterange = interval*4;
endDate   = datetime('28-mar-2020') 
% datetime('today')-1;
startDate = (endDate-daterange)

deaths      = G.tDeathsByDate;
dates       = deaths{:,1};
latitudes   = G.aLatitudesD;



setUpColours;

iCol = 5;

plotDates = [endDate, endDate-5, endDate-10, endDate-20, endDate-40] 


for i = 5:-1:1

  plotDate = plotDates(5-i+1)
  
  dateIndex     = find(deaths{:,1} == plotDate)
  deathsOnDate =  deaths(dateIndex,:)

  vecDeaths = table2array( deathsOnDate(:, 2:width(deathsOnDate) ) );
  % vecLats = table2array( latitudes(:, 2:width(latitudes) ) );

  m = [latitudes', vecDeaths(:)];
  sm = sortrows(m,1);

  histOnDate = histogramDeaths(sm);
  d = histOnDate;

  daysBefore = datenum(endDate)-datenum(plotDate);
  if daysBefore > 0 
    strDaysBefore = append("-",string(daysBefore), ' days: ');
    % strDaysBefore = append("(", string(daysBefore), ' days before)');
  else
    strDaysBefore = "";
    deathsHistFinal = sortrows(d,1,'descend');
  end
  str = append( strDaysBefore,datestr(plotDate,'local'));
  % str = append( datestr(plotDate,'local'), strDaysBefore);

  % alpha =(plotDate-startDate)/(endDate - startDate);
  % colRGB = hsv2rgb([alpha/40 alpha .25 + alpha*3/4]);
  colRGB = colourSetsRGB.WhiteToRed(iCol,:);


  h = barh(d(:,1), d(:,2), 'DisplayName', str) %,'LineWidth',2 ))
  % h = area(d(:,1), d(:,2), 'DisplayName', str) %,'LineWidth',2 ))

  h.BarWidth = 1;
  h.FaceColor = colRGB;
  h.EdgeColor = colRGB*.5;
  % h.BarWidth = 1;
  iCol = iCol-1;


  % h2 = plot(histOnDate(:,2)/1e3, histOnDate(:,1), 'DisplayName', str, 'Color' ,colRGB,'LineWidth',2 )
  % h = barh(histOnDate(:,2)/1e3, histOnDate(:,1), 'DisplayName', str, 'Color' ,colRGB,'LineWidth',2 )
  %area(histOnDate);
end
%view(90,90) %rotate area plot
legend('Location','northeast');
title('Covid-19 Deaths by Latitude over time');
xlabel(sprintf("Covid-19 deaths"));
ylabel('Latitude');

ax1 = gca; % current axes
ax1_pos = ax1.Position;
%ax1.XColor = 'r';
set(gcf,'Position',[-2159 1884 1430 1194])


