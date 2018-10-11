# used code from:
#      https://stackoverflow.com/questions/31049648/how-to-get-list-of-subdirectories-names
#      https://stackoverflow.com/questions/82831/how-do-i-check-whether-a-file-exists-using-python
#      http://www.pythonforbeginners.com/files/reading-and-writing-files-in-python

import os
import sys

serial = sys.argv[1]

for root,dirs,_ in os.walk('/sys/bus/usb/devices'):
    for d in dirs:
        # print os.path.join(root,d)
        if os.path.isfile(os.path.join(root,d) + "/serial"):
            # print "serial file exists"
	    f = open(os.path.join(root,d) + "/serial", "r")
	    read_serial = f.read()[:-1]
	    f.close()
            # print read_serial
	    if read_serial == serial:
		# print "found it"
		g = open(os.path.join(root,d) + "/uevent", "r")
		uevent_lines = g.read().split('\n')
		for line in uevent_lines:
		    # print line
		    tokens = line.split('=')
		    if tokens[0] == "DEVNAME":
                        sys.stdout.write("/dev/" + tokens[1])
                        sys.stdout.flush()
		        # print "/dev/" + tokens[1]
		
