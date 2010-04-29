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

% Last Modified by GUIDE v2.5 30-Mar-2010 23:52:15

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

checkFilters(handles);

% UIWAIT makes filterGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.

function Hd = makeBandPassFilter(Fs, Fstop1, Fpass1, Fpass2, Fstop2)
    Nb     = 8;                   % Numerator Order
    Na     = 8;                   % Denominator Order
    Wstop1 = 1;                   % First Stopband Weight
    Wpass  = 1;                   % Passband Weight
    Wstop2 = 1;                   % Second Stopband Weight
    P      = [2 128];             % P'th norm
    dens   = 20;                  % Density Factor

    F = [0 Fstop1 Fpass1 Fpass2 Fstop2 Fs/2]/(Fs/2);

    % Calculate the coefficients using the IIRLPNORM function.
    [b,a,err,sos_var,g] = iirlpnorm(Nb, Na, F, F, [0 0 1 1 0 0], [Wstop1 ...
                                    Wstop1 Wpass Wpass Wstop2 Wstop2], P, ...
                                    {dens});
    Hd                  = dfilt.df2sos(sos_var, g);

function Hd = makeFilterLageDo
    global Fs
    Hd = makeBandPassFilter(Fs,488,508,538,557);

function Hd = makeFilterRe
    global Fs
    Hd = makeBandPassFilter(Fs,550,571,604,623);

function Hd = makeFilterMi
    global Fs
    Hd = makeBandPassFilter(Fs,620,640,678,698);

function Hd = makeFilterFa
    global Fs
    Hd = makeBandPassFilter(Fs,659,679,718,738);

function Hd = makeFilterSol
    global Fs
    Hd = makeBandPassFilter(Fs,742,762,806,826);

function Hd = makeFilterLa
    global Fs
    Hd = makeBandPassFilter(Fs,835,855,904,924);

function Hd = makeFilterSi
    global Fs
    Hd = makeBandPassFilter(Fs,940,960,1015,1035);

function Hd = makeFilterHogeDo
    global Fs
    Hd = makeBandPassFilter(Fs,997,1017,1076,1096);

    %-- This function preloads all filters
