%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (C) Pedro Antonio Gutiérrez (pagutierrez at uco dot es)
% María Pérez Ortiz (i82perom at uco dot es)
% Javier Sánchez Monedero (jsanchezm at uco dot es)
%
% This file implements the code for the CSSVC method.
%
% The code has been tested with Ubuntu 12.04 x86_64, Debian Wheezy 8, Matlab R2009a and Matlab 2011
%
% If you use this code, please cite the associated paper
% Code updates and citing information:
% http://www.uco.es/grupos/ayrna/orreview
% https://github.com/ayrna/orca
%
% AYRNA Research group's website:
% http://www.uco.es/ayrna
%
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; either version 3
% of the License, or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
% Licence available at: http://www.gnu.org/licenses/gpl-3.0.html
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef NPSVOR_C < Algorithm
    %NPSVOR: Nonparallel Support Vector Ordinal Regression
    
    properties
        
        name_parameters = {'C','e','k'}
        
        parameters
    end
    
    methods
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %
        % Function: NPSVOR (Public Constructor)
        % Description: It constructs an object of the class
        %               NPSVOR Ordinal and sets its characteristics.
        % Type: Void
        % Arguments:
        %           kernel--> Type of Kernel function
        %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        function obj = NPSVOR_C(kernel)
            obj.name = 'NPSVOR: Nonparallel Support Vector Ordinal Regression';
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
            % kernel width
            obj.parameters.k = 10.^(-3:1:3);
            obj.parameters.e = 0.1;
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
        
        function [model_information] = runAlgorithm(obj,train, test, parameters)
            p = mfilename('fullpath');
            p(p == '\') = '/';
            indi = strfind(p, "/");
            p(indi(end-1):end) = [];
            libpath = [p '/Algorithm/libsvm-3.21/matlab'];
            addpath(libpath);
            param.C = parameters(1);
            param.k = parameters(2);
            param.e = parameters(3);
            
            c1 = clock;
            model = obj.train(train, param);
            c2 = clock;
            model_information.trainTime = etime(c2,c1);
            
            c1 = clock;
            [model_information.projectedTrain, model_information.predictedTrain] = obj.test(train,model);
            [model_information.projectedTest,model_information.predictedTest ] = obj.test(test,model);
            c2 = clock;
            model_information.testTime = etime(c2,c1);
            
            model.algorithm = 'NPSVOR';
            model.parameters = param;
            model_information.model = model;
            rmpath(libpath);
            
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
        
        
        function [model]= train( obj, train , param)
            p = mfilename('fullpath');
            p(p == '\') = '/';
            indi = strfind(p, "/");
            p(indi(end-1):end) = [];
            libpath = [p '/Algorithm/libsvm-3.21/matlab'];
            addpath(libpath);
            options = ['-t 0 -c ' num2str(param.C) ' -g ' num2str(param.k) ' -p ' num2str(param.e) ' -q'];
            model = svmtrain(train.targets, train.patterns, options);
            rmpath(libpath);
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
        
        function [projected, testTargets]= test(obj,test, model)
            p = mfilename('fullpath');
            p(p == '\') = '/';
            indi = strfind(p, "/");
            p(indi(end-1):end) = [];
            libpath = [p '/Algorithm/libsvm-3.21/matlab'];
            addpath(libpath);
            [testTargets, acc, projected] = svmpredict(test.targets,test.patterns,model, '');
            rmpath(libpath);
        end
    end
end
