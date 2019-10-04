#!/usr/bin/make
#
# Update the repository every time when a new package arrives

all: repo

repo: dists/mfc/InRelease

dists/mfc/InRelease: dists/mfc/Release
	gpg --clearsign --digest-algo SHA512 -o dists/mfc/InRelease.new dists/mfc/Release
	mv dists/mfc/InRelease.new dists/mfc/InRelease
	rm dists/mfc/Release

dists/mfc/Release: conf/distributions contrib/binary-amd64/Packages.xz
	cat conf/distributions > dists/mfc/Release
	apt-ftparchive release . | grep -vwE "dists/mfc/Release" >> dists/mfc/Release

contrib/binary-amd64/Packages.xz: contrib/binary-amd64/Packages
	xz -9ec contrib/binary-amd64/Packages > contrib/binary-amd64/Packages.xz

contrib/binary-amd64/Packages: contrib/binary-amd64/*.deb
	dpkg-scanpackages contrib/binary-amd64 > contrib/binary-amd64/Packages
