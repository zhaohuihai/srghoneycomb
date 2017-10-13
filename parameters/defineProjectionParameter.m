function parameter = defineProjectionParameter(parameter)

parameter.polarization = 1 ; %*
parameter.polarField = 1 ;
parameter.convergenceCriterion_polarization = 1e-6 ;

parameter.staggerMagField = 0.00 ;

parameter.TrotterOrder = 2 ;

parameter.tauInitial = 3e-1 ;
parameter.tauFinal = 4e-4 ; %*
parameter.tauChangeFactor = 0.4 ;
% disp(['initial tau = ', num2str(parameter.tauInitial)])

parameter.convergenceCriterion_projection = 1e-14 ;

%* if the retaining dimension is smaller than 'svdRatio' of the total dimention, use svds
parameter.svdRatio_projection = 0.0 ;