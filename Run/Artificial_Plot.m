%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author By: Haitao Jiang
% Author On: 2020-06-19
% Author To: 
%   1. Plot 6 diagram (fig 1-6) for two artificial datasets (2 data sets by 3 methods)
%   2. Plot 2 figures (fig 7-8) for introduction section
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; clear;

%% SVORIM: Case A 
load('DataSets/4_1_Artificial_DataSets/parallel/parallel.mat')
N = 100;
k = 2;
[X,Y] = meshgrid(-20:0.1:20,-20:0.1:20);
XGrid = [X(:) Y(:)];
test.patterns = XGrid;
test.nOfPatterns = size(XGrid,1);

% load('case_7_-1tmp.mat')
parm1.C = 1e-3;
parm1.Cs = 1e-3;
train.patterns = par(:,1:2);
train.targets = par(:,3);
train.nOfClasses = 3;
obj1 = SVORIMLinear();
model1 = obj1.train(train,parm1);



figure(1)
clf
hold on
k = 2;
plot(par(1:k:N,1),par(1:k:N,2),'red^','LineWidth',2,'MarkerSize',10)
axis([-8 8 -1 11])
plot(par(N+1:k:2*N,1),par(N+1:k:2*N,2),'green+','LineWidth',2,'MarkerSize',10)
plot(par(2*N+1:k:3*N,1),par(2*N+1:k:3*N,2),'blueo','LineWidth',2,'MarkerSize',10)
x1 = -20:0.1:20;
y1 = (model1.b(1) - model1.w(1) * x1) / model1.w(2);
y2 = (model1.b(2) - model1.w(1) * x1) / model1.w(2);
plot(x1, y1, 'black-','LineWidth',1.5)
plot(x1, y2, 'black-','LineWidth',1.5)
axis([-15 15 -8 15])
dim = [0.665 0.265 0 0];
str = {'MZE: 0.076','MAE: 0.076'};
annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',15);
title("")
xlabel('X') 
ylabel('Y') 
legend off

%% NPSVOR Case A
figure(2)
clf
hold on
k = 2;
plot(par(1:k:N,1),par(1:k:N,2),'red^','LineWidth',2,'MarkerSize',10)
axis([-8 8 -1 11])
plot(par(N+1:k:2*N,1),par(N+1:k:2*N,2),'green+','LineWidth',2,'MarkerSize',10)
plot(par(2*N+1:k:3*N,1),par(2*N+1:k:3*N,2),'blueo','LineWidth',2,'MarkerSize',10)
axis equal

% load('case_9_-2tmp.mat')
parm2.C = 10;
parm2.k = 0;
parm2.e = 0.2;
parm2.rho = 1;
train.patterns = par(:,1:2);
train.targets = par(:,3);
train.nOfPatterns = 300;
obj2 = NPSVOR('linear');
model2 = obj2.train(train,parm2);
model2.w = par(:,1:2)' * model2.Beta;
% syms x y
y1 = (model2.b(1) - model2.w(1,1) * x1) / model2.w(2,1);
y2 = (model2.b(2) - model2.w(1,2) * x1) / model2.w(2,2);
y3 = (model2.b(3) - model2.w(1,3) * x1) / model2.w(2,3);
plot(x1, y1, 'black-','LineWidth',1.5)
plot(x1, y2, 'black-','LineWidth',1.5)
plot(x1, y3, 'black-','LineWidth',1.5)
axis([-15 15 -8 15])
dim = [0.665 0.275 0 0];
str = {'MZE: 0.028','MAE: 0.029'};
annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',15);
title("")
xlabel('X') 
ylabel('Y') 
legend off


%% NPHORM case A
figure(3)
clf
hold on
k = 2;
plot(par(1:k:N,1),par(1:k:N,2),'red^','LineWidth',2,'MarkerSize',10)
axis([-8 8 -1 11])
plot(par(N+1:k:2*N,1),par(N+1:k:2*N,2),'green+','LineWidth',2,'MarkerSize',10)
plot(par(2*N+1:k:3*N,1),par(2*N+1:k:3*N,2),'blueo','LineWidth',2,'MarkerSize',10)
axis equal

