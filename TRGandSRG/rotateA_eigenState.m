function A = rotateA_eigenState(M, A0)

for i = 1 : M
    A(i) = rotateT(A0(i)) ;
end