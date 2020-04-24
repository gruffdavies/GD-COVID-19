function PlotSeveritySixRegionsParameterised(S_RD, plotRelative, plotPortrait, saveAsFilename)
  global G;
  global S;  
  setUpColours;
  
  locs = S.locsD;
  D = G.tDeaths_new;
  R = G.tRecovered;

  setUpRegions;

  % contains a set of six regions each a set of locations 
  Nplots = numel(regions); % = 6

  clf;
  hold on;

  if plotPortrait
    t = tiledlayout(3,2,'TileSpacing','Compact','Padding','Compact');
  else
    t = tiledlayout(2,3,'TileSpacing','Compact','Padding','Compact');
  end

  for i = 1:Nplots

    disp(sprintf(" Generating subplot %i of %d", i, Nplots));

    % get the countries for this region
    locations = regions{i};

    countryLabels = cellfun(@extractBeforeUnderscore,locations,'UniformOutput',false);

    d = D(:,locations);
    r = R(:,locations);
    [ESI_timeseries, severity_integrated]  = f_ESI(d, r, S_RD); % Epidemic Severity Index function

    % filtered table of zero day offsets for the selected countries in this region
    tDayOffsets = S.zeroDayOffsets(:,locations);
    % convert to array
    aDayOffsets = table2array(tDayOffsets);

    % h = subplot(Nplots/2,2,i);
    % h = subplot(Nplots,1,i);
    nexttile;

    set(gca,'linestyleorder',{'-','--',':','-.'},'colororder',colourSetsRGB.NinePlottable,'nextplot','add');

    if plotRelative
      % note X is a matrix here (all offsets differ by country)
      plot(aDayOffsets, ESI_timeseries, 'LineWidth',2);
      uberPrefix = "ESI Relative to Day Zero; "
    else
      % note X is a vector here (all dates same)
      plot(S.dates, ESI_timeseries, 'LineWidth',2);
      uberPrefix = "ESI by Date; "
    end
    % grid(gca,'minor')
    yticks(-4:4);
    grid on;

    h = gcf;
    h.CurrentAxes.YAxis.Limits = [-4 4];

    if plotRelative
      h.CurrentAxes.XAxis.Limits = [0 70];
    end


    % override defaults for China - lots to fit
    switch i 
      case  1
        fontsize          = 6;
        num_cols_inside   = 2;
        num_cols_outside  = 2;
        leg_loc_inside    = 'northeast';
      case 5
        fontsize          = 9;
        num_cols_inside   = 2;
        num_cols_outside  = 2;
        if plotRelative
          leg_loc_inside    = 'southwest';
        else
          leg_loc_inside    = 'southwest';
        end
      otherwise
        fontsize          = 9;
        num_cols_inside   = 2;
        num_cols_outside  = 1;
        leg_loc_inside    = 'north';
    end

    % leg_loc = 'northeast';
    % num_cols = 1;

    h_legend{i} = legend(countryLabels, 'Location',leg_loc_inside,'NumColumns',num_cols_inside,'FontSize',fontsize);

    % if ~plotPortrait 
    %   moveLegendOutside(h_legend{i}, 'northeast', num_cols_outside);
    % end


    % set(gca, 'LooseInset', [0,0,0,0]);


    str = sprintf("Region %d - Epidemic Severity Index", i);
    title(str);
    xlabel('Day');
    ylabel('f(D,R)');
  end


figure1 = gcf;
% strdeathsSensitivityScale = CommaFormat(deathsSensitivityScale);
uberTitle     = sprintf("%s S = %.1f", uberPrefix, S_RD );
uberSubTitle  = sprintf("('severe' = worse than %.1fx that of seasonal flu in the US)", (13/S_RD) );

if plotPortrait
  uberTitlePos      = [0.0931203153972286 0.972872403764898 0.788111888111888 0.03];
  uberSubTitlePos   = [0.0940470994565428 0.961580942932153 0.788111888111888 0.03];
else
  uberTitlePos      = [0.0931203153972286 0.972872403764895 0.488129684602771 0.0300000000000024];
  uberSubTitlePos   = [0.519270833333333 0.970554023689875 0.281770833333333 0.0300000000000025];
end

annotation(figure1,'textbox',...
    uberTitlePos,...
    'Color',[0.043137254901961 0.043137254901961 0.690196078431373],...
    'String',{uberTitle},...
    'HorizontalAlignment','center',...
    'FontWeight','bold',...
    'FontSize',12,...
    'FitBoxToText','off',...
    'EdgeColor','none');

annotation(figure1,'textbox',...
     uberSubTitlePos,...
    'Color',[0.043137254901961 0.043137254901961 0.690196078431373],...
    'String',{uberSubTitle},...
    'HorizontalAlignment','center',...
    'FontSize',9,...
    'FitBoxToText','off',...
    'EdgeColor','none');

  % screenpos = 'leftscreen-landscape-A4';
  % screenpos = 'leftscreen-portrait-upper';
  % screenpos = 'frontscreen-full';
  if plotPortrait
    screenpos = 'leftscreen-portrait-A4';
  else
    screenpos = 'frontscreen-full';
  end
  moveFigureToScreenPosition(screenpos);

  % set(gca,'LooseInset',get(gca,'TightInset'));
  % set(gca, 'LooseInset', [0,0,0,0]);
  disp('Saving figure image');

  % saveas(gcf,saveAsFilename);

  % print(gcf,saveAsFilename,'-dpng','-r300'); 
  exportgraphics(t, saveAsFilename, 'Resolution',300) 



end