function BANDPASS1
global reFilter
global lageDoFilter
global miFilter
global yDo

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

testFilter;

function testFilter
global reFilter;
global lageDoFilter;
global miFilter;
global yDo;

if(isempty(get(reFilter)))
    disp('refilter is not defined');
end
if(isempty(get(miFilter))) 
    disp('mifilter is not defined');
end

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
Hd = makeBandPassFilter(Fs,488,508,538,557);

function Hd = makeFilterRe(Fs)
Hd = makeBandPassFilter(Fs,550,571,604,623);

function Hd = makeFilterMi(Fs)
Hd = makeBandPassFilter(Fs,660,640,678,698);

function Hd = makeFilterFa(Fs)
Hd = makeBandPassFilter(Fs,659,679,718,738);

function Hd = makeFilterSol(Fs)
Hd = makeBandPassFilter(Fs,742,762,806,826);

function Hd = makeFilterLa(Fs)
Hd = makeBandPassFilter(Fs,835,855,904,924);

function Hd = makeFilterSi(Fs)
Hd = makeBandPassFilter(Fs,940,960,1015,995);

function Hd = makeFilterHogeDo(Fs)
Hd = makeBandPassFilter(Fs,997,1017,1076,1096);



