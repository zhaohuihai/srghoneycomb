function [waveLeft, waveRight] = findGroundStateWave(parameter, waveLeft, waveRight)

if parameter.loadPreviousWave == 1 && parameter.polarization == 1
    warning('Old wave is loaded, unnecessary to polarize')
    disp('The projection process will NOT polarize the wave function')
    parameter.polarization = 0 ;
end

if parameter.imbalanceWave == 0
    if parameter.polarization == 1
        waveLeft = polarizeWave(parameter, waveLeft) ;
    end
    waveLeft = applyWaveProjection(parameter, waveLeft) ;
    waveRight = waveLeft ;
else %* different ground state wave function dimension of left and right vector
    if parameter.polarization == 1
        parameter.bondDimension = parameter.leftBondDimension ;
        waveLeft = polarizeWave(parameter, waveLeft) ;
        
        parameter.bondDimension = parameter.rightBondDimension ;
        waveRight = polarizeWave(parameter, waveRight) ;
    end
    parameter.bondDimension = parameter.leftBondDimension ;
    waveLeft = applyWaveProjection(parameter, waveLeft) ;
    
    parameter.bondDimension = parameter.rightBondDimension ;
    waveRight = applyWaveProjection(parameter, waveRight) ;
end


