function NodeMetricsLecture(adj, adj2, adj3)
%% 2 different network creations

ADJRandom=adj;

ADJSW=adj2;

ADJLAT=adj3;

% %% Degree
% 
% RandomDegree=degrees_dir(ADJRandom);
% 
% 
% figure
% histogram(RandomDegree)
% 
% 
% SWDegree=degrees_dir(ADJSW);
% 
% figure
% bar([mean(RandomDegree),mean(SWDegree)])
% hold on
% % errorbar([mean(RandomDegree),mean(SWDegree)],[std(RandomDegree),std(SWDegree)],'.k')
% 
% %% Strength
% 
% RandomStrength=strengths_dir(ADJRandom);
% 
% % figure
% % histogram(RandomStrength)
% 
% SWStrength=strengths_dir(ADJSW);
% 
% LATStrength=strengths_dir(ADJLAT);
% 
% figure
% bar([mean(RandomStrength),mean(SWStrength),mean(LATStrength)])
% hold on
% errorbar([mean(RandomStrength),mean(SWStrength),mean(LATStrength)],[std(RandomStrength),std(SWStrength),std(LATStrength)],'.k')
% 

% %% Betweenness
% 
% RandomBTW=betweenness_bin(ADJRandom);
% 
% figure
% histogram(RandomBTW)
% 
% SWBTW=betweenness_bin(ADJSW);
% 
% figure
% bar([mean(RandomBTW),mean(SWBTW)])
% hold on
% errorbar([mean(RandomBTW),mean(SWBTW)],[std(RandomBTW),std(SWBTW)],'.k')
% 
% 
% % Is not normalized in the code
% RandomBTW./((length(RandomBTW)-1)*(length(RandomBTW)-2));
% 
% %% Clustering Coefficient
% 
% RandomCC=clustering_coef_bd(ADJRandom);
% 
% % figure
% % histogram(RandomCC)
% 
% SWCC=clustering_coef_bd(ADJSW);
% 
% LATCC=clustering_coef_bd(ADJLAT);
% 
% figure
% bar([mean(RandomCC),mean(SWCC),mean(LATCC)])
% hold on
% errorbar([mean(RandomCC),mean(SWCC),mean(LATCC)],[std(RandomCC),std(SWCC),std(LATCC)],'.k')
% % 
% 
%% local efficiency

RandomEff=efficiency_bin(ADJRandom,1);

% figure
% histogram(RandomEff)
% 
SWEff=efficiency_bin(ADJSW,1);

LATEff=efficiency_bin(ADJLAT,1);

figure
bar([mean(RandomEff),mean(SWEff),mean(LATEff)])
hold on
errorbar([mean(RandomEff),mean(SWEff),mean(LATEff)],[std(RandomEff),std(SWEff),std(LATEff)],'.k')


