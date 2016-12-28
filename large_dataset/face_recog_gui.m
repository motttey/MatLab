
function varargout = face_recog_gui(varargin)
% FACE_RECOG_GUI MATLAB code for face_recog_gui.fig
%      FACE_RECOG_GUI, by itself, creates a new FACE_RECOG_GUI or raises the existing
%      singleton*.
%
%      H = FACE_RECOG_GUI returns the handle to a new FACE_RECOG_GUI or the handle to
%      the existing singleton*.
%
%      FACE_RECOG_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FACE_RECOG_GUI.M with the given input arguments.
%
%      FACE_RECOG_GUI('Property','Value',...) creates a new FACE_RECOG_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before face_recog_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to face_recog_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help face_recog_gui

% Last Modified by GUIDE v2.5 28-Dec-2016 16:24:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @face_recog_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @face_recog_gui_OutputFcn, ...
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
end

% --- Executes just before face_recog_gui is made visible.
function face_recog_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to face_recog_gui (see VARARGIN)

% Choose default command line output for face_recog_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes face_recog_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);
init;
end

% --- Outputs from this function are returned to the command line.
function varargout = face_recog_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

init;
DB = get(handles.pushbutton3,'UserData');
query = get(handles.pushbutton2,'UserData');
Method = get(handles.uibuttongroup1,'UserData');

Qname = 'hoge'; %TODO
%setappdata��uibuttongroup�ɂĊi�[�������̂��擾

Method = getappdata(face_recog_gui,'radiobuttonvalue');
feature = getappdata(face_recog_gui,'radiobuttonfeature');

if isempty(feature)
        dblX = double(query);
        dctX = dct2(dblX); %2����DCT
        dctXlow = dctX(1:6, 1:6); %DCT��搬���̎��o��
        Sample = reshape(dctXlow,1,36); 
        feature = 'dct';
else
    switch feature
        case {'HOG', 'hog'}
            Sample = extractHOGFeatures(query, 'CellSize', [16 16]);
        case {'LBP', 'lbp'}
            Sample = extractLBPFeatures(query, 'Upright', false);
        case {'DCT', 'dct'}
            dblX = double(query);
            dctX = dct2(dblX); %2����DCT
            dctXlow = dctX(1:6, 1:6); %DCT��搬���̎��o��
            Sample = reshape(dctXlow,1,36);
        otherwise     
            dblX = double(query);
            dctX = dct2(dblX); %2����DCT
            dctXlow = dctX(1:6, 1:6); %DCT��搬���̎��o��
            Sample = reshape(dctXlow,1,36);   
    end
end    

if isempty(Method)
    %������Ԃ���ύX���Ȃ��Ƃ�, ���Ƃ���dct���{�s
    index = plene_similarity(DB, query, Qname);
    answ = DB(:,:,index);       
else
switch Method
    case 'plene'
        index = plene_similarity(DB, query, Qname);
        answ = DB(:,:,index);   
    case 'edge'
        index = edge_similarity(DB, query, Qname);
        answ = DB(:,:,index);
    case 'hist'
        index = hist_similarity(DB, query, Qname);
        answ = DB(:,:,index);
    case 'dct'
        index = dct_similarity(DB, query, Qname);
        answ = DB(:,:,index);
    case 'poc'
        index = POC_Similarity(DB, query, Qname);
        answ = DB(:,:,index);
    case 'pca'
        index = pca_similarity(DB, query, Qname);
        MeanFace;
        answ = Meanface(:,:,index);
    case 'stp'
        index = strong_point2(DB, query, Qname);
        answ = DB(:,:,index);
    case 'ncc'
        index = ncc(DB, query, Qname);
        answ = DB(:,:,index);
    case 'zncc'
        index = zncc(DB, query, Qname);
        answ = DB(:,:,index);
    case 'knn'
        knn_pretreatment;
        faceClass = predict(Class,Sample);
        MeanFace;
        answ = Meanface(:,:,faceClass);
    case 'svm'
        svm_pretreatment;
        faceClass = predict(SVMClass,Sample);
        MeanFace;
        answ = Meanface(:,:,faceClass);
    otherwise
        index = plene_similarity(DB, query, Qname);
        answ = DB(:,:,index);        
end

end
%number=ceil(index/Individual_Face_Num);

imshow(answ, 'Parent', handles.axes2);
end

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton1.
function pushbutton1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

end

% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
end

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2
end


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName,FilterIndex] = uigetfile({'*.png';'*.jpg';'*.*';},'Select the image file for ');
query = imread(strcat(PathName, FileName));
imshow(query, 'Parent', handles.axes1)
set(hObject,'UserData',query);
%set(hObject,'FileName',FileName);

end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
init;
c = Face_Class_Num;
n = Individual_Face_Num;

for i = 1:c

    for j = 1:n
            filename = strcat(db_path_crop, num2str(n*(i-1)+j-1, '%03d'), '_crop.png');
        if exist(filename, 'file') == 2

            img = imread(filename);
            DB(:, :, n*(i-1)+j) = img;

        else
            fprintf('file "%s" not found\n', filename);
        end
    end
end
set(hObject,'UserData',DB);

end


% --- Executes during object creation, after setting all properties.
function radiobutton3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

end

% --------------------------------------------------------------------
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  structure with the following fields
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
    
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'plene'
        method = 'plene';
    case 'edge'
        method = 'edge';
    case 'hist'
        method = 'hist';
    case 'dct'
        fprintf('Radio button 1');
        method = 'dct';
    case 'poc'
        fprintf('Radio button 2');
        method = 'poc';
    case 'pca'
        fprintf('Radio button 2');
        method = 'pca';
    case 'stp'
        method = 'stp';
    case 'ncc'
        method = 'ncc';
    case 'zncc'
        method = 'zncc';
    case 'knn'
        method = 'knn';
    case 'svm'
        method = 'svm';
    otherwise
        method = 'plene';        
end
%features buttoncontrol�̕\��/��\��
switch method
    case {'knn', 'svm'}
        set(handles.uibuttongroup3, 'Visible','on')
    otherwise
        set(handles.uibuttongroup3, 'Visible','off')        
end
        setappdata(face_recog_gui,'radiobuttonvalue',method);
        %test =  get(handles.uibuttongroup,'UserData')
end

% --------------------------------------------------------------------
function uibuttongroup1_ButtonDownFcn(hObject, eventdata, handles)
        fprintf('ButtonDown');

% hObject    handle to the selected object in uibuttongroup1 
% eventdata  structure with the following fields
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

end
% --- Executes during object deletion, before destroying properties.
function uibuttongroup1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% h= figure;
% setappdata(face_recog_gui,'radiobuttonvalue','dct');
% Method = getappdata(hObject,'radiobuttonvalue');

end
% --- Executes during object deletion, before destroying properties.
function uibuttongroup1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end


% --- Executes during object creation, after setting all properties.
function uibuttongroup3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroup3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
hObject.Visible = 'off';
end

% --- Executes during object deletion, before destroying properties.
function uibuttongroup3_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroup3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

end

% --- Executes when selected object is changed in uibuttongroup3.
function uibuttongroup3_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup3 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'dct'
        feature = 'dct';
    case 'hog'
        feature = 'hog';
    case 'lbp'
        feature = 'lbp';
    otherwise
        feature = 'dct';        
end

        setappdata(face_recog_gui,'radiobuttonfeature',feature);
        %test =  get(handles.uibuttongroup,'UserData')
end
