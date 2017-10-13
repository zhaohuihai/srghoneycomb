function U = UeTimesInvSqrtSe(U0, S)

%* U((yj,zi),x2) = U0((yj,zi),x2)*S(x2)
U = rmfield(U0, 'tensor2') ;
for i = 1 : U.subNo
    tensor = U0.tensor2{i} ; %* ((yj,zi),x2)
    U0.tensor2{i} = [] ;
    xQN = U0.quantNo(3, i) ;
    
    index = find(xQN == S.quantNo) ;
    Sx = diag(S.tensor1{index}) ;
    
    tensor = tensor * Sx ;
    
    U.tensor2{i} = tensor ;
end