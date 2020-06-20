clc; clear;

name = 'abalone';
eval(['load ' name]); 
len1 = 1000;

for ii = 1:20
    [~, indi] = sort(rand(size(dat,1),1));
    
    trindi = indi(1:len1);
    teindi = indi(len1+1:end);
    train = dat(trindi,:);
    test = dat(teindi,:);
    
    eval(['dlmwrite(''train_',name,'.',num2str(ii-1),''',train,''delimiter'', '' '', ''precision'', 5)'])
    eval(['dlmwrite(''test_',name,'.',num2str(ii-1),''',test,''delimiter'', '' '', ''precision'', 5)'])
    
end