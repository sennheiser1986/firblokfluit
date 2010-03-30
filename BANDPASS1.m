function BANDPASS1

[yDo,FsDo,nBits] = wavread('lDo.wav');
NDo = length(yDo);
durationDo = NDo / FsDo;
tDo = [1/FsDo:1/FsDo:durationDo];

[yRe,FsRe,nBits] = wavread('Re.wav');
NRe = length(yRe);
durationRe = NRe / FsRe;
tRe = [1/FsRe:1/FsRe:durationRe];

subplot(4,2,1);
plot(tRe,yDo);
subplot(4,2,2);
plot(tRe, yRe);

lageDoFilter = makeFilterLageDo(FsRe);
reFilter = makeFilterRe(FsRe);

subplot(4,2,3);
yLageDo_LageDo = filter(lageDoFilter,yDo);
plot(tDo, yLageDo_LageDo);

subplot(4,2,4);
yRe_LageDo = filter(lageDoFilter,yRe);
plot(tRe,yRe_LageDo);


subplot(4,2,5);
yLageDo_Re = filter(reFilter,yDo);
plot(tDo, yLageDo_Re);

subplot(4,2,6);
yRe_Re = filter(reFilter,yRe);
plot(tRe,yRe_Re);

function Hd = makeBandPassFilter(Fs, Fstop1, Fpass1, Fpass2, Fstop2)
Dstop1 = 0.0001;          % First Stopband Attenuation
Dpass  = 0.057501127785;  % Passband Ripple
Dstop2 = 0.0001;          % Second Stopband Attenuation
dens   = 20;              % Density Factor

% Calculate the order from the parameters using FIRPMORD.
[N, Fo, Ao, W] = firpmord([Fstop1 Fpass1 Fpass2 Fstop2]/(Fs/2), [0 1 ...
                          0], [Dstop1 Dpass Dstop2]);

% Calculate the coefficients using the FIRPM function.
b  = firpm(N, Fo, Ao, W, {dens});
Hd = dfilt.dffir(b);

% [EOF]

function Hd = makeFilterLageDo(Fs)
Hd = makeBandPassFilter(Fs,488,508,537,557);

function Hd = makeFilterRe(Fs)
Hd = makeBandPassFilter(Fs,550,570,603,623);

function Hd = makeFilterMi(Fs)
Hd = makeBandPassFilter(Fs,618,622,696,670);

function Hd = makeFilterFa(Fs)
Hd = makeBandPassFilter(Fs,655,659,737,741);

function Hd = makeFilterSol(Fs)
Hd = makeBandPassFilter(Fs,736,740,828,834);

function Hd = makeFilterLa(Fs)
Hd = makeBandPassFilter(Fs,826,831,929,935);

function Hd = makeFilterSi(Fs)
Hd = makeBandPassFilter(Fs,927,932,1043,1048);

function Hd = makeFilterHogeDo(Fs)
Hd = makeBandPassFilter(Fs,982,987,1105,1111);



