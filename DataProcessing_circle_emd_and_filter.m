cd('/data/keyen/everything_related_to_data/Processed/Circular/others/ProgrammData/');
p=dir;
Hz=4096.5;
for qq=10:length(p)
   cd(p(qq).name);
   l=dir;
   load(l(3).name);
   load(l(4).name);   
    %%%% Removing zero's in position data
    ind=find((data.posx==0).*(data.posy==0));
    data.posx(ind)=[];data.posy(ind)=[];data.post(ind)=[];   
    data.posx=data.posx-mean(data.posx);data.posy=data.posy-mean(data.posy);
    if isfield(data,'directionOfMotion')%%%%Some data sets have different field names
        data.directionOfMotion(ind)=[];%%%%%for direciton of motion
        direction=data.directionOfMotion;
    else
        data.direction(ind)=[];
        direction=data.direction;
    end
    posx=data.posx;posy=data.posy;post=data.post;
    position(1,:)=posx;position(2,:)=posy;position(3,:)=direction;
    %Hz=4096.5;
    %%%%%Data Acquisition
        tl(1)=isfield(data,'eeg1');
        if tl(1)==1
            time1=[];%%% The absolute time vector for eeg;
            t1=data.time1;t=t1;%%% time vecotr for the recording
            temp=[];tmp=[];tp=[];            
            check1=diff(t);
            m=mode(check1);
            s1=size(t1);
            for ii = 1:length(t)-1
                if check(ii) < m
                    temp=t(ii):(t(ii+1)-t(ii))/512:t(ii+1)-((t(ii+1)-t(ii))/512);
                    time1=[time1,temp];
                elseif check(ii)>=m
                    tp=t(ii)+m+1;
                    temp=t(ii):(tp-t(ii))/512:tp-((tp-t(ii))/512);
                    time1=[time1,temp];
                end
                if ii==length(t)-1
                    tmp=t(ii+1)+m;
                    temp=t(ii+1):(tmp-t(ii+1))/512:tmp-((tmp-t(ii+1))/512);
                    time1=[time1,temp];
                end
                temp=[];
            end
            clear t m
            %% Sub-sampling to match position sampling rate
            for ii=1:length(post)
                tmp=post(ii);
                [minval,ind]=min(abs((time1-post(ii))));
                index1(ii)=ind;%%%%The indices for which position are sampled
                clear minval ind;
            end
            eeg1=data.eeg1;eeg_1=eeg1(index1);
            time_1=time1(index1);
            %[theta1,tphase1]=ausie(eeg1,12,4,Hz);theta_1=theta1(index1);tphase_1=tphase1(index1);
            %[delta1,dphase1]=ausie(eeg1,4,1,Hz);delta_1=delta1(index1);dphase_1=dphase1(index1);
            %[slow1,sphase1]=ausie(eeg1,1,0,Hz);slow_1=slow1(index1);sphase_1=sphase1(index1);
        end
        tl(2)=isfield(data,'eeg2');
        if tl(2)==1
            time2=[];%%% The absolute time vector for eeg;
            t2=data.time2;t=t2;
            temp=[];tmp=[];tp=[];            
            check2=diff(t);
            m=mode(check2);  
            s2=size(t2);
            checker1=isequal(s1,s2);            
            if checker1==0
                for ii = 1:length(t)-1
                    if check(ii) < m
                        temp=t(ii):(t(ii+1)-t(ii))/512:t(ii+1)-((t(ii+1)-t(ii))/512);
                        time2=[time2,temp];
                    elseif check(ii)>=m
                        tp=t(ii)+m+1;
                        temp=t(ii):(tp-t(ii))/512:tp-((tp-t(ii))/512);
                        time2=[time2,temp];
                    end
                    if ii==length(t)-1
                        tmp=t(ii+1)+m;
                        temp=t(ii+1):(tmp-t(ii+1))/512:tmp-((tmp-t(ii+1))/512);
                        time2=[time2,temp];
                    end
                    temp=[];
                end
            clear t m
            %% Sub-sampling to match position sampling rate
                for ii=1:length(post)
                    tmp=post(ii);
                    [minval,ind]=min(abs((time2-post(ii))));
                    index2(ii)=ind;%%%%The indices for which position are sampled
                    clear minval ind;
                end            
            end            
            if exist('index2')==0
                index2=index1;
                time2=time1;
            end
            eeg2=data.eeg2;eeg_2=eeg2(index2);
            time2=time2;time_2=time2(index2);
            %[theta2,tphase2]=ausie(eeg2,12,4,Hz);theta_2=theta2(index2);tphase_2=tphase2(index2);
            %[delta2,dphase2]=ausie(eeg2,4,0.5,Hz);delta_2=delta2(index2);dphase_2=dphase2(index2);
            %[slow2,sphase2]=ausie(eeg2,1,0,Hz);slow_2=slow2(index2);sphase_2=sphase2(index2);
        end
        tl(3)=isfield(data,'eeg3');
        if tl(3)==1
            time3=[];%%% The absolute time vector for eeg;
            t3=data.time3;t=t3;
            temp=[];tmp=[];tp=[];            
            check3=diff(t);
            m=mode(check3);
            s3=size(t3);
            checker2=isequal(s2,s3);
            if checker2==0
                for ii = 1:length(t)-1
                    if check(ii) < m 
                        temp=t(ii):(t(ii+1)-t(ii))/512:t(ii+1)-((t(ii+1)-t(ii))/512);
                        time3=[time3,temp];
                    elseif check(ii)>=m
                        tp=t(ii)+m+1;
                        temp=t(ii):(tp-t(ii))/512:tp-((tp-t(ii))/512);
                        time3=[time3,temp];
                    end
                    if ii==length(t)-1
                        tmp=t(ii+1)+m;
                        temp=t(ii+1):(tmp-t(ii+1))/512:tmp-((tmp-t(ii+1))/512);
                        time3=[time3,temp];
                    end
                    temp=[];
                end
                clear t m
            %% Sub-sampling to match position sampling rate
                for ii=1:length(post)
                    tmp=post(ii);
                    [minval,ind]=min(abs((time-post(ii))));
                    index3(ii)=ind;%%%%The indices for which position are sampled
                    clear minval ind;
                end
            end
            if exist('index3')==0
                index3=index2;
                time3=time2;
            end
            eeg3=data.eeg3;eeg_3=eeg3(index3);
            time_3=time3(index3);
            %[theta3,tphase3]=ausie(eeg3,12,4,Hz);theta_3=theta3(index3);tphase_3=tphase3(index3);
            %[delta3,dphase3]=ausie(eeg3,4,0.5,Hz);delta_3=delta3(index3);dphase_3=dphase3(index3);
            %[slow3,sphase3]=ausie(eeg3,1,0,Hz);slow_3=slow3(index3);sphase_3=sphase3(index3);
        end
        tl(4)=isfield(data,'eeg4');
        if tl(4)==1
            time4=[];%%% The absolute time vector for eeg;
            t4=data.time4;t=t4;
            temp=[];tmp=[];tp=[];            
            check4=diff(t);
            m=mode(check4);
            s4=size(t4);
            checker3=isequal(s3,s4);
            if checker3==0
                for ii = 1:length(t)-1
                    if check(ii) < m 
                        temp=t(ii):(t(ii+1)-t(ii))/512:t(ii+1)-((t(ii+1)-t(ii))/512);
                        time4=[time4,temp];
                    elseif check(ii)>=m
                        tp=t(ii)+m+1;
                        temp=t(ii):(tp-t(ii))/512:tp-((tp-t(ii))/512);
                        time4=[time4,temp];
                    end
                    if ii==length(t)-1
                        tmp=t(ii+1)+m;
                        temp=t(ii+1):(tmp-t(ii+1))/512:tmp-((tmp-t(ii+1))/512);
                        time4=[time4,temp];
                    end
                    temp=[];
                end
                clear t m
                %% Sub-sampling to match position sampling rate
                for ii=1:length(post)
                    tmp=post(ii);
                    [minval,ind]=min(abs((time4-post(ii))));
                    index4(ii)=ind;%%%%The indices for which position are sampled
                    clear minval ind;
                end
            end
            if exist('index4')==0
                index4=index3;
                time4=time3;
            end
            eeg4=data.eeg4;eeg_4=eeg4(index4);
            time4=time4;time_4=time4(index4);
            %[theta4,tphase4]=ausie(eeg4,12,4,Hz);theta_4=theta4(index4);tphase_4=tphase4(index4);
            %[delta4,dphase4]=ausie(eeg4,4,0.5,Hz);delta_4=delta4(index4);dphase_4=dphase4(index4);
            %[slow4,sphase4]=ausie(eeg4,1,0,Hz);slow_4=slow4(index4);sphase_4=sphase4(index4);
        end
        tl(5)=isfield(data,'eeg5');
        if tl(5)==1
            time5=[];%%% The absolute time vector for eeg;
            t5=data.time5;t=t5;
            temp=[];tmp=[];tp=[];            
            check5=diff(t);
            m=mode(check5);
            s5=size(t5);
            checker4=isequal(s4,s5);
            if checker4==0
                for ii = 1:length(t)-1
                    if check(ii) < m 
                        temp=t(ii):(t(ii+1)-t(ii))/512:t(ii+1)-((t(ii+1)-t(ii))/512);
                        time5=[time5,temp];
                    elseif check(ii)>=m
                        tp=t(ii)+m;
                        temp=t(ii):(tp-t(ii))/512:tp-((tp-t(ii))/512);
                        time5=[time5,temp];
                    end
                    if ii==length(t)-1
                        tmp=t(ii+1)+m;
                        temp=t(ii+1):(tmp-t(ii+1))/512:tmp-((tmp-t(ii+1))/512);
                        time5=[time5,temp];
                    end
                    temp=[];
                end
                clear t m
                %% Sub-sampling to match position sampling rate
                for ii=1:length(post)
                    tmp=post(ii);
                    [minval,ind]=min(abs((time5-post(ii))));
                    index5(ii)=ind;%%%%The indices for which position are sampled
                    clear minval ind;
                end
            end
            if exist('index5')==0
                index5=index4;
                time5=time4;
            end
            eeg5=data.eeg5;eeg_5=eeg5(index5);
            time5=time5;time_5=time5(index5);
            %[theta5,tphase5]=ausie(eeg5,12,4,Hz);theta_5=theta5(index5);tphase_5=tphase5(index5);
            %[delta5,dphase5]=ausie(eeg5,4,0.5,Hz);delta_5=delta5(index5);dphase_5=dphase5(index5);
            %[slow5,sphase5]=ausie(eeg5,1,0,Hz);slow_5=slow5(index5);sphase_5=sphase5(index5);
        end
        tl(6)=isfield(data,'eeg6');
        if tl(6)==1
            time6=[];%%% The absolute time vector for eeg;
            t6=data.time6;t=t6;
            temp=[];tmp=[];tp=[];
            check6=diff(t);
            m=mode(check6);
            s6=size(t6);
            checker5=isequal(s5,s6);
            if checker5==0
                for ii = 1:length(t)-1
                    if check(ii) < m 
                        temp=t(ii):(t(ii+1)-t(ii))/512:t(ii+1)-((t(ii+1)-t(ii))/512);
                        time6=[time6,temp];
                    elseif check(ii)>=m
                        %tp=t(ii)+m+1;
                        temp=t(ii):(tp-t(ii))/512:tp-((tp-t(ii))/512);
                        time6=[time6,temp];
                    end
                    if ii==length(t)-1
                        %tmp=t(ii+1)+m;
                        temp=t(ii+1):(tmp-t(ii+1))/512:tmp-((tmp-t(ii+1))/512);
                        time6=[time6,temp];
                    end
                    temp=[];
                end
                clear t m
                %% Sub-sampling to match position sampling rate
                for ii=1:length(post)
                    tmp=post(ii);
                    [minval,ind]=min(abs((time6-post(ii))));
                    index6(ii)=ind;%%%%The indices for which position are sampled
                    clear minval ind;
                end
            end
            if exist('index6')==0
                index6=index5;
                time6=time5;
            end
            eeg6=data.eeg6;eeg_6=eeg6(index6);
            time6=time6;time_6=time6(index6);
            %[theta6,tphase6]=ausie(eeg6,12,4,Hz);theta_6=theta6(index6);tphase_6=tphase6(index6);
            %[delta6,dphase6]=ausie(eeg6,4,0.5,Hz);delta_6=delta6(index6);dphase_6=dphase6(index6);
            %[slow6,sphase6]=ausie(eeg6,1,0,Hz);slow_6=slow6(index6);sphase_6=sphase6(index6);
        end    
    %% Variables
    position(1,:)=posx;
    position(2,:)=posy;
    position(3,:)=direction;
    velocity=Velocity(posx,posy,30);
    
    %%%% Storing into a structure
    nlp=find(tl);
    for ii=1:max(nlp)
        %%Electrode #
        x{ii}=genvarname('R',who);
        eval([x{ii},sprintf('.posx=posx;')]);
        eval([x{ii},sprintf('.posy=posy;')]);
        eval([x{ii},sprintf('.post=post;')]);
        eval([x{ii},sprintf('.eeg=eeg_%d;',ii)]);    
        %eval([x{ii},sprintf('.theta=theta_%d;',ii)]);
        %eval([x{ii},sprintf('.tphase=tphase_%d;',ii)]);    
        %eval([x{ii},sprintf('.delta=delta_%d;',ii)]);
        %eval([x{ii},sprintf('.dphase=dphase_%d;',ii)]);
        %eval([x{ii},sprintf('.slowdc=slow_%d;',ii)]);
        %eval([x{ii},sprintf('.sphase=sphase_%d;',ii)]);  
        eval([x{ii},sprintf('.direction=direction;')]);
        eval([x{ii},sprintf('.time=time_%d;',ii)]);
        eval([x{ii},sprintf('.velocity=velocity;')]);
        eval([x{ii},sprintf('.Hz=Hz;')]);
        eval([x{ii},sprintf('.indRem=index%d;',ii)]);
        eval(sprintf('R_25=%s;',x{ii}))
        save(sprintf('/data/keyen/everything_related_to_data/Processed/Circular/Version1/%s_rec_%d_downsample.mat',l(3).name,ii),'R_25','-v7.3');
        clear R_25
    end
        for ii=1:max(nlp)
        %%Electrode #
        x{ii}=genvarname('R',who);
        eval([x{ii},sprintf('.posx=posx;')]);
        eval([x{ii},sprintf('.posy=posy;')]);
        eval([x{ii},sprintf('.post=post;')]);
        eval([x{ii},sprintf('.eeg=eeg%d;',ii)]);    
        %eval([x{ii},sprintf('.theta=theta%d;',ii)]);
        %eval([x{ii},sprintf('.tphase=tphase%d;',ii)]);    
        %eval([x{ii},sprintf('.delta=delta%d;',ii)]);
        %eval([x{ii},sprintf('.dphase=dphase%d;',ii)]);
        %eval([x{ii},sprintf('.slowdc=slow%d;',ii)]);
        %eval([x{ii},sprintf('.sphase=sphase%d;',ii)]);  
        eval([x{ii},sprintf('.direction=direction;')]);
        eval([x{ii},sprintf('.time=time%d;',ii)]);
        eval([x{ii},sprintf('.velocity=velocity;')]);
        eval([x{ii},sprintf('.Hz=Hz;')]);
        eval([x{ii},sprintf('.indRem=index%d;',ii)]);
        eval(sprintf('R_Hz=%s;',x{ii}))
        save(sprintf('/data/keyen/everything_related_to_data/Processed/Circular/Version1/%s_rec_%d_HighRes.mat',l(3).name,ii),'R_Hz','-v7.3');
        clear R_Hz
    end
    clearvars -except p qq Hz
    qq
    cd ..
end

