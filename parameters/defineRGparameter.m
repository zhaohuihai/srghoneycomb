function parameter = defineRGparameter(parameter)

parameter.TRG = 0 ;
parameter.SRG = 1 ;

%* parallel parameter
parameter.parallelBond = 1 ;
parameter.parallelSVD = 0 ; 
parameter.poolSize = 3 ;

%* dimension saved in RG process
parameter.dimSave_RG = 120 ;
% parameter.dimSave_RG = parameter.bondDimension^2 ;

%* continue calculation after accidentally termination
parameter.loadIntermediateResult = 0 ;
%*
parameter.eigenStateMethod = 0 ;

%* upDownSpin = 1 : |1,-1>; upDownSpin = 2 : |-1,1>; 
parameter.upDownSpin = 1 ;

%**************************************************************************************
%* file name
parameter.systemSuffix = {'x', 'y', 'z', 'Hx', 'Hy', 'Hz'} ;
parameter.environmentSuffix = {'xx', 'xy', 'xz'; 'yx', 'yy', 'yz'; 'zx', 'zy', 'zz'} ;
% parameter.latticeSize = 15 ;

parameter.environmentSize = 8 ;

parameter.convergenceCriterion_TRG = 1e-9 ;
parameter.convergenceCriterion_SRG = 1e-9 ;

parameter.maxTRGstep = 30 ;
parameter.maxSRGstep = 30 ;

%* if the retaining dimension is smaller than 'svdRatio' of the total dimention, use svds
parameter.svdRatio_TRG = 0.0 ;
parameter.svdRatio_SRG = 0.0 ;

%* if the singular values in the decomposition of environment is smaller than 'smallestSingularValue', then eliminate them.
parameter.smallestSingularValue = 1e-80 ;