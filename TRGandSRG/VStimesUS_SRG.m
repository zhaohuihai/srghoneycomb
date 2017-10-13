function RA = VStimesUS_SRG(VS, US)
%* RA(x,yi,zj) = sum_{x1}(VS((yi,zj),x1)*US(x1,x))

n = 0 ;
for i = 1 : VS.subNo
    vsQN = VS.quantNo(:, i) ;
    vsDim = VS.dim(:, i) ;
    vsTensor = VS.tensor2{i} ; %* ((yi,zj),x1)
    VS.tensor2{i} = [] ;
    j = find(vsQN(3) == US.quantNo) ;
    if ~isempty(j)
        n = n + 1 ;        
        usQN = US.quantNo(j) ;
        usDim = US.dim(:, j) ;
        usTensor = US.tensor2{j} ; %* (x1,x)
        
        tensor = vsTensor * usTensor ; %* ((yi,zj),x)
        tensor = reshape(tensor, [vsDim(1), vsDim(2), usDim(2)]) ; %* (yi,zj,x)
        tensor = permute(tensor, [3, 1, 2]) ; %* (x,yi,zj)
        
        RA.quantNo(:, n) = [usQN; vsQN(1 : 2)] ;
        RA.dim(:, n) = [usDim(2); vsDim(1 : 2)] ;
        RA.tensor3{n} = tensor ;
    end
end
RA.subNo = n ;
% RA.quantNo = quantNo ;
% RA.dim = dim ;
% RA.tensor3 = tensor3 ;