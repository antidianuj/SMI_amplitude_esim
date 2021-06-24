%% SM signal generation
idx=1;
for C_iter=0:10
    for A_iter=0:10
        for f_iter=0:6
            
            close all
            
            clc
            
            
            phi = pi/2;
            C =2+3/10*C_iter;
            alpha = 5; 
            amp =2+4/10*A_iter;   % Peak to peak Vibration Amp in terms of No of Lambda
            K = 6;
            
            
            frequency =2+6/6*f_iter;    % Freq in Hz
            sampling_f = 8*1e3;  % X samples per sec
            dt = 1/sampling_f;
            
            
            
            %M=1e7;      % total no of acquisition points
            time_in_sec = 1;
            M = sampling_f*time_in_sec;     % total no of acquisition points
            
            time = [0:dt:time_in_sec]';
            time = time(1:end-1);
            
            ramp_ON = 0;
            if ramp_ON == 1
                
                ramp = zeros(M,1);
                samples_per_period = (sampling_f)/frequency;
                samples_per_half_period = samples_per_period/2;
                
                ramp_pos = [-1:1/samples_per_half_period*2 :1]';
                ramp_neg = [1:-1/samples_per_half_period*2 :-1]';
                ramp_unit = [ ramp_pos(1:end-1) ; ramp_neg(1:end-1)];
                
                %     figure('name','double vvv  ')
                %     plot(ramp_unit)
                
                
                for i = 1:1:round(M/samples_per_period)
                    ramp( (i-1)*samples_per_period + 1: i*samples_per_period,1) = ramp_unit;
                end
                
                %     figure('name','double vvv  ')
                %     plot(ramp)
                
                Displ = 2*pi*amp*ramp;  %
                
            else
                
                % 7.4nm err
                 Displ = 1*2*pi*amp*(sin(2*pi*((1/M)*frequency*(dt*M))*([0:M-1]) + pi/2) )';  %
                %Displ = Displ + 1*2*pi*(amp/1)*(sin(2*pi*((1/M)*(frequency*2)*(dt*M))*[0:M-1] + 0*pi/2) )';  %
                  %Displ = Displ + 0.5*2*pi*(amp/1)*(sin(2*pi*((1/M)*(frequency*3)*(dt*M))*[0:M-1] + 5*pi/4) )';  %
                   %Displ = Displ + 2*pi*(amp/1)*(sin(2*pi*((1/M)*(frequency*4)*(dt*M))*[0:M-1] + pi/4) )';  %
                   %Displ = Displ + 2*pi*(amp/1)*(sin(2*pi*((1/M)*(frequency*5)*(dt*M))*[0:M-1] + 3*pi/4) )';  %
                
             %   Displ = 2*pi*amp*(sin(2*pi*((1/M)*frequency*(dt*M))*[0:M-1] + pi/2) )';  %
                %Displ = Displ + 2*pi*(amp/1)*(exp(-2*pi*((1/M)*(frequency*1)*(dt*M))*[0:M-1] + pi/4) )';
            end
            %Displ=sinc(10*time);
            
            
            xs_sim = K*pi - atan(alpha) + Displ + phi;
            
            
            N = length(xs_sim);
            
            xs_sim=xs_sim-mean(xs_sim);
            
            
            xc_sim = xc_fonction_xs_interpol_f_xs(xs_sim,C,atan(alpha));
            
            
            P_simo = cos(xc_sim); % original noise-less SM signal
            
            s1='SMy';
            s2=num2str(idx);
            s3=strcat(s1,s2);
            s4=strcat(s3,'.csv');
            csvwrite(s4,[amp,frequency]);
            idx=idx+1;
            
        end
    end
end