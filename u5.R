### Ejercicios Unidad 5 ###
# Autor:Josep Andreu Sabaté

## 1.0 Introduccion

## 2.0 Librerías (Instalar solo las necesarias!!! )

install.packages('scatterplot3d')
install.packages('geoR')
# Cargamos las librerias
library(sp)
library(sf)
library(geoR)
library(rgdal)
library(spData)
library(scatterplot3d)

# Ejercicio 1.
data(package="geoR")
data(ca20)
print(ca20)
class(ca20)
names(ca20)
head(ca20$data, 6) #obte les 6 primr. observacion s de lobjecte
summary(ca20)
# Ejercicio 2
#b convertir meuse a geodata
data(meuse)
class(meuse)
geo_meuse <- as.geodata(meuse)

#c 
sf_muese_bor<-st_read("C:/Users/34639/Desktop/cursetr/datos/datos 2/datos_vectoriales/meuse_borde.geojson")

#proyección de sf
#proj_sf_muese_bor <- st_transform(sf_muese_bor, "+proj=merc +lat_ts=0 +lon_0=0 +k=1.000000 +x_0=0 +y_0=0 +ellps=GRS80 
                            #     +datum=WGS84 +units=m +no_defs no_defs")
st_crs(proj_sf_muese_bo)
names(sf_meuse_bor)
class(proj_sf_muese_bo)

#d) convertir sf a sp
sf_meuse_bor <- st_read('C:/Users/34639/Desktop/cursetr/datos/datos 2/datos_vectoriales/meuse_borde.geojson')
sp_meuse_bor <- as(sf_meuse_bor, "Spatial")
# Ejercicio 3
#media
mean(ca20$data)
#mediana
median(ca20$data)
# Ejercicio 4
#variança
var(ca20$data)
#desv estandard/tipica
sd(ca20$data)
#rang intercuartil
IQR(ca20$data)

# Ejercicio 5
class(ca20)
summary(ca20)
# Ejercicio 6
hist(ca20$data, 5)
hist(ca20$data, 10)
hist(ca20$data, 15)
print(ca20)
# Diagrama de caja y bigotes
boxplot(ca20$data, col = 'blue',
        main='Diagrama de Caja y Bigotes, ca20')
# Ejercicio 7
plot.geodata(ca20)
plot.geodata(ca20, trend = "1st")
plot.geodata(ca20, trend = "1st", scatter3d = T)
# Ejercicio 8
#graficos con los bordes
print(ca20)
points.geodata(ca20,
               cex.min = 0.5, cex.max = 2, main="ca20" )

# Gráfico clasificación cuartiles
points(ca20, cex.min=0.5,
       cex.max=2, pt.div="quartile")
# Gráfico clasificación cuartiles
points(parana,
      cex.min=0.5,
       cex.max=2, pt.div="deciles")
# Ejercicio 9
#a variograma
ca20.vario1<-variog(ca20)
plot(ca20.vario1, main="Variograma")
#b)nube de varigrama
ca20.cl1<-variog(ca20, option="cloud")
plot(ca20.cl1, main="Nube de variograma")
#c) distancia adecuada 1/2 de dist.
ca20.vario2<-variog(ca20, max.dist = 600)
plot(ca20.vario2, main="Variograma a la distancia adecuada")
#d polinom 1st. y 2nd
ca20.variot1<-variog(ca20, trend = "1st",max.dist = 600)
plot(ca20.variot1, main="Variograma polinomio de primer grado")
ca20.variot2<-variog(ca20, trend = "2nd",max.dist = 600)
plot(ca20.variot2, main="Variograma polinomio de segundo grado")
#e comprov anisotropia
# Variograma direccional (0, 45, 90, 135 grados)
varca20.dir <-variog4(ca20)
plot(varca20.dir, main="Variograma direccional", legend=TRUE)

# Ejercicio 10
# FUNCION EXPONENCIAL
ca20.vfit.exp <- variofit(ca20.vario2,
                            cov.model="exponential")
# FUNCION ESFERICA
ca20.vfit.sph <- variofit(ca20.vario2,
                            cov.model="spherical")
# FUNCION GAUSSIANA
ca20.vfit.gau <- variofit(ca20.vario2,
                            cov.model="gaussian")
# Representación
plot(ca20.variot2)
lines(ca20.vfit.exp, col='green')
lines(ca20.vfit.gau, col='red')
lines(ca20.vfit.sph, col='blue')
legend("bottomright", c("Exponencial", "Gaussiano", "Esférico"),
       lty=1, col=c("green","red","blue"))
