function h = histogramDeaths(pSortedMatrix)

  % input is a sorted 2d matrix of rows of latitude, deaths

  binsize = 5;
  lats = -40:binsize:70;

  [tmp, lCount] = size(lats);  
  histLatsDeaths = [lats(:), zeros(lCount,1)];

  iLat = 1; %first lat bin
  latCurrBin = lats(iLat); % latitude of the bin

  [iMax, tmp] = size(pSortedMatrix);
  for i = 1:iMax
    latCurrBin
    row = pSortedMatrix(i,:);
    LatCurr = row(1)
    DeathsCurr = row(2)

    if LatCurr > latCurrBin + binsize/2 % offset half bin as we want centre on 0 
      iLat = iLat + 1 ;
      latCurrBin = lats(iLat);
    end 
    iLat
    histLatsDeaths(iLat,2) = histLatsDeaths(iLat,2)+DeathsCurr;
  end

% recompensate for offet as values in wrong bin
  histLatsDeaths(:,1) = histLatsDeaths(:,1);
  h = histLatsDeaths