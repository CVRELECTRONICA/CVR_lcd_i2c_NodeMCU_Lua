--[[
	**************************************************
	*				CVR ELECTRONICA					 *
	*			CONTROL DE PANTALLA LCD 		     *
	* 			 www.cvrelectronica.com 	         *
	*												 *
	**************************************************
	Este escript ayuda a controlar pantallas lcd 1602 - 2004 
	conectada al driver PCF8574T de una forma muy facil.
	el driver ayuda controlar la pantalla vía i2c usando 
	solo 2 cables. 
	Sientete completamente libre de usarlo en tus proyectos
	todo esto está echo para su uso sin remordimientos.
	Si quieres darnos las gracias escribenos un mensaje a
	develop@cvrelectronica.com saber que estas usando nuestro
	codigo, nos motiva a seguir trabajando en este tipo de cosas.
	Si tienes sugerencias no olvides en hacerlas llegar a nosotros
	Nos ayudan a mejorar!!
]]--
lcd_address = 0x27
lcd_led=true

function i2c_init(init,SDA,SCL) --inicializa el bus i2c
	id = 0
	pinSDA = SDA--2
	pinSCL = SCL--1
	speed = i2c.SLOW
	if init then
		i2c.setup(id, pinSDA, pinSCL, speed)
	end
end

function lcd_init(address) --inicializa la pantalla lcd
	lcd_address = address

	sendComand1(0x28)
	sendComand(0x28)
	sendComand(0x1)
	sendComand(0xE)
	sendComand(0x6)
	sendComand(0xF)
end
function lcd_clear()
	sendComand(1)
end 
function lcd_cursorOn(on,blink)
	baseComando=12
	onCursor,blinkCursor=0,0
	if on then
		onCursor=2
	end
	if blink then
		blinkCursor=1
	end
	baseComando=baseComando+onCursor+blinkCursor
	sendComand(baseComando)
end 
function lcd_ledOn(onLed)
	if onLed then
		lcd_led=true
		writeToPCD(8)
	else
		lcd_led=false
		writeToPCD(0)
	end
end
function lcd_shiftToleft()
	sendComand(24)
	--sendComand(20)
end
function lcd_shiftToright()
	sendComand(28)
	--sendComand(20)
end

function writeToPCD(byte) --escribe los datos al pcf8574 modulo vía i2c
	i2c.start(id)
	i2c.address(id, lcd_address,i2c.TRANSMITTER)
	i2c.write(id,byte)
	i2c.stop(id)
end

--[[envia los MSB al pcf8574 solo envia 1 enable.
se usa para configurar el display en modo 4 bits]]--
function sendComand1(byte) 
	msb = bit.band(byte, 0xF0) --se toma el byte y se realiza un and logico con 11110000
	lsb = bit.band(byte, 0xF)	--se toma el byte y se realiza un and logico con 11110000
							--esto separa los MSB Y LSB para luego enviarlos por separado
	lsb = bit.lshift(lsb,4)

	newByte = bit.bor(msb,8) 
	writeToPCD(newByte) 	--se enviando los datos al modulo y se suma el estado del pin enable
	tmr.delay(500)			-- la transicion del pin enable de 0->1->0 y RS en 1 (modo comandos)
	newByte = bit.bor(msb,12)
	writeToPCD(newByte)
	tmr.delay(500)
	newByte = bit.bor(msb,8)
	writeToPCD(newByte)
	tmr.delay(500)
end

 --[[Esta funcion envia primero los 4 MSB + Enable y luego los 4 MSB+Enable
 	del byte, luego envia la señal al modulo que controla la pantalla
 ]]--
function sendComand(byte)
	if lcd_led then
		orComando=8
	else
		orComando=0
	end
	msb=bit.band(byte, 0xF0) --se toma el byte y se realiza un and logico con 11110000
	lsb=bit.band(byte, 0xF)  --se toma el byte y se realiza un and logico con 11110000
							 --esto separa los MSB Y LSB para luego enviarlos por separado
	lsb=bit.lshift(lsb,4)    --se desplaza el byte y luego se opera con los valores de E,RS,LED
	--print("lsb: "..lsb)	 --RS=0 E=0->1->0 LED=1

	newByte=bit.bor(msb,orComando) 
	writeToPCD(newByte)
	tmr.delay(500)
	newByte=bit.bor(msb,orComando+4)
	writeToPCD(newByte)
	tmr.delay(500)
	newByte=bit.bor(msb,orComando)
	writeToPCD(newByte)
	tmr.delay(500)

	newByte=bit.bor(lsb,orComando) 
	writeToPCD(newByte)
	tmr.delay(500)
	newByte=bit.bor(lsb,orComando+4)
	writeToPCD(newByte)
	tmr.delay(500)
	newByte=bit.bor(lsb,orComando)
	writeToPCD(newByte)
	tmr.delay(500)
end

function sendData(byte)
	if lcd_led then
		orComando=9
	else
		orComando=1
	end
	msb=bit.band(byte, 0xF0)
	lsb=bit.band(byte, 0xF)

	lsb=bit.lshift(lsb,4)
	--print("lsb: "..lsb)

	newByte=bit.bor(msb,orComando) --ENVIA LOS DATOS CON RS=1
	writeToPCD(newByte)
	tmr.delay(500)
	newByte=bit.bor(msb,orComando+4)
	writeToPCD(newByte)
	tmr.delay(500)
	newByte=bit.bor(msb,orComando)
	writeToPCD(newByte)
	tmr.delay(500)

	newByte=bit.bor(lsb,orComando) --LSB A display
	writeToPCD(newByte)
	tmr.delay(500)
	newByte=bit.bor(lsb,orComando+4)
	writeToPCD(newByte)
	tmr.delay(500)
	newByte=bit.bor(lsb,orComando)
	writeToPCD(newByte)
	tmr.delay(500)
end

function lcd_setCursor(y,x) --cambia la posicion del cursor en la pantalla
	if y==1 then
		base=0x80
	elseif y==2 then
		base=0xC0
	elseif y==4 then
		base=0xE0
	end
	posByte=bit.bor(x,base)
	sendComand(posByte)
	--print(posByte)
end

function lcd_print(stringData) --nuestra el mensaje en la pantalla
	size=string.len(stringData)
	for i=1,size,1 do
		char=string.sub(stringData,i,i)
		dataByte=string.byte(char)
		if dataByte==nil then
			dataByte=32
		end
		sendData(dataByte)
	end
end