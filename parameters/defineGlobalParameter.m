function parameter = defineGlobalParameter

%* yes: 1, no: 0
parameter.loadPreviousWave = 0 ; %*

parameter.imbalanceWave = 0 ;

parameter.projection = 1 ; %*

%* staggered spontaneous magnetization parameters
parameter.magnetizationComputation = 1 ;

% energy computation parameters
parameter.energyComputation = 0 ;
%********************************************************************
%* Maximum number of iterations in svds
parameter.svdsOptions.maxit = 500 ;
%* tolerance in svds
parameter.svdsOptions.tol = 1e-10 ;

%* determine the maximum difference ratio of degenerate values
parameter.maxDiffRatio = 1 - 1e-15 ;
% parameter.maxDiffRatio = 1 ;

%
parameter.debugMode = 0 ;