function [P] = poc(A,B)
    %A‚ÆB‚ÆPOCŠÖ”‚ÌŒvZ, â‘Î’l‚ğ•Ô‚·
    A2 = fft2(A);
    A3 = A2./modified_abs(A2);
    B2 = fft2(B);
    B3 = conj(B2)./modified_abs(B2);
    C = ifft2(A3.*B3);
    C2 = fftshift(C);
    P=abs(C2);
end

 