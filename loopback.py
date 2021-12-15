import serial 


x = input('Insert name given to serial port:')
ser = serial.Serial(x, baudrate = 115200)
for i in range(10):
	ser.write(chr(i).encode())
	d = ser.read()
	print(ord(d))
