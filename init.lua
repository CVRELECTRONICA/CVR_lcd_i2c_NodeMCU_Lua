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

dofile("lcd_i2c.lua")

i2c_init(true, 0x27)

lcd_init() --inicia el display
lcd_setCursor(1,0) -- posiciona el cursor en la primera linea, primer segmento
lcd_print("CVR ELECTRONICA") --muestra el mensaje en la pantalla
lcd_setCursor(2,0) --posiciona el cursor en la segunda linea,primer segmento
lcd_print("Tienda virtual!") -- muestra el mensaje
