# Convert to CSV

load("data/clean/atoc_agency.rda")
write.csv(atoc_agency,"data/raw/atoc_agency.csv", row.names = FALSE)

load("data/clean/historic_bank_holidays.rda")
write.csv(historic_bank_holidays,"data/raw/historic_bank_holidays.csv", row.names = FALSE)

load("data/clean/naptan_missing.rda")
write.csv(naptan_missing,"data/raw/naptan_missing.csv", row.names = FALSE)

load("data/clean/naptan_replace.rda")
write.csv(naptan_missing,"data/raw/naptan_replace.csv", row.names = FALSE)

load("data/clean/tiplocs.rda")
write.csv(naptan_missing,"data/raw/tiplocs.csv", row.names = FALSE)


#Convert to GeoJSON
library(sf)
load("data/clean/rail_heavy.rda")
write_sf(rail_heavy,"data/raw/rail_heavy.geojson")

load("data/clean/rail.rda")
rail_light = rail[rail$type == "light_rail",]
st_crs(rail_light) = 4326
write_sf(rail_light,"data/raw/rail_light.geojson")

load("data/clean/atco_areas.rda")
write_sf(atco_areas,"data/raw/atco_areas.geojson")
