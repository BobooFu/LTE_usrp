function [y, yPg] = MIMOFadingChan_Tag_f(in, prmLTE, prmMdl_Tag)
%Tx-TAG的信道

% MIMOFadingChan
%#codegen
% Get simulation params
numTx         = prmLTE.numTx;
numRx         = prmLTE.numRx;
chanMdl      = prmMdl_Tag.chanMdl;
chanSRate   = prmLTE.chanSRate;
corrLvl         = prmMdl_Tag.corrLevel;
switch chanMdl
    case 'flat-low-mobility',
        PathDelays = 0*(1/chanSRate);
        PathGains  = 0;
        Doppler=0;
        ChannelType =1;
    case 'flat-high-mobility',
        PathDelays = 0*(1/chanSRate);
        PathGains  = 0;
        Doppler=70;
        ChannelType =1;
    case 'frequency-selective-low-mobility',
       PathDelays = [0 40 70]*(1/chanSRate);
        PathGains  = [0  -40 -154];
        Doppler=1;
        ChannelType =1;
    case 'frequency-selective-high-mobility',
       PathDelays = [0 10 20 30 70]*(1/chanSRate);
        PathGains  = [0 -3 -6 -8 -154];

%         PathDelays = [0 10 20 30 120]*(1/chanSRate);
%         PathGains  = [0 -3 -6 -7 -8];

        Doppler=70;
        ChannelType =1;
    case 'EPA 0Hz'
        PathDelays = [0 30 70 90 110 190 410]*1e-9;
        PathGains  = [0 -1 -2 -3 -8 -17.2 -20.8];
        Doppler=0;
        ChannelType =1;
    otherwise
        ChannelType =2;
        AntConfig=char([48+numTx,'x',48+numRx]);
end
% Initialize objects
persistent chanObj;
if isempty(chanObj)
    if ChannelType ==1
        chanObj = comm.MIMOChannel('SampleRate', chanSRate, ...
            'MaximumDopplerShift', Doppler, ...
            'PathDelays', PathDelays,...
            'AveragePathGains', PathGains,...
            'RandomStream', 'mt19937ar with seed',...
            'Seed', 100,...
            'TransmitCorrelationMatrix', eye(numTx),...
            'ReceiveCorrelationMatrix', eye(numRx),...
            'PathGainsOutputPort', true,...
            'NormalizePathGains', true,...
            'NormalizeChannelOutputs', true);
    else
        chanObj = comm.LTEMIMOChannel('SampleRate', chanSRate, ...
            'Profile', chanMdl, ...
            'AntennaConfiguration', AntConfig, ...
            'CorrelationLevel', corrLvl,...
            'RandomStream', 'mt19937ar with seed',...
            'Seed', 100,...
            'PathGainsOutputPort', true);
    end
end
[y, yPg] = step(chanObj, in);
tic
toc