% load('case_11_-2tmp.mat')
parm2.C = 10;
parm2.Cs = 1e-03;
train.patterns = par(:,1:2);
train.targets = par(:,3);
train.nOfPatterns = 300;
obj3 = NPHORMLinear();
model3 = obj3.train(train,parm2);
model3.w = model3.Beta;
y1 = (model2.b(1) - model2.w(1,1) * x1) / model2.w(2,1);
y2 = (model2.b(2) - model2.w(1,2) * x1) / model2.w(2,2);
y3 = (model2.b(3) - model2.w(1,3) * x1) / model2.w(2,3);
plot(x1, y1, 'black-','LineWidth',1.5)
plot(x1, y2, 'black-','LineWidth',1.5)
plot(x1, y3, 'black-','LineWidth',1.5)
axis([-15 15 -8 15])
title("")
axis([-15 15 -8 15])
dim = [0.665 0.275 0 0];
str = {'MZE: 0.020','MAE: 0.020'};
annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',15);
xlabel('X') 
ylabel('Y') 

%% SVORIM case B
load('DataSets/4_1_Artificial_DataSets/circle/circle.mat')
N = 100;
par = Circle;
figure(4)
clf
hold on
k = 2;
plot(par(1:k:N,1),par(1:k:N,2),'red^','LineWidth',2,'MarkerSize',10)
axis([-8 8 -1 11])
plot(par(N+1:k:2*N,1),par(N+1:k:2*N,2),'green+','LineWidth',2,'MarkerSize',10)
plot(par(2*N+1:k:3*N,1),par(2*N+1:k:3*N,2),'blueo','LineWidth',2,'MarkerSize',10)
axis equal
% load('case_7_-2tmp.mat')
parm1.C = 1e-2;
parm1.Cs = 1e-2;
train.patterns = par(:,1:2);
train.targets = par(:,3);
obj1 = SVORIMLinear();
model1 = obj1.train(train,parm1);
y1 = (model1.b(1) - model1.w(1) * x1) / model1.w(2);
y2 = (model1.b(2) - model1.w(1) * x1) / model1.w(2);
plot(x1, y1, 'black-','LineWidth',1.5)
plot(x1, y2, 'black-','LineWidth',1.5)
axis([-10 10 -10 10])

dim = [0.61 0.251 0 0];
str = {'MZE: 0.343','MAE: 0.343'};
annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',13.5);
title("")
xlabel('X') 
ylabel('Y') 


%% NPSVOR CASE B 
figure(5)
clf
hold on
k = 2;
plot(par(1:k:N,1),par(1:k:N,2),'red^','LineWidth',2,'MarkerSize',10)
axis([-8 8 -1 11])
plot(par(N+1:k:2*N,1),par(N+1:k:2*N,2),'green+','LineWidth',2,'MarkerSize',10)
plot(par(2*N+1:k:3*N,1),par(2*N+1:k:3*N,2),'blueo','LineWidth',2,'MarkerSize',10)
axis equal

% load('case_9_-1tmp.mat')
parm2.C = 1;
parm2.k = 0;
parm2.e = 0.2;
parm2.rho = 1;
train.patterns = par(:,1:2);
train.targets = par(:,3);
train.nOfPatterns = 300;
obj2 = NPSVOR('linear');
model2 = obj2.train(train,parm2);
model2.w = par(:,1:2)' * model2.Beta;
% syms x y
y1 = (model2.b(1) - model2.w(1,1) * x1) / model2.w(2,1);
y2 = (model2.b(2) - model2.w(1,2) * x1) / model2.w(2,2);
y3 = (model2.b(3) - model2.w(1,3) * x1) / model2.w(2,3);
plot(x1, y1, 'black-','LineWidth',1.5)
plot(x1, y2, 'black-','LineWidth',1.5)
plot(x1, y3, 'black-','LineWidth',1.5)
axis([-10 10 -10 10])

dim = [0.61 0.251 0 0];
str = {'MZE: 0.154','MAE: 0.156'};
annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',13.5);
title("")
xlabel('X') 
ylabel('Y') 

%% NPHORM 
figure(6)
clf
hold on
k = 2;
plot(par(1:k:N,1),par(1:k:N,2),'red^','LineWidth',2,'MarkerSize',10)
axis([-8 8 -1 11])
plot(par(N+1:k:2*N,1),par(N+1:k:2*N,2),'green+','LineWidth',2,'MarkerSize',10)
plot(par(2*N+1:k:3*N,1),par(2*N+1:k:3*N,2),'blueo','LineWidth',2,'MarkerSize',10)
axis equal


