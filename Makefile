all: build

build:
	make -C AuthLib
	make -C BeManager
	make -C BeSure
	make -C bt_fs
	make -C FileSharing
	make -C lshosts
	make -C mounthost
	make -C MyNetwork
	make -C server
	make -C transport

release: mrproper
	make RELEASE=1 -C AuthLib
	make RELEASE=1 -C BeManager
	make RELEASE=1 -C BeSure
	make RELEASE=1 -C bt_fs
	make RELEASE=1 -C FileSharing
	make RELEASE=1 -C lshosts
	make RELEASE=1 -C mounthost
	make RELEASE=1 -C MyNetwork
	make RELEASE=1 -C server
	make RELEASE=1 -C transport

clean:
	make -C AuthLib clean
	make -C BeManager clean
	make -C BeSure clean
	make -C bt_fs clean
	make -C FileSharing clean
	make -C lshosts clean
	make -C mounthost clean
	make -C MyNetwork clean
	make -C server clean
	make -C transport clean

.PHONY: build release clean
