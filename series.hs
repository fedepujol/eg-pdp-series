import Data.List

type Nombre = String
type Temporada = Int
type Anio = Int
type Cadena = String

data Serie = Serie {
    nombre :: Nombre,
    temporada :: Temporada,
    anio :: Anio,
    cadena :: Cadena
} deriving(Show, Eq)

data Actor = Actor {
    nombreActor :: Nombre,
    seriesActor :: [Serie]
}

losSoprano = Serie "los soprano" 6 1999 "HBO"
lost = Serie "lost" 4 2004 "ABC"
the4400 = Serie "4400" 4 2004 "CBS"
unitedStatesOfTara = Serie "United States of Tara" 3 2009 "Dreamworks"
v = Serie "V" 3 2009 "Warner Bross"
drHouse = Serie "dr house" 7 2004 "Universal"

series :: [Serie]
series = [losSoprano, lost, the4400, unitedStatesOfTara, v, drHouse]   

kenLeung = Actor "Ken Leung" [lost, losSoprano]
joelGretsch = Actor "Joel Gretsch" [the4400, v, losSoprano]
jamesGandolfini = Actor "James Gandolfini" [losSoprano]
elizabethMitchell = Actor "Elizabeth Mitchell" [drHouse, v, lost]

actores :: [Actor]
actores = [kenLeung, joelGretsch, jamesGandolfini, elizabethMitchell]  

findCri criterio = head . filter criterio 

-- 1)
datosDe :: Serie -> Serie
datosDe unaSerie = findCri (nombresIguales $ nombre unaSerie) series

nombresIguales :: Nombre -> Serie -> Bool
nombresIguales unNombre unaSerie = (==) unNombre (nombre unaSerie)

-- 2)
listaDeActoresDe :: Serie -> [Nombre]
listaDeActoresDe serie = map nombreActor (filtroNombres serie actores)

filtroNombres :: Serie -> [Actor] -> [Actor]
filtroNombres serie listaActores = filter (criterioActor serie) listaActores

criterioActor :: Serie -> Actor -> Bool
criterioActor serie actor = elem serie (seriesActor actor)

-- 3)
quienesActuaronEn :: Serie -> Serie -> [Nombre]
quienesActuaronEn serie1 serie2 = findCri criterioSeries (listaApariciones serie1 serie2)

listaApariciones :: Serie -> Serie -> [[Nombre]]
listaApariciones serie1 serie2 = map (aparicionesSerie serie1 serie2) actores

aparicionesSerie :: Serie -> Serie -> Actor -> [Nombre]
aparicionesSerie serie1 serie2 actor  
  | criterioActor serie1 actor && criterioActor serie2 actor = [nombreActor actor]
  | otherwise = []

criterioSeries :: [a] -> Bool
criterioSeries lista = (not . null) lista

-- 4)
-- a
anioDeComienzoDe :: Serie -> Anio
anioDeComienzoDe = anio . datosDe

-- b
seriesOrdenadas :: [Serie] -> Bool
seriesOrdenadas listaSeries = (==) listaSeries (ordenarListaPorAnio listaSeries)

ordenarListaPorAnio :: [Serie] -> [Serie]
ordenarListaPorAnio listaSeries = 
  sortBy (\ a b -> compare (anio a) (anio b)) listaSeries

-- 5)
queSeriesCumplen :: (Serie -> Bool) -> [Serie] -> [Nombre]
queSeriesCumplen unCriterio = map nombre . filter unCriterio

-- a
mayorA3Temporadas :: [Serie] -> [Nombre]
mayorA3Temporadas = queSeriesCumplen criterioTemporada

criterioTemporada :: Serie -> Bool
criterioTemporada = (>3) . temporada

-- b
masDe4Actores :: [Serie] -> [Nombre]
masDe4Actores = queSeriesCumplen criterio4Actores

criterio4Actores :: Serie -> Bool
criterio4Actores = (>4) . length . listaDeActoresDe

-- c
masDe5LetrasTitulo :: [Serie] -> [Nombre]
masDe5LetrasTitulo = queSeriesCumplen criterio5Letras

criterio5Letras :: Serie -> Bool
criterio5Letras = (<5) . length . nombre

-- 6)
-- a
promedioGeneral :: Int
promedioGeneral = div (totalSegun temporada series) (cantidadSegun temporada series)
  
totalSegun :: (Serie -> Int) -> [Serie] -> Int
totalSegun criterio = sum . aplicarCriterio criterio

cantidadSegun :: (Serie -> Int) -> [Serie] -> Int
cantidadSegun criterio = length . aplicarCriterio criterio

aplicarCriterio :: (Serie -> Int) -> [Serie] -> [Int]
aplicarCriterio criterio = map criterio

-- b
promedio :: (Serie -> Int) -> Int
promedio criterio = 
  div (totalSegun criterio series) (cantidadSegun criterio series)

anioFin :: Serie -> Int
anioFin unaSerie = temporada unaSerie + anio unaSerie

-- 7)
funcionHeavy :: (Ord a) => (c -> b) -> (c -> b) -> [c] -> a -> a -> [b]
funcionHeavy a b c d e 
  | d > e = map a c
  | otherwise = map b c