% load('case_11_-1tmp.mat')
parm2.C = 10;
parm2.Cs = 1e-03;
train.patterns = par(:,1:2);
train.targets = par(:,3);
train.nOfPatterns = 300;
obj3 = NPHORMLinear();
model3 = obj3.train(train,parm2);
model3.w = model3.Beta;
y1 = (model3.b(1) - model3.w(1,1) * x1) / model3.w(2,1);
y2 = (model3.b(2) - model3.w(1,2) * x1) / model3.w(2,2);
y3 = (model3.b(3) - model3.w(1,3) * x1) / model3.w(2,3);
plot(-x1, y1, 'black-','LineWidth',1.5)
plot(-x1, y2, 'black-','LineWidth',1.5)
plot(-x1, y3, 'black-','LineWidth',1.5)
axis([-10 10 -10 10])
dim = [0.61 0.251 0 0];
str = {'MZE: 0.133','MAE: 0.135'};
annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',13.5);
title("")
xlabel('X') 
ylabel('Y') 

%% Figure 1
load('DataSets/4_1_Artificial_DataSets/parallel/parallel.mat')
N = 100;
k = 2;
[X,Y] = meshgrid(-20:0.1:20,-20:0.1:20);
XGrid = [X(:) Y(:)];
test.patterns = XGrid;
test.nOfPatterns = size(XGrid,1);

% load('case_7_-1tmp.mat')
parm1.C = 1e-3;
parm1.Cs = 1e-3;
train.patterns = par(:,1:2);
train.targets = par(:,3);
train.nOfClasses = 3;
obj1 = SVORIMLinear();
model1 = obj1.train(train,parm1);
x1 = -20:0.1:20;
y1 = (model1.b(1) - model1.w(1) * x1) / model1.w(2);
y2 = (model1.b(2) - model1.w(1) * x1) / model1.w(2);

% close all
figure(7)
clf
hold on
k = 2;
h(1) = plot(par(1:k:N,1),par(1:k:N,2),'red^','LineWidth',2,'MarkerSize',10);
axis([-8 8 -1 11])
h(2) = plot(par(N+1:k:2*N,1),par(N+1:k:2*N,2),'green+','LineWidth',2,'MarkerSize',10);
h(3) = plot(par(2*N+1:k:3*N,1),par(2*N+1:k:3*N,2),'blueo','LineWidth',2,'MarkerSize',10);
axis equal

% load('case_11_-2tmp.mat')
parm2.C = 10;
parm2.Cs = 1e-03;
train.patterns = par(:,1:2);
train.targets = par(:,3);
train.nOfPatterns = 300;
obj3 = NPHORMLinear();
model3 = obj3.train(train,parm2);
model3.w = model3.Beta;
y1 = (model3.b(1) + model3.w(1,1) * x1) / model3.w(2,1);
a1 = -model3.w(1,1)/ model3.w(2,1);
b1 = -model3.b(1) / model3.w(2,1);
y2 = (model3.b(2) + model3.w(1,2) * x1) / model3.w(2,2);
a2 = -model3.w(1,2)/ model3.w(2,2);
b2 = -model3.b(2) / model3.w(2,2);
y3 = (model3.b(3) + model3.w(1,3) * x1) / model3.w(2,3);
a3 = -model3.w(1,3)/ model3.w(2,3);
b3 = -model3.b(3) / model3.w(2,3);
x12 = ((b2 + a2) - (b1 - a1)) / (a1 - a2);
% y12 = x12 * a1 + (b1 - a1);
phi1 = tan((pi - (atan(a1) - atan(a2))) / 2 + atan(a1));
y12 = (x1 - x12) * phi1 + x12 * a1 + (b1 - a1);
plot(x1, y12, 'black--','LineWidth',2)
x23 = ((b3 + a3)- (b2 - a2)) / (a2 - a3);
% y23 = x23 * a3 + (b3 + a3);
phi2 = tan( - (pi - (atan(a3) - atan(a2))) / 2 + atan(a2) - pi /2 );
y23 = (x1 - x23) * phi2 + x23 * a3 + (b3 + a3);
h(4) = plot(x1, y23, 'black--','LineWidth',2)
h(5) = plot(x1, -y1, 'black-','LineWidth',2)
h(6) = plot(x1+1, -y1, 'black-.','LineWidth',1.5)
h(7) = plot(x1, -y2, 'black-','LineWidth',2)
h(8) = plot(x1-1, -y2, 'black-.','LineWidth',1.5)
h(9) = plot(x1+1, -y2, 'black-.','LineWidth',1.5)
h(10) = plot(x1, -y3, 'black-','LineWidth',2)
h(11) = plot(x1-1, -y3, 'black-.','LineWidth',1.5)
legend(h(1:3),'Class 1','Class 2','Class 3')
axis([-15 15 -8 15])
title("")
axis([-15 15 -8 15])
xlabel('X') 
ylabel('Y') 


