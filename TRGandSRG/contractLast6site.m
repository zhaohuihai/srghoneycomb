function energyLast6site = contractLast6site(parameter, id)

fileNameM = ['M', parameter.systemSuffix{id}, '.mat'] ;
load(fileNameM, 'M') ;
M1 = M ;
clear M

fileNameM1 = ['M1', parameter.systemSuffix{id}, '.mat'] ;
save(fileNameM1, 'M1', '-v7.3') ;
M2 = M1 ;
clear M1
fileNameM2 = ['M2', parameter.systemSuffix{id}, '.mat'] ;
save(fileNameM2, 'M2', '-v7.3') ;
clear M2

%* MM((y1,z2),(y3,z3)) = sum{y2,z1}_(M((y1,z2),(y2,z1))*M((y2,z1),(y3,z3)))
M2 = contractM_M(fileNameM1, fileNameM2) ;
save(fileNameM2, 'M2', '-v7.3') ;
clear M2

%* MMM((y1,z2),(y1,z2)) = sum{y3,z3}_(MM((y1,z2),(y3,z3))*M((y3,z3),(y1,z2)))
M = contractM_M(fileNameM1, fileNameM2) ;
save(fileNameM, 'M', '-v7.3') ;
clear M

normFactor = computeTrace(fileNameM) 
% MH = partitionMbyBondBond(MH) ;
% MH = blockMbyBondBond(MH) ;

fileNameMH = ['MH', parameter.systemSuffix{id}, '.mat'] ;
load(fileNameMH, 'M') ;
M1 = M ;
clear M
save(fileNameM1, 'M1', '-v7.3') ;
M = contractM_M(fileNameM1, fileNameM2) ;
save(fileNameM, 'M', '-v7.3') ;
clear M

h = computeTrace(fileNameM) 

energyLast6site = h / normFactor ;