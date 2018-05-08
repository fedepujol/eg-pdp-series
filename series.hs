import Data.List

type Nombre = String
type Temporada = Int
type Anio = Int
type Cadena = String
type Serie = (Nombre, Temporada, Anio, Cadena)
type Actor = (Nombre, [Nombre])

series = [("los soprano", 6, 1999, "HBO"), 
          ("lost", 6, 2004, "ABC"), 
          ("4400", 4, 2004, "CBS"),  
          ("United States of Tara", 3, 2009, "Dreamworks"), 
          ("V", 3, 2009, "Warner Bross"), 
          ("dr house", 7, 2004, "Universal")]   

actores = [("Ken Leung", ["lost", "los soprano"]), 
    ("Joel Gretsch", ["4400", "V", "United States of Tara"]), 
    ("James Gandolfini", ["los soprano"]), 
    ("Elizabeth Mitchell", ["dr house", "V", "lost"])]  

-- Primitivas
serie :: Serie -> Nombre
serie (s, _, _, _) = s

temporadas :: Serie -> Temporada
temporadas (_, t, _, _) = t

anioComienzo :: Serie -> Anio
anioComienzo (_, _, a, _) = a

cadenaTV :: Serie -> Cadena
cadenaTV (_, _, _, c) = c

nombreActor :: Actor -> Nombre
nombreActor = fst

seriesDeActor :: Actor -> [Nombre]
seriesDeActor = snd

findCri criterio = head . filter criterio 

-- 1)
datosDe :: Nombre -> Serie
datosDe nombreSerie = findCri (nombresIguales nombreSerie) series

nombresIguales :: Nombre -> Serie -> Bool
nombresIguales unNombre unaSerie = (==) unNombre (serie unaSerie)

-- 2)
listaDeActoresDe :: Nombre -> [Nombre]
listaDeActoresDe nombreSerie = map nombreActor (filtroNombres nombreSerie actores)

filtroNombres :: Nombre -> [Actor] -> [Actor]
filtroNombres nombreSerie listaActores = filter (criterioActor nombreSerie) listaActores

criterioActor :: Nombre -> Actor -> Bool
criterioActor nombreSerie actor = elem nombreSerie (seriesDeActor actor)

-- 3)
quienesActuaronEn :: Nombre -> Nombre -> [Nombre]
quienesActuaronEn serie1 serie2 = findCri criterioSeries (listaApariciones serie1 serie2)

listaApariciones :: Nombre -> Nombre -> [[Nombre]]
listaApariciones serie1 serie2 = map (aparicionesSerie serie1 serie2) actores

aparicionesSerie :: Nombre -> Nombre -> Actor -> [Nombre]
aparicionesSerie nombreSerie1 nombreSerie2 actor  
  | criterioActor nombreSerie1 actor && criterioActor nombreSerie2 actor = [nombreActor actor]
  | otherwise = []

criterioSeries :: [a] -> Bool
criterioSeries lista = (not . null) lista

-- 4)
-- a
anioDeComienzoDe :: Nombre -> Anio
anioDeComienzoDe = anioComienzo . datosDe

-- b
seriesOrdenadas :: [Nombre] -> Bool
seriesOrdenadas listaSeries = (==) listaSeries (ordenarListaPorAnio listaSeries)

ordenarListaPorAnio :: [Nombre] -> [Nombre]
ordenarListaPorAnio listaSeries = 
  sortBy (\ a b -> compare (anioDeComienzoDe a) (anioDeComienzoDe b)) listaSeries

-- 5)
queSeriesCumplen :: (Serie -> Bool) -> [Serie] -> [Nombre]
queSeriesCumplen unCriterio = map serie . filter unCriterio

-- a
mayorA3Temporadas :: [Serie] -> [Nombre]
mayorA3Temporadas = queSeriesCumplen criterioTemporada

criterioTemporada :: Serie -> Bool
criterioTemporada = (>3) . temporadas

-- b
masDe4Actores :: [Serie] -> [Nombre]
masDe4Actores = queSeriesCumplen criterio4Actores

criterio4Actores :: Serie -> Bool
criterio4Actores = (>4) . length . listaDeActoresDe . serie

-- c
masDe5LetrasTitulo :: [Serie] -> [Nombre]
masDe5LetrasTitulo = queSeriesCumplen criterio5Letras

criterio5Letras :: Serie -> Bool
criterio5Letras = (<5) . length . serie

-- 6)
-- a
promedioGeneral :: Int
promedioGeneral = div (totalSegun temporadas series) (cantidadSegun temporadas series)
  
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
anioFin unaSerie = temporadas unaSerie + anioComienzo unaSerie

-- 7)
funcionHeavy :: (Ord a) => (c -> b) -> (c -> b) -> [c] -> a -> a -> [b]
funcionHeavy a b c d e 
  | d > e = map a c
  | otherwise = map b c