function [U, S, V] = eliminateEmptyElement_environment(U, S, V)

S = eliminateEmptyS_RG(S) ;

U = eliminateEmptyU_RG(U) ;

V = eliminateEmptyU_RG(V) ;
