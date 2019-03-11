--[[
	**************************************************
	*				CVR ELECTRONICA					 *
	*			CONTROL DE PANTALLA LCD 		     *
	* 			 www.cvrelectronica.com 	         *
	*												 *
	**************************************************
	No olvides Guardar el archivo lcd_i2c.lua en tu 
	placa ESP8266.
	Si quieres darnos las gracias escribenos un mensaje a
	develop@cvrelectronica.com 
	saber que estas usando nuestro
	codigo, nos motiva a seguir trabajando en este tipo de cosas.
	Si tienes sugerencias no olvides en hacerlas llegar a nosotros,
	Nos ayudan a mejorar!!
]]--

dofile("CVR_lcd_i2c.lua")

i2c_init(true,4,1) --puedes usar los cualquier pin del 1 al 12

lcd_init(0x27) --inicia el display
lcd_cursorOn(true,true) -- cursor on, cursor blink on
lcd_setCursor(1,0) -- posiciona el cursor en la primera linea, primer segmento
lcd_print("CVR ELECTRONICA") --muestra el mensaje en la pantalla
lcd_setCursor(2,0) --posiciona el cursor en la segunda linea,primer segmento
lcd_print("Tienda virtual!") -- muestra el mensaje
tmr.delay(1000000)
for i=0,1,1 do
	lcd_ledOn(false)
	tmr.delay(500000)
	lcd_ledOn(true)
	tmr.delay(500000)
end

for i=0,15,1 do
lcd_shiftToleft()
tmr.delay(200000)
end

for i=0,15,1 do
lcd_shiftToright()
tmr.delay(200000)
end
lcd_clear()
lcd_setCursor(1,0) -- posiciona el cursor en la primera linea, primer segmento
lcd_print("WWW.CVRELECTRONI") --muestra el mensaje en la pantalla
lcd_setCursor(2,0) --posiciona el cursor en la segunda linea,primer segmento
lcd_print("CA.COM") -- muestra el mensaje
