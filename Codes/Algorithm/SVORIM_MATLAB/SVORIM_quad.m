function [w, b] = SVORIM_quad(X, Y, C)
    [~,p] = size(X);
    r = length(unique(Y));
    
    tmp = 0;
    A1 = zeros(1, p + r - 1);
    for jj = 1:(r-1)
        X1 = X(Y <= jj,:);
        X2 = X(Y > jj,:);
        len1 = size(X1,1);
        len2 = size(X2,1);
        A1(end+1:end+len1+len2,:) = [X1 zeros(len1,jj-1) -ones(len1,1) zeros(len1,r-1-jj);
                                   -X2 zeros(len2,jj-1) ones(len2,1) zeros(len2,r-1-jj)];
        tmp = tmp + len1 + len2;
    end
    
    A = [A1(2:end,:) diag(-ones(tmp,1))];
    b = -ones(tmp,1);
    
    H = diag([ones(1,p) zeros(1,tmp + r - 1)]);
    f = [zeros(p + r - 1,1); C * ones(tmp,1)];
    
    lb = [-Inf * ones(p + r - 1,1); zeros(tmp,1)];
    ub = [Inf * ones(p + r - 1 + tmp,1)];
    
    options =  optimoptions('quadprog','Algorithm','interior-point-convex','Display','off');
    wb = quadprog(H,f,A,b,[],[],lb,ub,[],options);
    
    w = wb(1:p);
    b = wb(p+1:p+r-1);
    
end