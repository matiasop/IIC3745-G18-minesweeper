# IIC3745-G18-minesweeper

## Referencias

Para desarrollar este proyecto se usó [este repositorio como base](https://github.com/jakebruemmer/ruby-minesweeper-cli).

## Tests
Para correr los tests y generar el archivo de coverage de `simplecov` se debe correr: `rake test:all`.

## Aclaraciones
No se hicieron tests para los archivos `user_interface.rb` ni `board_printer.rb` porque según el enunciado no era necesario testear las clases que se encargan de la vista ni del input del usuario.

## Cómo jugar
### Iniciar el Juego
Para iniciar el juego se debe correr el comando `ruby lib/main.py [filas] [columnas] [bomb_rate]`.
- `[filas]` y `[columnas]`: número de filas y columnas del tablero. Debe ser un número entero
- `[bomb_rate]`: porcetaje de las celdas que serán minas. Debe ser un float entre 0 y 1.
- Ejemplo: `ruby lib/main.rb 10 12 0.5`

### Acciones
Una vez que se inicia el juego el usuario debe escribir una acción en la consola. Existen 3 tipos de acciones:

1. `play [fila] [columna]`: descubrir lo que está en una casilla. Se pierde el juego si se descubre una bomba.
2. `flag [fila] [columna]`: marca una casilla con una bandera. Sirve para marcar los lugares en los que el usuario cree que hay una bomba. No se puede hacer `play` en una casilla marcada con una bandera. Se puede borrar la bandera si se usa `flag` en una casilla que tenga una.
3. `exit`: se sale del juego.

### Cómo ganar
Se gana si el jugador descubre todas las casillas que no tienen minas.

Se pierde si el jugador descubre alguna casilla con una mina.

## Integrantes
- Felipe Campbell
- Tomás Flores
- Cristian Hinostroza
- Matías Ovalle
- Alejandra Uribe