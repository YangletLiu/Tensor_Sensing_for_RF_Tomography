function T = matrix2tensor(X,sz)
%% 把TS中的smallCircMat还原回tensor
T = zeros(sz(1), sz(2), sz(3));
for i = 1 : sz(1)
   for j = 1 : sz(2)
       T(i, j, :) = X(((i-1)*sz(3) + 1) : i*sz(3), j);
   end
end
end