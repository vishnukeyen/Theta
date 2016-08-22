% code 1 
% optimum time delay is 0ms and optimum no of peaks to check for is 5-7
cd('/data/keyen/EMDdata/');
npks=[5:7];tD=0;
p=dir;
for aa=3:4%length(p)
    for bb=1:length(npks)
        load(p(aa).name); 
        aa
        % Distribution of Data
        eeg=R_Hz.eeg;Hz=R_Hz.Hz;%% Theta
        pos(1,:)=R_Hz.posx;
        pos(1,:)=R_Hz.posy;
        posx=pos(1,:);posy=pos(1,:);vel=R_Hz.velocity;
        imfs=R_Hz.emd;
        % Velocity is calculated from the position values
        direc=R_Hz.direction;direc=direc+pi;direc=direc.*(180/pi);
        % The direction is converted into a scale from 0-2pi and then
        % translated into the degree measure rather than in the radian
        % measure        
        dlta=R_Hz.delta;thta=R_Hz.theta;
        % There is discrepancy between the eeg data and the position data
        % availabe. To be consisitent in analysis, it is decided to
        % eliminate data points which is not attributed with position data.
        if length(eeg)~=length(vel)
            eeg=eeg(1:length(vel));
            thta=thta(1:length(vel));
            dlta=dlta(1:length(vel));
        end                       
        nobin=100;% total number of bins.
        % The bin size would be (360/nobins).
        fbnd=0; % this would look at the signal as whole.
        %fbnd=[a b];% would look at the frequency band specified.
        thrshld=0; % This signifies the threshold of speed to be applied to the movement data
        %% IMFs
        tmpower={};txpower={};tbins={};
        tpks{cc}={};tlocs{cc}={};
        ts{cc},ti{cc};
        for cc=1:length(imfs)
            imf=imfs(cc);
            [mpower{cc},xpower{cc},bins{cc}]=power_direction_emd(imf,Hz,vel,direc,thrshld,nobins,tD)
        % The minimum peak distace is calculated by the indices. Depending
        % on the size of the bin, the actual minimum distance could vary. 
        % Minimum peak distance make sure that the peaks corresponding to
        % the same direction which is deviated a little bit because of the
        % errors are not picked up as different.
            [pks{cc},locs{cc}]=findpeaks(meanpwr{cc},'MINPEAKDISTANCE',4);
        % The peaks are oriented in descending order to pick out the 
        % highest peaks
            [s{cc},i{cc}]=sort(pks{cc},'descend'); 
            if length(pks{cc})<npks(rr)
                n=length(pks);
            else
                n=npks(rr);
            end 
        % the peaks are re-oriented according to the location of the peaks
        % in ascending order of the direction associated with the peaks.
        IPD{cc}=bins(locs(sort(i(1:n),'ascend')))
        
        imfdata(ii).meanpower=meanpwr{cc};
        imfdata(ii).maxpower=maxpwr{cc};
        imfdata(ii).bins=bins{cc};
        imfdata(ii).InterPkDist=IPD{cc};
        end
        
        close all
        clearvars -except imfdata p aa bb npks tD
    end
    name1=sprintf('/data/keyen/newdataEMD/head_derection_power_imfs_#Pks_%d_optimized_tD_data_%d',bb,aa);
    save(name1,'imfdata');
end
