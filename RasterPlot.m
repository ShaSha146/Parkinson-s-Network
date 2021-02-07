function [H]=RasterPlot(Spikes)
[x,y]=find(Spikes);
H.f=figure;
H.p=plot(y*.1,x,'k.');
xlabel('Time (msec)')
ylabel('Neuron ID')
end

