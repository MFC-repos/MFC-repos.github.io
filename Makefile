#!/usr/bin/make
#
# Update the repository every time when a new package arrives

all: repo

repo: dists/mfc/InRelease

dists/mfc/InRelease: dists/mfc/Release
	gpg --clearsign --digest-algo SHA512 -o dists/mfc/InRelease.new dists/mfc/Release
	mv dists/mfc/InRelease.new dists/mfc/InRelease
		rm dists/mfc/Release

dists/mfc/Release: conf/distributions contrib/binary-amd64/Packages.gz
	cat conf/distributions > dists/mfc/Release
	apt-ftparchive release . >> dists/mfc/Release

contrib/binary-amd64/Packages.gz: contrib/binary-amd64/Packages
	gzip --keep --force -9 contrib/binary-amd64/Packages

contrib/binary-amd64/Packages: contrib/binary-amd64/*.deb
	dpkg-scanpackages contrib/binary-amd64 > contrib/binary-amd64/Packages.new
	mv contrib/binary-amd64/Packages.new contrib/binary-amd64/Packages
