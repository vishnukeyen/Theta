%%% Each data set represent different time delays ranging from 5ms - 100ms 
%%% and each of them having a number of trials in it. 
% Here goes the directory of the data
cd('/data/keyen/NewData/Data3/Theta/')                                          
p=dir;% Directory variable                                                                  
for tt=3:length(p)
    load(p(tt).name);                                                       
    tpeakD=[];% This variable collects all the IPDs without concerning the identity of trials
    % Calculation for over all trials in a single session
    for ii=1:length(theta)-2% Trial variable
        % ii stands for number of trials in a single session
        % Re-distribution of the data into
        % Temporary variables                                                                            
        tmnpw=theta(ii+2).meanpower;                                         
        tmxpw=theta(ii+2).maxpower;                                          
        tipd=theta(ii+2).InterPkDist;  
        tbins=theta(ii+2).bins;                                             
        % Calculations
        txpd=diff(tipd);% The distance between adjascent peaks                       
        tpeakD=[tpeakD,txpd];
        % All the calculations are done on radian measure and are converted
        % back to angles later on
        txpd1=circ_ang2rad(txpd);% Conversion to radian        
        tipkd(ii)=circ_mean(txpd1'); % Mean for the trial           
    end  
    % Calculations for all the sessions
    mt(tt)=circ_mean(tipkd');
    mst(tt) = circ_std(tipkd');
    % Conversion back to angles
    tipkd1{tt}=circ_rad2ang(tipkd);
    mtdeg(tt)=circ_rad2ang(mt(tt));  
    mstdeg(tt)=circ_rad2ang(mst(tt));    
    % Figure
    tdly=(tt-2)*5; % Time Delay
    tit=sprintf('Theta with # Peaks-%dms',tdly); % Title for the figure
    figure;
    hist(tipkd1{tt},20);    
    xlabel('Inter Peak Difference');
    title(tit);
end

%%% Plot over different time delays for all the sessions and trials
x1=[0:20];x2=x1;% Time Delay
y1=mtdeg(3:length(mtdeg));% Data
e1=mstdeg(3:length(mstdeg));% Errorbar

figure;
plot(x1,y1,'LineWidth',2);
xlabel('Time delay');
ylabel('Mean IPD');

figure;
errorbar(x1,y1,e1,'LineWidth',2);
xlabel('Time delay');
ylabel('Mean IPD');

trad=tipkd.*(pi/180);
figure;
hist(trad,20);
xlabel('Inter Peak Difference');
title('Theta');

