function [ P, L ] = readin( filename )

lines = readlines( filename, 'EmptyLineRule', 'skip' );
P = cellfun( @(t)t{1}, regexp( char(lines(1)), '(\w+)', 'tokens' ), 'UniformOutput', false );
L = arrayfun( @char, lines(2:end), 'UniformOutput', false );
