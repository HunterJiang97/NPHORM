%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author By: Haitao Jiang
% Author On: 2020-06-19
% Author To: 
%   1. Compare 8 methods on 33 datasets(excluding artificial datasets)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear;

%
methods = [1:7 9 11];
datasets = 1:33;

[time1,sd1,time2,sd2,time3,sd3] = deal(zeros(length(datasets),length(methods)));
% [Latex1,Latex2] = deal([" ";" ";" ";" ";" ";" ";" ";" ";" ";" ";" ";" ";" ";" ";" ";" ";" ";]);
for ii = 1:length(methods)
    for jj= 1:length(datasets)
        load(['Outputs\case_',num2str(methods(ii)),'_',num2str(datasets(jj)),'.mat'])
        
        %         tmp = [Result(:,1); Result(:,3)];
        tmp = Result(:,5);
        time1(jj,ii) = mean(tmp);
        sd1(jj,ii) = sqrt(var(tmp));
        %         Latex1(jj) = strcat(Latex1(jj), "&", num2str(time1(jj,ii),'%1.3f'), '$_{', num2str(sd1(jj,ii),'%1.3f') ,'}$ ');
        
        %         tmp = [Result(:,2); Result(:,4)];
        tmp = mean(Result(:,[6 8]),2);
        time2(jj,ii) = mean(tmp);
        sd2(jj,ii) = sqrt(var(tmp));
        %         Latex2(jj) = strcat(Latex2(jj), "&", num2str(time2(jj,ii),'%1.3f'), '$_{', num2str(sd2(jj,ii),'%1.3f') ,'}$ ');
        
        %         tmp = [Result(:,2); Result(:,4)];
        tmp = mean(Result(:,[7 9]),2);
        time3(jj,ii) = mean(tmp);
        sd3(jj,ii) = sqrt(var(tmp));
        %         Latex3(jj) = strcat(Latex3(jj), "&", num2str(time3(jj,ii),'%1.3f'), '$_{', num2str(sd3(jj,ii),'%1.3f') ,'}$ ');
        
    end
end

size2 = [50 150 300 1000 3000 4000 5000 6000 50 150 300 1000 3000 4000 5000 6000 18 27 39 39 113 161 468 750 1296 42 225 552 750 153 1199 366 750];
size3 = [24 59 206 3177 5182 4182 15640 16784 24 59 206 3177 5182 4182 15640 16784 6 9 13 13 38 54 157 250 432 15 75 184 250 52 400 122 250];
% [~,indi2] = sort(size2); [~,indi3] = sort(size3);

%% CVtime Discrete
figure(1)
dataname = {'CL','PA','SS','SU','TA','NT','BS','SW','CA','BO','TO','EU','LE','AU','WI','ES','ER'};
plot(1:16,time1(1:16,1:9),'-')
xticks(1:16)
xticklabels({'P5','MC5','B5','A5','BA5','C5','CA5','CE5','P5','MC5','B10','A10','BA10','C10','CA10','CE10'})
legend('SVC1V1','SVC1VA','SVR','CSSVC','SVMOP','SVOREX','SVORIM','NPSVOR','NPHORM')
axis([0 18 0 1400])
xtickangle(45)

%% CVtime Ordinal

figure(2)
plot((17:33)-16,time1(17:33,1:9),'-')
xticks((17:33)-16)
xticklabels({'CL','PA','SS','SU','TA','NT','BS','SW','CA','BO','TO','EU','LE','AU','WI','ES','ER'})
legend('SVC1V1','SVC1VA','SVR','CSSVC','SVMOP','SVOREX','SVORIM','NPSVOR','NPHORM')
axis([0 19 0 2000])
xtickangle(45)