function T = reduceT_projection(T)

Tno = length(T) ;

for i = 1 : Tno
    subNo = T(i).subNo ;
    n = 0 ;
    equal = cell(1, 5) ;
    while subNo > 0
        s1 = T(i).site1(1) ;
        SN = T(i).serialNo(:, 1) ;
        equal{1} = (s1 == T(i).site1) ;
        for j = 1 : 4
            equal{j + 1} = (SN(j) == T(i).serialNo(j, :)) ;
        end
        index = find(equal{1} & equal{2} & equal{3} & equal{4} & equal{5}) ;
        indexNo = length(index) ;
        
        s2 = T(i).site2(index(1)) ;
        n = n + 1 ;
        tensor = 0 ;
        for j = 1 : indexNo
            tensor = tensor + T(i).tensor2{index(j)} ;
        end
        subNo = subNo - indexNo ;
        tensor2{n} = tensor ;
        serialNo(:, n) = SN ;
        site1(n) = s1 ;
        site2(n) = s2 ;
        T(i).site1(index) = [] ;
        T(i).site2(index) = [] ;
        T(i).serialNo(:, index) = [] ;
        T(i).tensor2(index) = [] ;
    end
    T(i).subNo = n ;
    T(i).site1 = site1 ;
    T(i).site2 = site2 ;
    T(i).serialNo = serialNo ;
    T(i).tensor2 = tensor2 ;
    clear site1 site2 serialNo tensor2
end