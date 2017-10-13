function TA = contract3RtoT(RAx, RAy, RAz)
%* RRAyz((yi,zi),(y,z)) = sum{xi}_(RAy(y,zi,xi)*RAz(z,xi,yi))
RRAyz = contractRy_Rz(RAy, RAz) ;
%* TA(x,y,z) = sum{yi,zi}_(RAx(x,yi,zi)*RRAyz((yi,zi),(y,z)))
TA = contractRx_RyRz(RAx, RRAyz) ;
% TA = reduceTA(TA) ;

% THA = contractRx_RyRz(RHAx, RRAyz) ;
% THA = reduceTA(THA) ;