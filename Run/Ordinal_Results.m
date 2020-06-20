%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author By: Haitao Jiang
% Author On: 2020-06-19
% Author To: 
%   1. Generate Latex friendly results for 17 Ordinal datasets
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear;

% 
methods = [1:7 9 11];
datasets = 17:33;

[MZE,sd1,MAE,sd2] = deal(zeros(length(datasets),length(methods)));
[Latex1,Latex2] = deal([" ";" ";" ";" ";" ";" ";" ";" ";" ";" ";" ";" ";" ";" ";" ";" ";" ";]);
for ii = 1:length(methods)
    for jj= 1:length(datasets)
            load(['Outputs\case_',num2str(methods(ii)),'_',num2str(datasets(jj)),'.mat'])
        
%         tmp = [Result(:,1); Result(:,3)];
        tmp = Result(:,1);
        MZE(jj,ii) = mean(tmp);
        sd1(jj,ii) = sqrt(var(tmp));
        Latex1(jj) = strcat(Latex1(jj), "&", num2str(MZE(jj,ii),'%1.3f'), '$_{', num2str(sd1(jj,ii),'%1.3f') ,'}$ ');
        
%         tmp = [Result(:,2); Result(:,4)];
        tmp = Result(:,4);
        MAE(jj,ii) = mean(tmp);
        sd2(jj,ii) = sqrt(var(tmp));
        Latex2(jj) = strcat(Latex2(jj), "&", num2str(MAE(jj,ii),'%1.3f'), '$_{', num2str(sd2(jj,ii),'%1.3f') ,'}$ ');
    end
end

rnk1 = zeros(length(datasets),length(methods));
for ii = 1:length(datasets)
    rnk1(ii,:) = floor(tiedrank(MZE(ii,:)));
end
meanrnk1 = mean(rnk1);
LatexSd1 = " ";
for ii = 1:length(methods)
    LatexSd1 = strcat(LatexSd1, "&", num2str(meanrnk1(ii),"%1.4f")," ");
end

rnk2 = zeros(length(datasets),length(methods));
for ii = 1:length(datasets)
    rnk2(ii,:) = floor(tiedrank(MAE(ii,:)));
end
meanrnk2 = mean(rnk2);
LatexSd2 = " ";
for ii = 1:length(methods)
    LatexSd2 = strcat(LatexSd2, "&", num2str(meanrnk2(ii),"%1.4f")," ");
end




% 5bin table
Latex1
LatexSd1

Latex2
LatexSd2