function filterPreloader(handles)
    global lageDoFilter;
    global reFilter;
    global miFilter;
    global faFilter;
    global solFilter;
    global laFilter;
    global siFilter;
    global hogeDoFilter;
    
    loadFromFile = 1;
    
    if(isempty(get(lageDoFilter))) 
        display('preloading ldo...');
    	set(handles.statusBar, 'String', 'Preloading Lage Do Filter...');  
        if(exist('lageDoFilter_matlab.mat', 'file') && loadFromFile)
            load('lageDoFilter_matlab.mat', 'lageDoFilter');
        else
            lageDoFilter = makeFilterLageDo();
            save('lageDoFilter_matlab.mat', 'lageDoFilter');
        end
        display('end preloading ldo...');
        set(handles.lageDoCheckbox, 'ForegroundColor', [0 0 1]);
    else
        set(handles.lageDoCheckbox, 'ForegroundColor', [0 0 1]);
    end
    
    if(isempty(get(reFilter))) 
        display('preloading re...');
        set(handles.statusBar, 'String', 'Preloading Re Filter...');
        if(exist('reFilter_matlab.mat', 'file') && loadFromFile)
            load('reFilter_matlab.mat', 'reFilter');
        else
            reFilter = makeFilterRe();
            save('reFilter_matlab.mat', 'reFilter');
        end
        display('end preloading re...');
        set(handles.reCheckbox, 'ForegroundColor', [0 0 1]);
    else
        set(handles.reCheckbox, 'ForegroundColor', [0 0 1]);
    end
    
    
    if(isempty(get(miFilter))) 
        display('preloading mi...');
        set(handles.statusBar, 'String', 'Preloading Mi Filter...');
        if(exist('miFilter_matlab.mat', 'file') && loadFromFile)
            load('miFilter_matlab.mat', 'miFilter');
        else
            miFilter = makeFilterMi();
            save('miFilter_matlab.mat', 'miFilter');
        end
        display('end preloading mi...');
        set(handles.miCheckbox, 'ForegroundColor', [0 0 1]);
    else
        set(handles.miCheckbox, 'ForegroundColor', [0 0 1]);
    end
    
    if(isempty(get(faFilter))) 
        display('preloading fa...');
        set(handles.statusBar, 'String', 'Preloading Fa Filter...');
        if(exist('faFilter_matlab.mat', 'file') && loadFromFile)
            load('faFilter_matlab.mat', 'faFilter');
        else
            faFilter = makeFilterFa();
            save('faFilter_matlab.mat', 'faFilter');
        end
        display('end preloading fa...');
        set(handles.faCheckbox, 'ForegroundColor', [0 0 1]);
    else
        set(handles.faCheckbox, 'ForegroundColor', [0 0 1]);
    end
    
    if(isempty(get(solFilter)))    
        display('preloading sol...');
        set(handles.statusBar, 'String', 'Preloading Sol Filter...');
        if(exist('solFilter_matlab.mat', 'file') && loadFromFile)
            load('solFilter_matlab.mat', 'solFilter');
        else
            solFilter = makeFilterSol();
            save('solFilter_matlab.mat', 'solFilter');
        end
        display('end preloading sol...');
        set(handles.solCheckbox, 'ForegroundColor', [0 0 1]);
    else
        set(handles.solCheckbox, 'ForegroundColor', [0 0 1]);
    end
    
    if(isempty(get(laFilter)))
        display('preloading la...');
        set(handles.statusBar, 'String', 'Preloading La Filter...');
        if(exist('laFilter_matlab.mat', 'file') && loadFromFile)
            load('laFilter_matlab.mat', 'laFilter');
        else
            laFilter = makeFilterLa();
            save('laFilter_matlab.mat', 'laFilter');
        end
        display('end preloading la...');
        set(handles.laCheckbox, 'ForegroundColor', [0 0 1]);
    else
        set(handles.laCheckbox, 'ForegroundColor', [0 0 1]);
    end
    
    if(isempty(get(siFilter)))
        display('preloading si...');
        set(handles.statusBar, 'String', 'Preloading Si Filter...');
        if(exist('siFilter_matlab.mat', 'file') && loadFromFile)
            load('siFilter_matlab.mat', 'siFilter');
        else
            siFilter = makeFilterSi();
            save('siFilter_matlab.mat', 'siFilter');
        end
        display('end preloading si...');
        set(handles.siCheckbox, 'ForegroundColor', [0 0 1]);
    else
        set(handles.siCheckbox, 'ForegroundColor', [0 0 1]);
    end
    
    if(isempty(get(hogeDoFilter)))
        display('preloading hdo...');
        set(handles.statusBar, 'String', 'Preloading Hoge Do Filter...');
        if(exist('hogeDoFilter_matlab.mat', 'file') && loadFromFile)
            load('hogeDoFilter_matlab.mat', 'hogeDoFilter');
        else
            hogeDoFilter = makeFilterHogeDo();
            save('hogeDoFilter_matlab.mat', 'hogeDoFilter');
        end
        display('end preloading hdo...');
        set(handles.hogeDoCheckbox, 'ForegroundColor', [0 0 1]);
    else
        set(handles.hogeDoCheckbox, 'ForegroundColor', [0 0 1]);
    end    
    set(handles.statusBar, 'String', 'All systems ready');


function varargout = filterGUI_OutputFcn(hObject, eventdata, handles) 
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;

function enableGuiElements(handles)
    set(handles.preloadFilters, 'Enable', 'on');
    set(handles.lageDoCheckbox, 'Enable', 'on');
    set(handles.reCheckbox, 'Enable', 'on');
    set(handles.miCheckbox, 'Enable', 'on');
    set(handles.faCheckbox, 'Enable', 'on');
    set(handles.solCheckbox, 'Enable', 'on');
    set(handles.laCheckbox, 'Enable', 'on');
    set(handles.siCheckbox, 'Enable', 'on');
    set(handles.hogeDoCheckbox, 'Enable', 'on');
    set(handles.filterPushbutton, 'Enable', 'on');
    set(handles.playInSignal, 'Enable', 'on');
    
function checkFilters(handles)
    global lageDoFilter;
    global reFilter;
    global miFilter;
    global faFilter;
    global solFilter;
    global laFilter;
    global siFilter;
    global hogeDoFilter;
    if(isempty(get(lageDoFilter))) 
        set(handles.lageDoCheckbox, 'ForegroundColor', [0 0 0]);
    else
        set(handles.lageDoCheckbox, 'ForegroundColor', [0 0 1]);
    end
    
    if(isempty(get(reFilter))) 
        set(handles.reCheckbox, 'ForegroundColor', [0 0 0]);
    else
        set(handles.reCheckbox, 'ForegroundColor', [0 0 1]);
    end
    
    if(isempty(get(miFilter))) 
        set(handles.miCheckbox, 'ForegroundColor', [0 0 0]);
    else
        set(handles.miCheckbox, 'ForegroundColor', [0 0 1]);
    end
    
    if(isempty(get(faFilter))) 
        set(handles.faCheckbox, 'ForegroundColor', [0 0 0]);
    else
        set(handles.faCheckbox, 'ForegroundColor', [0 0 1]);
    end
    
    if(isempty(get(solFilter))) 
        set(handles.solCheckbox, 'ForegroundColor', [0 0 0]);
    else
        set(handles.solCheckbox, 'ForegroundColor', [0 0 1]);
    end
    
    if(isempty(get(laFilter))) 
        set(handles.laCheckbox, 'ForegroundColor', [0 0 0]);
    else
        set(handles.laCheckbox, 'ForegroundColor', [0 0 1]);
    end
    
    if(isempty(get(siFilter))) 
        set(handles.siCheckbox, 'ForegroundColor', [0 0 0]);
    else
        set(handles.siCheckbox, 'ForegroundColor', [0 0 1]);
    end
    
    if(isempty(get(hogeDoFilter))) 
        set(handles.hogeDoCheckbox, 'ForegroundColor', [0 0 0]);
    else
        set(handles.hogeDoCheckbox, 'ForegroundColor', [0 0 1]);
    end

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
   

