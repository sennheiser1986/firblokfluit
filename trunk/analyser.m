%OPDRACHT SPECTRUMANALYZER
%
%Jordy Mertens
% &
%Dennis van Cleemput


function varargout = analyser(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @analyser_OpeningFcn, ...
                   'gui_OutputFcn',  @analyser_OutputFcn, ...
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


% --- Executes just before analyser is made visible.
function analyser_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to analyser (see VARARGIN)

% Choose default command line output for analyser
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes analyser wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = analyser_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function set_parameters_on(handles)
set(handles.freqParam, 'Enable', 'ON');
set(handles.amplParam, 'Enable', 'ON');
set(handles.dcParam, 'Enable', 'ON');
set(handles.faseverschParam, 'Enable', 'ON');
set(handles.freqParamSlider, 'Enable', 'ON');
set(handles.amplParamSlider, 'Enable', 'ON');
set(handles.dcSlider, 'Enable', 'ON');
set(handles.faseverschParamSlider, 'Enable', 'ON');
set(handles.samplingFreq, 'Enable', 'ON');
set(handles.samplingPuntenRadioButton, 'Enable', 'ON');
set(handles.samplingFreqSlider, 'Enable', 'ON');
set(handles.schaalverdelingAnalyzerEinde, 'String', 2);

function set_parameters_off(handles)
set(handles.freqParam, 'Enable', 'OFF');
set(handles.amplParam, 'Enable', 'OFF');
set(handles.dcParam, 'Enable', 'OFF');
set(handles.faseverschParam, 'Enable', 'OFF');
set(handles.freqParamSlider, 'Enable', 'OFF');
set(handles.amplParamSlider, 'Enable', 'OFF');
set(handles.dcSlider, 'Enable', 'OFF');
set(handles.faseverschParamSlider, 'Enable', 'OFF');
set(handles.samplingPuntenRadioButton, 'Value', 0);
set(handles.samplingPuntenRadioButton, 'Enable', 'OFF');
set(handles.samplingFreq, 'Enable', 'OFF');
set(handles.samplingFreqSlider, 'Enable', 'OFF');


function freqParam_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function freqParam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freqParam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function freqParamSlider_Callback(hObject, eventdata, handles)
valueFreqSlider = round(get(handles.freqParamSlider,'value'));
set(handles.freqParam,'String',num2str(valueFreqSlider));

% --- Executes during object creation, after setting all properties.
function freqParamSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freqParamSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function amplParamSlider_Callback(hObject, eventdata, handles)
valueAmplSlider = round(get(handles.amplParamSlider,'value'));
set(handles.amplParam,'String',num2str(valueAmplSlider));


% --- Executes during object creation, after setting all properties.
function amplParamSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amplParamSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function dcSlider_Callback(hObject, eventdata, handles)
valueDcSlider = round(get(handles.dcSlider,'value'));
set(handles.dcParam,'String',num2str(valueDcSlider));


% --- Executes during object creation, after setting all properties.
function dcSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dcSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function amplParam_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function amplParam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amplParam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dcParam_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function dcParam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dcParam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function faseverschParamSlider_Callback(hObject, eventdata, handles)
valueFaseverschParamSlider = round(get(handles.faseverschParamSlider,'value'));
set(handles.faseverschParam,'String',num2str(valueFaseverschParamSlider));


% --- Executes during object creation, after setting all properties.
function faseverschParamSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to faseverschParamSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function faseverschParam_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function faseverschParam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to faseverschParam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function samplingFreq_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function samplingFreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to samplingFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function samplingFreqSlider_Callback(hObject, eventdata, handles)
valueSamplingFreqSlider = round(get(handles.samplingFreqSlider,'value'));
set(handles.samplingFreq,'String',num2str(valueSamplingFreqSlider));


% --- Executes during object creation, after setting all properties.
function samplingFreqSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to samplingFreqSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in samplingPuntenRadioButton.
function samplingPuntenRadioButton_Callback(hObject, eventdata, handles)

% --- Executes on button press in blokRadioButton.
function blokRadioButton_Callback(hObject, eventdata, handles)
set(handles.browseWavPushButton, 'Enable', 'OFF');
set_parameters_on(handles);


% --- Executes on button press in sinusRadioButton.
function sinusRadioButton_Callback(hObject, eventdata, handles)
set(handles.browseWavPushButton, 'Enable', 'OFF');
set_parameters_on(handles);


% --- Executes on button press in wavRadioButton.
function wavRadioButton_Callback(hObject, eventdata, handles)
set(handles.browseWavPushButton,'enable', 'ON');
set(handles.samplingFreq, 'String', 44100);
set_parameters_off(handles);

% --- Executes on button press in browseWavPushButton.
function browseWavPushButton_Callback(hObject, eventdata, handles)
global filename;
filename = uigetfile('*.wav','Selecteer een wav file');


% --- Executes on button press in schaalverdelingAutoCheckBox.
function schaalverdelingAutoCheckBox_Callback(hObject, eventdata, handles)
if isequal(get(hObject,'Value'),0) 
set(handles.schaalverdelingXBegin, 'Enable', 'ON');
set(handles.schaalverdelingXEinde, 'Enable', 'ON');
set(handles.schaalverdelingYBegin, 'Enable', 'ON');
set(handles.schaalverdelingYEinde, 'Enable', 'ON');
end;
if isequal(get(hObject,'Value'),1)
set(handles.schaalverdelingXBegin, 'Enable', 'OFF');
set(handles.schaalverdelingXEinde, 'Enable', 'OFF');
set(handles.schaalverdelingYBegin, 'Enable', 'OFF');
set(handles.schaalverdelingYEinde, 'Enable', 'OFF');
end;



function schaalverdelingXBegin_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function schaalverdelingXBegin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to schaalverdelingXBegin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function schaalverdelingYBegin_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function schaalverdelingYBegin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to schaalverdelingYBegin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function schaalverdelingXEinde_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function schaalverdelingXEinde_CreateFcn(hObject, eventdata, handles)
% hObject    handle to schaalverdelingXEinde (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function schaalverdelingYEinde_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function schaalverdelingYEinde_CreateFcn(hObject, eventdata, handles)
% hObject    handle to schaalverdelingYEinde (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function schaalverdelingAnalyzerBegin_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function schaalverdelingAnalyzerBegin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to schaalverdelingAnalyzerBegin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function schaalverdelingAnalyzerEinde_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function schaalverdelingAnalyzerEinde_CreateFcn(hObject, eventdata, handles)
% hObject    handle to schaalverdelingAnalyzerEinde (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in schaalverdelingAnalyzerAutomatischCheckBox.
function schaalverdelingAnalyzerAutomatischCheckBox_Callback(hObject, eventdata, handles)
if isequal(get(hObject,'Value'),0)
set(handles.schaalverdelingAnalyzerBegin, 'Enable', 'ON');
set(handles.schaalverdelingAnalyzerEinde, 'Enable', 'ON');
end;
if isequal(get(hObject,'Value'),1)
set(handles.schaalverdelingAnalyzerBegin, 'Enable', 'OFF');
set(handles.schaalverdelingAnalyzerEinde, 'Enable', 'OFF');
end;


% --- Executes on button press in lineairRadioButton.
function lineairRadioButton_Callback(hObject, eventdata, handles)


% --- Executes on button press in dBRadioButton.
function dBRadioButton_Callback(hObject, eventdata, handles)



% FUNCTIEGENERATOR

% --- Executes on button press in functiegeneratorPushButton.
function functiegeneratorPushButton_Callback(hObject, eventdata, handles)
%  Getting the setup of the function 
global y x filename e f;

a = str2num(get(handles.amplParam,'String'));
b = str2num(get(handles.freqParam,'String'));
c = str2num(get(handles.faseverschParam,'String'));
d = str2num(get(handles.dcParam,'String'));

%  Setup graph
e =  str2num(get(handles.schaalverdelingXBegin, 'String'));
f =  str2num(get(handles.schaalverdelingXEinde, 'String'));
g =  str2num(get(handles.schaalverdelingYBegin, 'String'));
h =  str2num(get(handles.schaalverdelingYEinde, 'String'));

%  Setup of the samplingrate (samplingfreq)
samplingrate = (1/(str2num(get(handles.samplingFreq, 'String'))))/(f-e);

%  Setup function - original graph
if isequal(get(handles.wavRadioButton,'Value'),1) 
    [y,x] = wavread(filename);
else
    x = e:0.00001:f;
    if isequal(get(handles.sinusRadioButton, 'Value'),1) 
            y= a*sin((2*pi*b*x)+c)+d;
    end;
    if isequal(get(handles.blokRadioButton, 'Value'),1) 
            y= a*square((2*pi*b*x)+c)+d; 
    end;
end;

% draws original graph on generator
set(handles.generatorAxis,'HandleVisibility','ON');
axes(handles.generatorAxis); 
if isequal(get(handles.wavRadioButton,'Value'),1) 
    plot(y);
else
    plot(x,y);
end;
xlabel('Tijd [s]');
ylabel('Amplitude [V]');

%  setup function - sampled graph
if isequal(get(handles.wavRadioButton,'Value'),1) 
    [y,x] = wavread(filename);
    if isequal(get(handles.schaalverdelingAutoCheckBox,'Value'),1)
        f = length(y);
        set(handles.schaalverdelingXEinde,'string',f);
    end;
else
    x = e:samplingrate:f;
    if isequal(get(handles.sinusRadioButton, 'Value'),1) 
            y= a*sin((2*pi*b*x)+c)+d;
    end;
    if isequal(get(handles.blokRadioButton, 'Value'),1) 
            y= a*square((2*pi*b*x)+c)+d; 
    end;
end;

% draws sampled graph on generator
if isequal(get(handles.samplingPuntenRadioButton, 'Value'),1)
    hold on;
    stem(x,y,'fill','-rp');
    hold off;
end;
if isequal(get(handles.schaalverdelingAutoCheckBox,'Value'),1)
    axis tight;
    if isequal(get(handles.wavRadioButton,'Value'),0)
        xlim([0 1/(b/2)]);
    end;
else
    axis([e f g h]);
end;
grid on;
set(handles.generatorAxis,'HandleVisibility','OFF');

%SPECTRUMANALYZER

% --- Executes on button press in functieAnalyzerPushButton.
function functieAnalyzerPushButton_Callback(hObject, eventdata, handles)
global y x e f;

% draws spectrum graph (lineair)
set(handles.analyzerAxis,'HandleVisibility','ON');
axes(handles.analyzerAxis);
if isequal(get(handles.wavRadioButton,'Value'),1) 
    lengte = length(linspace(0,length(y) * (1/x),length(y)));
    frequentie = (x/2*linspace(0,1,lengte/2));
else
    lengte = length(x);
    Fs = 1/((f-e)/(lengte-1));
    frequentie = (Fs/2*linspace(0,1,lengte/2));
end;
Y = fft(y,lengte)/lengte;
if rem(lengte,2)
    lengte=lengte-1;
end;
power = 2*abs(Y(1:lengte/2));

% draws spectrum graph on analyzer (dB values)
if isequal(get(handles.dBRadioButton, 'Value'),1)
    power(1) = 0;
    power = 10*log10(power);
end;
stem(frequentie, power,'.-');
axis tight;
grid on;

xlabel('Frequentie [Hz]');
if isequal(get(handles.dBRadioButton, 'Value'),1)
    ylabel('Decibels [dB]');
else
    ylabel('Amplitude [V]');
end;
if isequal(get(handles.schaalverdelingAnalyzerAutomatischCheckBox,'Value'),1)
    xspecbegin = 0;
    if isequal(get(handles.wavRadioButton,'Value'),1) 
        xspeceinde = 4000;
    else 
        xspeceinde = str2num(get(handles.samplingFreq,'String'));
    end;
else
    xspecbegin = str2num(get(handles.schaalverdelingAnalyzerBegin,'String'));
    xspeceinde = str2num(get(handles.schaalverdelingAnalyzerEinde,'String'));
end;
xlim([xspecbegin xspeceinde]);
set(handles.analyzerAxis,'HandleVisibility','OFF');

% Check Nyquist
if (2*str2num(get(handles.freqParam,'String'))) > str2num(get(handles.samplingFreq,'String'))
    if isequal(get(handles.wavRadioButton,'Value'),0) 
     msgbox('De samplingfrequentie ligt onder de Nyquist-frequentie!','Warning','warn')
    end;
end; 





