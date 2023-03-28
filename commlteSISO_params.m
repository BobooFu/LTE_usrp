%设置LTE的参数 被主函数读入
% PDSCH   生成资源块的信息
numTx          = 1;    % Number of transmit antennas
numRx          = 1;    % Number of receive antennas
chanBW       = 6;    % Index to chanel bandwidth used [1,....6]
contReg       = 1;    % No. of OFDM symbols dedictaed to control information [1,...,3]
modType      =  1;   % Modulation type [1, 2, 3] for ['QPSK,'16QAM','64QAM']
% DLSCH   Turbo解码的信息
cRate            = 1/3; % Rate matching target coding rate 
maxIter         = 6;     % Maximum number of turbo decoding terations  
fullDecode    = 0;    % Whether "full" or "early stopping" turbo decoding is performed
% Channel model
chanMdl        =  'frequency-selective-high-mobility'; 
% chanMdl        =  'flat-high-mobility'; 
corrLvl           = 'Low'; 
% Simulation parametrs
Eqmode        = 2;      % Type of equalizer used [1,2] for ['ZF', 'MMSE']
chEstOn        = 1;     % Whether channel estimation is done or ideal channel model used
maxNumErrs = 1e7; % Maximum number of errors found before simulation stops
maxNumBits = 1e7;  % Maximum number of bits processed before simulation stops
visualsOn     = 1;      % Whether to visualize channel response and constellations
snrdB            = 18;   % Value of SNR used in this experiment