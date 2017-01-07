
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

% Last Modified by GUIDE v2.5 07-Jan-2017 18:05:29

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
% 
%imshow('anonymous.png', 'Parent', handles.axes2);
%imshow('anonymous.png', 'Parent', handles.axes1);

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
if isempty(DB)
   errordlg('DBが作成されていません');
end
query = get(handles.pushbutton2,'UserData');
if isempty(query)
   errordlg('Queryが指定されていません');
end

Qname = 'hoge'; %TODO
%setappdataでuibuttongroupにて格納したものを取得

Method = getappdata(face_recog_gui,'radiobuttonvalue');
feature = getappdata(face_recog_gui,'radiobuttonfeature');
neuralnet = getappdata(face_recog_gui,'radiobuttonneural');

reject = getappdata(face_recog_gui,'reject');

if isempty(neuralnet)
        network_type = 'perceptron';
else
    switch neuralnet
        case {'perceptron'}
            network_type = 'perceptron';   
        case {'pettern'}
            network_type = 'pattern';
        otherwise     
            network_type = 'perceptron';   
    end
end    

if isempty(feature)
        dblX = double(query);
        dctX = dct2(dblX); %2次元DCT
        dctXlow = dctX(1:6, 1:6); %DCT低域成分の取り出し
        Sample = reshape(dctXlow,1,36); 
        feature = 'dct';
else
    switch feature
        case {'plene'}
            Reshaped_Query = reshape(query,1,Resize_Height * Resize_Width);
            Sample = double(Reshaped_Query);
        case {'HOG', 'hog'}
            Sample = extractHOGFeatures(query, 'CellSize', [HOG_Cell_Size HOG_Cell_Size]);
        case {'LBP', 'lbp'}
            Sample = extractLBPFeatures(query, 'Upright', false);
        case {'DCT', 'dct'}
            dblX = double(query);
            dctX = dct2(dblX); %2次元DCT
            dctXlow = dctX(1:6, 1:6); %DCT低域成分の取り出し
            Sample = reshape(dctXlow,1,36);
        otherwise     
            dblX = double(query);
            dctX = dct2(dblX); %2次元DCT
            dctXlow = dctX(1:6, 1:6); %DCT低域成分の取り出し
            Sample = reshape(dctXlow,1,36);   
    end
end    

if isempty(Method)
    %初期状態から変更がないとき, 仮としてdctを施行
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
        Class =  knn_pretreatment(DB, feature);
        faceClass = predict(Class,Sample);
        MeanFace;
        answ = Mean_face(:,:,faceClass);
    case 'svm'
        Class =  svm_pretreatment(DB, feature);
        faceClass = predict(Class,Sample);
        MeanFace;
        answ = Mean_face(:,:,faceClass);
    case 'neural'
        net = neural_pretreatment(DB, network_type, feature);
        face_vector = net(transpose(Sample));
        [maximum, faceindex] = max(face_vector);
        MeanFace;
        answ = Mean_face(:,:,faceindex);
    otherwise
        index = plene_similarity(DB, query, Qname);
        answ = DB(:,:,index);        
end

end

%リジェクト処理
if reject == true
    match_points = strongpoint_reject(query, answ)
    if match_points == 0
       imshow('rejected.png', 'Parent', handles.axes2);    
    else
       imshow(answ, 'Parent', handles.axes2);    
    end
else
    imshow(answ, 'Parent', handles.axes2);
end

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
%クエリデータの読み込み(via File Dialog)
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
%DBの作成
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
%メソッドのボタングループの選択変化時の効果
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
        method = 'dct';
    case 'poc'
        method = 'poc';
    case 'pca'
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
    case 'neural'
        method = 'neural';
    otherwise
        method = 'plene_b';        
end
%features buttoncontrolの表示/非表示
switch method
    case {'neural'}
        set(handles.uibuttongroup3, 'Visible','on');
        set(handles.uibuttongroup4, 'Visible','on');
        set(handles.plene_b, 'Visible','on');
    case {'knn', 'svm'}
        set(handles.uibuttongroup3, 'Visible','on');
        set(handles.uibuttongroup4, 'Visible','off');
        set(handles.plene_b, 'Visible','off');
    otherwise
        set(handles.uibuttongroup3, 'Visible','off');        
        set(handles.uibuttongroup4, 'Visible','off');   
        set(handles.plene_b, 'Visible','off');        
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

%KNN, SVM等の特徴量選択変化時の動作
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
    case 'plene'
        feature = 'plene';
    otherwise
        feature = 'dct';        
end
    setappdata(face_recog_gui,'radiobuttonfeature',feature);
        %test =  get(handles.uibuttongroup,'UserData')
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
if (get(hObject,'Value') == get(hObject,'Max'))
        setappdata(face_recog_gui,'reject',true);
else
        setappdata(face_recog_gui,'reject',false);
end

end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
 imshow('anonymous.png', hObject);

end

% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2
 imshow('anonymous.png', hObject);

end

function figure1_CreateFcn(hObject, eventdata, handles)

end


% --- Executes during object creation, after setting all properties.
function uibuttongroup4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroup4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
hObject.Visible = 'off';
end


% --- Executes when selected object is changed in uibuttongroup4.
function uibuttongroup4_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup4 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'perceptron'
        neural = 'perceptron';
    case 'pattern'
        neural = 'pettern';
    otherwise
        neural = 'perceptron';        
end
        setappdata(face_recog_gui,'radiobuttonneural',neural);
end

% --- Executes during object creation, after setting all properties.
function plene_b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plene_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
hObject.Visible = 'off';
end