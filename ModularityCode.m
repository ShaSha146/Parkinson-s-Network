function [ReorderedADJ, NewADJ] = ModularityCode(Adj)

ADJ = Adj;

%% First Test different values for gamma
% Gamma is a size parameter from [0 - inf]. The lower the gamma the
% larger the modules. We want whatever size gives the highest quality Q


ReorderedADJ = 0;
NewADJ = 0;
GammaValuesToTest=[.01 .05 .08 .1 .2 .4 .6 .8 1]; % Shows that qulaity better with lower gamma(One big module)
% GammaValuesToTest=[1 1.5 2 3 6 10 15 20 25]; % Shows that quality decreases when you try to look for smaller/more than 1 module
for j=1:length(GammaValuesToTest)
    for i=1:10
        [M,Q(i,j)]=community_louvain(ADJ,GammaValuesToTest(j));
        NumModules(i,j)=numel(unique(M));
    end
end

figure
bar(GammaValuesToTest,mean(Q))
hold on
errorbar(GammaValuesToTest,mean(Q),std(Q),'k.')


figure
bar(GammaValuesToTest,mean(NumModules))
hold on
errorbar(GammaValuesToTest,mean(NumModules),std(NumModules),'k.')


% CANT DO THIS SECTION BECAUSE THE BEST NUMBER OF MODULES IS 1 WHICH community_louvain DOESNT LIKE
% %% Next Calculate potential ways to break apart the network
% % Note, these are not perfect and won't be the same every time, so we have
% % to do it many times
% 
% clear M Q
% for i=1:100
%     [M(:,i),Q(i)]=community_louvain(ADJ,GammaValuesToTest(.1));
% end
% 
% % mean(Q)
% % 
% % figure
% % histogram(mean(M,2))
% % 
% % figure
% % imagesc(M)
% % colorbar
% 
% %% Next Create a matrix of how likely node a and node b were in the same partition
% D = agreement(M);
% 
% figure
% imagesc(D)
% colorbar
% 
% %% Finally compute a single partition from the probabilibilities
% Communities = consensus_und(D,.1,100); % May need to change the .1 to .2 or .3
% 
% 
% [B,I]=sort(Communities);
% ReorderedADJ=ADJ(I,I);
% figure
% imagesc(ReorderedADJ)
% 
% 
% [~,NewADJ] = reorder_mod(ADJ,Communities');
% figure
% imagesc(NewADJ)
