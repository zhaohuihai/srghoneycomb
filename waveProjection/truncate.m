function [USV, projectionSingularValue] = truncate(parameter, USV)

M = parameter.siteDimension ;
U = USV.U ;
S = USV.S ;
V = USV.V ;

[U, S, V, coef, projectionSingularValue] = doTruncation(parameter, U, S, V) ;

[U, S, V] = eliminateEmptyElement(M, U, S, V) ;

USV.U = U ;
USV.V = V ;
USV.S = S ;
USV.coef = coef ;
%****************************
