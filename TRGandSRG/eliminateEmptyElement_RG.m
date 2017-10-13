function [U, S, V] = eliminateEmptyElement_RG(U, S, V)

S = eliminateEmptyS_RG(S) ;

U = eliminateEmptyU_RG(U) ;

V = eliminateEmptyU_RG(V) ;
