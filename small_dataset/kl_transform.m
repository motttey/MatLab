%function matching_flag = clafic(Class, X, Qname)
y = double(DB(:,:,1));
%y=[1,2,4;2,3,10];
y=y' %Reasons for transposing will become clear when you will read the second point given below.
[V,D]=eig(cov(y));
KLT = V' * y';

