
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
