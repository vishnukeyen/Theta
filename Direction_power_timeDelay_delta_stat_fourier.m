%%% Each data set represent different time delays ranging from 5ms - 100ms 
%%% and each of them having a number of trials in it. 
% Here goes the directory of the data
cd('/data/keyen/Relics/NewData/Data3/Delta')
pd=dir % Directory variable
for rr=3:length(pd) % Directory variable (Session variable)
    % rr stands for the number of sessions
    load(pd(rr).name);
    dpeakD=[];% This variable collects all the IPDs without concerning the identity of trials
    % Calculation for over all trials in a single session
    for ii=1:length(delta)-2 % Trial variable
        % ii stands for number of trials in a single session
        % Re-distribution of the data into
        % Temporary variables
        dmnpw=delta(ii+2).meanpower;
        dmxpw=delta(ii+2).maxpower
        dipd=delta(ii+2).InterPkDist;
        dbins=delta(ii+2).bins;
        % Calculations
        dxpd=diff(dipd);% The distance between adjascent peaks                
        dpeakD=[dpeakD,dxpd];
        % All the calculations are done on radian measure and are converted
        % back to angles later on
        dxpd1=circ_ang2rad(dxpd);% Conversion to radian        
        dipkd(ii)=circ_mean(dxpd1');% Mean for the trial    
    end
    % Calculations for all the sessions
    md(rr)=circ_mean(dipkd');
    msd(rr) = circ_std(dipkd');
    % Conversion back to angles
    dipkd1{rr}=circ_rad2ang(dipkd);
    mddeg(rr)=circ_rad2ang(md(rr));    
    msddeg(rr)=circ_rad2ang(msd(rr))
    % Figure
    tdly=(rr-2)*5; % Time delay
    tit=sprintf('Delta with #peaks-%dms',tdly);% Title for the figure.    
    figure;
    hist(dipkd1{rr},20);
    xlabel('Inter Peak Difference');
    title(tit);
    
end

%%% Plot over different time delays for all the sessions and trials
x1=[0:20];x2=x1;% Time delay
y1=mddeg(3:length(mddeg));% Data
e1=msddeg(3:length(msddeg)); % Errorbar

figure;
plot(x1,y1,'LineWidth',2);
xlabel('Time Delay');
ylabel('Mean IPD');
title('Delta')

figure;
errorbar(x1,y1,e1,'LineWidth',2);
xlabel('Time delay');
ylabel('Mean IPD');
title('Delta')


drad=dipkd.*(180/pi);
figure;
hist(drad,20);
xlabel('Inter Peak Difference');
title('Delta');

