function varargout = figuur(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @figuur_OpeningFcn, ...
                   'gui_OutputFcn',  @figuur_OutputFcn, ...
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

% -------------------------------------------------------------------------

function figuur_OpeningFcn(hObject, eventdata, handles, varargin)
% Settings
global DBmMin;
global DBmMax;
global DBRange;
global VMin;
global VMax;
global LineStyle;
global LineWidth;
DBmMin = -20;
DBmMax = 20;
DBRange = 80;
VMin = 0.000001; % microvolt
VMax = 10; % volt
LineStyle = '.-';
LineWidth = 2;
% Initialize
init();
% GUI
handles.output = hObject;
guidata(hObject, handles);
% Update memory info
updateMemoryInfo(handles);

% -------------------------------------------------------------------------

function init()
global PlotColorOscilloscope;
global ColorOscilloscope;
global XYColorOscilloscope;
global PlotColorAnalyzer;
global ColorAnalyzer;
global XYColorAnalyzer;
global PlaySound;
global CurrentWaveName;
global LegendLabels;
global HoldCounter;
PlotColorOscilloscope = 'cyan';
ColorOscilloscope = [35 150 180]./255;
XYColorOscilloscope = [20 95 115]./255;
PlotColorAnalyzer = 'cyan';
ColorAnalyzer = [35 150 180]./255;
XYColorAnalyzer = [20 95 115]./255;
PlaySound = 'off';
CurrentWaveName = '';
LegendLabels = {};
HoldCounter = 1;

% -------------------------------------------------------------------------

function varargout = figuur_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

% =========================================================================
%                                GENERATOR
% =========================================================================
% -------------------------------------------------------------------------
function browseWavPushButton_Callback(hObject, eventdata, handles)
global wave;
wave = uigetfile('*.wav','Selecteer een wav file')

function btnStartGenerator_Callback(hObject, eventdata, handles)
global wave;
global PlotColorAnalyzer;
global CurrentWaveName;
global LegendLabels;
global HoldCounter;
global y;
global N;
global Ta;

% Disable start buttons
disableStartButtons(handles);
% Update status
[y,Fs,nBits] = wavread(wave);
N = length(y);
duration = N / Fs;
t = [1/Fs:1/Fs:duration];
tlen = length(t)
ylen = length(y)
Ta = N / Fs;
% Update status
status('Plotting time domain...',handles);
% Plot time domain
plotOscilloscope(t,y,handles);
% Clear frequency domain
if get(handles.toggleHold,'Value') == 0
    clearAnalyzer(handles);
    LegendLabels = {};
    HoldCounter = 1;
    if get(handles.popupColorsAnalyzer,'Value') == 1
        % Marine
        PlotColorAnalyzer = 'cyan';
    elseif get(handles.popupColorsAnalyzer,'Value') == 2
        % Dark
        PlotColorAnalyzer = 'green';
    end
end
% Update current wave name
CurrentWaveName = getSelectedWaveName(handles);
% Update status
status('All systems ready.',handles);
% Update memory info
updateMemoryInfo(handles);
% Enable start buttons
enableStartButtons(handles);

% =========================================================================
%                                OSCILLOSCOPE
% =========================================================================

function checkboxRangeOscilloscope_Callback(hObject, eventdata, handles)
if get(handles.checkboxRangeOscilloscope,'Value') == 0
    set(handles.editRangeOscilloscopeV,'Enable','On');
    set(handles.textRangeOscilloscopeV,'Enable','On');
    set(handles.editRangeOscilloscopeTimeStart,'Enable','On');
    set(handles.textRangeOscilloscopeTimeStart,'Enable','On');
    set(handles.textRangeOscilloscopeTimeFromTo,'Enable','On');
    set(handles.editRangeOscilloscopeTimeEnd,'Enable','On');
    set(handles.textRangeOscilloscopeTimeEnd,'Enable','On');
else
    set(handles.editRangeOscilloscopeV,'Enable','Off');
    set(handles.textRangeOscilloscopeV,'Enable','Off');
    set(handles.editRangeOscilloscopeTimeStart,'Enable','Off');
    set(handles.textRangeOscilloscopeTimeStart,'Enable','Off');
    set(handles.textRangeOscilloscopeTimeFromTo,'Enable','Off');
    set(handles.editRangeOscilloscopeTimeEnd,'Enable','Off');
    set(handles.textRangeOscilloscopeTimeEnd,'Enable','Off');
end

% -------------------------------------------------------------------------

function editRangeOscilloscopeV_Callback(hObject, eventdata, handles)

% -------------------------------------------------------------------------

function editRangeOscilloscopeV_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
                   get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% -------------------------------------------------------------------------

function editRangeOscilloscopeTimeStart_Callback(hObject, eventdata, handles)

% -------------------------------------------------------------------------

function editRangeOscilloscopeTimeStart_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
                   get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% -------------------------------------------------------------------------

function editRangeOscilloscopeTimeEnd_Callback(hObject, eventdata, handles)

% -------------------------------------------------------------------------

function editRangeOscilloscopeTimeEnd_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
                   get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% -------------------------------------------------------------------------

function checkboxLocalMaximaOscilloscope_Callback(hObject, eventdata, handles)

% -------------------------------------------------------------------------

function popupColorsOscilloscope_Callback(hObject, eventdata, handles)
global PlotColorOscilloscope;
global ColorOscilloscope;
global XYColorOscilloscope;
if get(handles.popupColorsOscilloscope,'Value') == 1
    % Marine
    PlotColorOscilloscope = 'cyan';
    ColorOscilloscope = [35 150 180]./255;
    XYColorOscilloscope = [20 95 115]./255;
elseif get(handles.popupColorsOscilloscope,'Value') == 2
    % Dark
    PlotColorOscilloscope = 'green';
    ColorOscilloscope = [80 80 80]./255;
    XYColorOscilloscope = [50 50 50]./255;
end

% -------------------------------------------------------------------------

function popupColorsOscilloscope_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
                   get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% -------------------------------------------------------------------------

function plotOscilloscope(t, y, handles)
global PlotColorOscilloscope;
global ColorOscilloscope;
global XYColorOscilloscope;
global LineStyle;
global LineWidth;
global Ta;

Yr = get(handles.editRangeOscilloscopeV,'String');
Xrs = get(handles.editRangeOscilloscopeTimeStart,'String');
Xre = get(handles.editRangeOscilloscopeTimeEnd,'String');
% Validate input
if isempty(Yr) || ~isNumeric(Yr)
    warning('Oscilloscope','Invalid amplitude',Yr);
    Yr = 1;
    set(handles.editRangeOscilloscopeV,'String',num2str(Yr));
else
    Yr = parseScale(Yr);
    if Yr < 0
        warning('Oscilloscope','Invalid amplitude',num2str(Yr));
        Yr = abs(Yr);
        set(handles.editRangeOscilloscopeV,'String',num2str(Yr));
    elseif Yr == 0
        warning('Oscilloscope','Invalid amplitude',num2str(Yr));
        Yr = 1;
        set(handles.editRangeOscilloscopeV,'String',num2str(Yr));
    end
end
if isempty(Xrs) || ~isNumeric(Xrs)
    warning('Oscilloscope','Invalid time range start',Xrs);
    Xrs = 0;
    set(handles.editRangeOscilloscopeTimeStart,'String',num2str(Xrs));
else
    Xrs = parseScale(Xrs);
    if Xrs < 0
        warning('Oscilloscope','Invalid time range start',num2str(Xrs));
        Xrs = abs(Xrs);
        set(handles.editRangeOscilloscopeTimeStart,'String',num2str(Xrs));
    end
end
if isempty(Xre) || ~isNumeric(Xre)
    warning('Oscilloscope','Invalid time range end',Xre);
    Xre = 1;
    set(handles.editRangeOscilloscopeTimeEnd,'String',num2str(Xre));
else
    Xre = parseScale(Xre);
    if Xre < 0
        warning('Oscilloscope','Invalid time range end',num2str(Xre));
        Xre = abs(Xre);
        set(handles.editRangeOscilloscopeTimeEnd,'String',num2str(Xre));
    end
end
if Xrs >= Xre
    warning('Oscilloscope','Invalid time range',strcat(num2str(Xrs),'...',num2str(Xre)));
    Xrs = 0;
    Xre = 1;
    set(handles.editRangeOscilloscopeTimeStart,'String',num2str(Xrs));
    set(handles.editRangeOscilloscopeTimeEnd,'String',num2str(Xre));
end
if Yr > intmax('int32')
    warning('Oscilloscope','Invalid amplitude',num2str(Yr));
    Yr = 1;
    set(handles.editRangeOscilloscopeV,'String',num2str(Yr));
end
if Xrs > intmax('int32')
    warning('Oscilloscope','Invalid time range start',num2str(Xrs));
    Xrs = 0;
    set(handles.editRangeOscilloscopeTimeStart,'String',num2str(Xrs));
end
if Xre > intmax('int32')
    warning('Oscilloscope','Invalid time range end',num2str(Xre));
    Xre = 1;
    set(handles.editRangeOscilloscopeTimeEnd,'String',num2str(Xre));
end
% Plot time domain
p = plot(handles.axesOscilloscope,t,y,LineStyle);
set(p,'Color',PlotColorOscilloscope);
hold(handles.axesOscilloscope,'on');
% Title
set(get(handles.axesOscilloscope,'Title'), ...
    'String','Oscilloscope (time domain)', ...
    'FontWeight','bold');
% Labels
set(get(handles.axesOscilloscope,'XLabel'), ...
    'String','Time (s)');
set(get(handles.axesOscilloscope,'YLabel'), ...
    'String','Amplitude (V)');
% Ranges
if get(handles.checkboxRangeOscilloscope,'Value') == 0
    set(handles.axesOscilloscope,'XLim',[Xrs Xre]);
    set(handles.axesOscilloscope,'YLim',[-Yr Yr]);
else
    set(handles.axesOscilloscope,'XLim',[0 Ta]);
end
% Pan
h = pan;
setAxesPanMotion(h,handles.axesOscilloscope,'Horizontal');
% Grid
set(handles.axesOscilloscope,'XGrid','On');
set(handles.axesOscilloscope,'YGrid','On');
set(handles.axesOscilloscope,'XMinorGrid','On');
set(handles.axesOscilloscope,'YMinorGrid','On');
% Colors
set(handles.axesOscilloscope,'Color',ColorOscilloscope);
set(handles.axesOscilloscope,'XColor',XYColorOscilloscope);
set(handles.axesOscilloscope,'YColor',XYColorOscilloscope);
% Plot local minima/maxima
if get(handles.checkboxLocalMaximaOscilloscope,'Value') == 1
    delta = max(y)/100;
    [maxtab,mintab] = peak(y,delta,t);
    if size(maxtab,1) > 0
        Xx = maxtab(:,1);
        Xy = maxtab(:,2);
        p = plot(handles.axesOscilloscope, ...
                Xx,Xy, ...
                'r*');
        excludeFromLegend(p);
    end
    if get(handles.popupColorsOscilloscope,'Value') == 1
        minColor = 'green';
    elseif get(handles.popupColorsOscilloscope,'Value') == 2
        minColor = 'cyan';
    end
    if size(mintab,1) > 0
        Xx = mintab(:,1);
        Xy = mintab(:,2);
        p = plot(handles.axesOscilloscope, ...
                Xx,Xy, ...
                '*','Color',minColor);
        excludeFromLegend(p);
    end
    for i = 1:1:size(maxtab,1)
        Xx = [maxtab(i,1) maxtab(i,1)];
        Xy = get(handles.axesOscilloscope,'YLim');
        p = plot(handles.axesOscilloscope, ...
                Xx,Xy, ...
                '-','Color','red');
        excludeFromLegend(p);
    end
end
% Plot cross
if get(handles.checkboxRangeOscilloscope,'Value') == 0
    mid = Xrs+((Xre-Xrs)/2);
else
    mid = max(get(handles.axesOscilloscope,'XLim'))/2;
end
if Xre-Xrs < Ta
    lim = 2*Ta;
else
    lim = 2*(Xre-Xrs);
end
Xx = [-lim lim];
Xy = [0 0];
Yx = [mid mid];
Yy = get(handles.axesOscilloscope,'YLim');
plot(handles.axesOscilloscope, ...
    Xx,Xy, ...
    'k','LineWidth',LineWidth);
plot(handles.axesOscilloscope, ...
    Yx,Yy, ...
    'k','LineWidth',LineWidth);
% Plot cross ticks
if get(handles.checkboxRangeOscilloscope,'Value') == 0
    X = Xrs:(Xre-Xrs)/10:Xre;
    Y = -Yr:Yr/2:Yr;
    Xoff = (Xre-Xrs)/40;
    Yoff = 2*Yr/40;
    posX = [Xrs+((Xre-Xrs)/2)+Xoff/2 Xrs+((Xre-Xrs)/2)-Xoff/2];
    posY = [0-Yoff Yoff];
else
    X = get(handles.axesOscilloscope,'XTick');
    Y = get(handles.axesOscilloscope,'YTick');
    Xoff = diff(get(handles.axesOscilloscope,'XLim'))./40;
    Yoff = diff(get(handles.axesOscilloscope,'YLim'))./40;
    posX = [Ta/2-Xoff/2 Ta/2+Xoff/2];
    posY = [0-Yoff Yoff];
end
for i = 1:length(X)-1
    % Major ticks
    if i > 1
        plot(handles.axesOscilloscope, ...
            [X(i) X(i)],posY, ...
            '-k','LineWidth',LineWidth);
    end
    % Minor ticks
    if length(X) > 1
        tick = X(2)-X(1);
        plot(handles.axesOscilloscope, ...
            [X(i)+tick/2 X(i)+tick/2],posY, ...
            '-k','LineWidth',LineWidth);
    end
end
for i = 2:length(Y)
    % Major ticks
    if i < length(Y)
        plot(handles.axesOscilloscope, ...
            posX,[Y(i) Y(i)], ...
            '-k','LineWidth',LineWidth);
    end
    % Minor ticks
    if length(Y) > 1
        tick = Y(2)-Y(1);
        plot(handles.axesOscilloscope, ...
            posX,[Y(i)-tick/2 Y(i)-tick/2], ...
            '-k','LineWidth',LineWidth);
    end
end
hold(handles.axesOscilloscope,'off');

% =========================================================================
%                                ANALYZER
% =========================================================================

function toggleLine_Callback(hObject, eventdata, handles)
if get(handles.toggleLine,'Value') == 0
    if get(handles.toggleStem,'Value') == 0
        set(handles.toggleLine,'Value',1);
    end
else
    set(handles.toggleStem,'Value',0);
    set(handles.toggleLine,'FontWeight','bold');
    set(handles.toggleStem,'FontWeight','normal');
end

% -------------------------------------------------------------------------

function toggleStem_Callback(hObject, eventdata, handles)
if get(handles.toggleStem,'Value') == 0
    if get(handles.toggleLine,'Value') == 0
        set(handles.toggleStem,'Value',1);
    end
else
    set(handles.toggleLine,'Value',0);
    set(handles.toggleLine,'FontWeight','normal');
    set(handles.toggleStem,'FontWeight','bold');
end

% -------------------------------------------------------------------------

function toggleLinear_Callback(hObject, eventdata, handles)
if get(handles.toggleLinear,'Value') == 0
    if get(handles.toggleLog,'Value') == 0
        set(handles.toggleLinear,'Value',1);
    end
else
    set(handles.toggleLog,'Value',0);
    set(handles.toggleLinear,'FontWeight','bold');
    set(handles.toggleLog,'FontWeight','normal');
end

% -------------------------------------------------------------------------

function toggleLog_Callback(hObject, eventdata, handles)
if get(handles.toggleLog,'Value') == 0
    if get(handles.toggleLinear,'Value') == 0
        set(handles.toggleLog,'Value',1);
    end
else
    set(handles.toggleLinear,'Value',0);
    set(handles.toggleLinear,'FontWeight','normal');
    set(handles.toggleLog,'FontWeight','bold');
end

% -------------------------------------------------------------------------

function toggleDB_Callback(hObject, eventdata, handles)
global DBmMin;
global DBmMax;
if get(handles.toggleDB,'Value') == 0
    if get(handles.toggleVpeak,'Value') == 0 ...
            && get(handles.toggleVrms,'Value') == 0
        set(handles.toggleDB,'Value',1);
    end
else
    set(handles.toggleVpeak,'Value',0);
    set(handles.toggleVrms,'Value',0);
    set(handles.toggleDB,'FontWeight','bold');
    set(handles.toggleVpeak,'FontWeight','normal');
    set(handles.toggleVrms,'FontWeight','normal');
end
set(handles.textRangeAnalyzerAmplitude,'String','dBm');
if str2num(get(handles.editRangeAnalyzerAmplitude,'String')) < DBmMin
    set(handles.editRangeAnalyzerAmplitude,'String',num2str(DBmMin));
end
if str2num(get(handles.editRangeAnalyzerAmplitude,'String')) > DBmMax
    set(handles.editRangeAnalyzerAmplitude,'String',num2str(DBmMax));
end

% -------------------------------------------------------------------------

function toggleVpeak_Callback(hObject, eventdata, handles)
global VMin;
global VMax;
if get(handles.toggleVpeak,'Value') == 0
    if get(handles.toggleDB,'Value') == 0 ...
            && get(handles.toggleVrms,'Value') == 0
        set(handles.toggleVpeak,'Value',1);
    end
else
    set(handles.toggleDB,'Value',0);
    set(handles.toggleVrms,'Value',0);
    set(handles.toggleDB,'FontWeight','normal');
    set(handles.toggleVpeak,'FontWeight','bold');
    set(handles.toggleVrms,'FontWeight','normal');
end
set(handles.textRangeAnalyzerAmplitude,'String','V');
if str2num(get(handles.editRangeAnalyzerAmplitude,'String')) < VMin
    set(handles.editRangeAnalyzerAmplitude,'String',num2str(VMin,'%1.6f'));
end
if str2num(get(handles.editRangeAnalyzerAmplitude,'String')) > VMax
    set(handles.editRangeAnalyzerAmplitude,'String',num2str(VMax));
end

% -------------------------------------------------------------------------

function toggleVrms_Callback(hObject, eventdata, handles)
global VMin;
global VMax;
if get(handles.toggleVrms,'Value') == 0
    if get(handles.toggleDB,'Value') == 0 ...
            && get(handles.toggleVpeak,'Value') == 0
        set(handles.toggleVrms,'Value',1);
    end
else
    set(handles.toggleDB,'Value',0);
    set(handles.toggleVpeak,'Value',0);
    set(handles.toggleDB,'FontWeight','normal');
    set(handles.toggleVpeak,'FontWeight','normal');
    set(handles.toggleVrms,'FontWeight','bold');
end
set(handles.textRangeAnalyzerAmplitude,'String','V');
if str2num(get(handles.editRangeAnalyzerAmplitude,'String')) < VMin
    set(handles.editRangeAnalyzerAmplitude,'String',num2str(VMin,'%1.6f'));
end
if str2num(get(handles.editRangeAnalyzerAmplitude,'String')) > VMax
    set(handles.editRangeAnalyzerAmplitude,'String',num2str(VMax));
end

% -------------------------------------------------------------------------

function checkboxRangeAnalyzer_Callback(hObject, eventdata, handles)
if get(handles.checkboxRangeAnalyzer,'Value') == 0
    set(handles.editRangeAnalyzerAmplitude,'Enable','On');
    set(handles.textRangeAnalyzerAmplitude,'Enable','On');
    set(handles.editRangeAnalyzerFrequencyStart,'Enable','On');
    set(handles.textRangeAnalyzerFrequencyStart,'Enable','On');
    set(handles.textRangeAnalyzerFrequencyFromTo,'Enable','On');
    set(handles.editRangeAnalyzerFrequencyEnd,'Enable','On');
    set(handles.textRangeAnalyzerFrequencyEnd,'Enable','On');
else
    set(handles.editRangeAnalyzerAmplitude,'Enable','Off');
    set(handles.textRangeAnalyzerAmplitude,'Enable','Off');
    set(handles.editRangeAnalyzerFrequencyStart,'Enable','Off');
    set(handles.textRangeAnalyzerFrequencyStart,'Enable','Off');
    set(handles.textRangeAnalyzerFrequencyFromTo,'Enable','Off');
    set(handles.editRangeAnalyzerFrequencyEnd,'Enable','Off');
    set(handles.textRangeAnalyzerFrequencyEnd,'Enable','Off');
end

% -------------------------------------------------------------------------

function editRangeAnalyzerAmplitude_Callback(hObject, eventdata, handles)

% -------------------------------------------------------------------------

function editRangeAnalyzerAmplitude_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
                   get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% -------------------------------------------------------------------------

function editRangeAnalyzerFrequencyStart_Callback(hObject, eventdata, handles)

% -------------------------------------------------------------------------

function editRangeAnalyzerFrequencyStart_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
                   get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% -------------------------------------------------------------------------

function editRangeAnalyzerFrequencyEnd_Callback(hObject, eventdata, handles)

% -------------------------------------------------------------------------

function editRangeAnalyzerFrequencyEnd_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
                   get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% -------------------------------------------------------------------------

function popupWindow_Callback(hObject, eventdata, handles)

% -------------------------------------------------------------------------

function popupWindow_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
                   get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% -------------------------------------------------------------------------

function checkboxLocalMaximaAnalyzer_Callback(hObject, eventdata, handles)

% -------------------------------------------------------------------------

function popupColorsAnalyzer_Callback(hObject, eventdata, handles)
global PlotColorAnalyzer;
global ColorAnalyzer;
global XYColorAnalyzer;
if get(handles.popupColorsAnalyzer,'Value') == 1
    % Marine
    PlotColorAnalyzer = 'cyan';
    ColorAnalyzer = [35 150 180]./255;
    XYColorAnalyzer = [20 95 115]./255;
elseif get(handles.popupColorsAnalyzer,'Value') == 2
    % Dark
    PlotColorAnalyzer = 'green';
    ColorAnalyzer = [80 80 80]./255;
    XYColorAnalyzer = [50 50 50]./255;
end

% -------------------------------------------------------------------------

function popupColorsAnalyzer_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
                   get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% -------------------------------------------------------------------------

function toggleHold_Callback(hObject, eventdata, handles)
if get(handles.toggleHold,'Value') == 0
    set(handles.toggleHold,'ForegroundColor',[0 127 0]./255);
else
    set(handles.toggleHold,'ForegroundColor',[0 190 0]./255);
end

% -------------------------------------------------------------------------

function clearAnalyzer(handles)
cla(handles.axesAnalyzer,'reset');
set(handles.axesAnalyzer,'Box','on');
set(handles.axesAnalyzer,'XTick',[]);
set(handles.axesAnalyzer,'YTick',[]);

% -------------------------------------------------------------------------

function btnStartAnalyzer_Callback(hObject, eventdata, handles)
global PlotColorAnalyzer;
global LegendLabels;
global HoldCounter;
global Ta;
global N;
global y;
% Disable start buttons
disableStartButtons(handles);
% Update status
status('Analyzing time domain...',handles);
% Discrete Fourier transform
if get(handles.popupWindow,'Value') > 1
    % Window
    if get(handles.popupWindow,'Value') == 2
        w = bartlett(N);
    elseif get(handles.popupWindow,'Value') == 3
        w = blackman(N,'periodic');
    elseif get(handles.popupWindow,'Value') == 4
        w = bohmanwin(N);
    elseif get(handles.popupWindow,'Value') == 5
        w = chebwin(N);
    elseif get(handles.popupWindow,'Value') == 6
        w = gausswin(N);
    elseif get(handles.popupWindow,'Value') == 7
        w = hamming(N,'periodic');
    elseif get(handles.popupWindow,'Value') == 8
        w = hann(N,'periodic');
    elseif get(handles.popupWindow,'Value') == 9
        w = kaiser(N);
    elseif get(handles.popupWindow,'Value') == 10
        w = tukeywin(N);
    end
    Y = fft(y.*w',N);
else
    Y = fft(y,N);
end
% Normalize data
Y = Y/N;
% Get amplitude (amplitude -> abs, phase -> angle)
Y = abs(Y);
% Two-sided
% -> symmetrical: positive half followed by negative half
% -> convert to single-sided (take only positive half and multiply by 2)
Y = 2*Y(1:N/2);
if get(handles.toggleDB,'Value') == 1
    % Convert to dB
    R = 50; % ohms
    Y = 20*log10(Y/R);
    % Normalize data
    %Y = Y-max(Y);
elseif get(handles.toggleVrms,'Value') == 1
          Y = Y/sqrt(2);
end
% Update status
status('Plotting frequency domain...',handles);
% Clear frequency domain
if get(handles.toggleHold,'Value') == 0
    clearAnalyzer(handles);
    LegendLabels = {};
    HoldCounter = 1;
    if get(handles.popupColorsAnalyzer,'Value') == 1
        % Marine
        PlotColorAnalyzer = 'cyan';
    elseif get(handles.popupColorsAnalyzer,'Value') == 2
        % Dark
        PlotColorAnalyzer = 'green';
    end
end
% Plot frequency domain
Fw = N/(2*Ta);
t = linspace(0,Fw,N/2);
plotAnalyzer(t,Y,handles);
% Update status
status('All systems ready.',handles);
% Update memory info
updateMemoryInfo(handles);
% Enable start buttons
enableStartButtons(handles);

% -------------------------------------------------------------------------

function plotAnalyzer(t, Y, handles)
global PlotColorAnalyzer;
global ColorAnalyzer;
global XYColorAnalyzer;
global CurrentWaveName;
global LegendLabels;
global HoldCounter;
global DBmMin;
global DBmMax;
global DBRange;
global VMin;
global VMax;
global LineStyle;
global LineWidth;
Yr = get(handles.editRangeAnalyzerAmplitude,'String');
Xrs = get(handles.editRangeAnalyzerFrequencyStart,'String');
Xre = get(handles.editRangeAnalyzerFrequencyEnd,'String');
% Validate input
if isempty(Yr) || ~isNumeric(Yr)
    warning('Analyzer','Invalid amplitude reference level',Yr);
    Yr = 10;
    set(handles.editRangeAnalyzerAmplitude,'String',num2str(Yr));
else
    Yr = parseScale(Yr);
    if get(handles.toggleDB,'Value') == 1
        if Yr < DBmMin % -dBm
            warning('Analyzer','Invalid amplitude reference level',num2str(Yr));
            Yr = DBmMin;
            set(handles.editRangeAnalyzerAmplitude,'String',num2str(Yr));
        elseif Yr > DBmMax % +dBm
            warning('Analyzer','Invalid amplitude reference level',num2str(Yr));
            Yr = DBmMax;
            set(handles.editRangeAnalyzerAmplitude,'String',num2str(Yr));
        end
    else
        if Yr < VMin
            warning('Analyzer','Invalid amplitude reference level',num2str(Yr));
            Yr = VMin;
            set(handles.editRangeAnalyzerAmplitude,'String',num2str(Yr,'%1.6f'));
        elseif Yr > VMax
            warning('Analyzer','Invalid amplitude reference level',num2str(Yr));
            Yr = VMax;
            set(handles.editRangeAnalyzerAmplitude,'String',num2str(Yr));
        end
    end
end
if isempty(Xrs) || ~isNumeric(Xrs)
    warning('Analyzer','Invalid frequency range start',Xrs);
    Xrs = 0;
    set(handles.editRangeAnalyzerFrequencyStart,'String',num2str(Xrs));
else
    Xrs = parseScale(Xrs);
    if Xrs < 0
        warning('Analyzer','Invalid frequency range start',num2str(Xrs));
        Xrs = abs(Xrs);
        set(handles.editRangeAnalyzerFrequencyStart,'String',num2str(Xrs));
    end
end
if isempty(Xre) || ~isNumeric(Xre)
    warning('Analyzer','Invalid frequency range end',Xre);
    Xre = 10;
    set(handles.editRangeAnalyzerFrequencyEnd,'String',num2str(Xre));
else
    Xre = parseScale(Xre);
    if Xre < 0
        warning('Analyzer','Invalid frequency range end',num2str(Xre));
        Xre = abs(Xre);
        set(handles.editRangeAnalyzerFrequencyEnd,'String',num2str(Xre));
    end
end
if Xrs >= Xre
    warning('Analyzer','Invalid frequency range',strcat(num2str(Xrs),'...',num2str(Xre)));
    Xrs = 0;
    Xre = 10;
    set(handles.editRangeAnalyzerFrequencyStart,'String',num2str(Xrs));
    set(handles.editRangeAnalyzerFrequencyEnd,'String',num2str(Xre));
end
if Yr > intmax('int32')
    warning('Analyzer','Invalid amplitude reference level',num2str(Yr));
    if get(handles.toggleDB,'Value') == 1
        Yr = DBmMax;
    else
        Yr = VMax;
    end
    set(handles.editRangeAnalyzerAmplitude,'String',num2str(Yr));
end
if Xrs > intmax('int32')
    warning('Analyzer','Invalid frequency range start',num2str(Xrs));
    Xrs = 0;
    set(handles.editRangeAnalyzerFrequencyStart,'String',num2str(Xrs));
end
if Xre > intmax('int32')
    warning('Analyzer','Invalid frequency range end',num2str(Xre));
    Xre = 0;
    set(handles.editRangeAnalyzerFrequencyEnd,'String',num2str(Xre));
end
DBMin = DBmMin-30;
DBMax = DBmMax-30;
% Plot frequency domain
if get(handles.toggleStem,'Value') == 1
    p = stem(handles.axesAnalyzer,t,Y,'Fill','-');
    set(get(p,'BaseLine'),'LineWidth',LineWidth);
else
    p = plot(handles.axesAnalyzer,t,Y,LineStyle);
end
set(p,'Color',PlotColorAnalyzer);
hold(handles.axesAnalyzer,'on');
% Title
set(get(handles.axesAnalyzer,'Title'), ...
    'String','Analyzer (frequency domain)', ...
    'FontWeight','bold');
% Labels & ranges
set(get(handles.axesAnalyzer,'XLabel'), ...
    'String','Frequency (Hz)');
if get(handles.toggleDB,'Value') == 1
    set(get(handles.axesAnalyzer,'YLabel'), ...
        'String','Amplitude (dB)');
    if get(handles.checkboxRangeAnalyzer,'Value') == 0
        Ytop = round(Yr-30); % dBm to dB
        set(handles.axesAnalyzer,'XLim',[Xrs Xre]);
        set(handles.axesAnalyzer,'YLim',[Ytop-DBRange Ytop]);
        set(handles.axesAnalyzer,'YTick',DBMin-DBRange:10:0);
    else
        set(handles.axesAnalyzer,'YLim',[min(Y) max(Y)]);
    end
else
    if get(handles.toggleVpeak,'Value') == 1
        set(get(handles.axesAnalyzer,'YLabel'), ...
            'String','Amplitude (Vpeak)');
    else
        set(get(handles.axesAnalyzer,'YLabel'), ...
            'String','Amplitude (Vrms)');
    end
    if get(handles.checkboxRangeAnalyzer,'Value') == 0
        set(handles.axesAnalyzer,'XLim',[Xrs Xre]);
        if get(handles.toggleLinear,'Value') == 1
            set(handles.axesAnalyzer,'YLim',[0 Yr]);
            set(handles.axesAnalyzer,'YTick',0:Yr/10:Yr);
        end
    else
        set(handles.axesAnalyzer,'YLim',[min(Y) max(Y)]);
    end
end
% Pan
h = pan;
setAxesPanMotion(h,handles.axesAnalyzer,'Vertical');
% Grid
set(handles.axesAnalyzer,'XGrid','On');
set(handles.axesAnalyzer,'YGrid','On');
set(handles.axesAnalyzer,'XMinorGrid','On');
if get(handles.checkboxRangeAnalyzer,'Value') == 1
    set(handles.axesAnalyzer,'YMinorGrid','On');
end
% Colors
set(handles.axesAnalyzer,'Color',ColorAnalyzer);
set(handles.axesAnalyzer,'XColor',XYColorAnalyzer);
set(handles.axesAnalyzer,'YColor',XYColorAnalyzer);
% Scale
if get(handles.toggleLinear,'Value') == 1
    set(handles.axesAnalyzer,'YScale','Linear');
else
    set(handles.axesAnalyzer,'YScale','Log');
end
% Plot zero axis
if get(handles.toggleStem,'Value') == 0
    Xx = get(handles.axesAnalyzer,'XLim');
    if get(handles.toggleLinear,'Value') == 1
        Xy = [0 0];
    else
        Xy = [10^0 10^0];
    end
    p = plot(handles.axesAnalyzer, ...
            Xx,Xy, ...
            'k','LineWidth',LineWidth);
    excludeFromLegend(p);
end
% Plot boundaries
if get(handles.toggleDB,'Value') == 1
    Xx = get(handles.axesAnalyzer,'XLim');
    Xy = [DBMax DBMax];
    p = plot(handles.axesAnalyzer, ...
            Xx,Xy, ...
            '--','Color','blue');
    excludeFromLegend(p);
    Xx = get(handles.axesAnalyzer,'XLim');
    Xy = [DBMin-DBRange DBMin-DBRange];
    p = plot(handles.axesAnalyzer, ...
            Xx,Xy, ...
            '--','Color','blue');
    excludeFromLegend(p);
else
    Xx = get(handles.axesAnalyzer,'XLim');
    Xy = [VMax VMax];
    p = plot(handles.axesAnalyzer, ...
            Xx,Xy, ...
            '--','Color','blue');
    excludeFromLegend(p);
end
% Plot local maxima
if get(handles.checkboxLocalMaximaAnalyzer,'Value') == 1
    if get(handles.toggleDB,'Value') == 1
        delta = max(abs(Y))/10; % threshold (dB)
    else
        delta = max(Y)/100; % threshold (V)
    end
    [maxtab,mintab] = peak(Y,delta,t);
    if size(maxtab,1) > 0
        Xx = maxtab(:,1);
        Xy = maxtab(:,2);
        p = plot(handles.axesAnalyzer, ...
                Xx,Xy, ...
                'r*');
        excludeFromLegend(p);
    end
    for i = 1:1:size(maxtab,1)
        Xx = [maxtab(i,1) maxtab(i,1)];
        if get(handles.checkboxRangeAnalyzer,'Value') == 0
            if get(handles.toggleDB,'Value') == 1
                if maxtab(i,2) < DBMin-DBRange
                    % Don't plot lines of maxima which are
                    % outside the boundaries
                    continue;
                end
                Xy = [DBMin-DBRange 0];
            else
                Xy = [0 VMax];
            end
        else
            if get(handles.toggleDB,'Value') == 1
                Xy = get(handles.axesAnalyzer,'YLim');
            else
                Xy = [0 VMax];
            end
        end
        p = plot(handles.axesAnalyzer, ...
                Xx,Xy, ...
                '-','Color','red');
        excludeFromLegend(p);
    end
end
if get(handles.toggleHold,'Value') == 0
    hold(handles.axesAnalyzer,'off');
else
    if HoldCounter == 1
        PlotColorAnalyzer = 'yellow';
    elseif HoldCounter == 2
        PlotColorAnalyzer = 'magenta';
    elseif HoldCounter == 3
        if get(handles.popupColorsAnalyzer,'Value') == 1
            PlotColorAnalyzer = 'green';
        elseif get(handles.popupColorsAnalyzer,'Value') == 2
            PlotColorAnalyzer = 'cyan';
        end
    elseif HoldCounter == 4
        if get(handles.popupColorsAnalyzer,'Value') == 1
            PlotColorAnalyzer = 'cyan';
        elseif get(handles.popupColorsAnalyzer,'Value') == 2
            PlotColorAnalyzer = 'green';
        end
    end
    HoldCounter = HoldCounter+1;
    if HoldCounter == 5
        HoldCounter = 1;
    end
    LegendLabels{end+1} = CurrentWaveName;
    legend(handles.axesAnalyzer,LegendLabels);
    leg = legend(handles.axesAnalyzer,'show');
    set(leg,'Color','white');
end

% =========================================================================
%                                GLOBAL
% =========================================================================

function res = isNumeric(input)
res = 1;
if ~isempty(str2num(input))
    return;
end
scale = input(length(input));
if isempty(str2num(scale))
    valid = 0;
    switch scale
        case 'p'
            valid = 1;
        case 'n'
            valid = 1;
        case 'u'
            valid = 1;
        case 'm'
            valid = 1;
        case 'k'
            valid = 1;
        case 'M'
            valid = 1;
        case 'G'
            valid = 1;
        case 'T'
            valid = 1;
    end
    if valid == 0
        res = 0;
        return;
    else
        if isempty(str2num(input(1:(length(input)-1))))
            res = 0;
        end
        return;
    end
else
    res = 0;
    return;
end

% -------------------------------------------------------------------------

function value = parseScale(inputString)
scale = inputString(length(inputString));
if isempty(str2num(scale))
    factor = 1;
    switch scale
        case 'p'
            factor = power(10,-12);
        case 'n'
            factor = power(10,-9);
        case 'u'
            factor = power(10,-6);
        case 'm'
            factor = power(10,-3);
        case 'k'
            factor = power(10,3);
        case 'M'
            factor = power(10,6);
        case 'G'
            factor = power(10,9);
        case 'T'
            factor = power(10,12);
    end
    value = inputString(1:(length(inputString)-1));
    value = str2double(value);
    value = value*factor;
    return;
else
    value = str2double(inputString);
    return;
end

% -------------------------------------------------------------------------

function [maxtab, mintab] = peak(v, delta, x)
maxtab = [];
mintab = [];
v = v(:);
if nargin < 3
    x = (1:length(v))';
else
    %--remove me
    x = x(:);
    xlen = length(x)
    vlen = length(v)
    if length(v) ~= length(x)
        error('Input vectors v and x must have same length');
    end
end
if (length(delta(:))) > 1
    error('Input argument DELTA must be a scalar');
end
if delta <= 0
    error('Input argument DELTA must be positive');
end
mn = Inf;
mx = -Inf;
mnpos = NaN;
mxpos = NaN;
lookformax = 1;
for i = 1:length(v)
    this = v(i);
    if this > mx, mx = this;
        mxpos = x(i);
    end
    if this < mn, mn = this;
        mnpos = x(i);
    end
    if lookformax
        if this < mx-delta
            maxtab = [maxtab ; mxpos mx];
            mn = this; mnpos = x(i);
            lookformax = 0;
        end
    else
        if this > mn+delta
            mintab = [mintab ; mnpos mn];
            mx = this; mxpos = x(i);
            lookformax = 1;
        end
    end
end

% -------------------------------------------------------------------------

function name = getSelectedWaveName(handles)
name = 'wave';

% -------------------------------------------------------------------------

function excludeFromLegend(plot_handle)
hAnnotation = get(plot_handle,'Annotation');
hLegendEntry = get(hAnnotation','LegendInformation');
set(hLegendEntry,'IconDisplayStyle','off');

% -------------------------------------------------------------------------

function enableStartButtons(handles)
set(handles.btnStartGenerator,'Enable','On');
set(handles.btnStartAnalyzer,'Enable','On');

% -------------------------------------------------------------------------

function disableStartButtons(handles)
set(handles.btnStartGenerator,'Enable','Off');
set(handles.btnStartAnalyzer,'Enable','Off');

% -------------------------------------------------------------------------

function uitoggletoolPlaySound_OnCallback(hObject, eventdata, handles)
global PlaySound;
PlaySound = 'on';
% -------------------------------------------------------------------------

function uitoggletoolPlaySound_OffCallback(hObject, eventdata, handles)
global PlaySound;
PlaySound = 'off';

% -------------------------------------------------------------------------

function warning(dev, msg, var)
s = {' '};
if nargin == 3
    if ~isempty(var)
        var = strtrim(var);
    end
    if isempty(var)
        msg = strcat(msg,':',s,'(empty)');
    else
        msg = strcat(msg,':',s,var);
    end
end
title = strcat('Warning',s,'-',s,dev);
h = warndlg(msg,title{:},'modal');
uiwait(h);

% -------------------------------------------------------------------------

function status(msg, handles)
set(handles.textStatus,'String',msg);
drawnow;

% -------------------------------------------------------------------------

function updateMemoryInfo(handles)
[user,sys] = memory;
s = {' '};
txt = strcat('Available memory:',s, ...
             num2str(round(sys.PhysicalMemory.Available/(1024^2)),'%d'), ...
             'MB',s, ...
             ' Total memory:',s, ...
             num2str(round(sys.PhysicalMemory.Total/(1024^2)),'%d'), ...
             'MB',s);
set(handles.textMemory,'String',txt);
drawnow;
