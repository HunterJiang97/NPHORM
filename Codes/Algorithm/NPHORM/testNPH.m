clc; clear;
load toy

AA = [r1; r2; r3];
Y = [ones(150,1)*1;ones(150,1)*2;ones(150,1)*3];
C = 0.5;
Cs = 0.1;
sigma = 0.01;
Ker = {};
Ker{1} = "None";
% Ker{2} = 0.2;

[V, B, KerA] = NPHORMmix(AA, Y, C, Cs, 0.2);
% [w, b] = SVORIM_quad(AA, Y, C);

% syms x y
% cla
% scatter(KerA(:,1),KerA(:,2))
% hold on

pred = zeros(450,1);
pren = 1000*ones(450,1);
for ii = 1:3
%     tmp = abs((KerA * V(:,ii) + B(ii)));
    tmp = abs((KerA * V(:,ii) + B(ii)) / norm(V(:,ii)));
    pred(pren > tmp) = ii;
    pren(pren > tmp) = tmp(pren > tmp);
%     ezplot(V(1,ii) * x + V(2,ii) * y + B(ii) == 0,[-20,60])
end

% pred1 = ones(450,1) * 3;
% dec = KerA * w;
% for ii = 2:-1:1
%    pred1(dec < b(ii)) = ii;
% %    ezplot(w(1) * x + w(2) * y - b(ii) == 0,[-20,60]) 
% end

label = [ones(150,1) * 1; ones(150,1) * 2; ones(150,1) * 3];
% length(label(pred ~= label))
% length(label(pred1 ~= label))