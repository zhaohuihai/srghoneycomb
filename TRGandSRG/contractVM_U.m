function contractVM_U(parameter, id, th)
%* VMU(x1, x2) = sum_{yj,zi}(VM(x1, (yj,zi)) * Ue((yj,zi),x2))

id6 = id + 3 * (th - 1) ;
suffix = parameter.systemSuffix{id6} ;
fileNameVM = ['VM', suffix, '.mat'] ;
load(fileNameVM, 'VM')

fileNameUe = ['Ue', suffix, '.mat'] ;
load(fileNameUe, 'Ue')

n = 0 ;

VMU.subNo = 0 ;
VMU.quantNo = zeros(1, 0) ;
VMU.dim = zeros(1, 0) ;
VMU.tensor2 = cell(0) ;
for i = 1 : VM.subNo
    vmQN = VM.quantNo(:, i) ;
    vmDim = VM.dim(:, i) ;
    vmTensor = VM.tensor2{i} ; %* (x1, (yj,zi))
    VM.tensor2{i} = [] ;
    equalYj = (vmQN(2) == Ue.quantNo(1, :)) ;
    equalZi = (vmQN(3) == Ue.quantNo(2, :)) ;
    j = find(equalYj & equalZi) ;
    if ~isempty(j)                        
        % uQN = Ue.quantNo(:, j) ;
        % uDim = Ue.dim(:, j) ;
        uTensor = Ue.tensor2{j} ; %* ((yj,zi),x2)
        
        tensor = vmTensor * uTensor ; %* (x1, x2)
        
        index = find(vmQN(1) == VMU.quantNo) ;
        if isempty(index)
            n = n + 1 ;
            VMU.quantNo(n) = vmQN(1) ;
            VMU.dim(n) = vmDim(1) ;
            VMU.tensor2{n} = tensor ;
        else
            VMU.tensor2{index} = VMU.tensor2{index} + tensor ;
        end
    end
end
VMU.subNo = n ;

fileNameVMU = ['VMU', suffix, '.mat'] ;
save(fileNameVMU, 'VMU', '-v7.3')