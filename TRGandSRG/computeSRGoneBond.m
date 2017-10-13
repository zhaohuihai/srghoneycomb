function [RA, RB, coefT, RHA, RHB, coefH] = computeSRGoneBond(parameter, id)

decomposeEnvironment(parameter, id) ;

coefTH = zeros(1, 2) ;

% if parameter.parallelBond == 1
%     parfor i = 1 : 2
%         [R_A(i), R_B(i), coefTH(i)] = decomposeSystemInEnvironment(parameter, id, i) ;
%     end
% else
for i = 1 : 2
    [R_A(i), R_B(i), coefTH(i)] = decomposeSystemInEnvironment(parameter, id, i) ;
end
% end
RA = R_A(1) ;
RB = R_B(1) ;
RHA = R_A(2) ;
RHB = R_B(2) ;

coefT = coefTH(1) ;
coefH = coefTH(2) ;