function moveFigureToScreenPosition(posDesc)

  switch posDesc
    
    case 'leftscreen-portrait-lower'
      position = [-2159 604 1430 1194];

    case 'leftscreen-portrait-upper'
      position = [-2159 1884 1430 1194];

    case 'leftscreen-portrait-full'
      position = [-2159 603 1440 2483];

    case 'leftscreen-portrait-A4'
      position = [-1974 1107 1079 1417];

    case 'leftscreen-landscape-A4'
      position = [-3524 843 1919 1135];
      
    
    % case 'frontscreen-75%'
    %   position = [];

    % case 'frontscreen-left'
    %   position = [];

    % case 'frontscreen-right'
    %   position = [];

    case 'frontscreen-full'
      position = [1 1084 1920 1003];

    case 'laptopscreen-full'
      position = [1 82 1920 922];

    case 'laptopscreen-75%'
      position = [242 208 1438 663];

    % case ''
    %   position = ;

  end

  set(gcf,'Position',position);

end