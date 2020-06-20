%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (C) Pedro Antonio Gutiérrez (pagutierrez at uco dot es)
% María Pérez Ortiz (i82perom at uco dot es)
% Javier Sánchez Monedero (jsanchezm at uco dot es)
%
% This file implements the code for the SVORIM method.
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

classdef SVORIMLinear < Algorithm
    % SVOR Support Vector for Ordinal Regression (Implicit constraints)
    %   This class derives from the Algorithm Class and implements the
    %   SVORIM method.
    % Further details in: * P.A. Gutiérrez, M. Pérez-Ortiz, J. Sánchez-Monedero,
    %                       F. Fernández-Navarro and C. Hervás-Martínez (2015),
    %                       "Ordinal regression methods: survey and
    %                       experimental study",
    %                       IEEE Transactions on Knowledge and Data
    %                       Engineering. Vol. Accepted
    %                     * W. Chu and S. S. Keerthi, “Support Vector
    %                       Ordinal Regression,�? Neural Computation, vol.
    %                       19, no. 3, pp. 792–815, 2007.
    % Dependencies: this class uses
    % - svorim implementation: http://www.gatsby.ucl.ac.uk/~chuwei/svor.htm
    
    properties
        
        parameters
        
        name_parameters = {'C'}
    end
    
    methods
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %
        % Function: SVORIM (Public Constructor)
        % Description: It constructs an object of the class
        %               SVORIM and sets its characteristics.
        % Type: Void
        % Arguments:
        %           kernel--> Type of Kernel function
        %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        function obj = SVORIM(kernel)
            obj.name = 'Linear Support Vector for Ordinal Regression (Implicit constraints)';
            if(nargin ~= 0)
                obj.kernelType = kernel;
            else
                obj.kernelType = 'None';
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
            obj.parameters.C =  10.^(-3:1:3);
            % kernel width
            %             obj.parameters.k = 10.^(-3:1:3);
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
            param.C = parameters(1);
            
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
            [model_information.projectedTrain, model_information.predictedTrain] = obj.test(train,train, model,param);
            [model_information.projectedTest,model_information.predictedTest ] = obj.test(train, test,model,param);
            c2 = clock;
            model_information.testTime = etime(c2,c1);
            
            model.algorithm = 'SVORIMLinear';
            model.parameters = param;
            model_information.model = model;
            
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %
        % Function: train (Public)
        % Description: This function train the model for
        %               the SVORIM algorithm.
        % Type: It returns the model, the projected test patterns,
        %	the projected train patterns and the time information.
        % Arguments:
        %           train --> Train struct
        %	        test --> Test struct
        %           parameters--> struct with the parameter information
        %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        function [model] = train( obj, train, param)
            [w,b] = SVORIM_quad(train.patterns, train.targets, param.C);
            model.w = w;
            model.b = b;
            model.labelSet = unique(train.targets);
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %
        % Function: test (Public)
        % Description: This function test a model given in
        %               a set of test patterns.
        % Outputs: Array of predicted patterns
        % Arguments:
        %           project --> projected patterns
        %           model --> struct with the model information
        %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        function [decv, pred]= test(obj, train, test,model, pram)
            nT=test.nOfPatterns;
            decv= zeros(nT,train.nOfClasses);
%             if nT >1000
%                 for j=1:nT/1000
%                     xnewk=test.patterns(1000*(j-1)+1:1000*j,:);
%                     decv(1000*(j-1)+1:1000*j,:) = xnewk* model.w;
%                 end
%                 xnewk=test.patterns(1000*j+1:nT,:);
%                 decv(1000*j+1:nT,:)= xnewk*model.w;
%             else
                decv =  test.patterns*model.w;
%             end
            
            pred = ones(nT,1) * train.nOfClasses;
            for ii = train.nOfClasses-1:-1:1
                pred(decv < model.b(ii)) = ii;
            end
            pred = model.labelSet(pred);
            
        end
        
        
    end
    
end

