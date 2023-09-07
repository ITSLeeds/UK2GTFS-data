# Convert to rda

dir.create("data/clean")

fls = list.files("data/raw")
fls = fls[grepl(".",fls, fixed = TRUE)]

for(i in seq_along(fls)){
  fl = fls[i]
  message(fl)
  ext = strsplit(fl, ".", fixed = TRUE)[[1]]
  nm = ext[1]
  ext = ext[2]


  if(ext == "csv"){
    sub = read.csv(file.path("data/raw",fl))
  } else if (ext == "geojson"){
    sub = sf::st_read(file.path("data/raw",fl))
  } else {
    stop("Unknown type")
  }



  if(file.exists(file.path("data/clean",paste0(nm,".rda")))){
    file.remove(file.path("data/clean",paste0(nm,".rda")))
  }

  if(fl == "tiplocs.csv"){
    sub = sub[!is.na(sub$stop_lon),]
    sub = sf::st_as_sf(sub, coords = c("stop_lon","stop_lat"), crs = 4326)
  }

  assign(nm, sub)
  rm(sub)

  save(list = nm, file = file.path("data/clean",paste0(nm,".rda")))

}


# Zip for release

oldwd <- getwd()
setwd("data/clean")
fls <- list.files()
fls <- fls[grepl(".rda",fls, fixed = TRUE)]
zip("all.zip", fls)
setwd(oldwd)
