## Parcial Paradigmas de Programacion
- Nombre: Series TV
- Fecha: 14/05/2011

### Branches
- data: Solucion pasando las tuplas a datas.
- master: Solucion inicial por medio de tuplas.

### Codigo

En el branch master, se tiene las siguientes tuplas y sus correspondientes primitivas:
```haskell
series = [("los soprano", 6, 1999, "HBO"),
          ("lost", 6, 2004, "ABC"),
          ("4400", 4, 2004, "CBS"), 
          ("United States of Tara", 3, 2009, "Dreamworks"),
          ("V", 3, 2009, "Warner Bross"),
          ("dr house", 7, 2004, "Universal")]
          
actores = [ ("Ken Leung", ["lost", "los soprano"]),
            ("Joel Gretsch", ["4400", "V", "United States of Tara"]),
            ("James Gandolfini", ["los soprano"]),
            ("Elizabeth Mitchell", ["dr house", "V", "lost"])]
serie (s, _, _, _) = s
temporadas (_, t, _, _) = t
cadenaTV (_, _, _, c) = c	
anioComienzo (_, _, a, _) = a
seriesDeActor = snd
nombreActor = fst
```
Mientras que en el branch data, pasando las tuplas a Data, generando "automaticamente" las primitivas. Se obtiene:
```haskell
losSoprano = Serie "los soprano" 6 1999 "HBO"
lost = Serie "lost" 4 2004 "ABC"
the4400 = Serie "4400" 4 2004 "CBS"
unitedStatesOfTara = Serie "United States of Tara" 3 2009 "Dreamworks"
v = Serie "V" 3 2009 "Warner Bross"
drHouse = Serie "dr house" 7 2004 "Universal"

kenLeung = Actor "Ken Leung" [lost, losSoprano]
joelGretsch = Actor "Joel Gretsch" [the4400, v, losSoprano]
jamesGandolfini = Actor "James Gandolfini" [losSoprano]
elizabethMitchell = Actor "Elizabeth Mitchell" [drHouse, v, lost]

series :: [Serie]
series = [losSoprano, lost, the4400, unitedStatesOfTara, v, drHouse] 

actores :: [Actor]
actores = [kenLeung, joelGretsch, jamesGandolfini, elizabethMitchell] 
```
### Consideracion

En el punto 2 del enunciado "Conocer la lista de actores que trabajaron en una serie".
  - La solucion (series2011) propone usar comprension de listas
  - El branch master y data, proponen usar funciones de alto nivel

### Posible Solucion (series2011.hs):

La solucion propuesta ([pagina de PDP](https://sites.google.com/site/paradigmasdeprogramacion/material/parciales/FUN_Series_20111C.pdf?attredirects=1)) es hecha por medio de tuplas.


