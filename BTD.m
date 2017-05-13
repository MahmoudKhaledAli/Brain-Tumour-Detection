function varargout = BTD(varargin)
% BTD MATLAB code for BTD.fig
%      BTD, by itself, creates a new BTD or raises the existing
%      singleton*.
%
%      H = BTD returns the handle to a new BTD or the handle to
%      the existing singleton*.
%
%      BTD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BTD.M with the given input arguments.
%
%      BTD('Property','Value',...) creates a new BTD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BTD_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BTD_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BTD

% Last Modified by GUIDE v2.5 28-Dec-2016 00:10:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BTD_OpeningFcn, ...
                   'gui_OutputFcn',  @BTD_OutputFcn, ...
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


% --- Executes just before BTD is made visible.
function BTD_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BTD (see VARARGIN)

% Choose default command line output for BTD
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BTD wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BTD_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imagename = get(handles.edit1, 'String');
[numberofTumours maxDiameter position] = Project(imagename);
if numberofTumours == 0
    set(handles.text6, 'String', numberofTumours);
    set(handles.text7, 'String', 'NA');
    set(handles.text8, 'String', 'NA');

else
    set(handles.text6, 'String', numberofTumours);
    set(handles.text7, 'String', position);
    set(handles.text8, 'String', maxDiameter);
end
