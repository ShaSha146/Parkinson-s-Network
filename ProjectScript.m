% %% Script file to run the models for the final project
% %% Normal Network Creation (Compare affect of network topology)
% 
% % Small world network
% ADJ=SmallWorldNetwork(500,.1);
% 
% ADJ2=ADJ;
% 
% ADJ3=ADJ;
% %% Add inhibitory and excitatory neurons
% % Select a random set of neurons to be inhibitory
% InhibitoryNeurons=randperm(500,500);  
% ADJ(InhibitoryNeurons(1:125),:)=ADJ(InhibitoryNeurons(1:125),:)*-3.5;
% ADJ(InhibitoryNeurons(126:250),:)=ADJ(InhibitoryNeurons(126:250),:)*-1;
% ADJ(InhibitoryNeurons(251:375),:)=ADJ(InhibitoryNeurons(251:375),:)*.5;
% 
% % Change for low excitatory neuron
% % Each of these should be a vector of values (1,N) to have a value for each of your neurons
% 
% a=(1:500);
% a(1:end)=.02;
% a(InhibitoryNeurons(1:250))=.1;
% b= (1:500);
% b(1:end)=.2; 
% c=(1:500);  
% c(1:end)=-65;
% d=(1:500);
% d(1:end)=8;
% d(InhibitoryNeurons(1:250))=2;
% 
% % Lower connection strength based on No dopamine?
% 
% % Small world network (Damage)
% 
% ADJ2(InhibitoryNeurons(1:125),:)=ADJ2(InhibitoryNeurons(1:125),:)*-3.5*(1/.8);
% ADJ2(InhibitoryNeurons(126:250),:)=ADJ2(InhibitoryNeurons(126:250),:)*-1*(1/.8);
% ADJ2(InhibitoryNeurons(251:375),:)=ADJ2(InhibitoryNeurons(251:375),:)*.5*(.8);
% ADJ2(InhibitoryNeurons(376:end),:)=ADJ2(InhibitoryNeurons(376:end),:)*1*(.8);
% 
% %% Higher connection strength based on Excess dopamine?
% 
% % Small world network (Damage)
% 
% ADJ3(InhibitoryNeurons(1:125),:)=ADJ3(InhibitoryNeurons(1:125),:)*-3.5*(.8);
% ADJ3(InhibitoryNeurons(126:250),:)=ADJ3(InhibitoryNeurons(126:250),:)*-1*(.8);
% ADJ3(InhibitoryNeurons(251:375),:)=ADJ3(InhibitoryNeurons(251:375),:)*.5*(1/.8);
% ADJ3(InhibitoryNeurons(376:end),:)=ADJ3(InhibitoryNeurons(376:end),:)*1*(1/.8);
%  
% %% Simulation (for each of your networks) / %% functional analysis / %% Get Phase Synchonization 
% FR1 =(1:3);
% FR2 =(1:3);
% FR3 =(1:3);
% 
% SquareWave=ones(1,5*5)/(5*5);
% 
% OscFreq =(1:3);
% OscFreq2 =(1:3);
% OscFreq3 =(1:3);
% 
% for i =1:3
%     [Spikes]=RunIzhikevichNetworkModelHW5(ADJ,a, b, c, d);
%     FR1(i) = sum(sum(Spikes))/60/500;
%     
%     SmoothedNetworkSignal1=conv(sum(Spikes),SquareWave,'same');
%     NumPeaks=findpeaks(SmoothedNetworkSignal1);
%     TotalNumPeaks=sum(NumPeaks);
%     OscFreq(i)=TotalNumPeaks/60;
%     
%     [Spikes2]=RunIzhikevichNetworkModelHW5(ADJ2,a, b, c, d);
%     FR2(i) = sum(sum(Spikes2))/60/500;
%     
%     SmoothedNetworkSignal2=conv(sum(Spikes2),SquareWave,'same');
%     NumPeaks2=findpeaks(SmoothedNetworkSignal2);
%     TotalNumPeaks2=sum(NumPeaks2);
%     OscFreq2(i)=TotalNumPeaks2/60;
% 
%     [Spikes3]=RunIzhikevichNetworkModelHW5(ADJ3,a, b, c, d);
%     FR3(i) = sum(sum(Spikes3))/60/500;
%     
%     SmoothedNetworkSignal3=conv(sum(Spikes3),SquareWave,'same');
%     NumPeaks3=findpeaks(SmoothedNetworkSignal3);
%     TotalNumPeaks3=sum(NumPeaks3);
%     OscFreq3(i)=TotalNumPeaks3/60;
%     
% end
% 
% MagnitudeOfPhaseBetween1And2= NetworkFunctionalMetricsLecture(Spikes);
% MagnitudeOfPhaseBetween1And2 = MagnitudeOfPhaseBetween1And2 + MagnitudeOfPhaseBetween1And2';
% 
% MagnitudeOfPhaseBetween2And3=NetworkFunctionalMetricsLecture(Spikes2);
% MagnitudeOfPhaseBetween2And3= MagnitudeOfPhaseBetween2And3 + MagnitudeOfPhaseBetween2And3';
%     
% MagnitudeOfPhaseBetween4And5=NetworkFunctionalMetricsLecture(Spikes3);
% MagnitudeOfPhaseBetween4And5= MagnitudeOfPhaseBetween4And5 + MagnitudeOfPhaseBetween4And5';
% 
% %%
% 
% figure
% imagesc(ADJ) % BAse
% colorbar
% 
% figure
% imagesc(ADJ2) % No Dop
% colorbar
% 
% figure
% imagesc(ADJ3) % Excess Dop
% colorbar
% 
% figure
% imagesc(MagnitudeOfPhaseBetween1And2)
% colorbar
% 
% figure
% imagesc(MagnitudeOfPhaseBetween2And3)
% colorbar
% 
% figure
% imagesc(MagnitudeOfPhaseBetween4And5)
% colorbar
% 
% figure
% RasterPlot(Spikes)
% 
% figure
% RasterPlot(Spikes2)
% 
% figure
% RasterPlot(Spikes3)
% 
% 
% 
% %% Find the error of the measurements
% % Graph Frequency 
% 
% figure 
% datas = FR1'; % Insert Values of interest for baseline here
% data(1) = mean(datas);
% SEM = std(datas)/sqrt(length(datas));               % Standard Error
% ts = tinv([0.025  0.975],length(datas)-1);      % T-Score
% CI = mean(datas) + ts*SEM;                      % Confidence Intervals
% errlow(1) = data(1) - CI(1);
% errhigh(1) = CI(2) - data(1);
% 
% datas = FR2'; % Insert Values of interest for no dopamine here
% data(2) = mean(datas);
% SEM = std(datas)/sqrt(length(datas));               % Standard Error
% ts = tinv([0.025  0.975],length(datas)-1);      % T-Score
% CI = mean(datas) + ts*SEM;                      % Confidence Intervals
% errlow(2) = data(2) - CI(1);
% errhigh(2) = CI(2) - data(2);
% 
% datas = FR3'; % Insert Values of interest for excess dopamine here
% data(3) = mean(datas);
% SEM = std(datas)/sqrt(length(datas));               % Standard Error
% ts = tinv([0.025  0.975],length(datas)-1);      % T-Score
% CI = mean(datas) + ts*SEM;                      % Confidence Intervals
% errlow(3) = data(3) - CI(1);
% errhigh(3) = CI(2) - data(3);
% 
% x = 1:3;
% name = {'Dopamine';'W/o Dopamine';'Excess Dopamine'};
% bar(x,data)                
% set(gca,'xticklabel',name)
% hold on
% er = errorbar(x,data,errlow,errhigh);    
% er.Color = [0 0 0];                            
% er.LineStyle = 'none';  
% ylabel('Firing Rate (Hz)')
% hold off
% 
% 
% %%
% % Graph Oscillatory Frequency 
% 
% figure 
% datas = OscFreq'; % Insert Values of interest for baseline here
% data(1) = mean(datas);
% SEM = std(datas)/sqrt(length(datas));               % Standard Error
% ts = tinv([0.025  0.975],length(datas)-1);      % T-Score
% CI = mean(datas) + ts*SEM;                      % Confidence Intervals
% errlow(1) = data(1) - CI(1);
% errhigh(1) = CI(2) - data(1);
% 
% datas = OscFreq2'; % Insert Values of interest for no dopamine here
% data(2) = mean(datas);
% SEM = std(datas)/sqrt(length(datas));               % Standard Error
% ts = tinv([0.025  0.975],length(datas)-1);      % T-Score
% CI = mean(datas) + ts*SEM;                      % Confidence Intervals
% errlow(2) = data(2) - CI(1);
% errhigh(2) = CI(2) - data(2);
% 
% datas = OscFreq3'; % Insert Values of interest for excess dopamine here
% data(3) = mean(datas);
% SEM = std(datas)/sqrt(length(datas));               % Standard Error
% ts = tinv([0.025  0.975],length(datas)-1);      % T-Score
% CI = mean(datas) + ts*SEM;                      % Confidence Intervals
% errlow(3) = data(3) - CI(1);
% errhigh(3) = CI(2) - data(3);
% 
% x = 1:3;
% name = {'Dopamine';'W/o Dopamine';'Excess Dopamine'};
% bar(x,data)                
% set(gca,'xticklabel',name)
% hold on
% er = errorbar(x,data,errlow,errhigh);    
% er.Color = [0 0 0];                            
% er.LineStyle = 'none';  
% ylabel('Qsillatory Frequency (Hz)')
% hold off
% 

%% Nodal Analysis
% NodeMetricsLecture(MagnitudeOfPhaseBetween1And2, MagnitudeOfPhaseBetween2And3, MagnitudeOfPhaseBetween4And5);

% %% Network Stats
% EdgeNetworkMetricsLecture(MagnitudeOfPhaseBetween1And2, MagnitudeOfPhaseBetween2And3, MagnitudeOfPhaseBetween2And3);

% %% Advanced Network Stats/Modularity
% [ReorderedADJ_Base, NewADJ_Base] = ModularityCode(MagnitudeOfPhaseBetween1And2);
% 
% [ReorderedADJ_NoDop, NewADJ_NoDop] = ModularityCode(MagnitudeOfPhaseBetween2And3);
% 
% [ReorderedADJ_Dop, NewADJ_Dop] = ModularityCode(MagnitudeOfPhaseBetween4And5);


