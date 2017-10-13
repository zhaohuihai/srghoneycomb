function H = createHamiltonian(parameter)

%* Heisenberg model with spin half

M = parameter.siteDimension ;
staggerMagField = parameter.staggerMagField ;

H = zeros(M, M, M, M) ;
MM = M * M ;
% %* H(m1, m2, n1, n2) = <m1, m2| H | n1, n2 >
% H(1, 1, 1, 1) = 0.25 ;
% H(1, 2, 1, 2) = -0.25 ;
% H(2, 1, 2, 1) = -0.25 ; 
% H(2, 2, 2, 2) = 0.25 ;
% 
% % add a Marshall sign to the non-diagonal elements
% 
% H(1, 2, 2, 1) = -0.5 ;
% H(2, 1, 1, 2) =  H(1, 2, 2, 1);
% H = reshape(H, [MM, MM])  %* H((m1, m2), (n1, n2))

%* H(m1, -m2, n1, -n2) = <m1, -m2| H | n1, -n2 >
H(1, 2, 1, 2) = 0.25 ;
H(1, 1, 1, 1) = -0.25 - staggerMagField / 3 ;
H(2, 2, 2, 2) = -0.25 + staggerMagField / 3 ; 
H(2, 1, 2, 1) = 0.25 ;

% add a Marshall sign to the non-diagonal elements
H(1, 1, 2, 2) = -0.5 ;
H(2, 2, 1, 1) =  H(1, 1, 2, 2);
H = reshape(H, [MM, MM]) ; %* H((m1, -m2), (n1, -n2))