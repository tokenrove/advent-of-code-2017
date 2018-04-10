#!/usr/bin/env ijconsole
NB. -*- j -*-
i =. }. ".;._2 LF,stdin ''
echo 'part 1: '; +/ (>./"1 - <./"1) i
echo 'part 2: '; +/ ((#~(=>.))@(#~(1&~:))@,@(%/]))"1 i
NB. linear time should be something like this:
echo 'part 2: '; +/ ((#~(=>.))@(#~1&~:)@,@:% (<./@(#~ 0&=) (*: | */))"1) x: i