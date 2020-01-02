import sys
# from guppy import hpy
# hp = hpy()

def rss():
    return 4096 * int(open('/proc/self/stat').read().split(' ')[23])

def gcsize():
    return 0 # hp.heap().size

rss0, gc0 = (rss(), gcsize())

buf = [bytearray(1020) for i in range(200*1024)]
print("start rss={}   gcsize={}".format(rss()-rss0, gcsize()-gc0))
buf = buf[::2]
print("end   rss={}   gcsize={}".format(rss()-rss0, gcsize()-gc0))
