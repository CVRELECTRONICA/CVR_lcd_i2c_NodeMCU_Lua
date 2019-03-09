# CVR_lcd_i2c_NodeMCU_Lua
Script que ayuda a controlar pantallas lcd 1602 2004 vía i2c haciendo uso del controlador PCF8574 adaptado para este tipo de pantallas.

# Modulos requeridos
bit   i2c   tmr

# USO
Guarda el archivo CVR_lcd_i2c.lua en el modulo y listo.

# Ejemplo
```
dofile("CVR_lcd_i2c.lua")

i2c_init(true, 0x27)

lcd_init() 
lcd_setCursor(1,0) 
lcd_print("CVR ELECTRONICA") 
lcd_setCursor(2,0) 
lcd_print("Tienda virtual!") 
```
# ----
Si tienes dudas, recomendaciones o simplemente quieres saludar escribenos un mensaje a develop@cvrelectronica.com con gusto responderemos lo que sea que quieras decirnos.

# COMPRAR COMPONENTES
- Modulo i2c para pantalla LCD --->> https://www.cvrelectronica.com/descripcion.php?id=271
- Pantalla LCD 16x2 1602 --->> https://www.cvrelectronica.com/descripcion.php?id=84
- Pantalla LCD 20x4 2004 -->> https://www.cvrelectronica.com/descripcion.php?id=353

# Nota
No olvides compartir este proyecto con todos tus amigos!! 
