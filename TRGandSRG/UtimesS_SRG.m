function US = UtimesS_SRG(U, S)
%* US(x1,x) = U(x1,x)*S(x)

US = rmfield(U, 'tensor2') ;
for i = 1 : U.subNo
    Sx = diag(S.tensor1{i}) ;
    
    tensor = U.tensor2{i} * Sx ;
    U.tensor2{i} = [] ;
    US.tensor2{i} = tensor ;
end
