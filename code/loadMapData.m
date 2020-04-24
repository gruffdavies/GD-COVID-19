% set up file paths
G.pathMapData = "..\data\Natural_Earth\";
ne_path       = G.pathMapData;
ne_scale      = "110m";

fg             = {};

% fg.land      = "landareas.shp"; % comes with matlab
% fg.land        =  ne_path + "ne_50m_land.shp"
% fg.pop_places  =  ne_path + "ne_50m_populated_places.shp"
% fg.countries   =  ne_path + "ne_50m_admin_0_countries.shp"
% fg.airports    =  ne_path + "ne_50m_airports.shp"
% fg.coastlines  =  ne_path + "ne_50m_coastline.shp"
% fg.regions     =  ne_path + "ne_50m_geography_regions_polys.shp"

fg.map         = ne_path + ne_scale + "_cultural\ne_"+ne_scale+"_admin_0_map_units.shp";
fg.geolines    = ne_path + ne_scale + "_physical\ne_"+ne_scale+"_geographic_lines.shp";
% fg.pop_places  = ne_path + "50m_cultural\ne_50m_populated_places_simple.shp";

% nore: urban data isn't available at 110m scale
fg.urban       = ne_path + "50m_cultural\ne_50m_urban_areas.shp";


% readshapes converting X and Y fields to Lat and Long geocoordinates 
shapes        = {};
entityNames   = fieldnames(fg);

for k = 1:numel(entityNames)
  entity_name = entityNames{k};
  file_name   = getfield(fg, entity_name)
  shape       = shaperead(file_name, 'UseGeoCoords', true);
  shapes      = setfield(shapes, entity_name, shape); 
end

isMapDataLoaded = true;

disp("Map shape data loaded.");