figure(8)
clf
hold on
k = 2;
h(1) = plot(par(1:k:N,1),par(1:k:N,2),'red^','LineWidth',2,'MarkerSize',10);
axis([-8 8 -1 11])
h(2) = plot(par(N+1:k:2*N,1),par(N+1:k:2*N,2),'green+','LineWidth',2,'MarkerSize',10);
h(3) = plot(par(2*N+1:k:3*N,1),par(2*N+1:k:3*N,2),'blueo','LineWidth',2,'MarkerSize',10);
axis equal

% load('case_11_-2tmp.mat')
parm2.C = 10;
parm2.Cs = 1e-03;
train.patterns = par(:,1:2);
train.targets = par(:,3);
train.nOfPatterns = 300;
obj3 = NPHORMLinear();
model3 = obj3.train(train,parm2);
model3.w = model3.Beta;
y1 = (model3.b(1) + model3.w(1,1) * x1) / model3.w(2,1);
a1 = -model3.w(1,1)/ model3.w(2,1);
b1 = -model3.b(1) / model3.w(2,1);
y2 = (model3.b(2) + model3.w(1,2) * x1) / model3.w(2,2);
a2 = -model3.w(1,2)/ model3.w(2,2);
b2 = -model3.b(2) / model3.w(2,2);
y3 = (model3.b(3) + model3.w(1,3) * x1) / model3.w(2,3);
a3 = -model3.w(1,3)/ model3.w(2,3);
b3 = -model3.b(3) / model3.w(2,3);
x12 = ((b2 + a2) - (b1 - a1)) / (a1 - a2);
% y12 = x12 * a1 + (b1 - a1);
phi1 = tan((pi - (atan(a1) - atan(a2))) / 2 + atan(a1));
y12 = (x1 - x12) * phi1 + x12 * a1 + (b1 - a1);
x23 = ((b3 + a3)- (b2 - a2)) / (a2 - a3);
% y23 = x23 * a3 + (b3 + a3);
phi2 = tan( - (pi - (atan(a3) - atan(a2))) / 2 + atan(a2) - pi /2 );
y23 = (x1 - x23) * phi2 + x23 * a3 + (b3 + a3);
y1 = (model1.b(1) - model1.w(1) * x1) / model1.w(2);
y2 = (model1.b(2) - model1.w(1) * x1) / model1.w(2);
y1 = (model1.b(1) - model1.w(1) * x1) / model1.w(2);
y2 = (model1.b(2) - model1.w(1) * x1) / model1.w(2);
plot(x1, y1, 'magenta-','LineWidth',2)
plot(x1, y2, 'magenta-','LineWidth',2)
plot(x1-1, y1, 'magenta-.','LineWidth',2)
plot(x1-1, y2, 'magenta-.','LineWidth',2)
plot(x1+1, y1, 'magenta-.','LineWidth',2)
plot(x1+1, y2, 'magenta-.','LineWidth',2)
h(4) = plot(x1, y12, 'cyan-','LineWidth',2);
h(5) = plot(x1, y23, 'cyan-','LineWidth',2);
h(4) = plot(x1-1, y12, 'cyan:','LineWidth',1.5);
h(5) = plot(x1-1, y23, 'cyan:','LineWidth',1.5);
h(4) = plot(x1+1, y12, 'cyan:','LineWidth',1.5);
h(5) = plot(x1+1, y23, 'cyan:','LineWidth',1.5);
legend(h(1:3),'Class 1','Class 2','Class 3')
axis([-15 15 -8 15])
title("")
axis([-15 15 -8 15])
xlabel('X') 
ylabel('Y') 