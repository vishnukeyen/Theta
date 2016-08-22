cd('/data/keyen/Relics/FinalData/Data/Processed/Enclosure/250');
p=dir; %Directory variable to parse through all the data in the folder.
npks=[3:12]; % No of peaks picked in the algorithm.
% This is to check that the six fold symmetry is not intetionally created
% by the analysis.
for rr=1:length(npks) % First loop variable. rr - loops through the no of peaks picked.
    for ii=3:length(p) % Second loop variable. ii - loops through the entire data set.
        load(p(ii).name);
        % Distribution of Data
        eeg=R_250.eeg;Hz=R_250.Hz;
        pos=R_250.position;posx=pos(1,:);posy=pos(1,:);vel=R_250.velocity;
        % Velocity is calculated from the position values
        direc=R_250.direction;direc=direc+pi;direc=direc.*(180/pi);
        % The direction is converted into a scale from 0-2pi and then
        % translated into the degree measure rather than in the radian
        % measure        
        dlta=R_250.delta;thta=R_250.theta;
        % There is discrepancy between the eeg data and the position data
        % availabe. To be consisitent in analysis, it is decided to
        % eliminate data points which is not attributed with position data.
        if length(eeg)~=length(vel)
            eeg=eeg(1:length(vel));
            thta=thta(1:length(vel));
            dlta=dlta(1:length(vel));
        end               
        timeDelay=0;  % for simplicity, there is no time delay assumed. The relationship is instantaneous.
        nobin=100;% total number of bins. 
        % The bin size would be (360/nobins).
        fbnd=0; % this would look at the signal as whole.
        %fbnd=[a b];% would look at the frequency band specified.
        thrshld=0; % This signifies the threshold of speed to be applied to the movement data
        %% Theta
        [tmeanpwr,tmaxpwr,tbins]=power_direction_fourier(thta,Hz,fbnd,vel,direc,thrshld,nobin,timeDelay);
        % The minimum peak distace is calculated by the indices. Depending
        % on the size of the bin, the actual minimum distance could vary. 
        % Minimum peak distance make sure that the peaks corresponding to
        % the same direction which is deviated a little bit because of the
        % errors are not picked up as different.
        [tpks,tlocs]=findpeaks(tmeanpwr,'MINPEAKDISTANCE',4);
        % The peaks are oriented in descending order to pick out the 
        % highest peaks
        [ts,ti]=sort(tpks,'descend'); 
        if length(tpks)<npks(rr)
            tn=length(tpks);
        else
            tn=npks(rr);
        end 
        % the peaks are re-oriented according to the location of the peaks
        % in ascending order of the direction associated with the peaks.
        tIPD=tbins(tlocs(sort(ti(1:tn),'ascend')))
        
        theta(ii).meanpower=tmeanpwr;
        theta(ii).maxpower=tmaxpwr;
        theta(ii).bins=tbins;
        theta(ii).InterPkDist=tIPD;
        %% Delta
        [dmeanpwr,dmaxpwr,dbins]=power_direction_fourier(dlta,Hz,fbnd,vel,direc,thrshld,nobin,timeDelay);
        [dpks,dlocs]=findpeaks(dmeanpwr,'MINPEAKDISTANCE',4);
        [ds,di]=sort(dpks,'descend');
        if length(dpks)<npks(rr)
            dn=length(dpks);
        else
            dn=npks(rr);
        end 
        dIPD=dbins(dlocs(sort(di(1:dn),'ascend')))
        delta(ii).meanpower=dmeanpwr;
        delta(ii).maxpower=dmaxpwr;
        delta(ii).bins=dbins;
        delta(ii).InterPkDist=dIPD;
        
        close all
        clearvars -except theta delta p ii npks rr tD
    end
name1=sprintf('/data/keyen/NewData/head_direc_power_delta_#pks_%d_data_%d_minPeak_4.mat',rr,ii);
name2=sprintf('/data/keyen/NewData/head_direc_power_theta_#pks_%d_data_%d_minPeak_4.mat',rr,ii);
% The naming convention is the no peaks and minimum peak distance
save(name2,'theta');
save(name1,'delta');

end

    