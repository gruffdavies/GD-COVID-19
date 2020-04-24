
%% superceded by plotAllDeathsAndRecoveries

% plot deaths surface map

% annoyingly deaths and recoveries are not the same shape!
% Canada is split into territories
% latsD        = S.latsD;
% latsR        = S.latsR;
% dates       = S.dates;
% deaths      = S.deaths;
% recoveries  = S.recoveries;

% [dateCountD,latCountD] = size(latsD);
% [dateCountR,latCountR] = size(latsR);

% locsD = S.locsD; %.tDeathsByDate.Properties.VariableNames(2:latCountD+1); % the table has the extra date col so add 1
% locsR = S.locsR; % G.tRecoveredByDate.Properties.VariableNames(2:latCountR+1); % the table has the extra date col so add 1

% NumOfDoublings = 12;
iterations = 600;

clf;
hold on;

% for N = 1:NumOfDoublings
for N = 1:iterations

  firstDeathDates     = NaT(1, S.latCountD);
  firstRecoveredDates = NaT(1, S.latCountR);

  % firstNThreshold = 2^N

  %firstNThreshold = 1 + 2*(N-1)
  firstNThreshold = N

  for i = 1:S.latCountD
    % assumes dates in ascending order:
    firstD = find(S.deaths(:,i) >= firstNThreshold,1,'first');
    if ~isempty(firstD)
      firstDeathDates(i) = S.dates(firstD);
    end
  end

  for i = 1:S.latCountR
    firstR = find(S.recoveries(:,i) >= firstNThreshold,1,'first');
    if ~isempty(firstR)
      firstRecoveredDates(i) = S.dates(firstR);
    end
  end


  plotcol = 1 - 0.8*(N/iterations);
  edgecol = 0.75;
  yoffset = 0.25;

  pointsize = 8; %*sqrt(firstNThreshold);

  s_d = scatter(firstDeathDates, S.latsD+yoffset, pointsize);
  s_d.MarkerFaceColor = [plotcol 0 0];
  s_d.MarkerEdgeColor = [edgecol 0 0];

  % s_r = scatter(firstRecoveredDates,latsR-yoffset,pointsize);
  % s_r.MarkerFaceColor = [0 plotcol 0];
  % s_r.MarkerEdgeColor = [0 edgecol 0];
  

  % label first
  if(N == 1)
    labelpoints(firstDeathDates     , S.latsD, S.locsD, 'FontSize', 8, 'Color', [0.75 0.5 0.5], 'rotation', -45);
    % labelpoints(firstRecoveredDates , latsR, locsR, 'FontSize', 8, 'Color', [0.5 0.75 0.5], 'rotation', 45);
  end

  % if(N > 10)
    % labelpoints(firstDeathDates,latsD,locsD,'SE','FontSize', 12, 'Color', 'black','FontWeight','bold','rotation', 16 ); %, 'rotation', 45);
    % labelpoints(firstDeathDates,latsD,locsD,    'SE','FontSize', 12, 'Color', [edgecol 0 0],'FontWeight','bold','rotation', 20 ); %, 'rotation', 45);
    % labelpoints(firstRecoveredDates,latsR,locsR,'SE','FontSize', 12, 'Color', [0 edgecol 0],'FontWeight','bold','rotation', 20 ); %, 'rotation', 45);
  % end

end % loop doubling

% if(firstNThreshold == 1)
%   sTitle = sprintf("First Death and First Recovery by Location");
% else
% sType = "Deaths";
% sType = "Deaths and Recoveries";
sType = "Deaths";
sTitle = sprintf("1st to %ith %s by Location", firstNThreshold, sType);
% end  

title(sTitle);

hold off;

set(gcf,'Position', [-2159 1884 1430 1194]);
