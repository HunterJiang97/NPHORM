%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author By: Haitao Jiang
% Author On: 2020-06-19
% Author To: 
%   1. Generate Latex friendly results for 16(8*2) discrete datasets
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear;

% 5bin
methods = [1:7 9 11];
datasets = 1:8;

[MZE,sd1,MAE,sd2] = deal(zeros(length(datasets),length(methods)));
[Latex1,Latex2] = deal([" ";" ";" ";" ";" ";" ";" ";" "]);
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


%% 10bin
methods = [1:7 9 11];
datasets = 9:16;

[MZE2,sd21,MAE2,sd22] = deal(zeros(length(datasets),length(methods)));
[Latex3,Latex4] = deal([" ";" ";" ";" ";" ";" ";" ";" "]);
for ii = 1:length(methods)
    for jj= 1:length(datasets)
            load(['Outputs\case_',num2str(methods(ii)),'_',num2str(datasets(jj)),'.mat'])

        %tmp = [Result(:,1); Result(:,3)];
        tmp = Result(:,1);
        MZE2(jj,ii) = mean(tmp);
        sd21(jj,ii) = sqrt(var(tmp));
        Latex3(jj) = strcat(Latex3(jj), "&", num2str(MZE2(jj,ii),'%1.3f'), '$_{', num2str(sd21(jj,ii),'%1.3f') ,'}$ ');
        
        %tmp = [Result(:,2); Result(:,4)];
        tmp = Result(:,4);
        MAE2(jj,ii) = mean(tmp);
        sd22(jj,ii) = sqrt(var(tmp));
        Latex4(jj) = strcat(Latex4(jj), "&", num2str(MAE2(jj,ii),'%1.3f'), '$_{', num2str(sd22(jj,ii),'%1.3f') ,'}$ ');
    end
end

rnk3 = zeros(length(datasets),length(methods));
for ii = 1:length(datasets)
    rnk3(ii,:) = floor(tiedrank(MAE2(ii,:)));
end
meanrnk3 = mean(rnk3);
LatexSd3 = " ";
for ii = 1:length(methods)
    LatexSd3 = strcat(LatexSd3, "&", num2str(meanrnk3(ii),"%1.4f")," ");
end

rnk4 = zeros(length(datasets),length(methods));
for ii = 1:length(datasets)
    rnk4(ii,:) = floor(tiedrank(MAE2(ii,:)));
end
meanrnk4 = mean(rnk4);
LatexSd4 = " ";
for ii = 1:length(methods)
    LatexSd4 = strcat(LatexSd4, "&", num2str(meanrnk4(ii),"%1.4f")," ");
end

%% total rank
totalrank1 = mean([meanrnk1; meanrnk3]);
LatexSd5 = " ";
for ii = 1:length(methods)
    LatexSd5 = strcat(LatexSd5, "&", num2str(totalrank1(ii),"%1.4f")," ");
end
totalrank2 = mean([meanrnk2; meanrnk4]);
LatexSd6 = " ";
for ii = 1:length(methods)
    LatexSd6 = strcat(LatexSd6, "&", num2str(totalrank2(ii),"%1.4f")," ");
end

% 5bin table
Latex1
LatexSd1
Latex3
LatexSd3
LatexSd5


% 10bin table
Latex2
LatexSd2
Latex4
LatexSd4
LatexSd6