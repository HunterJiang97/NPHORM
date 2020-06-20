%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author By: Haitao Jiang
% Author On: 2020-06-19
% Author To: 
%   1. Generate Wilcoxtest comparison on 4 cases (MZE discrete/ MAE discrete/ MZE ordinal/ MAE ordinal)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear;
methods = [1:7 9 11]; datasets = 1:16; K = 20;
DiscreteR = zeros(length(methods),length(datasets),3);
DiscreteR1 = zeros(length(methods),length(datasets),3);
for ii = 1:length(datasets)
    % read MZE & MAE data
    MAEs = zeros(length(methods),K);
    MZEs = zeros(length(methods),K);
    for jj = 1:length(methods)
      load(['Outputs\case_',num2str(methods(jj)),'_',num2str(datasets(ii)),'.mat'])
      MZEs(jj,:) = Result(:,1);
      MAEs(jj,:) = Result(:,4);
    end
    
    % implement wilcoxon tests
    for jj = 1:length(methods)
        for kk = 1:length(methods)
            if jj == kk 
                continue;
            end;
            [~,h1] = signrank(MZEs(jj,:),MZEs(kk,:),'alpha',0.05); % x > y
            if (h1 == 1 && mean(MZEs(jj,:)) < mean(MZEs(kk,:)))
                DiscreteR(jj,ii,1) = DiscreteR(jj,ii,1) + 1;
            elseif (h1 == 1 && mean(MZEs(jj,:)) > mean(MZEs(kk,:)))
                DiscreteR(jj,ii,3) = DiscreteR(jj,ii,3) + 1;
            else
                DiscreteR(jj,ii,2) = DiscreteR(jj,ii,2) + 1;
            end
            
            
            [~,h3] = signrank(MAEs(jj,:),MAEs(kk,:),'alpha',0.05); % x > y
            if (h3 == 1 && mean(MAEs(jj,:)) < mean(MAEs(kk,:)))
                DiscreteR1(jj,ii,1) = DiscreteR1(jj,ii,1) + 1;
            elseif (h3 == 1 && mean(MAEs(jj,:)) > mean(MAEs(kk,:)))
                DiscreteR1(jj,ii,3) = DiscreteR1(jj,ii,3) + 1;
            else
                DiscreteR1(jj,ii,2) = DiscreteR1(jj,ii,2) + 1;
            end
        end
    end
end
% [p1,tbl1,stats1] = friedman(MZEs');
% [p2,tbl2,stats2] = friedman(MAEs');
name={'SVC1V1','SVC1VA','SVR','CSSVC','SVMOP','SVOREX','SVORIM','NPSVOR','NPHORM'};
% figure(11)
[p,t,stats1] = anova1(MZEs',name,'off');
[c1,m,h] = multcompare(stats1,'CType','hsd');
% figure(12)
[p,t,stats2] = anova1(MAEs',name,'off');
[c2,m,h] = multcompare(stats2,'CType','hsd');

% figure(11)
% cd1 = criticaldifference(MZEs',name,0.05)
% figure(12)
% cd2 = criticaldifference(MAEs',name,0.05)

table1 = zeros(length(methods),3);
table2 = zeros(length(methods),3);
for ii = 1:length(methods)
    for jj = 1:3
        table1(ii,jj) = sum(DiscreteR(ii,:,jj));
        table2(ii,jj) = sum(DiscreteR1(ii,:,jj));
    end
end

%% Ordinal
methods = [1:7 9 11]; datasets = 17:33; K = 30;
OrdinalR = zeros(length(methods),length(datasets),3);
OrdinalR1 = zeros(length(methods),length(datasets),3);
for ii = 1:length(datasets)
    % read MZE & MAE data
    MAEs = zeros(length(methods),K);
    MZEs = zeros(length(methods),K);
    for jj = 1:length(methods)
      load(['Outputs\case_',num2str(methods(jj)),'_',num2str(datasets(ii)),'.mat'])
      MZEs(jj,:) = Result(:,1);
      MAEs(jj,:) = Result(:,4);
    end
    
    % implement wilcoxon tests
    for jj = 1:length(methods)
        for kk = 1:length(methods)
            if jj == kk 
                continue;
            end;
            [~,h2] = signrank(MZEs(jj,:),MZEs(kk,:),'alpha',0.05); % x < y
            if (h2 == 1 && mean(MZEs(jj,:)) < mean(MZEs(kk,:)))
                OrdinalR(jj,ii,1) = OrdinalR(jj,ii,1) + 1;
            elseif (h2 == 1 && mean(MZEs(jj,:)) > mean(MZEs(kk,:)))
                OrdinalR(jj,ii,3) = OrdinalR(jj,ii,3) + 1;
            else
                OrdinalR(jj,ii,2) = OrdinalR(jj,ii,2) + 1;
            end
            
            
            [~,h4] = signrank(MAEs(jj,:),MAEs(kk,:),'alpha',0.05); % x > y
            if (h4 == 1 && mean(MAEs(jj,:)) < mean(MAEs(kk,:)))
                OrdinalR1(jj,ii,1) = OrdinalR1(jj,ii,1) + 1;
            elseif (h4 == 1 && mean(MAEs(jj,:)) > mean(MAEs(kk,:)))
                OrdinalR1(jj,ii,3) = OrdinalR1(jj,ii,3) + 1;
            else
                OrdinalR1(jj,ii,2) = OrdinalR1(jj,ii,2) + 1;
            end
        end
    end
end


table3 = zeros(length(methods),3);
table4 = zeros(length(methods),3);
for ii = 1:length(methods)
    for jj = 1:3
        table3(ii,jj) = sum(OrdinalR(ii,:,jj));
        table4(ii,jj) = sum(OrdinalR1(ii,:,jj));
    end
end

% [p3,tbl3,stats3] = friedman(MZEs');
% [p4,tbl4,stats4] = friedman(MAEs');


[p,t,stats3] = anova1(MZEs',name,'off');
[c3,m,h] = multcompare(stats3,'CType','hsd');
% figure(12)
[p,t,stats4] = anova1(MAEs',name,'off');
[c4,m,h] = multcompare(stats4,'CType','hsd');
% [p1 p2 p3 p4]
% figure(13)
% cd3 = criticaldifference(MZEs',name,0.05)
% figure(14)
% cd4 = criticaldifference(MAEs',name,0.05)

table1
table2
table3
table4

save HSDdata c1 c2 c3 c4