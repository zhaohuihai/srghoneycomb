function MM = contractM_M(fileNameM1, fileNameM2)
%* MM((y1,z2),(y3,z3)) = sum{y2,z1}_(M1((y1,z2),(y2,z1))*M2((y2,z1),(y3,z3)))

load(fileNameM1, 'M1') ;
load(fileNameM2, 'M2') ;
n = 0 ;

MM.subNo = 0 ;
MM.quantNo = zeros(4, 0) ;
MM.dim = zeros(4, 0) ;
MM.tensor2 = cell(0) ;

for i = 1 : M1.subNo
    m1QN = M1.quantNo(:, i) ;
    m1Dim = M1.dim(:, i) ;
    %* M1tensor((y1,z2),(y2,z1))
    M1tensor = M1.tensor2{i} ;
    M1.tensor2{i} = [] ;
    equalY2 = (m1QN(3) == M2.quantNo(1, :)) ;
    equalZ1 = (m1QN(4) == M2.quantNo(2, :)) ;
    j = find(equalY2 & equalZ1) ;
    if ~isempty(j)        
        for k = 1 : length(j)           
            m2QN = M2.quantNo(:, j(k)) ;
            m2Dim = M2.dim(:, j(k)) ;
            %* M2tensor((y2,z1),(y3,z3))
            M2tensor = M2.tensor2{j(k)} ;
            
            %* tensor((y1,z2),(y3,z3))
            tensor = M1tensor * M2tensor ;
            tQN = [m1QN(1 : 2); m2QN(3 : 4)] ;
            
            equalT = cell(1, 3) ;
            for m = 1 : 3
                equalT{m} = (tQN(m) == MM.quantNo(m, :)) ;
            end
            index = find(equalT{1} & equalT{2} & equalT{3}) ;
            
            if isempty(index)
                n = n + 1 ;
                MM.quantNo(:, n) = tQN ;
                MM.dim(:, n) = [m1Dim(1 : 2); m2Dim(3 : 4)] ;
                MM.tensor2{n} = tensor ;
            else
                MM.tensor2{index} = MM.tensor2{index} + tensor ;
            end
        end
    end
end
clear M1 M2
MM.subNo = n ;

% subNo = n ;
% tensor2 = cell(0) ;
% quantNo = zeros(4, 0) ;
% dim = zeros(4, 0) ;
% 
% n = 0 ;
% while subNo > 0
%     QN = MM.quantNo(:, 1) ;
%     for i = 1 : 4
%         equal{i} = (QN(i) == MM.quantNo(i, :)) ;
%         
%     end
%     index = find(equal{1} & equal{2} & equal{3} & equal{4}) ;
%     indexNo = length(index) ;
%     n = n + 1 ;
%     tensor = 0 ;
%     for i = 1 : indexNo
%         tensor = tensor + MM.tensor2{index(i)} ;
%     end
%     subNo = subNo - indexNo ;
%     tensor2{n} = tensor ;
%     quantNo(:, n) = QN ;
%     dim(:, n) = MM.dim(:, 1) ;
%     MM.quantNo(:, index) = [] ;
%     MM.dim(:, index) = [] ;
%     MM.tensor2(index) = [] ;
% end
% MM.subNo = n ;
% MM.quantNo = quantNo ;
% MM.dim = dim ;
% MM.tensor2 = tensor2 ;
