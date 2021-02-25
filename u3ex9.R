install.packages("spData")
install.packages("spDataLarge")
library(spData)
r2<-raster(grain)
print(grain)
summary(grain)
plot(grain)

exp<-writeRaster(grain,filename = "C:/Users/34639/Desktop/cursetr/unitat3/rastexp.grd",format="raster", overwrite=TRUE)


r3<-raster("C:/Users/34639/Desktop/cursetr/unitat3/rastexp.grd")
plot(r3)
