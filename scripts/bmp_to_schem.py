#!/usr/bin/env python2
# -*- coding: UTF-8 -*-

import sys, os

try: 
	from PIL import Image
except ImportError as err:
	sys.stderr.write(str(err) + '\n')
	sys.exit(1)

def msg_error(string):
	sys.stderr.write(str(string) + '\n')


class Img_to_schem():
	def __init__(self,Filein, FileOut):
		self.__Image = Filein
		self.__fileOut = FileOut
		self.__pixels = []
		self.img = None
		self.parcours = dict()
		self.nodes = dict()
	
	def load(self):
		try:
			self.img = Image.open(self.__Image)
			self.__pixels = self.img.load()
		except Exception as err:
			msg_error(err)
			sys.exit(1)
	
	def get_size(self):
		return self.img.size
	
	def get_mode(self):
		return self.img.mode
	
	def get_format(self):
		return self.img.format
	
	def get_pixel(self, x, y):
		return self.__pixels[x, y]
		
	def set_nodes(self):
		nb = 0
		for i in range(self.img.size[0]):
			color = self.__pixels[i, 0]
			if color == self.__pixels[0, 0]:
				nb += 1
			if nb == 2:
				break
			self.nodes[color] = i
	
	def get_nodes(self, color):
		return self.nodes[color]
	
	def set_parcours(self, x):
		data = []
		for z in range(5):
			for y in range(10):
				color = self.__pixels[x, y+(z*10)+5]
				node = self.get_nodes(color)
				if node != 0:
					data.append({"x":x,"y":y,"z":z,"n":node})
		self.parcours[x] = data
	
	
	def serialize(self):
		data = "return {"
		for l, t in self.parcours.iteritems():
			#{["1"]= {
			data = "%s [\"%s\"] = {" % (data, l)
			for n in t:
				#{["y"]= 2, ["x"]= 3, ["node"]= "node1"}
				d = '{x=%d,y=%d,z=%d,node=%d},' % (n["x"], n["y"], n["z"], n["n"])
				data = "%s %s" % (data, d)
			data += "}," 
			#["D"] = {{ {x=0,y=0,z=0},"default:mese"} },	
		data = "%s }" % data
		try:
			f = open(self.__fileOut, "w")
		except Exception as err:
			msg_error(err)
			sys.exit(1)
		f.write(data)
		f.close()		
		

def Main(FileImg, FileOut):
	print("process...")
	img = Img_to_schem(FileImg, FileOut)
	img.load()
	print("Size:%sX%s" % img.get_size())
	print("Mode:%s" % img.get_mode())
	if img.get_mode() != "P":
		msg_error("Erreur, not 10 color")
		sys.exit(1)
	print("Format:%s" % img.get_format())
	img.set_nodes()
	for x in range(img.get_size()[0]):
		img.set_parcours(x)
	img.serialize()


if __name__ == "__main__":
	if len(sys.argv) == 3:
		FileImg = sys.argv[1]
		FileOut = sys.argv[2]
		if not os.path.exists(FileImg) or  not FileImg.endswith(".bmp"):
			msg_error("Bad argument, param 1 must be image.bmp and exited.")
			sys.exit(1)
		
		if not FileOut.endswith(".txt"):
			msg_error("File Ext must be .txt.")
			sys.exit(1)
		
		Main(FileImg, FileOut)
	
	else:
		msg_error("Bad argument, exec %s image.bmp file.txt." % sys.argv[0])
		sys.exit(1)