% --- Executes on button press in lageDoCheckbox.
function lageDoCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to lageDoCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of lageDoCheckbox


% --- Executes on button press in reCheckbox.
function reCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to reCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of reCheckbox


% --- Executes on button press in miCheckbox.
function miCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to miCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of miCheckbox


% --- Executes on button press in faCheckbox.
function faCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to faCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of faCheckbox


% --- Executes on button press in solCheckbox.
function solCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to solCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of solCheckbox


% --- Executes on button press in laCheckbox.
function laCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to laCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of laCheckbox


% --- Executes on button press in siCheckbox.
function siCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to siCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of siCheckbox


% --- Executes on button press in hogeDoCheckbox.
function hogeDoCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to hogeDoCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hogeDoCheckbox


% --- Executes on button press in filterPushbutton.
function filterPushbutton_Callback(hObject, eventdata, handles)
    global lageDoFilter;
    global reFilter;
    global miFilter;
    global faFilter;
    global solFilter;
    global laFilter;
    global siFilter;
    global hogeDoFilter;
    global inSignal;
    global timeVec;
    global Fs;
    global outSignal;
    
    cla(handles.waveUitAxes,'reset');
    cla(handles.fftUitAxes,'reset');
    
    outSignal = zeros(size(inSignal));
    % disable play out signal button
    set(handles.playOutSignal, 'Enable', 'off');
    
    set(handles.statusBar, 'String', 'Applying Filters...');
    

    % --- Load Filters
    if get(handles.lageDoCheckbox, 'Value')==1
        if(isempty(get(lageDoFilter))) 
            lageDoFilter = makeFilterLageDo();
        end
        outSignal = outSignal + filter(lageDoFilter,inSignal);
    end
    if get(handles.reCheckbox, 'Value')==1
        if(isempty(get(reFilter))) 
            reFilter = makeFilterRe();
        end
        outSignal = outSignal + filter(reFilter,inSignal);
    end
    if get(handles.miCheckbox, 'Value')==1
        if(isempty(get(miFilter))) 
            miFilter = makeFilterMi();
        end
        outSignal = outSignal + filter(miFilter,inSignal);
    end
    if get(handles.faCheckbox, 'Value')==1
        if(isempty(get(faFilter))) 
            faFilter = makeFilterFa();
        end
        outSignal = outSignal + filter(faFilter,inSignal);
    end
    if get(handles.solCheckbox, 'Value')==1
        if(isempty(get(solFilter))) 
            solFilter = makeFilterSol();
        end
        outSignal = outSignal + filter(solFilter,inSignal);
    end
    if get(handles.laCheckbox, 'Value')==1
        if(isempty(get(laFilter))) 
            laFilter = makeFilterLa();
        end
        outSignal = outSignal + filter(laFilter,inSignal);
    end
    if get(handles.siCheckbox, 'Value')==1
        if(isempty(get(siFilter))) 
            siFilter = makeFilterSi();
        end
        outSignal = outSignal + filter(siFilter,inSignal);
    end
    if get(handles.hogeDoCheckbox, 'Value')==1
        if(isempty(get(hogeDoFilter))) 
            hogeDoFilter = makeFilterHogeDo();
        end
        outSignal = outSignal + filter(hogeDoFilter,inSignal);
    end
    
    % enable play out signal button
    set(handles.playOutSignal, 'Enable', 'on');

    
    set(handles.statusBar, 'String', 'Plotting output signal...');
     axes(handles.waveUitAxes);
     plot(timeVec,outSignal);
     set(handles.statusBar, 'String', 'Analysing output signal...');
     analyseOutSignal(outSignal, handles);
     set(handles.statusBar, 'String', 'All systems ready');

% --- Executes on button press in preloadFilters.
function preloadFilters_Callback(hObject, eventdata, handles)
global Fs;
display(Fs);
filterPreloader(handles);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in preloadFilters.
function filterPreload_Callback(hObject, eventdata, handles)
% hObject    handle to preloadFilters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over filterPushbutton.
function filterPushbutton_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to filterPushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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
