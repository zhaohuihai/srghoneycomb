function staggerOperator = createStaggerOperator(parameter)

M = parameter.siteDimension ;
MM = M * M ;
staggerOperator = zeros(M, M, M, M) ;

%* staggerOperator(m1, -m2, n1, -n2) = <m1, -m2| staggerOperator | n1, -n2 >
staggerOperator(1, 1, 1, 1) = 1 / 3 ;
staggerOperator(2, 2, 2, 2) = - 1 / 3 ;

staggerOperator = reshape(staggerOperator, [MM, MM]) ;