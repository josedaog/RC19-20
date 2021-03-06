

/*
  Problemas de estado
  
  - Ajedrez
  - 9 reinas
  - Jarras
    ...

   Problema de las jarras	

	  |     |
	  |     |    |   | 
	  |     |    |   |
    -------    -----
	  G5         G3
	  
   1. Definir el estado
   
      estado(G5, G3)
	    representa un instante del problema de las 
		jarras. G5 indica en número de galones
		en la garrafa de 5 galones y G3 indica
		el número de galones en la garrafa de 
		3 galones.
      
	  estado( .... )
	  
      Ajedrez
      estado([[t,c,a,k,q,a,c,t],
	          [p,p,p,..],
			  [x,x,x,x,x,x,x,x ],
              ...			  
			  ])	
    2. Estados inicial y final
       estado inicial = estado(0,0).
       estado final   = estado(4,_).	   
	  
    3. Definir los movimientos
        1. llenar G5
        2. llenar G3
        3. vaciar G5
        4. vaciar G3
        5. pasar de G3 a G5
        6. pasar de G5 a G3 		



mov(Nombre, EstadoAntes, EstadoDespués)

*/

 /* 1. llenar G5 */
 mov(llenarG5, estado(_, G3), estado(5, G3)).
 
 /* 2. llenar G3 */
 mov(llenarG3, estado(G5, _), estado(G5, 3)).
 
/* 3. vaciar G5 */
 mov(vaciarG5, estado(_, G3), estado(0, G3)).

/* 4. vaciar G3 */
 mov(llenarG3, estado(G5, _), estado(G5, 0)).

/* 5. pasar de G3 a G5 */
 mov(pasarG3G5, estado(G5, G3), estado(T,0) ) :- 
   T is G3 + G5,
   T =< 5.
 mov(pasarG3G5, estado(G5, G3), estado(5,G32) ) :- 
   T is G3 + G5,
   T > 5,
   G32 is T - 5.

/* 6. pasar de G5 a G3 */
 mov(pasarG5G3, estado(G5, G3), estado(0,T) ) :- 
   T is G3 + G5, T =< 3.
 mov(pasarG5G3, estado(G5, G3), estado(G52,3) ) :- 
   T is G3 + G5,
   T > 3,
   G52 is T - 3.

/* 
  camino(+EstadoInicial, +EstadoFinal, +Visitados, -R)
    es cierto si R unifica con una lista de movimientos
    para pasar del EstadoInicial al EstadoFinal sin
    repetir los estados de la lista de estados
    Visibles

  Inicial -> Mov -> EstadoTMP                Final
                        ----------------------->
                                   N-1

*/

camino(Ini, Ini, _, []).

camino(Ini, Final, Visitados, [Mov|Camino]) :-
  mov(Mov, Ini, Tmp),
  \+ member(Tmp,Visitados),
  camino(Tmp, Final, [Tmp|Visitados], Camino).

/*
  camino(estado(0,0),estado(4,_),[],Camino),length(Camino,6).
*/

/*
  Obtener todas las soluciones
  
*/
