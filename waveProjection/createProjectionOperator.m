function projectionOperator = createProjectionOperator(parameter)
%* input arguments: parameter.siteDimension, parameter.tau, parameter.H
%* output arguments: projectionOperator(M^2, M^2)


% M = parameter.siteDimension ;

%* H = V*D*V'
[V, D] = eig(parameter.H) ;

expD = diag(exp(- parameter.tau * diag(D))) ;
projectionOperator = V * expD * (V') ;

