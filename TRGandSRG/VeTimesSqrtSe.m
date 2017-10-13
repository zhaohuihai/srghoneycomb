function VeTimesSqrtSe(parameter, S, id, th)

fileNameUSVenv = ['USVenv', parameter.systemSuffix{id}, '.mat'] ;
load(fileNameUSVenv, 'V')

%* Ve((yj,zi),x2) = V((yj,zi),x2)*S(x2)
Ve = rmfield(V, 'tensor2') ;
for i = 1 : V.subNo
    tensor = V.tensor2{i} ; %* ((yj,zi),x2)
    V.tensor2{i} = [] ;
    xQN = V.quantNo(3, i) ;
    
    index = find(xQN == S.quantNo) ;
    Sx = diag(S.tensor1{index}) ;
    
    tensor = tensor * Sx ;
    
    Ve.tensor2{i} = tensor ;
end

id6 = id + 3 * (th - 1) ;
fileNameVe = ['Ve', parameter.systemSuffix{id6}, '.mat'] ;
save(fileNameVe, 'Ve', '-v7.3') ;

