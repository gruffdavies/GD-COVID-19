function moveLegendOutside(h_legend, pos_inside, nCols)
% This keeps plot area size constant:

  pos_outside = sprintf("%soutside",pos_inside);

  % set unit for figure size to inches
  % set(gcf, 'unit', 'inches');

  % get the original size of figure before the legends are added
  figure_size =  get(gcf, 'position');

  % add legends and get its handle
  % h_legend = legend('legend1', 'legend');

  set(h_legend, 'location', pos_outside, 'NumColumns', nCols);

  % set unit for legend size to inches
  % set(h_legend, 'unit', 'inches');

  % % get legend size
  legend_size = get(h_legend, 'position')

  % % new figure width
  figure_size(3) = figure_size(3) + legend_size(3);

  % % set new figure size
  set(gcf, 'position', figure_size);
end