function parameter = defineWaveParameter(parameter)

if parameter.imbalanceWave == 0
    
    parameter.bondDimension = 3 ;
    
    disp('use SAME right and left wave function')
    disp(['bond dimension = ', num2str(parameter.bondDimension)]) ;
else
    
    parameter.leftBondDimension = 5 ;
    parameter.rightBondDimension = 30 ;
    if parameter.rightBondDimension == parameter.leftBondDimension
        disp('use SAME right and left wave function')
        parameter.bondDimension = parameter.rightBondDimension ;
        disp(['bond dimension = ', num2str(parameter.bondDimension)]) ;
        parameter.imbalanceWave = 0 ;
    else
        disp('use DIFFERENT right and left wave function')
        disp(['left bond dimension = ', num2str(parameter.leftBondDimension)])
        disp(['right bond dimension = ', num2str(parameter.rightBondDimension)])
    end
end

parameter.siteDimension = 2 ;

% *********************************
%* virtualSpin must be INTEGER
parameter.virtualSpin = 20 ;

% if initial A and B are same
parameter.sameInitialTensor = 0 ;