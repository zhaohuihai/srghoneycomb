function [waveLeft, waveRight] = loadWave(parameter)


if parameter.imbalanceWave == 0
    resultFileName = ['result/D = ', num2str(parameter.bondDimension), '/wavefunction.mat'] ;
    load (resultFileName, 'wave')
    waveLeft = wave ;
    waveRight = wave ;
    
else
    resultFileName = ['result/D = ', num2str(parameter.leftBondDimension), '/wavefunction.mat'] ;
    load (resultFileName, 'wave')
    waveLeft = wave ;
    
    resultFileName = ['result/D = ', num2str(parameter.rightBondDimension), '/wavefunction.mat'] ;
    load (resultFileName, 'wave')
    waveRight = wave ;
end




