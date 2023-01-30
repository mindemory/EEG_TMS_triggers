import sys
curr_val = 0
while True:
	with open('failed.txt', 'r') as fi:
		curr_val = fi.readlines()[-1]
	if int(curr_val) == 0:
		print('nothing')
	elif int(curr_val) == 10:
		newfi = open('safe1.txt', 'w')
		newfi.write('success')
		newfi.close()
	elif int(curr_val) == 11:
		newfi = open('safe2.txt', 'w')
		newfi.write('success')
		newfi.close()
	elif int(curr_val) == 50:
		break



