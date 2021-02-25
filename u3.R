install.packages(sp)
#cargar paquets
library(sf)
library(raster)
library(spData)

#Exercici 1
sfg1<-st_point(c(3,7))
sfg2<-st_point(c(-4,9))
sfg3<-st_point(c(0,27,8))

#multilinia
x4<-c(12,6,0)
y4<-c(4,1,1)
#matriu
xy4<-cbind(x4,y4)
#creació multilínia
sfg4<-st_linestring(xy4)

#multilinia2
x5<-c(-4,7,21)
y5<-c(9,8,0)
#matriu
xy5<-cbind(x5,y5)
#creació multilínia
sfg5<-st_linestring(xy5)

#multilinia3
x6<-c(0,4,-3)
y6<-c(2,7,9)
#matriu
xy6<-cbind(x6,y6)
#creació multilínia
sfg6<-st_linestring(xy6)

#poligons
x7<-(c(1,4,6,5,9,0,1))
y7<-(c(7,4,1,2,9,1,7))

#creacio de la llista a partir duna matriu
xy7<-list(cbind(x7,y7))
#creació de poligon
sfg7<-st_polygon(xy7)

#poligon2
x8<-(c(0,0,2,2,1,1,0))
y8<-(c(0,1,1,2,2,0,0))

#creacio de la llista a partir duna matriu
xy8<-list(cbind(x8,y8))
#creació de poligon
sfg8<-st_polygon(xy8)

#realitzargraficpol
plot(sfg7)
plot(sfg8)
#ex 2 
#cració de multilinestting
ml1<-st_multilinestring(list(sfg4,sfg5,sfg6))
#cració de multipoligon
mpl1<-st_multipolygon(list(sfg7,sfg8))
plot(mpl1)
#geom coll
gc1<-st_geometrycollection(list(sfg1,sfg4,sfg7))
plot(gc1)

#ex3
m1<-st_point(c(-1.6967,37.6775))
m2<-st_point(c(-1.6967 ,37.6774))
m3<-st_point(c(-1.700,37.6761))
#creació de sfc i assign directa de crs
ex3<-st_sfc(m1,m2,m3, crs = 4326)
#compr crs
st_crs(ex3)
#ex4
#creacid'atr
atrim1=data.frame(name="Museo muBBla")
atrim2=data.frame(name="Capilla del Rosario")
atrim3=data.frame(name="Casa de los Albuquerque")
sfc1<-st_sfc(m1, crs = 4326)
sfc2<-st_sfc(m2, crs = 4326)
sfc3<-st_sfc(m3, crs = 4326)
#objecte sf
sfm1=st_sf(atrim1,geom=sfc1)
sfm2=st_sf(atrim2,geometry=sfc2)
sfm3=st_sf(atrim3,geometry=sfc3)
class(sfm1)
names(sfm1)
summary(sfm1)
#Exercici 5
setwd("C:/Users/34639/Desktop/cursetr/datos/datos 2/datos_vectoriales")
puntolimpio<-st_read("C:/Users/34639/Desktop/cursetr/datos/datos 2/datos_vectoriales/PuntoLimpioMovil.geojson")
hidro<-st_read("C:/Users/34639/Desktop/cursetr/datos/datos 2/datos_vectoriales/NC_Hydro.shp")
geopunto<-puntolimpio$geometry
geohidro<-st_geometry(hidro)
print(geohidro)
print(geopunto)

#Exercici 6
puntolimpio<-st_write(hidro,"C:/Users/34639/Desktop/cursetr/unitat3/hidro.geojson")
puntolimpio<-st_write(hidro,"C:/Users/34639/Desktop/cursetr/unitat3/hidro.csv")
hidro0<-st_write(hidro,"C:/Users/34639/Desktop/cursetr/unitat3/hidro.gml")

puntolimpio<-st_write(puntolimpio,"C:/Users/34639/Desktop/cursetr/unitat3/puntolimpio.shp")
puntolimpio2<-st_write(puntolimpio,"C:/Users/34639/Desktop/cursetr/unitat3/puntolimpio.csv")
puntolimpio3<-st_write(puntolimpio,"C:/Users/34639/Desktop/cursetr/unitat3/puntolimpio.gml")
#Exerc 7
install.packages("rgdal")
#cargar paquets
library(rgdal)
r<-raster("C:/Users/34639/Desktop/cursetr/datos/datos 2/datos_raster/LC81970242014109LGN00_sr_band2.tif")
summary(r)
crs(r)
plot(r)
#Exerc 8
writeFormats()
#Exercici9
#cargar paquets
library(spData)