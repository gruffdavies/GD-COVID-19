% https://colorbrewer2.org/
colourSetsHex.RedWhiteBlue      = {'#ca0020','#f4a582','#f7f7f7','#92c5de','#0571b0'};
colourSetsHex.RedYellowBlue     = {'#d7191c','#fdae61','#ffffbf','#abd9e9','#2c7bb6'};
colourSetsHex.PurpleWhiteGreen  = {'#7b3294','#c2a5cf','#f7f7f7','#a6dba0','#008837'};
colourSetsHex.WhiteToRed        = {'#ffffff', '#fef0d9','#fdcc8a','#fc8d59','#d7301f'};
colourSetsHex.TenPlottable      = {'#e41a1c','#377eb8','#4daf4a','#984ea3','#ff7f00','#ffff33','#000000','#a65628','#f781bf','#999999'}; %NB:  6th = bright yellow
colourSetsHex.NinePlottable     = {'#e41a1c','#377eb8','#4daf4a','#984ea3','#ff7f00','#000000','#a65628','#f781bf','#999999'}; % without yellow

colourSetsRGB.RedWhiteBlue      = hex2rgb(colourSetsHex.RedWhiteBlue);
colourSetsRGB.RedYellowBlue     = hex2rgb(colourSetsHex.RedYellowBlue);
colourSetsRGB.PurpleWhiteGreen  = hex2rgb(colourSetsHex.PurpleWhiteGreen);
colourSetsRGB.WhiteToRed        = hex2rgb(colourSetsHex.WhiteToRed);
colourSetsRGB.TenPlottable      = hex2rgb(colourSetsHex.TenPlottable);
colourSetsRGB.NinePlottable     = hex2rgb(colourSetsHex.NinePlottable);



% named colours
colours = {};
colours.darkfactor      = 0.5;

colours.lightGreen      = [0.5 1.0 0.5];
colours.darkGreen       = colours.lightGreen*colours.darkfactor;

colours.lightBlue       = [0.5 0.5 1.0];
colours.darkBlue        = colours.lightBlue*colours.darkfactor;

colours.lightMagenta    = [1.0 0.5 1.0];
colours.lighterMagenta  = [1.0 0.75 1.0];
colours.darkMagenta     = colours.lightMagenta*colours.darkfactor;

colours.lightPurple     = colours.lightMagenta;
colours.lighterPurple   = colours.lighterMagenta;

colours.lightRed        = [1.0 0.5 0.5];
colours.lighterRed      = [1.0 0.75 0.75];

colours.lightGrey       = [0.75 0.75 0.75];

colours.orange          = [1.0 0.70 0.0];
colours.darkOrange      = colours.orange*colours.darkfactor;
