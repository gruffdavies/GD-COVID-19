
scales      = ["Linear", "Log"];
plotTypes   = ["Deaths", "Recovered", "ESI"];

for s = 1:numel(scales)
  for p = 1:numel(plotTypes)
    plotGeobubble(G.TC, plotTypes(p), scales(s), "9th April", "0409");
  end
end 