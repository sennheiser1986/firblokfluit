function varargout = filterGUI(varargin)
% FILTERGUI M-file for filterGUI.fig
%      FILTERGUI, by itself, creates a new FILTERGUI or raises the existing
%      singleton*.
%
%      H = FILTERGUI returns the handle to a new FILTERGUI or the handle to
%      the existing singleton*.
%
%      FILTERGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FILTERGUI.M with the given input arguments.
%
%      FILTERGUI('Property','Value',...) creates a new FILTERGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before filterGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to filterGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help filterGUI

% Last Modified by GUIDE v2.5 05-May-2010 15:51:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @filterGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @filterGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before filterGUI is made visible.
function filterGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to filterGUI (see VARARGIN)

% Choose default command line output for filterGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes filterGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function varargout = filterGUI_OutputFcn(hObject, eventdata, handles) 
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;
    
    % --- Executes on button press in browsewavPushbutton.
function browsewavPushbutton_Callback(hObject, eventdata, handles)
    % hObject    handle to browsewavPushbutton (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global inSignal;
    global timeVec;
    global Fs;

    % disable play out signal button
    set(handles.playOutSignal, 'Enable', 'off');
    
    wave = uigetfile('*.wav','Selecteer een wav file');
    set(handles.wavText, 'String', wave);
    [y,Fs,nBits] = wavread(wave);
    
    N = length(y);
    duration = N / Fs;
    t = [1/Fs:1/Fs:duration];

    enableGuiElements(handles);
    
    inSignal = y;
    timeVec = t;
    
    outSignal = zeros(size(inSignal));

    axes(handles.waveInAxes);
    set(handles.statusBar, 'String', 'Plotting input signal...');
    plot(timeVec, inSignal);
   
    set(handles.statusBar, 'String', 'Analysing input signal spectrum...');
    analyseInSignal(inSignal, handles);
    set(handles.statusBar, 'String', 'All systems ready');
    
    cla(handles.waveUitAxes,'reset');
    cla(handles.fftUitAxes,'reset');

function enableGuiElements(handles)
    set(handles.playInSignal, 'Enable', 'on');    
    set(handles.goButton, 'Enable', 'on');
    
function analyseInSignal(signal, handles)
    global Fs;
    N = length(signal);
    Ta = N/Fs;
    
    Y = fft(signal,N);
    % Normalize data
    Y = Y/N;
    % Get amplitude (amplitude -> abs, phase -> angle)
    Y = abs(Y);
    % Two-sided
    % -> symmetrical: positive half followed by negative half
    % -> convert to single-sided (take only positive half and multiply by 2)
    Y = 2*Y(1:N/2);
    
    % Generate x vector
    Fw = N/(2*Ta);
    tSpec = linspace(0,Fw,N/2);
    
    axes(handles.fftInAxes);
    semilogy(tSpec,Y);
    set(handles.fftInAxes,'XLim',[0 3000]);
    
function analyseOutSignal(signal, handles)
    global Fs;
    N = length(signal);
    Ta = N/Fs;
    
    Y = fft(signal,N);
    % Normalize data
    Y = Y/N;
    % Get amplitude (amplitude -> abs, phase -> angle)
    Y = abs(Y);
    % Two-sided
    % -> symmetrical: positive half followed by negative half
    % -> convert to single-sided (take only positive half and multiply by 2)
    Y = 2*Y(1:N/2);
    
    % Generate x vector
    Fw = N/(2*Ta);
    tSpec = linspace(0,Fw,N/2);
    
    axes(handles.fftUitAxes);
    semilogy(tSpec,Y);
    set(handles.fftUitAxes,'XLim',[0 3000]);
    
    
% --- Executes on button press in playOutSignal.
function playOutSignal_Callback(hObject, eventdata, handles)
% hObject    handle to playOutSignal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global outSignal;
global Fs;
sound(outSignal, Fs);


% --- Executes on button press in playInSignal.
function playInSignal_Callback(hObject, eventdata, handles)
% hObject    handle to playInSignal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global inSignal;
global Fs;
sound(inSignal, Fs);

function numCrossings = findZeroCrossings(signal, handles)
    global Fs;
    global start;
    global duration;
        
    numCrossings = 0;
    prev = 0;
    start = str2num(get(handles.measureStart,'String')) * Fs;
    duration = str2num(get(handles.measureDuration,'String')) * Fs;
    dBthresh = str2num(get(handles.measureThreshold,'String'));
    thresh = power(10,(dBthresh / 20));
    
    % increment counter whenever sign changes
    for i = start:1:start+duration
        if(abs(signal(i)) > thresh && abs(prev) > thresh)
            if(sign(signal(i)) ~= sign(prev))
                numCrossings = numCrossings + 1; 
            end
        end
        prev = signal(i);
    end
    
    numCrossings = numCrossings / (duration / Fs);

% --- Executes on button press in goButton.
function goButton_Callback(hObject, eventdata, handles)
% hObject    handle to goButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs;
global freqs;
global notes;
global inSignal;
global outSignal;
global timeVec;
global duration;
global start;

freqs = [523.25, 587.33, 659.26, 698.46, 783.99, 880.00, 987.77, 1046.50];
sampFreqs = [537, 590, 652, 706, 780, 860, 970, 1029];
notes = {'lDo', 're', 'mi', 'fa', 'sol', 'la', 'si', 'hDo'};

set(handles.statusBar, 'String', 'Generating filters...');
lpFilterHd = lowpassFilter();
hpFilterHd = highpassFilter();

%remove low frequencies
set(handles.statusBar, 'String', 'Applying lowpassfilter...');
outSignal = filter(lpFilterHd, inSignal);

%remove higher frequencies (harmonics)
set(handles.statusBar, 'String', 'Applying highpassfilter...');
outSignal = filter(hpFilterHd, outSignal);
%smoothing doesnt help
%outSignal = smooth(outSignal,40);

%plot output signal
set(handles.statusBar, 'String', 'Plotting output signal...');
axes(handles.waveUitAxes);
plot(timeVec, outSignal);

%analyse and plot output signal
set(handles.statusBar, 'String', 'Analysing output signal...');
analyseOutSignal(outSignal,handles);

%count the number of zero crossings
set(handles.statusBar, 'String', 'Counting the number of zero crossings...');
numCrossingsOutSignal = findZeroCrossings(outSignal, handles);

%frequency = half of number of zero crossings
estFreq = numCrossingsOutSignal / 2;
set(handles.estimatedFrequency, 'String', estFreq);

%find closest match from frequency array
numNote = getClosestNote(estFreq);
note = notes(numNote);
set(handles.noteDisplay, 'String', note);

%get literal noteDisplay name
idealFreq = freqs(numNote);
set(handles.idealFrequency, 'String', idealFreq);

%calculate freqDifference between estimated and ideal frequency
difference = estFreq - idealFreq;
set(handles.freqDifference, 'String', difference);

%difference between estimated and our excel fft freq
sampFreq = sampFreqs(numNote);
fftDifference = estFreq - sampFreq;
set(handles.diffWithFft, 'String', fftDifference);

set(handles.playOutSignal, 'Enable', 'on');

set(handles.statusBar, 'String', 'All systems ready...');

%overlay region of intrest (the part of the signal which we have measured)
%http://blogs.mathworks.com/desktop/2008/08/25/overlaying-information-on-a-
%plot/
myDuration = duration / Fs;
myStart = start / Fs;

dataAxes = handles.waveUitAxes;
ylim = get(dataAxes,'ylim');
ymin = ylim(1);
ymax = ylim(2);

rectangle('Parent',dataAxes,'Position',[myStart ymin myDuration ymax-ymin],...
    'EdgeColor',[1 .4 .4],'LineWidth',4);

function numNote = getClosestNote(frequency)
global freqs;
%From:
%http://desk.stinkpot.org:8080/tricks/index.php/2006/03 /in-matlab-find-the-array-position-of-an-entry-closest-to-some-arbitrary-value/
[trash, array_position] = min(abs(freqs - frequency));
numNote = array_position;

function Hd = lowpassFilter()
%Returns a discrete-time filter object.

%
%
% M-File generated by MATLAB(R) 7.8 and the Signal Processing Toolbox 6.11.
%
% Generated on: 05-May-2010 00:22:57
%

% Chebyshev Type I Lowpass filter designed using FDESIGN.LOWPASS.

% All frequency values are in Hz.
global Fs;

Fpass = 1100;        % Passband Frequency
Fstop = 1150;        % Stopband Frequency
Apass = 1;           % Passband Ripple (dB)
Astop = 80;          % Stopband Attenuation (dB)
match = 'passband';  % Band to match exactly

% Construct an FDESIGN object and call its CHEBY1 method.
h  = fdesign.lowpass(Fpass, Fstop, Apass, Astop, Fs);
Hd = design(h, 'cheby1', 'MatchExactly', match);

% [EOF]

function Hd = highpassFilter()

%
% M-File generated by MATLAB(R) 7.8 and the Signal Processing Toolbox 6.11.
%
% Generated on: 05-May-2010 00:25:07
%

% Chebyshev Type I Highpass filter designed using FDESIGN.HIGHPASS.

% All frequency values are in Hz.
global Fs;

Fstop = 400;         % Stopband Frequency
Fpass = 500;         % Passband Frequency
Astop = 80;          % Stopband Attenuation (dB)
Apass = 1;           % Passband Ripple (dB)
match = 'passband';  % Band to match exactly

% Construct an FDESIGN object and call its CHEBY1 method.
h  = fdesign.highpass(Fstop, Fpass, Astop, Apass, Fs);
Hd = design(h, 'cheby1', 'MatchExactly', match);

% [EOF]



function measureStart_Callback(hObject, eventdata, handles)
% hObject    handle to measureStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of measureStart as text
%        str2double(get(hObject,'String')) returns contents of measureStart as a double


% --- Executes during object creation, after setting all properties.
function measureStart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to measureStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function measureDuration_Callback(hObject, eventdata, handles)
% hObject    handle to measureDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of measureDuration as text
%        str2double(get(hObject,'String')) returns contents of measureDuration as a double


% --- Executes during object creation, after setting all properties.
function measureDuration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to measureDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function measureThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to measureThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of measureThreshold as text
%        str2double(get(hObject,'String')) returns contents of measureThreshold as a double


% --- Executes during object creation, after setting all properties.
function measureThreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to measureThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


