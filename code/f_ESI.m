function [ESI, ESI_SUM] = f_ESI(D, R, S)
% 2020-Apr-09 - GD - New ESI function requiring only deaths, recoveries and min survival rates

  % assumes either both inputs contain table data representing timeseries or both are single values
  % haven't got time to properly check conditions here #TECHDEBT
  if (istable(D) | istable(R))
    D = table2array(D);
    R = table2array(R);
  end

  min_sensitivity      = 20; % starting 'resolution' in terms of totals
  res_scale_stabiliser = 2*min_sensitivity;  % stabilises function for low values of R + D 
  % ensures ESI is stable for reported values < `res_scale_stabiliser`, and then normalises numbers as they scale beyond `stabilise_below`

  % s = min survival ratio, e.g. 10 requires 10 survivors for every death to give 0 
  severity      = (S*D) - R;
  normaliser    = min_sensitivity + ((R + D)/res_scale_stabiliser);
  scale_linear  = 1 + D;

  if numel(D) == 1
    disp(sprintf("severity: %.2f", severity));
    disp(sprintf("normaliser: %.2f", normaliser));
    disp(sprintf("scale_linear: %.2f", scale_linear));
  end

  % {'severity' size(severity,1) size(severity,2) }
  % {'normaliser' size(normaliser,1) size(normaliser,2)}
  % {'scale_linear' size(scale_linear,1) size(scale_linear,2)}

  ESI  = tanh(severity./normaliser) .* log10(scale_linear); % time series

  % if matrix of timeseries and locations is supplied this will sum on the default axis (down) to give
  % a value of ESi integrated over time per location
  ESI_SUM  = sum(ESI);

  return 

end