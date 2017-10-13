function [waveLeft, waveRight] = initializeWave(parameter)

if parameter.debugMode == 1
    wave = InitializeTensorForTest ;
    waveLeft = wave ;
    waveRight = wave ;
else
    if parameter.imbalanceWave == 0
        mapping = initializeMapping(parameter) ;
        wave = initializeTNS(parameter, mapping) ;
        waveLeft = wave ;
        waveRight = wave ;        
    else       
        parameter.bondDimension = parameter.leftBondDimension ;
        mapping = initializeMapping(parameter) ;
        waveLeft = initializeTNS(parameter, mapping) ;
        
        parameter.bondDimension = parameter.rightBondDimension ;
        mapping = initializeMapping(parameter) ;
        waveRight = initializeTNS(parameter, mapping) ;
    end    
end
