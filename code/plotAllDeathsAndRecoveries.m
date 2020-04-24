
% plot deaths surface map

% annoyingly deaths and recoveries are not the same shape!
% Canada is split into territories

clf;
hold on;
setUpColours;
coloursHex  = colourSetsHex.RedWhiteBlue;
colDeath    = hex2rgb(coloursHex{1}); % red
colRecover  = hex2rgb(coloursHex{5}); %blue


categories(1).name = 'Recoveries';
categories(1).on = true;
categories(2).name = 'Deaths';
categories(2).on = true;

for i = 1:2

  pCategory = categories(i).name

  if categories(i).on 
    if pCategory == "Deaths"
      locs      = S.locsD;
      lats      = S.latsD;
      latCount  = S.latsDCount;
      dataSet   = S.deaths;
      colEdge   = colDeath * 0.9;
      colFace     = colDeath;
      yOffsetDot  = 0.25;
      lineWidth   = 1;

    elseif pCategory == "Recoveries"
      locs      = S.locsR;
      lats      = S.latsR;
      latCount  = S.latsRCount;
      dataSet   = S.recoveries;

      colEdge   = colRecover*.9;
      colFace   = colRecover;
      % colFace   = 'white' ; %colRecover * 1.25;
      % colFace   = 'white';

      yOffsetDot     = -0.25;
      lineWidth   = 1;
    end


    for N = 1:latCount

      location_raw  = locs{N};
      location      = strrep(location_raw,'_',char(10)); % TODO replace with cellfun(@extractBeforeUnderscore,locNames,'UniformOutput',false);
      valuesAtLat   = dataSet(:,N);
      indices       = find(valuesAtLat>0);
      count         = size(indices,1);
      latArray      = ones(count,1) .* lats(N);
      % valArray      = sqrt(valuesAtLat(indices));
      valArray      = valuesAtLat(indices);
      % onePersonSize = log10(1+1); %add one otherwise log(1) = 0
      % valArray      = 6 * log10(1+valuesAtLat(indices))/onePersonSize;
      dotScale      = 1/8;

      s_d = scatter(dates(indices), yOffsetDot + latArray, 16 + valArray*dotScale, 'LineWidth', lineWidth );
      s_d.MarkerFaceColor = colFace;
      s_d.MarkerEdgeColor = colEdge;

      % output the last valuee
      % if strcmp(location, 'Italy')
      if count>0
         idx = indices(1); %indices(count);
         % {location 'N = latitudeindex:' N 'idx:' idx 'dates:' dates(idx) 'lats(N):' lats(N) 'valuesAtLat(idx):' valuesAtLat(idx)}
         % labelpoints(dates(idx), lats(N), location, 'FontSize', 8, 'Color', 'black', 'rotation', -45);
         figure1 = gcf;
         % idx dateCount
         if(idx < S.datesCount - 3)
           txt = text(dates(idx)-0.25, lats(N)+0.75, location, 'VerticalAlignment','bottom','HorizontalAlignment','left','FontSize', 7, 'color', colFace);
         end
         % set(txt,'Rotation',30)
      end 
    end % loop lats


  end %if on

end %loops categories

% sTitle = sprintf("%s by Location", pCategory);
title('Timeline Of Spread | Covid-19');

hold off;

set(gcf, 'Position', [-2159 1884 1430 1194]);


addSpreadMarkupToScatter;
