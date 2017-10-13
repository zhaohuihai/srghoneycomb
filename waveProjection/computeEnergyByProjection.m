function [energyByProjection, wave] = computeEnergyByProjection(parameter, wave)

AB = computeLyLz_A_Lx_B_LyLz(parameter, wave) ;

T = partitionABbySiteBondBond(parameter, AB, wave.Lambda) ;

S = computeSingularValue(T, wave.Lambda) ;

coef = wave.coef ;
Lnew = S .* coef ;
Lold = wave.ABsingularValue ;

LnewNo = length(Lnew) ;
LoldNo = length(Lold) ;
Lno = min([LnewNo, LoldNo]) ;
x1 = 0 ;
for i = 1 : Lno
    x1 = x1 + Lnew(i) .* Lold(i) ;
end
x2 = sum ( Lold .* Lold ) ;

x = x1 / x2 ;
energyByProjection = -log(x) / parameter.tau / 2 ;

wave.ABsingularValue = S ;