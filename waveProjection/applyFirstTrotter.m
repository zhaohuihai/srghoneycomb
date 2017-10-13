function wave = applyFirstTrotter(parameter, wave)

% PT = parameter.eachTime ;
% for i = 1 : PT
for j = 1 : 3
    wave = projectBy1operator(parameter, wave) ;
    
    wave = rotate(parameter, wave) ;
end
%     [energyByProjection, wave] = computeEnergyByProjection(parameter, wave) ;
%     wave.coef = 1 ;
%     if ((i / 100) == floor(i / 100))
%         i
%         energyByProjection
%     end
% end
