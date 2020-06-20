clc; clear;

% generating the "round" data set
gen = false;

N = 100;
Circle = zeros(3*N,3);
thet = 1;
d = 5;
if (gen)     
    r1 = rand(N,1) * 2/3*pi;
    d1 = d + mvnrnd(0,thet,N);
    Circle(1:N,:) = [d1 .* cos(r1) d1 .* sin(r1) 1 * ones(N,1)];
    
    r2 = rand(N,1) * 2/3*pi + 2/3*pi;
    d2 = d + mvnrnd(0,thet,N);
    Circle(N+1:2*N,:) = [d2 .* cos(r2) d2 .* sin(r2) 2 * ones(N,1)];
    
    r3 = rand(N,1) * 2/3*pi + 4/3*pi;
    d3 = d + mvnrnd(0,thet,N);
    Circle(2*N+1:3*N,:) = [d3 .* cos(r3) d3 .* sin(r3) 3 * ones(N,1)];
    
    % split data into 10 x 80%/20% sets
    times = 10;
    tr = .8;
    for ii = 1:times
        
        [~,indi] = sort(rand(3*N,1));
        train = Circle(indi(1:floor(3*N*tr)),:);
        test = Circle(indi(1:floor(3*N*tr)),:);
        
        eval(['dlmwrite(''train_circle.',num2str(ii-1),''',train,''delimiter'', '' '', ''precision'', 5)'])
        eval(['dlmwrite(''test_circle.',num2str(ii-1),''',test,''delimiter'', '' '', ''precision'', 5)'])
    end
    
    save circle Circle
end

load circle
figure(1)
cla
plot(Circle(1:N,1),Circle(1:N,2),'rx')
hold on
plot(Circle(N+1:2*N,1),Circle(N+1:2*N,2),'gx')
plot(Circle(2*N+1:3*N,1),Circle(2*N+1:3*N,2),'bx')
axis equal