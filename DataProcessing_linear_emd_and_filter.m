
%%% Square enclosure data manipulation
%%% A1. Time matched data, (downsample)
%%% A2. position upsampled to match eeg sampling rate
%%% B. Velocity direction of movement and acceleration are calculated using
%%% the obtained position co-ordinates

cd('/data/keyen/everything_related_to_data/Processed/Linear/others');
p=dir;

%%% Part I
%%% Since the data has different sampling rates for position and eeg the
%%% time vector is used to match them. The eeg data at time points where
%%% poisition has been sampled is used later on

%%% Part II
%%% The position data has been upsampled to match the eeg sampling rate.
load(p(3).name);
s=length(vars)
for aa=2:s
    %load(p(aa).name);
    zz=aa
    %% vars
    eeg=vars(aa).eeg;
    Hz=vars(aa).Hz;
    posx=vars(aa).posx;posy=vars(aa).posy;
    signaltheta=vars(aa).theta;signaldelta=vars(aa).delta;    
    phasetheta=angle(hilbert(signaltheta));phasedelta=angle(hilbert(signaldelta));
    theta(1,:)=signaltheta;theta(2,:)=phasetheta;
    delta(1,:)=signaldelta;delta(2,:)=phasedelta;
    f=length(eeg)/length(posx);
    t=length(eeg)/Hz;
    eegt=[1/Hz:(1/Hz):t];
    post=[f/Hz:f/(Hz):t];    
    %%% EMD
    imfs=emd(eeg);    
    %% B - Time matched data
    %%% Movement vars
    xHz=50;% Position sampling rate
    [speed,direction,acceleration]=Velocity(posx,posy,xHz);
    %%% EEG
    cc=1;
    for bb=1:length(eegt)        
        if post(cc)==eegt(bb)
            eegdown(cc)=eeg(bb);
            emddown{cc}=imfs(:,bb);
            thetadown(:,cc)=theta(:,bb);
            deltadown(:,cc)=delta(:,bb);
            cc=cc+1;
        end
    end    
    Hzdown=Hz/f;% Resampled eeg sampling rate
    %%% Data structure
    data(zz).eeg=eegdown;
    data(zz).emd=emddown;
    data(zz).theta=thetadown;% 1st row is signal, 2nd row is phase
    data(zz).delta=deltadown;% 1st row is signal, 2nd row is phase
    data(zz).time=post;
    data(zz).Hz=Hzdown;
    data(zz).posx=posx;
    data(zz).posy=posy;
    data(zz).post=post;
    data(zz).velocity=speed;
    data(zz).direction=direction;
    data(zz).acceleration=acceleration;
    data(zz).xHz=xHz;
    
    name=sprintf('/data/keyen/everything_related_to_data/Processed/Linear/Version1/Downsampled_match_timepoints_%d',aa);
    save(name,'data');
    clear data speed direction acceleration;    
    
    %% A - Upsampled     
    %%% Movement vars
    posX=interp(posx,f);posY=interp(posy,f);
    [speed,direction,acceleration]=Velocity(posX,posY,Hz);
    %%% Data structure
    data(zz).eeg=eeg;
    data(zz).emd=imfs;
    data(zz).theta=theta;
    data(zz).delta=delta;
    data(zz).time=eegt;
    data(zz).Hz=Hz;
    data(zz).posx=posX;
    data(zz).posy=posY;
    data(zz).post=eegt;
    data(zz).velocity=speed;
    data(zz).direction=direction;
    data(zz).acceleration=acceleration;
    data(zz).xHz=Hz;
    
    name=sprintf('/data/keyen/everything_related_to_data/Processed/Linear/Version1/Upsampled_interpolation_%d',aa);
    save(name,'data');
    clearvars -except zz aa p s vars
end

    