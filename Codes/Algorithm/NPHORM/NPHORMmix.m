function [V, B, KerA] = NPHORMmix(AA, Y, C, Cs_scale, sigma)

% coder.extrinsic('invChol_mex');
% coder.extrinsic('qp');

% get the number of labels
K = length(unique(Y));

% define the hyper-parameters
% gc          = groupcounts(Y);
% C           = C_scale * gc / mean(gc);
% Cs          = Cs_scale * gc / mean(gc);
% C(C == 0)   = mean(C);
% Cs(Cs == 0) = mean(Cs);
% C           = C_scale * ones(K,1);
Cs          = Cs_scale * ones(K,1);

% get the kernel product
% kertype = Kdata{1};
% if kertype == "None"
%     KerA = AA;
% else
KerA = Kernel('rbf', AA', AA', sigma);
% end

% pre-allocate the output
N = size(KerA,2);
V = zeros(N, K);
B = zeros(1, K);

% calculate problem (40) and equation (39) in the paper
for ii = 1:K
    % preps
    indi0 = (Y <= ii-1);
    indi1 = Y == ii;
    indi2 = (Y >= ii+1);
    len0  = length(find(indi0));
    len1  = length(find(indi1));
    len2  = length(find(indi2));
    
    % calcs
    Sk  = [KerA(indi1,:) ones(len1,1)];
    Bk  = [-KerA(indi0,:); KerA(indi2,:)];
    ek1 = [-ones(len0,1); ones(len2,1)];
    ek = ones(len0+len2,1);
    Rk  = [Bk ek1];
    
    Mx  = invChol_mex(Sk'*Sk + Cs(ii)*eye(N+1))*Rk';
    H   = Rk*Mx;
    
    %problem (40)
    currN   = length(ek1);
    options =  optimoptions('quadprog','Algorithm','interior-point-convex','Display','off');
    alpha   = quadprog((H+H')/2, -ek,[],[],[],[], ...
        zeros(currN,1), C*ones(currN,1),[],options);    

%     alpha = qp((H+H')/2, -ek, [], [], zeros(currN,1), C*ones(currN,1), zeros(currN,1), 0);
    % equation (39)
    zk = Mx*alpha;
    
    % save weights
    V(:,ii) = zk(1:N);
    B(1,ii) = zk(N+1);
end

end

