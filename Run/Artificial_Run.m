%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author By: Haitao Jiang
% Author On: 2020-06-19
% Author To: 
%   1. Run 3 methods on 2 artificial generated datasets
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear;

for i = [7 9 11];
    
    % name={'SVC1V1','SVC1VA','SVR','CSSVC','SVMOP','SVOREX','SVORIM','NPSVOR','HPHORM'};
    switch i
        case 7
            Algorithm = SVORIMLinear();
            if exist('obj','var') == 1
                 obj = rmfield(obj,'parameters');
            end
            name = 'SVORIMLinear';
            % Parameter C (Cost)
            % Parameter k (kernel width)
            obj.parameters.C = 10.^(-3:3);
%             obj.parameters.k = 10.^(-3:3);
        case 9
            Algorithm = NPSVOR('linear');  % matlab code
            if exist('obj','var') == 1
                 obj = rmfield(obj,'parameters');
            end
            name = 'NPSVOR';
            % Parameter C (Cost)
            % Parameter k (kernel width)
            % Parameter e (insenstive)
            obj.parameters.C = 10.^(-3:3);
            obj.parameters.k = [0];
            obj.parameters.e = [0.2];
        case 11
            Algorithm = NPHORMLinear();
            name = 'NPHORM';
            if exist('obj','var') == 1
                 obj = rmfield(obj,'parameters');
            end
            % Parameter C (Cost)
            % Parameter k (kernel width)
            obj.parameters.C = 10.^(-3:3);
            obj.parameters.Cs = 10.^(-3:3);
    end
    
    for j = -1:-1:-2
        switch j
            case -1
                subpath = 'DataSets/4_1_Artificial_DataSets/circle';
                name0 = 'circle';
            case -2
                subpath = 'DataSets/4_1_Artificial_DataSets/parallel';
                name0 = 'parallel';
        end
        
        
        if isfile(['Outputs/case_', num2str(i), '_', num2str(j), '.mat'])
            continue;
        end
        
        if isfile(['case_', num2str(i), '_', num2str(j), 'tmp.mat'])
            eval(['load(''case_',num2str(i),'_',num2str(j),'tmp.mat'')'])
        else
            k = 0;
        end
        
        while (k < 10)
            
            k = k + 1;
            
            fname1 = strcat(subpath, '/train_',name0,'.', num2str(k-1));
            fname2 = strcat(subpath,'/test_',name0,'.', num2str(k-1));
            
            Train = load(fname1);
            Test = load(fname2);
            
            train.patterns = Train(:,1:end-1);
            train.targets =  Train(:,end);
            test.patterns = Test(:,1:end-1);
            test.targets =  Test(:,end);
%             [train, test] = preProcessData(train,test); % normalization
            
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
        
        eval(strcat('save(''Outputs/case_',num2str(i),'_',num2str(j),'.mat'',''Result'')'))
               
    end
end