import serial

ser = serial.Serial('COM4', baudrate=115200)
d = [175, 0b11010000, 0b11110000, 0b01110000, 0b01010000, 0b00110000, 0b00010000, 0b10110000]
f = [79, 80, 64, 16, 10, 16]

for i in f:
	ser.write(chr(i).encode())
	d = ser.read()
	print(ord(d))

