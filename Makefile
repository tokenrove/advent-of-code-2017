FACTOR=$$HOME/build/factor/factor

.PHONY: help
help:
	@echo 'make day[n] => compile and run nth day solution'

day1: day1.fut day1.in
	echo '"'$(cat day1.in)'"' | futharki day1.fut

day2: day2.rb day2.in
	ruby day2.rb < day2.in

day3.exe: day3.fs
	fsharpc day3.fs

day3: day3.exe day3.in
	mono day3.exe $$(cat day3.in)

day4: day4.scm day4.in
	guile day4.scm

day5.data.s: day5.in
	sed 's/^/dw /' day5.in > day5.data.s

day5.img: day5.s day5.data.s
	nasm -f bin day5.s -o day5.img

day5: day5.img
	qemu-system-i386 -drive file=day5.img,index=0,media=disk,format=raw

day6: day6.st day6.in
	gst day6.st

day7: day7.pl day7.in
	swipl -t main -q day7.pl

day8: day8.factor day8.in
	$(FACTOR) day8.factor

