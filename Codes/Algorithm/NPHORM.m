classdef NPHORM < Algorithm
    %NPHORM: Nonparallel Hyperplanes Ordinal Regression Machine
    properties
       
        name_parameters = {'C','Cs','k'}

        parameters
    end
    
    methods
    
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %
        % Function: NPHORM (Public Constructor)
        % Description: It constructs an object of the class
        %               NPHORM Ordinal and sets its characteristics.
        % Type: Void
        % Arguments: 
        %           kernel--> Type of Kernel function
        % 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        function obj = NPHORM(kernel)
            obj.name = 'NPHORM: Nonparallel Hyperplanes Ordinal Regression Machine';
            if(nargin ~= 0)
                 obj.kernelType = kernel;
            else
                obj.kernelType = 'rbf';
            end
            
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %
        % Function: defaultParameters (Public)
        % Description: It assigns the parameters of the 
        %               algorithm to a default value.
        % Type: Void
        % Arguments: 
        %           No arguments for this function.
        % 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        function obj = defaultParameters(obj)
            obj.parameters.C = 10.^(-3:1:3);
            obj.parameters.Cs = 10.^(-3:1:3);
	    % kernel width
            obj.parameters.k = 10.^(-3:1:3);
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %
        % Function: runAlgorithm (Public)
        % Description: This function runs the corresponding
        %               algorithm, fitting the model and 
        %               testing it in a dataset.
        % Type: It returns the model (Struct) 
        % Arguments: 
        %           Train --> Training data for fitting the model
        %           Test --> Test data for validation
        %           parameters --> vector with the parameter information
        % 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        function [model_information] = runAlgorithm(obj, train, test, parameters)
                param.C = parameters(1);
                param.Cs = parameters(2);
                param.k = parameters(3);
                
                train.uniqueTargets = unique([train.targets]);
                test.uniqueTargets = train.uniqueTargets;
                train.nOfClasses = max(train.uniqueTargets);
                test.nOfClasses = train.nOfClasses;
                train.nOfPatterns = length(train.targets);
                test.nOfPatterns = length(test.targets);                
                
                c1 = clock;
                model = obj.train(train, param);
                c2 = clock;
                model_information.trainTime = etime(c2,c1);
                
                c1 = clock;
                [model_information.projectedTrain, model_information.predictedTrain] = obj.test(train,train,model,param);
                [model_information.projectedTest, model_information.predictedTest] = obj.test(train,test,model,param);
                c2 = clock;
                model_information.testTime = etime(c2,c1);
                           
                model.algorithm = 'NPHORM';
                model.parameters = param;
                model_information.model = model;

        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %
        % Function: train (Public)
        % Description: This function train the model for
        %               the NPSVOR algorithm.
        % Type: It returns the model
        % Arguments: 
        %           train --> Train struct
        %           param--> struct with the parameter information
        % 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
        function [model]= train( obj, train, param)  
%             kertype = obj.kernelType;
            sigma = param.k;
            [model.Beta,model.b,model.Kern] = NPHORMmix(train.patterns, train.targets, param.C, param.Cs, sigma);
            model.labelSet = unique(train.targets);
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %
        % Function: test (Public)
        % Description: This function test a model given in
        %               a set of test patterns.
        % Outputs: Two arrays (decision values and predicted targets)
        % Arguments: 
        %           test --> Test struct data
        %           model --> struct with the model information
        % 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        function [decv, pred]= test(obj, train, test,model,param)
          nT=test.nOfPatterns;  
          decv= zeros(nT,train.nOfClasses);         
          if nT >500
              for j=1:nT/500
                  xnewk=test.patterns(500*(j-1)+1:500*j,:);
                  decv(500*(j-1)+1:500*j,:) = (Kernel(obj.kernelType, xnewk',train.patterns',param.k) * model.Beta + model.b);
              end
              xnewk=test.patterns(500*j+1:nT,:);
              decv(500*j+1:nT,:)= (Kernel(obj.kernelType, xnewk',train.patterns',param.k) * model.Beta + model.b);
          else
              decv =  (Kernel(obj.kernelType, test.patterns',train.patterns',param.k) * model.Beta + model.b);
          end
%           for ii = 1:train.nOfClasses
%             decv(:,ii) = decv(:,ii) / norm(model.Beta(:,ii));
% %             decv(:,ii) = decv(:,ii) / sqrt(model.Beta(:,ii)' * model.Kern * model.Beta(:,ii));
%           end
          [~,pred] = min(abs(decv),[],2);
          pred = model.labelSet(pred);
          
        end
    end
end
