### Ejercicios Unidad 4 ###
# Autor: Josep Andreu Sabaté


## 2.0 Librerías (Instalar solo las necesarias!!! )


install.packages('rgeos')


# Cargamos las librerias

library(sf)
library(sp)
library(raster)
library(spData)
library(rgeos)
library(maptools)

# Ejercicio 1
#a)
x<-c(2,4,7,4,2)
y<-c(8,2,11,7,8)
#cració de la llista amb una matriu
xy<-list(cbind(x,y))
#creació de polygon
p1<-st_polygon(xy)
class(p1)#mostra el tipus d'objecte
#b
p1<-st_cast(p1,"MULTIPOLYGON")
#c
p1<-st_cast(p1,"POLYGON")
class(p1)
# Ejercicio 2
#a)
nc_counties<-st_read("C:/Users/34639/Desktop/cursetr/datos/datos 2/datos_vectoriales/NC_Counties.shp")
plot.new()
plot(st_geometry(nc_counties),axes=TRUE)
#b)
names(nc_counties)
head(nc_counties,10)
#c,d)reprojectar
nc_webmercator<-st_transform(nc_counties,st_crs(3857))
plot.new()
plot(st_geometry(nc_webmercator), axes=TRUE)
# Ejercicio 3
nc_hidro<-st_read("C:/Users/34639/Desktop/cursetr/datos/datos 2/datos_vectoriales/NC_Hydro.shp")
# ver si geom es simple y o vallida
st_is_valid(nc_counties)
st_is_simple(nc_counties)
st_is_valid(nc_webmercator)
st_is_simple(nc_webmercator)
#calcul area web mercator i crear nova col
nc_webmercator$Area<-st_area(nc_webmercator)/1000000
names(nc_webmercator)
print(nc_webmercator)
#nova col calc longitud

install.packages("lwgeom")
library(lwgeom)

nc_hidro$Longitud<-st_length(nc_hidro)/1000
names(nc_hidro)
print(nc_hidro)

#d plot ejes, titulo, titulo ejes
plot.new()
plot(st_geometry(nc_counties), main = "Rios Carolina del Norte", xlab = "coordenadas x", ylab = "coordenadas y",axes=TRUE)
plot(st_geometry(nc_hidro),add=TRUE, col="blue")
# Ejercicio 4
sf_LI<-st_read("C:/Users/34639/Desktop/cursetr/datos/datos 2/datos_vectoriales/sf_LIN.shp")
sf_POL<-st_read("C:/Users/34639/Desktop/cursetr/datos/datos 2/datos_vectoriales/sf_POL.shp")
sf_PTS<-st_read("C:/Users/34639/Desktop/cursetr/datos/datos 2/datos_vectoriales/sf_PTS.shp")
#Intersecció
st_intersects(sf_LI,sf_POL, sparse = FALSE)
st_intersects(sf_LI,sf_PTS, sparse = FALSE)

# Ejercicio 5
#calcul centroide
nc_counties<-st_read("C:/Users/34639/Desktop/cursetr/datos/datos 2/datos_vectoriales/NC_Counties.shp")
#  Trasformacion y calculo de centroides
nc_webmercator <- st_transform(nc_counties, 3857)
centroides <- st_centroid(st_geometry(nc_webmercator))

#plot
plot.new()
plot(st_geometry(nc_counties), axes=TRUE,main="Calculo del centroiode")
plot(st_geometry(count_centr), col="red",add=TRUE)
#b
nc_webhidro <- st_transform(nc_hidro, 3857)
bufrios<-st_buffer(nc_webhidro, 1)
#plot
plot.new()
plot(st_geometry(nc_webmercator), main = "Rios Carolina del Norte", xlab = "coordenadas x", ylab = "coordenadas y",axes=TRUE)
plot(st_geometry(bufrios),add=TRUE, col="blue")

# Ejercicio 6
#creo interseccion
int_geom<-st_intersection(st_geometry(sf_LI,sf_POL,sf_PTS))
plot.new()
plot(st_geometry(sf_POL), border = 'blue')
title("GEOMETRYCOLLECTION")
plot(sf_LI, add = TRUE, col = 'red')
plot(st_geometry(int_geom), add = TRUE, col = 'green')

# Ejercicio 7
uni<-st_union(nc_counties)
plot.new()
plot(uni)
int<-st_combine(nc_counties)
plot.new()
plot(int)

# Ejercicio 8
rs1<-stack("C:/Users/34639/Desktop/cursetr/datos/datos 2/datos_raster/mx-bio_4.tif","C:/Users/34639/Desktop/cursetr/datos/datos 2/datos_raster/mx-bio_5.tif","C:/Users/34639/Desktop/cursetr/datos/datos 2/datos_raster/mx-bio_6.tif")
print(rs1)
plot(rs1)
extent(rs1)
res(rs1)
projection(rs1)
# Ejercicio 9
r9<-raster("C:/Users/34639/Desktop/cursetr/datos/datos 2/datos_raster/mx-bio_5.tif")
plot.new()
plot(r9)
print(r9)

temp<-(r9/10)
plot.new()
plot(temp)
print(temp)

# Ejercicio 10
rfilmin<-focal(temp, w=matrix(1,3,3), fun=min)
plot.new()
plot(rfilmin)
rfilmax<-focal(temp, w=matrix(1,3,3), fun=max)
plot.new()
plot(rfilmax)