function UeTimesSqrtSe(parameter, S, id, th)

fileNameUSVenv = ['USVenv', parameter.systemSuffix{id}, '.mat'] ;
load(fileNameUSVenv, 'U')

%* Ue((yj,zi),x2) = U((yj,zi),x2)*S(x2)
Ue = rmfield(U, 'tensor2') ;
for i = 1 : U.subNo
    tensor = U.tensor2{i} ; %* ((yj,zi),x2)
    U.tensor2{i} = [] ;
    xQN = U.quantNo(3, i) ;
    
    index = find(xQN == S.quantNo) ;
    Sx = diag(S.tensor1{index}) ;
    
    tensor = tensor * Sx ;
    
    Ue.tensor2{i} = tensor ;
end

id6 = id + 3 * (th - 1) ;
fileNameUe = ['Ue', parameter.systemSuffix{id6}, '.mat'] ;
save(fileNameUe, 'Ue', '-v7.3') ;
