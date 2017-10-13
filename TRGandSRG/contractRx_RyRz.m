function TA = contractRx_RyRz(RAx, RRAyz)

%* TA(x,y,z) = sum{yi,zi}_(RAx(x,yi,zi)*RRAyz((yi,zi),(y,z)))

RAxNo = RAx.subNo ;
n = 0 ;
TA.subNo = 0 ;
TA.quantNo = zeros(3, 0) ;
TA.dim = zeros(3, 0) ;
TA.tensor3 = cell(0) ;
for i = 1 : RAxNo
    RxQN = RAx.quantNo(:, i) ;
    RxDim = RAx.dim(:, i) ;
    RAxTensor = RAx.tensor3{i} ; %* (x,yi,zi)
    RAx.tensor3{i} = [] ;
    
    equalYi = (RxQN(2) == RRAyz.quantNo(1, :)) ;
    equalZi = (RxQN(3) == RRAyz.quantNo(2, :)) ;
    j = find(equalYi & equalZi) ;
    
    if ~isempty(j)
        RAxTensor = reshape(RAxTensor, [RxDim(1), RxDim(2) * RxDim(3)]) ; %* (x,(yi,zi))
        
        for k = 1 : length(j)                        
            RRyzQN = RRAyz.quantNo(:, j(k)) ;
            RRyzDim = RRAyz.dim(:, j(k)) ;
            RRAyzTensor = RRAyz.tensor2{j(k)} ; %* RRAyz((yi,zi),(y,z))
            
            %* tensor(x,(y,z))            
            tensor = RAxTensor * RRAyzTensor ;
            %* tensor(x,y,z)
            tDim = [RxDim(1); RRyzDim(3); RRyzDim(4)] ;
            tensor = reshape(tensor, tDim') ;
            tQN = [RxQN(1); RRyzQN(3 : 4)] ;
            
            equalT = cell(1, 2) ;
            for m = 1 : 2
                equalT{m} = (tQN(m) == TA.quantNo(m, :)) ;
            end
            index = find(equalT{1} & equalT{2}) ;
            
            if isempty(index)
                n = n + 1 ; 
                TA.quantNo(:, n) = tQN ;
                TA.dim(:, n) = tDim ;
                TA.tensor3{n} = tensor ;
            else
                TA.tensor3{index} = TA.tensor3{index} + tensor ;
            end
        end
    end
end
TA.subNo = n ;