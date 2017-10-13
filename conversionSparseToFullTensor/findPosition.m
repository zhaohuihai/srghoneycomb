function p = findPosition(SN, Lambda)

a = sum(Lambda.dim(1 : SN)) - Lambda.dim(SN) + 1 ;
b = sum(Lambda.dim(1 : SN)) ;

p = a : b ;