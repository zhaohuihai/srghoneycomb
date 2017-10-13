function [RA, RB] = createR(parameter, id)
%* RA(x,y,z), RB(x,y,z)

fileNameUSV = ['USV', parameter.systemSuffix{id}, '.mat'] ;
load(fileNameUSV, 'U', 'S')

RA = createRA(U, S) ;

clear U
load(fileNameUSV, 'V')
RB = createRA(V, S) ;