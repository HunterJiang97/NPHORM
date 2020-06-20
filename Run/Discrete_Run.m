%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author By: Haitao Jiang
% Author On: 2020-06-19
% Author To: 
%   1. Run all algorithms on 16(8*2) discrete datasets
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear;

for i = [11];
    
    % name={'SVC1V1','SVC1VA','SVR','CSSVC','SVMOP','SVOREX','SVORIM','NPSVOR','NPHORM'};
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
        case 8
            Algorithm = REDSVM();
            name = 'REDSVM';
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
        case 10
            Algorithm = OPBE();
            name = 'OPBE';
            % Parameter C (Cost)
            % Parameter k (kernel width)
            obj.parameters.C = 10.^(-3:3);
            obj.parameters.k = 10.^(-3:3);
        case 11
            Algorithm = NPHORM();
            name = 'NPHORM';
            % Parameter C (Cost)
            % Parameter k (kernel width)
            obj.parameters.C = 10.^(-3:3);
            obj.parameters.Cs = 10.^(-3:3);
            obj.parameters.k = 10.^(-3:3);
    end
    
    for j = 1:16
        switch j
            case 1
                subpath = 'DataSets/4_2_Discretized_Regression/5bins/pyrim/matlab';
                name0 = 'pyrim';
            case 2
                subpath = 'DataSets/4_2_Discretized_Regression/5bins/machine/matlab';
                name0 = 'machine';
            case 3
                subpath = 'DataSets/4_2_Discretized_Regression/5bins/housing/matlab';
                name0 = 'housing';
            case 4
                subpath = 'DataSets/4_2_Discretized_Regression/5bins/abalone/matlab';
                name0 = 'abalone';
            case 5
                subpath = 'DataSets/4_2_Discretized_Regression/5bins/bank2-5/matlab';
                name0 = 'bank2-5';
            case 6
                subpath = 'DataSets/4_2_Discretized_Regression/5bins/computer2-5/matlab';
                name0 = 'computer2-5';
            case 7
                subpath = 'DataSets/4_2_Discretized_Regression/5bins/calhousing-5/matlab';
                name0 = 'calhousing-5';
            case 8
                subpath = 'DataSets/4_2_Discretized_Regression/5bins/census2-5/matlab';
                name0 = 'census2-5';
            case 9
                subpath = 'DataSets/4_2_Discretized_Regression/10bins/pyrim10/matlab';
                name0 = 'pyrim10';
            case 10
                subpath = 'DataSets/4_2_Discretized_Regression/10bins/machine10/matlab';
                name0 = 'machine10';
            case 11
                subpath = 'DataSets/4_2_Discretized_Regression/10bins/housing10/matlab';
                name0 = 'housing10';
            case 12
                subpath = 'DataSets/4_2_Discretized_Regression/10bins/abalone10/matlab';
                name0 = 'abalone10';
            case 13
                subpath = 'DataSets/4_2_Discretized_Regression/10bins/bank2-10/matlab';
                name0 = 'bank2-10';
            case 14
                subpath = 'DataSets/4_2_Discretized_Regression/10bins/computer2-10/matlab';
                name0 = 'computer2-10';
            case 15
                subpath = 'DataSets/4_2_Discretized_Regression/10bins/calhousing-10/matlab';
                name0 = 'calhousing-10';
            case 16
                subpath = 'DataSets/4_2_Discretized_Regression/10bins/census2-10/matlab';
                name0 = 'census2-10';
        end
        
        if isfile(['Outputs/case_', num2str(i), '_', num2str(j), '.mat'])
            continue;
        end
        
        if isfile(['case_', num2str(i), '_', num2str(j), 'tmp.mat'])
            eval(['load(''case_',num2str(i),'_',num2str(j),'tmp.mat'')'])
        else
            k = 0;
        end
        
        while (k < 20)
            
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
            
            eval(['save(''case_',num2str(i),'_',num2str(j),'tmp.mat'')'])
            
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