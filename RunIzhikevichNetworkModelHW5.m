function [Spikes,t,i]=RunIzhikevichNetworkModelHW5(AdjacencyMatrix,a, b, c, d)
%% Inputs
% Adjacency Matrix is an NxN matrix displaying the strength of connection
[i,j] = size(AdjacencyMatrix); % between neuron i and j
% % a,b,c,and d are 1xN vectors of izhikevich parameters for each neuron
% a = (1:500);
% a(1:end)=.02;
% b=(1:500);
% b(1:end)=.2;
% c=(1:500);
% c(1:end)=-65;
% d=(1:500);
% d(1:end)=8;
% AdjacencyMatrixTranspose = transpose(AdjacencyMatrix);
% for x =  1 : i
%     if Connections(1,x)==2 || Connections(1,x)==1
%         a(x) = .1;
%         d(x) = 4;
%     end
% end

%% Outputs
total_time = 60000; % 60000 ms
dt = .2;
total_time_steps = length(0 : dt : total_time)-1;
Spikes = false(i,total_time_steps); % Spikes is matrix representing the times where neurons spiked within the
% simulation. This can be an NxTime binary matrix or a NSpikesx2 sparse
% matrix where column 1 is the time a spike occurred and column 2 is
% the neuron ID that spiked.
dV=zeros(1,i);
du=zeros(1,i);

%% Constants
u = zeros(i,total_time_steps);
I = zeros(i,total_time_steps);
V = zeros(i,total_time_steps);
a1 = 0;
b1 = 1;
NeuronDamage = (b1-a1).*rand(500,1) + a1;
for x = 1 : i
    if (.25>=NeuronDamage(x,1)>=0)
        NeuronDamage(x,1) = 0;
    elseif (.5>=NeuronDamage(x,1)>.25)
        NeuronDamage(x,1) = .35;
    elseif (.75>=NeuronDamage(x,1)>.5)
        NeuronDamage(x,1) = .65;
    elseif (1>=NeuronDamage(x,1)>.75)
        NeuronDamage(x,1) = 1;
    end
end
%% Initialize constants
% for x = 1 : i  % set every resting menbrane potential for all neurons at all times
%     for t = 1 : (total_time_steps)
%         V(x,t) = -70;
%     end
% end

V=-70*ones(i,total_time_steps);
u=.2*V;

noiseSpikes = 0;
%% Simulation Loop
for (t = 2 : (total_time_steps))%for each time point
    % Add Noise
    % Determine if any neurons should receive input noise
    if(mod(t,5000/i)==0) % Every instance where t(current time) is a mutiple of the frequncy period stim a random neuron
        checker  = noiseSpikes/((t-2)*.0002)/i; % num spikes divided by (num of timesteps*seconds in each timestep)divided by num neurons
        while checker <= 1  % If AP is less than the number of AP needed for 1Hz
            neuneu = randsample(i,1); % Determine which neurons should receive input noise
            while(Spikes(neuneu,t)==1) % Keep picking a neuron until it finds one that hasent been excited 
                neuneu = randsample(i,1);
            end
            %             for(y = 1 : total_time_steps)% Counts AP of neuron
            %                 if Spikes(neuneu,y) == 1
            %                     checkin = checkin +1;
            %                 end
            %             end
            noiseSpikes = noiseSpikes +1;
            V(neuneu,t)= 30; % Basically voltage for an AP
            checker  = noiseSpikes/((t-2)*.0002)/i;
        end
    end
    
    %Runs network
    dV=.04.*((V(:,t)).^2) + 5.*(V(:,t)) + 140 - u(:,t) + I(:,t);%.*NeuronDamage(:,1); 
    V(:,t+1)=V(:,t)+dV.*dt;
    du = a(:).*((b(:).*V(:,t))-u(:,t));
    u(:,t+1)=u(:,t)+du.*dt;
    for neuronID=1:i
        if(V(neuronID,t+1) >= 30)
            V(neuronID,t+1) = c(neuronID);
            u(neuronID,t+1) = u(neuronID,t) + d(neuronID);
            Spikes(neuronID,t+1)=1; 
            I(:, t)=I(:, t)+ AdjacencyMatrix(neuronID,:)'*8; % May need to multiply this by some constant;(Mutiple by some constant to get 6 Hz firing rate)
        end
    end
    I(:,t+1) = 0.96 * I(:, t);% Decay Current
end
end