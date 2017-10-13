function main

% clc
clear
format long
restoredefaultpath
createPath

parameter = setParameter ;

if parameter.loadPreviousWave == 0
    [waveLeft, waveRight] = initializeWave(parameter);
    disp('create new wave')
else    
    [waveLeft, waveRight] = loadWave(parameter) ;
    disp('load old wave')
end

if parameter.projection == 1
    [waveLeft, waveRight] = findGroundStateWave(parameter, waveLeft, waveRight) ;
end
% convertSparseToFullWave(parameter, wave) ;

% wave = truncateWave(parameter, wave) ;
if parameter.energyComputation == 1
    parameter.H = createHamiltonian(parameter) ;
    computeEnergy(parameter, waveLeft, waveRight) ;
end

if parameter.magnetizationComputation == 1
    if parameter.eigenStateMethod == 1
        disp('you can not use eigen state method if the wavefunction is not the eigen state of the operator!')
        disp('use inner product method instead')
        parameter.eigenStateMethod = 0 ;
    end
    parameter.H = createStaggerOperator(parameter) ;
    computeMagnetization(parameter, waveLeft, waveRight) ;
end
deleteIntermediateResult
deleteTempData