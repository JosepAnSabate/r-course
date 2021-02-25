### Ejercicios Unidad 7 ###
# Autor: Josep Andreu Sabate

## 2.0 Librerías Necesarias
install.packages("leaflet")
# Cargar paquetes
library(leaflet)
library(sf)
library(sp)
library(raster)

# Ejercicio 1.
# Creación de widget con restricciones de zoom
m1 <- leaflet(options = leafletOptions(minZoom= 8, maxZoom= 20))

# Añadimos al widget, un mapa de teselas (por defecto OSM)
m1 <- addTiles(m1)
# Configuramos el centro del mapa y el nivel máximo de zoom de msd1
m1 <-setView(m1, lng= -2.44, lat = 42.46, zoom = 12)
m1


# Ejercicio 2
# Creación de mapa Leaflet con %<&
m2 <- leaflet() %>%
  addTiles() %>% # Añade un mapa de teselas OSM
  addMarkers(lng= -2.44, lat= 42.46, popup="El nacimiento de R")
# Muestra el mapa
m2

# Ejercicio 3
# Mapa Base Esri
m1esri <- addProviderTiles(m1, provider = providers$Esri)
m1esri
#b 
names(providers)

# Mapa Base mapbox
m1mapbox <- addProviderTiles(m1, provider = providers$MapBox)
m1mapbox

# Mapa Base Esri
m1here <- addProviderTiles(m1, provider = providers$HERE)
m1here
# Ejercicio 4
m4 <- addMarkers(m1esri, lng=-2.44, lat = 42.46,
                 label = "Capital de la Rioja", 
                 popup = 'Centro de Logrono')

m4


# Ejercicio 5
# Cargo un vector
mex5 <- st_read("C:/Users/34639/Desktop/cursetr/datos/datos 2/datos_vectoriales/centros.geojson")
# Campos del DataFrame
names(mex5)
class(mex5)
crs(mex5)
# Asigno CRS
st_crs(mex5) <- 4326
m1esri <- addMarkers()
mcd3 <- addMarkers(m1esri, data = mex5,
                   popup = as.character(mex5$T205_NOMBRE))

mcd3           
# Ejercicio 6
## Icono local
icono <- makeIcon(
  iconUrl = "C:/Users/34639/Desktop/cursetr/datos/datos 2/otros_datos/school.png",
  iconWidth = 50, iconHeight = 50,
  iconAnchorX = 30, iconAnchorY = 94
)
## Mapa con marcadores con iconos personalizados
mc6 <- leaflet(m2)
mc6 <- addTiles(mc6)

## Añado los marcadores con un popup que contiene la magnitud
m6 <- addMarkers(mc6, data = mex5[1:10,], icon = icono, popup = as.character(mex5[1:10,]$T205_NOMBRE))
m6esri <- addProviderTiles(m6, provider = providers$Esri)
m6esri

# Ejercicio 7
m7a<-addCircleMarkers(m1esri, lng=-2.471, lat = 42.453,  label = "Parque de bomberos de Logroño", 
                      labelOptions = labelOptions(noHide = TRUE, direction = "bottom",
                                                  style = list(
                                                    "color" = "green",
                                                    "font-family" = "serif",
                                                    "font-style" = "italic",
                                                    "box-shadow" = "3px 3px
                                                      rgba(0,0,0,0.25)",
                                                    "font-size" = "15px",
                                                    "border-color" = "rgba(0,0,0,0.5)"
                                                  )))
m7a

#b
#Creación de un etiqueta
txt <- "<b> 5ª Carrera Popular Ferrer Sport Center </b> <br/> "
m7b <- addPopups(m7a, lng=-2.4718, lat = 42.427, txt,
                  options = popupOptions(closeButton = FALSE))
m7b


# Ejercicio 8
## LINEAS
ferro <- st_read("C:/Users/34639/Desktop/cursetr/datos/datos 2/datos_vectoriales/ferrocarril.geojson")
# Creación de mapa con líneas

names(ferro)
class(ferro)
m8 <- addPolylines(m1esri, data=ferro,
                     weight = 2, opacity = 1,color = 'red',
                     popup = as.character(ferro$T186_NOMBRE))
m8 <-setView(m8, lng= -2.44, lat = 42.46, zoom = 6)
m8 <- addProviderTiles(m8, provider = providers$Esri)
muni <- st_read("C:/Users/34639/Desktop/cursetr/datos/datos 2/datos_vectoriales/municipios.geojson")
names(muni)
# Adición de polígonos
m8 <- addPolygons(m8, data = muni,
                  weight = 0.5, opacity = 0.4,color = 'green',
                    label = muni$NOMBRE_MUNICIPIO)
m8
#ej9
bomb <- st_read("C:/Users/34639/Desktop/cursetr/datos/datos 2/datos_vectoriales/emergencias.geojson")
# Creación de mapa con círculos

m9 <- addCircles(m1esri, data = bomb, 
                   weight = 1,
                   color = " mediumslateblue",
                   radius = 3000,
                    popup = bomb$T137_137_NOMBRE)
m9

