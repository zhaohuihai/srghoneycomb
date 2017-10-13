function S = computeSingularValue(T, Lambda)

TNo = length(T) ;

S = [] ;
for iT = 1 : TNo
    Tblock = combineTsub(T(iT), Lambda) ;
    Sblock = svd(Tblock) ;
    S= [S; Sblock] ;
     
end

S = sort(S, 'descend') ;