function T = computeProjection(parameter, AB, Lambda)

ABpro = projectAB(parameter, AB) ;

T = partitionABproBySiteBondBond(ABpro, Lambda) ;

