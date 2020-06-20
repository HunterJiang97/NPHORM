%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author By: Haitao Jiang
% Author On: 2020-06-19
% Author To: 
%   1. Plot tukey HSD test results for two artificial datasets
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; clear;
load HSDdata

c = {c1(c1(:,2) == 9,:),c2(c2(:,2) == 9,:),c3(c3(:,2) == 9,:),c4(c4(:,2) == 9,:)};
% figure(1)
% cla
for ii = 1:4
    %     subplot(1,4,ii)
    figure(ii)
    cla
    plot([0 10], [0 0], 'cyan--','LineWidth',2,'MarkerSize',10)
    hold on
    for jj = 1:8
        if c{ii}(jj,6) > 0.05
            plot([jj jj], c{ii}(jj,[3 5]),'b-','LineWidth',2,'MarkerSize',10);
            h(1) = plot(jj, c{ii}(jj,4),'bo','LineWidth',2,'MarkerSize',10);
        else
            plot([jj jj], c{ii}(jj,[3 5]),'r-','LineWidth',2,'MarkerSize',10);
            h(2) = plot(jj, c{ii}(jj,4),'rx','LineWidth',2,'MarkerSize',10);
        end
    end
    xticks(1:8)
    legend(h, 'No difference','Statistically significant');
    xticklabels({'SVC1V1','SVC1VA','SVR','CSSVC','SVMOP','SVOREX','SVORIM','NPSVOR'})
    ylabel('Mean Differences with NPHORM')
    xtickangle(45)
%     if (ii == 1 || ii == 2)
%         axis([0 10 -.05 .05])
%     else
%         axis([0 10 -.12 .12])
%     end
end
