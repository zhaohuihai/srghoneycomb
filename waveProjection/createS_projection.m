function S = createS_projection(Sblock, S, T, iT)

S.quantNo(iT) = T.siteBondBond ;
S.dim(iT) = length(Sblock) ;
S.tensor1{iT} = diag(Sblock) ;