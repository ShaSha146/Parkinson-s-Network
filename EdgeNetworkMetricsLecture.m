function EdgeNetworkMetricsLecture(adj, adj2, adj3)
%% Create networks to compare

ADJRandom=adj;

ADJSW=adj2;

ADJLAT=adj3;

%% Path length

% Calculate the distance matrix
DRandom=distance_bin(ADJRandom);

DSW=distance_bin(ADJSW);

DLAT=distance_bin(ADJLAT);

%% Characteristic Path Length and Global Efficiency
[LambdaRandom,EffRandom]=charpath(DRandom);

[LambdaSW,EffSW]=charpath(DSW);

[LambdaLAT,EffLAT]=charpath(DLAT);

% global efficency comparison
figure
bar([EffRandom,EffSW,EffLAT])

%% Core Periphery Structure

[CRandom, qRandom]=core_periphery_dir(ADJRandom);
[CSW, qSW]=core_periphery_dir(ADJSW);
[CLAT, qLAT]=core_periphery_dir(ADJLAT);


% quality comparison
figure
bar([qRandom,qSW,qLAT])

% % Visualizing the core-periphery structure
% ReorderingRandom=[find(CRandom) find(~CRandom)];
% ReorderingSW=[find(CSW) find(~CSW)];
% ReorderingLAT=[find(CLAT) find(~CLAT)];
% 
% 
% figure
% subplot(1,2,1)
% imagesc(ADJRandom)
% subplot(1,2,2)
% imagesc(ADJRandom(ReorderingRandom,ReorderingRandom))
% hold on
% plot([0 500],[sum(CRandom) sum(CRandom)],'r','LineWidth',6)
% plot([sum(CRandom) sum(CRandom)],[0 500],'r','LineWidth',6)
% figure
% subplot(1,2,1)
% imagesc(ADJSW)
% subplot(1,2,2)
% imagesc(ADJSW(ReorderingSW,ReorderingSW))
% hold on
% plot([0 500],[sum(CSW) sum(CSW)],'r','LineWidth',6)
% plot([sum(CSW) sum(CSW)],[0 500],'r','LineWidth',6)
% figure
% subplot(1,2,1)
% imagesc(ADJLAT)
% subplot(1,2,2)
% imagesc(ADJLAT(ReorderingLAT,ReorderingLAT))
% hold on
% plot([0 500],[sum(CLAT) sum(CLAT)],'r','LineWidth',6)
% plot([sum(CLAT) sum(CLAT)],[0 500],'r','LineWidth',6)

%Number of neurons in core comparison 

figure
bar([sum(CRandom),sum(CSW),sum(CLAT)])









