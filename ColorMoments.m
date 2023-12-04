
%moment feature

function vectors = ColorMoments(img)
    lab = rgb2lab(img);
    L_Img = lab(:,:,1);
    A_Img = lab(:,:,2);
    B_Img = lab(:,:,3);
    [m,n] = size(L_Img);
    N = m*n;
 
    % 1
    lMean = mean2( L_Img );
    aMean = mean2( A_Img );
    bMean = mean2( B_Img );
 
    % 2
    lSig = sqrt( sum(sum((L_Img-lMean).^2))/N );
    aSig= sqrt( sum(sum((A_Img-aMean).^2))/N );
    bSig = sqrt( sum(sum((B_Img-bMean).^2))/N );
 
    % 3
    l3   = sum( sum( (L_Img-lMean).^3 ) );
    lSke = ( l3/N )^(1/3);
    a3   = sum( sum( (A_Img-aMean).^3 ) );
    aSke = ( a3/N )^(1/3);
    b3   = sum( sum( (B_Img-bMean).^3 ) );
    bSke = ( b3/N )^(1/3);
    %4
    l4   = sum( sum( (L_Img-lMean).^4 ) );
    lKur = ( l4/N )^(1/4);
    a4   = sum( sum( (A_Img-aMean).^4 ) );
    aKur = ( a4/N )^(1/4);
    b4   = sum( sum( (B_Img-bMean).^4 ) );
    bKur = ( b4/N )^(1/4);
    
    vectors = [ lMean, lSig, lSke,lKur, aMean, aSig, aSke,aKur bMean, bSig, bSke , bKur];
end