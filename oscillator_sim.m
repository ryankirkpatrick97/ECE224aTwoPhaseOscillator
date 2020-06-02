close all
clear
clc

fs = 2^24;                      %oversample clock frequency
ts = 1/fs;                      %oversample clock period
num_samples = 1*fs;             %number of simulation clock periods
t_stop = (num_samples-1)*ts;    %final simulation time
t = 0:ts:t_stop;                %time vector
x0 = fs*[1;0];          %initial conditions

fsig = 1000;         %oscillator frequency in Hertz
w = linspace(2*pi*fsig,2*pi*fsig,length(t))./sqrt(3);

shift = 24;                     %bitshifts in accumulators
bw = 40;                        %bitwidth of accumulator registers

% sim('oscillator3_ideal.slx');  %simulate ideal oscillator
sim('oscillator2_discrete.slx'); %simulate discrete oscillator

figure; plot(t,osc,'Linewidth',2);
axis tight
title('Oscillator Simulation');
xlabel('Time (s)');
ylabel('Amplitude');

figure; hold on;
phase1 = osc(:,1);

N = length(phase1);
xdft = fft(phase1);
xdft = xdft(1:N/2+1);
psdx = (1/(fs*N))*abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
f = 0:fs/N:fs/2;

semilogx(f,10*log10(psdx),'b');
set(gca, 'XScale', 'log')
title('Oscillator Phase PSD');
xlabel('Frequency (Hz)');
ylabel('Power (dB/Hz)');


