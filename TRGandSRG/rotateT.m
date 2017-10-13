function TA = rotateT(TA0)

%* TA0(x,y,z) --> TA(y,z,x)
TA.subNo = TA0.subNo ;
TA.quantNo(1, :) = TA0.quantNo(2, :) ;
TA.quantNo(2, :) = TA0.quantNo(3, :) ;
TA.quantNo(3, :) = TA0.quantNo(1, :) ;
TA.dim(1, :) = TA0.dim(2, :) ;
TA.dim(2, :) = TA0.dim(3, :) ;
TA.dim(3, :) = TA0.dim(1, :) ;

for i = 1 : TA0.subNo
    TA.tensor3{i} = permute(TA0.tensor3{i}, [2, 3, 1]) ;
end