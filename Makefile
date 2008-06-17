CXXFLAGS = -I./ -I../include -DSTRICT_MEM -DDEBUG -DTIXML_USE_STL -g3 -Wall
TINYXML_USE_STL := YES

CPPFILES  := $(wildcard *.cpp) $(wildcard tinyxml/*.cpp) $(wildcard ext/*.cpp)

#LINFILES  := $(wildcard lin/*.cpp)
OFILES    := $(CPPFILES:.cpp=.o) #$(LINFILES:.cpp=.o)

#WINFILES  := $(wildcard win/*.cpp)
OBJFILES  := $(CPPFILES:.cpp=.OBJ) #$(WINFILES:.cpp=.OBJ)

DOPFILES  := $(CPPFILES:.cpp=.DOP)
DOIFILES  := $(CPPFILES:.cpp=.DOI)

PKGPREFIX := ../l-echo-0.2.3_r40-
DESC      := L-Echo 0.2.3

all: $(OFILES)
	gcc tinyxml/*.o *.o -DTIXML_USE_STL -lGL -lGLU  /usr/lib/libglut.so.3.8.0 -lpthread -g3 -Wall -o l-echo

%.OBJ: %.cpp
	i586-mingw32msvc-g++ $(CXXFLAGS) -c -o $@ $<

w32: $(OBJFILES)
	i586-mingw32msvc-g++ *.OBJ tinyxml/*.OBJ glut32.lib -lGL -lGLU -g3 -Wall -o l-echo.exe

%.DOP: %.cpp #DOP stands for "Darwin Object (PowerPC)"
	powerpc-apple-darwin8-g++ $(CXXFLAGS) -c -o $@ $<

%.DOI: %.cpp #DOP stands for "Darwin Object (Intel)"
	i686-apple-darwin8-g++ $(CXXFLAGS) -c -o $@ $<

macppc: $(DOPFILES)
	powerpc-apple-darwin8-g++ *.DOP tinyxml/*.DOP -framework OpenGL -framework GLUT -g3 -Wall -o l-echo.macppc

macintel: $(DOIFILES)
	i686-apple-darwin8-g++ *.DOI tinyxml/*.DOI -framework OpenGL -framework GLUT -g3 -Wall -o l-echo.macintel

clean:
	rm *.o *.OBJ l-echo.exe l-echo l-echo.mac* *.DOP *.DOI *~ || echo

clean-all: clean
	rm tinyxml/*.o tinyxml/*.OBJ tinyxml/*.DOP tinyxml/*.DOI || echo

run: all
	./l-echo perspective_movement.xml

dbg: all
	gdb ./l-echo

package: all w32
	zip -r $(PKGPREFIX)lin32.zip l-echo *.xml L_ECHO_README
	zip -r $(PKGPREFIX)w32.zip l-echo.exe *.xml L_ECHO_README

package-mac: macintel macppc
	powerpc-apple-darwin8-lipo -create l-echo.macppc l-echo.macintel -output l-echo.mac
	dd if=/dev/zero of=$(PKGPREFIX)osx.dmg bs=1M count=8
	mkfs.hfsplus -v '$(DESC)' $(PKGPREFIX)osx.dmg
	sudo mkdir -p /mnt/dmg
	sudo mount -t hfsplus -o loop $(PKGPREFIX)osx.dmg /mnt/dmg
	sudo cp -t /mnt/dmg l-echo.mac *.xml L_ECHO_README
	sudo umount /mnt/dmg

count:
	wc -l *.cpp *.h lin/*.cpp win/*.cpp

