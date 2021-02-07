function [MagnitudeOfPhaseBetween1And2]=NetworkFunctionalMetricsLecture(Spikes)
%% phase synchronization
SpikesOsc = Spikes(:,1:5000*60);
MagnitudeOfPhaseBetween1And2 = zeros(500, 500);

for x = 1:500
    % Calculate a phase angle for every timepoint in the simulation for neuron
    % 1
    PhaseAngle=zeros(1,5000*60);

    NumberOfSpikesForNeuron1=sum(SpikesOsc(x,:));
    % Preallocate
    LastSpike=0;
    SpikesTimes=find(SpikesOsc(x,:));
    for i=1:NumberOfSpikesForNeuron1
        SpikeTime=SpikesTimes(i);
        LengthOfTimeSinceLastSpike=SpikeTime-LastSpike;
        PhaseAngleSinceLastSpike=linspace(0,2*pi,LengthOfTimeSinceLastSpike);
        PhaseAngle(LastSpike+1:SpikeTime)=PhaseAngleSinceLastSpike;
        LastSpike=SpikeTime;
    end


    for y= x+1:500
        % plot(PhaseAngle)

        % Calculate a phase angle for every timepoint in the simulation for neuron
        % 2
        PhaseAngle2=zeros(1,5000*60);

        NumberOfSpikesForNeuron1=sum(SpikesOsc(y,:));
        % Preallocate
        LastSpike=0;
        SpikesTimes=find(SpikesOsc(y,:));
        for i=1:NumberOfSpikesForNeuron1
            SpikeTime=SpikesTimes(i);
            LengthOfTimeSinceLastSpike=SpikeTime-LastSpike;
            PhaseAngleSinceLastSpike=linspace(0,2*pi,LengthOfTimeSinceLastSpike);
            PhaseAngle2(LastSpike+1:SpikeTime)=PhaseAngleSinceLastSpike;
            LastSpike=SpikeTime;
        end

        % hold on
        % plot(PhaseAngle2)

        % Determine the phase angle between neuron 1 and 2 at each time point
        PhaseAngleDifference=PhaseAngle-PhaseAngle2;

        % Finding the average magnitude of all of the phase difference angles

        XDirection=mean(cos(PhaseAngleDifference));
        YDirection=mean(sin(PhaseAngleDifference));

        MagnitudeOfPhaseBetween1And2(x,y)=sqrt(XDirection^2+YDirection^2);
    end

end
end