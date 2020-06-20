%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author By: Haitao Jiang
% Author On: 2020-06-19
% Author To: 
%   1. Run all algorithms on 17 Ordinal datasets
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear;

for i = [1:7 9:11]; 
        
    % name={'SVC1V1','SVC1VA','SVR','CSSVC','SVMOP','SVOREX','SVORIM','NPSVOR','HPHORM'};
    switch i
        case 1
            Algorithm = SVC1V1();
            name = 'SVC1V1';
            %  Parameter C (Cost)
            %  Parameter k (kernel width)
            obj.parameters.C = 10.^(-3:3);
            obj.parameters.k = 10.^(-3:3);
        case 2
            
            Algorithm = SVC1VA();
            name = 'SVC1VA';
            %  Parameter C (Cost)
            %  Parameter k (kernel width)
            obj.parameters.C = 10.^(-3:3);
            obj.parameters.k = 10.^(-3:3);
        case 3
            Algorithm = SVR();
            name = 'SVR';
            % Parameter C (Cost)
            % Parameter k (kernel width)
            % Parameter e (insenstive)
            obj.parameters.C = 10.^(-3:3);
            obj.parameters.k = 10.^(-3:3);
            obj.parameters.e = 10.^(-1);
        case 4
            Algorithm = CSSVC();
            name = 'CSSVC';
            % Parameter C (Cost)
            % Parameter k (kernel width)
            obj.parameters.C = 10.^(-3:3);
            obj.parameters.k = 10.^(-3:3);
        case 5
            Algorithm = SVMOP();
            name = 'SVMOP';
            % Parameter C (Cost)
            % Parameter k (kernel width)
            obj.parameters.C = 10.^(-3:3);
            obj.parameters.k = 10.^(-3:3);
        case 6
            Algorithm = SVOREX();
            name = 'SVOREX';
            % Parameter C (Cost)
            % Parameter k (kernel width)
            obj.parameters.C = 10.^(-3:3);
            obj.parameters.k = 10.^(-3:3);
        case 7
            Algorithm = SVORIM();
            name = 'SVORIM';
            % Parameter C (Cost)
            % Parameter k (kernel width)
            obj.parameters.C = 10.^(-3:3);
            obj.parameters.k = 10.^(-3:3);
        case 9
            Algorithm = NPSVOR();  % matlab code
            name = 'NPSVOR';
            % Parameter C (Cost)
            % Parameter k (kernel width)
            % Parameter e (insenstive)
            obj.parameters.C = 10.^(-3:3);
            obj.parameters.k = 10.^(-3:3);
            obj.parameters.e = [0.2];
        case 11
            Algorithm = NPHORM();
            name = 'NPHORM';
            % Parameter C (Cost)
            % Parameter k (kernel width)
            obj.parameters.C = 10.^(-3:3);
            obj.parameters.Cs = 10.^(-3:3);
            obj.parameters.k = 10.^(-3:3);
    end
    
    for j = 17:33
        switch j
            case 17
                subpath = 'DataSets/4_3_Ordinal_Regression/contact-lenses/matlab';
                name0 = 'contact-lenses';
            case 18
                subpath = 'DataSets/4_3_Ordinal_Regression/pasture/matlab';
                name0 = 'pasture';
            case 19
                subpath = 'DataSets/4_3_Ordinal_Regression/squash-stored/matlab';
                name0 = 'squash-stored';
            case 20
                subpath = 'DataSets/4_3_Ordinal_Regression/squash-unstored/matlab';
                name0 = 'squash-unstored';
            case 21
                subpath = 'DataSets/4_3_Ordinal_Regression/tae/matlab';
                name0 = 'tae';
            case 22
                subpath = 'DataSets/4_3_Ordinal_Regression/newthyroid/matlab';
                name0 = 'newthyroid';
            case 23
                subpath = 'DataSets/4_3_Ordinal_Regression/balance-scale/matlab';
                name0 = 'balance-scale';
            case 24
                subpath = 'DataSets/4_3_Ordinal_Regression/SWD/matlab';
                name0 = 'SWD';
            case 25
                subpath = 'DataSets/4_3_Ordinal_Regression/car/matlab';
                name0 = 'car';
            case 26
                subpath = 'DataSets/4_3_Ordinal_Regression/bondrate/matlab';
                name0 = 'bondrate';
            case 27
                subpath = 'DataSets/4_3_Ordinal_Regression/toy/matlab';
                name0 = 'toy';
            case 28
                subpath = 'DataSets/4_3_Ordinal_Regression/eucalyptus/matlab';
                name0 = 'eucalyptus';
            case 29
                subpath = 'DataSets/4_3_Ordinal_Regression/LEV/matlab';
                name0 = 'LEV';
            case 30
                subpath = 'DataSets/4_3_Ordinal_Regression/automobile/matlab';
                name0 = 'automobile';
            case 31
                subpath = 'DataSets/4_3_Ordinal_Regression/winequality-red/matlab';
                name0 = 'winequality-red';
            case 32
                subpath = 'DataSets/4_3_Ordinal_Regression/ESL/matlab';
                name0 = 'ESL';
            case 33
                subpath = 'DataSets/4_3_Ordinal_Regression/ERA/matlab';
                name0 = 'ERA';
            
        end
         
        if isfile(['Outputs/case_', num2str(i), '_', num2str(j), '.mat'])
            continue;
        end
        
        if isfile(['case_', num2str(i), '_', num2str(j), 'tmp.mat'])
            eval(['load(''case_',num2str(i),'_',num2str(j),'tmp.mat'')'])
        else
            k = 0;
        end
        
        while (k < 30)
            
            k = k + 1;
            
            fname1 = strcat(subpath, '/train_',name0,'.', num2str(k-1));
            fname2 = strcat(subpath,'/test_',name0,'.', num2str(k-1));
            
            Train = load(fname1);
            Test = load(fname2);
            
            train.patterns = Train(:,1:end-1);
            train.targets =  Train(:,end);
            test.patterns = Test(:,1:end-1);
            test.targets =  Test(:,end);
            [train, test] = preProcessData(train,test); % normalization
            
            % Running the algorithm
            obj.nOfFolds=5;
            obj.method = Algorithm;
            obj.cvCriteria1 = MZE;
            obj.cvCriteria2 = MAE;
            
            c1 = clock;
            param = crossValide(obj,train);
            c2 = clock;
            time=etime(c2,c1);
            
            %time information for Cross Validation
            CVtime(k) = time;
            
            info1 = Algorithm.runAlgorithm(train,test,param.pram1);
            time1(k,1) = info1.trainTime;
            time1(k,2) = info1.testTime;
            error1(k)=sum(test.targets~=info1.predictedTest)/size(test.targets,1);
            abserror1(k)=sum(abs(test.targets-info1.predictedTest))/size(test.targets,1);
            fprintf('%d %d %d %f %f %f\n',i,j,k, info1.trainTime,error1(k),abserror1(k))
            
            if(param.pram1==param.pram2)
                info2=info1;
            else
                info2 = Algorithm.runAlgorithm(train,test,param.pram2);
            end
            time2(k,1) = info2.trainTime;
            time2(k,2) = info2.testTime;
            error2(k)=sum(test.targets~=info2.predictedTest)/size(test.targets,1);
            abserror2(k)=sum(abs(test.targets-info2.predictedTest))/size(test.targets,1);
            fprintf('%d %d %d %f %f %f\n',i,j,k, info2.trainTime,error2(k),abserror2(k))
            
            eval(['save case_',num2str(i),'_',num2str(j),'tmp'])
            
        end
        
        
        % fsave0 = strcat(name, name0);
        Result = [error1',abserror1',error2',abserror2',CVtime',time1,time2];
        % save(fsave0,'Result','-ascii')
        
        param=[];
        time1=[];
        error1=[];
        abserror1=[];
        time2=[];
        error2=[];
        abserror2=[];
        CVtime = [];
        res = mean(Result)
        
        eval(['save ''Outputs/case_',num2str(i),'_',num2str(j),'.mat'' Result res'])
        
    end
end