function [RSE,error]=TS(X, X_s, A_all, A_all_t, y, IterNum, r, SamplingRate)
%% Simplified Alternating Minimization for tensor sensing
% Problem state：min|| b - <A,(U*V)> ||_F^2, s.t.:tubal-rank of U * V=r
% Input : X = U * V  - 理想数据，U:m * r * k,   V:r * n * k，    X：m * n * k
%         A - 采样tensor，每一个前切面A_i大小为mk * n,每一个A_i与X做内积，所得的数作为y_i,1 <= i<= d
%         IterNum - 算法迭代次数
%         r - target tubal-rank
% Output : U^c : mk * rk  -  X^s的左近似分解项
%          V^s : rk * n   -  X^s的右近似分解项
%          X^s : mk * n      X^s = U^c * V^s

error = zeros(IterNum,1);      %误差数组


%% 初始化 A2m U0

[m, n, k] = size(X);
U0 = randn(m, r, k);
U = Tensor2fullCircM(U0);     % U 初始化时化为循环矩阵
% parpool open;
%% 算法迭代主体
for l = 1 : IterNum
    V = LS_V(A_all, U, r*k, y, n);
    U = LS_U(A_all_t, V, r*k, y, m*k);
    X_ = U * V;
    RSE = norm(X_s(:) - X_(:)) / norm(X_s(:));
    fprintf('SamplingRate:%d,%d-th iteration,error is %e\n',SamplingRate,l,RSE);
    error(l,:) = RSE;
end

%% LS函数
    function [V] = LS_V(A2m, U, r, y, n)
        U_ = mat2diaMat(U,n);         % 编排后的矩阵 U    
        W = A2m*U_;
        V_ = W \ y ;
%         V_ = lsqr(W, y, 1e-6, 100); 
        clear W;
        V = Vec2Mat(V_,[r, n]);       % 将得到的向量  V  重新转化为矩阵
     
    end

    function [U] = LS_U(A_t2m, V, r, y, m)
        Vt = V.';
        Vt_ = mat2diaMat(Vt,m);
        W = A_t2m*Vt_;
        U_ = W \ y ;
%       U_ = lsqr(W, y, 1e-6, 100); 
        clear W;
        U = (Vec2Mat(U_,[r, m])).';
    end
end






