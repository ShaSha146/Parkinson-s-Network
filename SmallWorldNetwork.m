function [Adj] = SmallWorldNetwork(NumberofNeurons, Density)
%% Inputs
% Number of neurons is the number of neurons in the adjacency matrix
% Density is the number of connections in the model / total number of
% possible connection

%% Outputs
% Adj is the adjacency matrix of connections. Adj(i,j) is the connection
% between neuron i and j

% Select the number of connections per neuron (calculated based on
% density)
TotalNumberOfConnections=Density*(NumberofNeurons*NumberofNeurons);

ConnectionsPerNeuron=round(TotalNumberOfConnections/NumberofNeurons);
Adj=zeros(NumberofNeurons);
Distance = zeros(1,NumberofNeurons);

for PresynapticNeuron=1:NumberofNeurons
    % Calculate Distance
    for PostsynapticNeurons=1:NumberofNeurons
        Distance(PostsynapticNeurons)=min(...
            [abs(NumberofNeurons+PresynapticNeuron-PostsynapticNeurons),...
            abs(PresynapticNeuron-PostsynapticNeurons),...
            abs(-NumberofNeurons+PresynapticNeuron-PostsynapticNeurons)]);
    % Fix 0s;
        if Distance(PostsynapticNeurons)==0 %PostsynapticNeurons==PresynapticNeurons
            Distance(PostsynapticNeurons)=inf;
        end
    end

    % Calculate Weights Matrix 1/Distance^2
    WeightsVector=1./Distance.^2;
    
% select specific connections that neuron will have based on random
% sampling
NeuronsiIsConnectedTo = datasample(1:NumberofNeurons,ConnectionsPerNeuron,'Replace',false,'Weights',WeightsVector);
% Place connections in ADJ
Adj(PresynapticNeuron,NeuronsiIsConnectedTo) = 1;

end


Adj(eye(NumberofNeurons)==1)=0;









end