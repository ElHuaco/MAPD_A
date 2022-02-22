import serial

ser = serial.Serial('COM4', baudrate=115200)

f = [0b0001010, 0b0101011, 0b0011000, 0b0111000, 0b0110000]

for i in f:
	ser.write(chr(i).encode())
	d = ser.read()
	print(ord(d))

