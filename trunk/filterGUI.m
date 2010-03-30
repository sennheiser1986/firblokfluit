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

% Last Modified by GUIDE v2.5 30-Mar-2010 17:07:59

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

if get(handles.lageDoCheckbox, 'Value')==1
    %blablabla
end
if get(handles.reCheckbox, 'Value')==1
    %blablabla
end
if get(handles.miCheckbox, 'Value')==1
    %blablabla
end
if get(handles.faCheckbox, 'Value')==1
    %blablabla
end
if get(handles.solCheckbox, 'Value')==1
    %blablabla
end
if get(handles.laCheckbox, 'Value')==1
    %blablabla
end
if get(handles.siCheckbox, 'Value')==1
    %blablabla
end
if get(handles.hogeDoCheckbox, 'Value')==1
    %blablabla
end
