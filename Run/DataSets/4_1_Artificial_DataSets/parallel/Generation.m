clc; clear;
gen = false;

N = 100;
Circle = zeros(3*N,3);
thet = 1.5;
d = 3;
if gen
    % generating the "parallel" data set
    
    r1 = rand(N,1) * 2 * pi;
    r2 = -pi / 4;
    thet1 = rand(N,1) * d .* cos(r1);
    thet2 = rand(N,1) * 2.5 * d.* sin(r1);
    Circle(1:N,:) = [-6+thet1*cos(r2) - thet2*sin(r2) 6 + thet1 * sin(r2) + thet2 * cos(r2)  1 * ones(N,1)];

    r1 = rand(N,1) * 2 * pi;
    r2 = 0;
    thet1 = rand(N,1) * d .* cos(r1);
    thet2 = rand(N,1) * 2.5 * d.* sin(r1);
    Circle(N+1:2*N,:) = [thet1*cos(r2) - thet2*sin(r2) 2+thet1 * sin(r2) + thet2 * cos(r2)  2 * ones(N,1)];

    r1 = rand(N,1) * 2 * pi;
    r2 = pi / 3;
    thet1 = rand(N,1) * d .* cos(r1);
    thet2 = rand(N,1) * 2.5 * d.* sin(r1);
    Circle(2*N+1:3*N,:) = [7+thet1*cos(r2) - thet2*sin(r2) 9 + thet1 * sin(r2) + thet2 * cos(r2)  3 * ones(N,1)];
    
    % split data into 10 x 80%/20% sets
    times = 10;
    tr = .8;
    for ii = 1:times
        
        [~,indi] = sort(rand(3*N,1));
        train = Circle(indi(1:floor(3*N*tr)),:);
        test = Circle(indi(1:floor(3*N*tr)),:);
        
        eval(['dlmwrite(''train_parallel.',num2str(ii-1),''',train,''delimiter'', '' '', ''precision'', 5)'])
        eval(['dlmwrite(''test_parallel.',num2str(ii-1),''',test,''delimiter'', '' '', ''precision'', 5)'])
    end
    par = Circle;
    save parallel par
    
end
load parallel
figure(1)
cla
plot(par(1:N,1),par(1:N,2),'rx')
hold on
plot(par(N+1:2*N,1),par(N+1:2*N,2),'gx')
plot(par(2*N+1:3*N,1),par(2*N+1:3*N,2),'bx')
axis equal