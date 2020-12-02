##lets use magick to:
## back up original photos ont he d drive
##resize teh photos in our main file
##convert our pngs to jpg
##make a composite image of all the most relevant culvert shots for easy display in leaflet yo
##get rid of the AAE files from the iphone.



library(tidyverse)
library(magick)

##back up your photos onto the D drive.

##create a folder to copy the photos to


##get teh name of the folder we are in
bname <- basename(dirname(dirname(getwd())))

##input the name of the file we want to copy.  We should get a list of files next time and then purrr::map the procedure
filename = "backup"

##here we back everything up to the D drive
targetdir = paste0(getwd(), '/', filename)
dir.create(targetdir)


##path to the photos
path <- paste0(getwd(),'/fig')

filestocopy <- list.files(path = path,
                          full.names = T,
                          pattern = ".*\\.(JPG|png)$") #https://stackoverflow.com/questions/56773187/how-to-select-multiple-files-with-different-extension-in-filelist-in-r



# #copy over the photos in the al folder -- this is done already
# file.copy(from=filestocopy, to=targetdir,
#           overwrite = F, recursive = FALSE,
#           copy.mode = TRUE)


##this scales everything and converts everything to jpg
# img_resize_convert <- function(img){
#   image <- image_read(img)
#   image_scaled <- image_scale(image,"1440x1080!") #1080
# image_write(image_scaled, path = paste0(path, '/', tools::file_path_sans_ext(basename(img)), '.JPG'), format = 'jpg')
# }

img_resize_convert <- function(img, width = "1440", height = "x1080!"){
  image <- image_read(img)
  image_scaled <- image_scale(image, paste0(width, height)) #1080
  image_write(image_scaled, path = paste0(path, '/', tools::file_path_sans_ext(basename(img)), '.JPG'), format = 'jpg')
}

filestocopy %>%
  purrr::map(img_resize_convert)

##had a couple of photos to resize
filestoresize <- paste0(getwd(), '/fig/', c('overview_map_bulk.jpg', 'overview_map_pars.jpg'))
filestoresize <- paste0(getwd(), '/fig/', c('fwcp Logo for reports.jpg', 'HCTFLogo-Hst.jpg'))
img_resize_convert(paste0(getwd(), '/fig/', 'SERNbc-Logo-FULL.jpg'), height = 'x400')

filestoresize %>% 
  purrr::map(img_resize_convert, width = "", height = 'x120')

############ remove the png files that are now converted to jpg
##identify all the png files in the folder
filesremove <- grep('.png', filestocopy, value=TRUE)

file.remove(filesremove)