# Ejercicio 11
#rejilla
ca20.grid1 <- pred_grid(ca20$borders, by = 30)
plot(ca20.grid1)
plot.new()
points(ca20)
points(ca20.grid1, pch = 19, col = 'blue', cex = 0.25)
ca20.grid0 <- locations.inside(ca20.grid1, ca20$borders)
points(ca20.grid0, pch = 19, col = 'green', cex = 0.25)

# Ejercicio 12
# Krigeado
ca20k1exp <- krige.conv(ca20, loc = ca20.grid1,
                 krige = krige.control(obj.m = ca20.vfit.exp))
ca20k1 <- krige.conv(ca20, loc = ca20.grid1,
                     krige = krige.control(obj.m = ca20.vfit.gau))

ca20k1 <- krige.conv(ca20, loc = ca20.grid1,
                     krige = krige.control(obj.m = ca20.vfit.sph))
names(ca20k1exp)
  # Representación de la interpolación por Krigeado
image(ca20k1exp, col = rev(rainbow(30)), xlab = "Longitud", ylab = "Latitud")
   # Se le añade un título
title(main = "Modelo Exponencial")
 # Le añadimos curvas de nivel
contour(ca20k1exp, add = TRUE, nlevel = 10)

# Ejercicio 13
ca20sf<-st_read("C:/Users/34639/Desktop/cursetr/datos/datos 2/datos_vectoriales/ca20.geojson")
ca20sf_bordes<-st_read("C:/Users/34639/Desktop/cursetr/datos/datos 2/datos_vectoriales/ca20bordes.geojson")
# Representamos los datos
plot.new()
plot(st_geometry(ca20sf), axes=TRUE)
plot(st_geometry(ca20sf_bordes), col = 'red', cex=0.5, pch=16, add=TRUE)
## creamos un geometry set de tipo MULTIPOINT
pre_union <- st_union(ca20sf)
## calculamos los polígonos
pre_voronoi <- st_voronoi(pre_union)
## Extraemos los polígonos de nuevo a tipo POLYGON
pol_voronoi <- st_collection_extract(pre_voronoi)
names(pol_voronoi)
plot(st_geometry(pol_voronoi), axes=TRUE)

# Ejercicio 14
## a) Recortamos los polígonos resultantes con los límites
     
ca20_union <- st_union(ca20sf)
ca20_voronoi <- st_voronoi(ca20_union)
pol_voronoi_int_lim <- st_intersection(pol_voronoi, 
                                       st_geometry(ca20sf_bordes)) 
plot.new()
plot(pol_voronoi_int_lim, col = sf.colors(15, categorical = TRUE),
     border = 'grey', axes = TRUE)
plot(st_geometry(ca20sf), col = 'red', cex=0.5, pch=16, add=TRUE)

#Añadimos los datos de calcio
intersection <- as.integer(st_intersects(pol_voronoi_int_lim, ca20sf))
cdata <- ca20sf$data[intersection]
## b) Convertimos a sf
poligonos_final <- st_sf(geom=pol_voronoi_int_lim, data=cdata)

# Rasterización
install.packages("fasterize")
library(fasterize)
library(raster)
print(poligonos_final)
r <- raster(ca20sf, res=1)
vor_raster <- fasterize(poligonos_final, r, 'data')
plot(vor_raster)

# Ejercicio 15
# Instalación y carga de librerías
install.packages("gstat")
library(gstat)
ca20sf<-st_read("C:/Users/34639/Desktop/cursetr/datos/datos 2/datos_vectoriales/ca20.geojson")
ca20sf_bordes<-st_read("C:/Users/34639/Desktop/cursetr/datos/datos 2/datos_vectoriales/ca20bordes.geojson")
# De sf a sp
ca20sf_bordes_sp <- as(ca20sf_bordes, "Spatial")
ca20sf_sp<-as(ca20sf, "Spatial")
class(ca20sf_bordes_sp)
class(ca20sf_sp)
#Crea un objeto gstat a partir de estos datos y obtén un ráster empleando la técnica de la distancia inversa ponderada
gs_ca20 <- gstat(formula=data~1, locations=ca20sf_sp)
#interpolacio+ Creación de objeto RasterLayer
raster_ca20 <- raster(ca20sf_sp, res=1)
idw_ca20 <- interpolate(raster_ca20, gs_ca20)
# Resultado final
idwr_ca20 <- mask(idw_ca20, ca20sf_bordes_sp)
plot(idwr_ca20)





