global G S;

G = {}; % global namespace
S = {}; % short name aliases for convenience

% setup paths
G.pathFigures       = "..\figures\";
G.pathDataPop       = "..\data\population\";
G.pathDataCoord     = "..\data\coordinates\";
G.pathDataJH        = "..\data\JH\";
G.pathDataJH_0328   = G.pathDataJH + "20200328-JHTS\";
G.pathDataJH_0409   = G.pathDataJH + "20200409-JHTS\";
G.pathDataJH_0411   = G.pathDataJH + "20200411-JHTS\";

% First data set analysed up to 28th March
% TIMESERIES data
G.tDeaths28March    = readtable(G.pathDataJH_0328 + "20200328-covid19_deaths.xlsx",             'Sheet','data');
G.tRecoveredByDate  = readtable(G.pathDataJH_0328 + "time_series_covid19_recovered_global.xlsx",'Sheet','recovered');
G.tDeathsByDate     = readtable(G.pathDataJH_0328 + "time_series_covid19_deaths_global.xlsx",   'Sheet','deaths');
G.tLatitudesD       = readtable(G.pathDataJH_0328 + "time_series_covid19_deaths_global.xlsx",   'Sheet','latitudes');
G.tLatitudesR       = readtable(G.pathDataJH_0328 + "time_series_covid19_recovered_global.xlsx",'Sheet','latitudes');
G.tPopulation       = readtable(G.pathDataPop     + "world-population-by-latitude-data-only.xlsx",'Sheet','Sheet1');

G.tLocationCoords   = readtable(G.pathDataJH_0328 + "20200328-location-coordinates-from-recoveries.xlsx", 'Sheet','Sheet1');

% G.tsDeaths      = G.tDeathsByDate(:,2:width(G.tDeathsByDate));
% Canada is split into territories for deaths so fix this (still won't be identical order due to dupe lats)
reconcile_missing_extra_cols();
G.tsDeaths      = G.tDeathsByDate_reconciled(:,2:width(G.tDeathsByDate_reconciled));
G.tsRecovered   = G.tRecoveredByDate(:,2:width(G.tRecoveredByDate));
G.tsDates       = G.tRecoveredByDate(:,1);
% ts arrays
G.aDeaths       = table2array(G.tsDeaths);
G.aRecovered    = table2array(G.tsRecovered);
G.aDates        = table2array(G.tsDates);

G.tsTotals        = array2table(G.aDeaths+G.aRecovered,'VariableNames',G.tsDeaths.Properties.VariableNames());
G.firstReportDate = array2table(findFirstDateGreaterThanThreshold(table2array(G.tsTotals),G.aDates,0),'VariableNames',G.tsTotals.Properties.VariableNames());
G.zeroDayOffsets  = calculateZeroDayOffsets(G.aDates, G.firstReportDate);

s_rd = 6.5; % outbreaks at least 2X worse than flu 
G.aESI    = f_ESI(G.tsDeaths, G.tsRecovered,s_rd);

% the timseries data is per location, with time going down and locations across
G.aPeakESI = max(G.aESI); %NB: countries that go negative immediately will be shown as zero
G.aMinESI  = min(G.aESI); 
G.tPeakESI = array2table(G.aPeakESI,'VariableNames',G.tsRecovered.Properties.VariableNames());

E_  = makeLocationFirstReportsPeakESITable(G.firstReportDate, G.tPeakESI, G.tLocationCoords);
E_.S_RD         = s_rd .* ones(height(E_),1);
E_.ESI_abs      = abs(E_.ESI(:));        % add abs(ESI) for plotting (can't plot negatives)
E_.TentoESI_abs = 10.^E_.ESI_abs(:);     % add linearised log values
G.tLocationFirstReportsPeakESI = E_;

% G.tLocationFirstReports         = makeLocationFirstReportsTable(G.firstReportDate, G.tLocationCoords);

% Second data set up to 9th April
% SINGLE DATE
G.tDeaths_0409_unrec     = readtable(G.pathDataJH_0409 + "20200409-covid19_deaths-table.xlsx",'Sheet','data');
G.tRecovered_0409_unrec  = readtable(G.pathDataJH_0409 + "20200409-covid19_recoveries-table.xlsx",'Sheet','data');
[G.tDeaths_0409 G.tRecovered_0409] = reconcileDeathsRecoveredTableData(G.tDeaths_0409_unrec, G.tRecovered_0409_unrec); 
G.TC = makeDeathsRecoveredESITable(G.tDeaths_0409, G.tRecovered_0409, s_rd);


% CSV Timeseries
G.csvDeaths0411     = readtable(G.pathDataJH_0411 + "time_series_covid19_deaths_global.csv");
G.csvRecovered0411  = readtable(G.pathDataJH_0411 + "time_series_covid19_recovered_global.csv");

D       = readtable(G.pathDataJH_0411 + "time_series_covid19_deaths_global.xlsx", 'ReadVariableNames', true, 'datetime','text');
xlDates = datetime(D{1,4:size(D,2)},'ConvertFrom','excel');
D(1,:)  = [];
G.xlDeaths0411 = D;

R       = readtable(G.pathDataJH_0411 + "time_series_covid19_recovered_global.xlsx", 'ReadVariableNames', true, 'datetime','text');
% xlDates = datetime(D{1,4:size(D,2)},'ConvertFrom','excel');
R(1,:)  = [];
G.xlRecovered0411 = R;


% % create arrays from table data
% G.aDatesD         = table2array(G.tDatesD);
% G.aDeaths         = table2array(G.tDeaths);

% % new reconciled 
G.aLatitudesD     = table2array(G.tLatitudesD_reconciled);
% G.aDeaths_new     = table2array(G.tDeaths_new);

% % DEATHS
% G.aLatitudesR   = table2array(G.tLatitudesR);
% G.aDatesR       = table2array(G.tDatesR);

% % shorter convenient names for commonly used:
% S.dates           = G.aDatesD;
% S.datesCount      = size(S.dates,1);
% S.latsDCount      = size(G.aLatitudesD,2);
% S.latsDCount_new  = size(G.aLatitudesD_new,2);
% S.latsRCount      = size(G.aLatitudesR,2);

% S.latsR       = G.aLatitudesR;
% S.locsR       = G.tRecoveredByDate.Properties.VariableNames(2:S.latsRCount+1); % the table has the extra date col so add 1
% S.recoveries  = G.aRecovered;

% S.latsD       = G.aLatitudesD;
% S.latsD_new   = G.aLatitudesD_new;
% S.locsD       = G.tDeathsByDate.Properties.VariableNames(2:S.latsDCount+1); % the table has the extra date col so add 1
% S.locsD_new   = G.tDeathsByDate_reconciled.Properties.VariableNames(2:S.latsD_new+1); % the table has the extra date col so add 1
% S.deaths      = G.aDeaths;

% % names and location coordinates
% S.lats          = G.tLatitudes{1,:};
% S.longs         = G.tLongitudes{1,:};
% S.locNamesFull  = G.tLongitudes.Properties.VariableNames();
% S.locNames      = cellfun(@extractBeforeUnderscore,S.locNamesFull,'UniformOutput',false);
% S.tots          = G.tTotals;

% S.firstReportDate = array2table(findFirstDateGreaterThanThreshold(table2array(S.tots),S.dates,0),'VariableNames',S.tots.Properties.VariableNames());

% S.zeroDayOffsets = calculateZeroDayOffsets(S.dates, S.firstReportDate);

format short g;
G = orderfields(G)
% S = orderfields(S)


% set up short vars for quick access and reability




