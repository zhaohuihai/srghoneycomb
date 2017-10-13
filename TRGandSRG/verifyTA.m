function verifyTA(TA)

TAno = length(TA.tensor3) ;

for i = 1 : TAno
    A = rand(TA.xDim(i), TA.yDim(i), TA.zDim(i)) ;
    B = TA.tensor3{i} ;
    A - B
end