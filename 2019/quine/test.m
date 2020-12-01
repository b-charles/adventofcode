clear all
clc

nl = char(10);
contents = strsplit(fileread('quine.m'),nl);
ref_contents = [strjoin(contents(1:end-2),nl), nl];
actual_contents=quine();

ref_contents
actual_contents
assert( isequal(ref_contents,actual_contents) )

