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

% Last Modified by GUIDE v2.5 30-Mar-2010 18:15:18

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


% --- Outputs from this function are returned to the command line.

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

function Hd = makeFilterLageDo
    global Fs
    Hd = makeBandPassFilter(Fs,488,508,538,557);

function Hd = makeFilterRe
    global Fs
    Hd = makeBandPassFilter(Fs,550,571,604,623);

function Hd = makeFilterMi
    global Fs
    Hd = makeBandPassFilter(Fs,660,640,678,698);

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
    Hd = makeBandPassFilter(Fs,940,960,1015,995);

function Hd = makeFilterHogeDo
    global Fs
    Hd = makeBandPassFilter(Fs,997,1017,1076,1096);

    %-- This function preloads all filters
function filterPreloader
    global lageDoFilter;
    global reFilter;
    global miFilter;
    global faFilter;
    global solFilter;
    global laFilter;
    global siFilter;
    global hogeDoFilter;

    lageDoFilter = makeFilterLageDo();
    reFilter = makeFilterRe();
    miFilter = makeFilterMi();
    faFilter = makeFilterFa();
    solFilter = makeFilterSol();
    laFilter =  makeFilterLa();
    siFilter =  makeFilterSi();
    hogeDoFilter =  makeFilterHogeDo();


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

    wave = uigetfile('*.wav','Selecteer een wav file');
    set(handles.wavText, 'String', wave);
    [y,Fs,nBits] = wavread(wave);
    N = length(y);
    duration = N / Fs;
    t = [1/Fs:1/Fs:duration];

    inSignal = y;
    timeVec = t;

    axes(handles.waveInAxes);
    plot(timeVec, inSignal);
    
    analyse(inSignal, handles);

function analyse(signal, handles)
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
    plot(tSpec,Y);

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
    outSignal = [];


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
    plot(timeVec,outSignal);

% --- Executes on button press in preloadFilters.
function preloadFilters_Callback(hObject, eventdata, handles)
filterPreloader();


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
