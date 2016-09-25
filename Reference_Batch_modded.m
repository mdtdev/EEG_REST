function varargout = Reference_Batch_modded(varargin)
% REFERENCE_BATCH M-file for Reference_Batch.fig
%      REFERENCE_BATCH, by itself, creates a new REFERENCE_BATCH or raises the existing
%      singleton*.
%
%      H = REFERENCE_BATCH returns the handle to a new REFERENCE_BATCH or the handle to
%      the existing singleton*.
%
%      REFERENCE_BATCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REFERENCE_BATCH.M with the given input arguments.
%
%      REFERENCE_BATCH('Property','Value',...) creates a new REFERENCE_BATCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Reference_Batch_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Reference_Batch_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help Reference_Batch

% Last Modified by GUIDE v2.5 05-Jan-2010 19:22:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Reference_Batch_OpeningFcn, ...
    'gui_OutputFcn',  @Reference_Batch_OutputFcn, ...
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


% --- Executes just before Reference_Batch is made visible.
function Reference_Batch_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Reference_Batch (see VARARGIN)

% Choose default command line output for Reference_Batch
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Reference_Batch wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Reference_Batch_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global File_List;
% uigetfile(,'MultiSelect',selectmode)
[filename, pathname] = uigetfile('*.mat', 'Pick an M-file', 'MultiSelect', 'on');
if isequal(filename,0)
    return;
end
% File_List=fullfile(pathname, filename);
if iscell(filename)
    for i=1:length(filename)
        File_List{i}=strcat(pathname,filename{i})

    end
else
    File_List{1}=strcat(pathname,filename);
end
%--------------------
%    Num_cluster=length(File_List);
% 
%     for k=1:Num_cluster
%         List_str{k}=strcat(File_List{k},'Not Processed');
%         
%     end

    set(handles.listbox_files, 'String', File_List);
    set(handles.listbox_files, 'Value', 1);


%----------------------

% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global File_List;
Ref_electrode=-1;
cur_ref_mode=2; % get(handles.popupmenu1,'value');   % MADE CHANGE HERE!!!!!!

switch cur_ref_mode
    case 1
        Ref_electrode=-1;
        G=load('Lead_Field.dat');
        G=G';
%         G=G.Lead_Field;
        G_ave=mean(G);
        G_ave=G-repmat(G_ave,size(G,1),1);
        Ra=G*pinv(G_ave,0.05);   %the value 0.05 is for real data; for simulated data, it may be set as zero.
        clear G;
        clear G_ave;
        for i=1:length(File_List)
%            set(handles.listbox_files, 'String', File_List);
           set(handles.listbox_files, 'Value', i);
            try
                cur_file=File_List{i};
                [pathstr,name,ext,versn] = fileparts(cur_file);
                 save_dir=strcat(pathstr,'\');
                save_dir=strcat(save_dir,name);
                           
                save_dir=strcat(save_dir,'_REST_Ref.mat');
%                 save_dir=strcat
                cur_data=load(cur_file);
                Fields_list=fields(cur_data);
                %---------------------
                Ref_data=[];
                for k=1:length(Fields_list)
                    cur_var=cur_data.(Fields_list{k});

                    cur_ave=mean(cur_var);
                    cur_var=cur_var-repmat(cur_ave,size(cur_var,1),1);
                    cur_var=Ra*cur_var;
                    Ref_data.(Fields_list{k})=cur_var;
                end
                save(save_dir, '-struct', 'Ref_data');
            catch
               disp(['error occuring 1 for ' File_List{i}]);
            end

            %---------------------
        end

    case 2

        for i=1:length(File_List)
            try
                cur_file=File_List{i};
                [pathstr,name,ext,versn] = fileparts(cur_file);
                save_dir=strcat(pathstr,name);
                save_dir=strcat(save_dir,'_AVERAGE_Ref.mat');
                cur_data=load(cur_file);
                Fields_list=fields(cur_data);
                %---------------------
                Ref_data=[];
                for k=1:length(Fields_list)
                    cur_var=cur_data.(Fields_list{k});

                    cur_ave=mean(cur_var);
                    cur_var=cur_var-repmat(cur_ave,size(cur_var,1),1);
                    Ref_data.(Fields_list{k})=cur_var;
                end
                save(save_dir, '-struct', 'Ref_data');
                
            catch
              disp(['error occuring 2 for ' File_List{i}]);
            end

            %---------------------
        end
    case 3
        for i=1:length(File_List)
            try
                cur_file=File_List{i};
                [pathstr,name,ext,versn] = fileparts(cur_file);
                save_dir=strcat(pathstr,name);
                save_dir=strcat(save_dir,'_CZ_Ref.mat');
                cur_data=load(cur_file);
                Fields_list=fields(cur_data);
                %---------------------
                Ref_data=[];
                for k=1:length(Fields_list)
                    cur_var=cur_data.(Fields_list{k});

                    %             cur_ave=mean(cur_var);
                    cur_var=cur_var-repmat(cur_var(end,:),size(cur_var,1),1);
                    Ref_data.(Fields_list{k})=cur_var;
                end
                save(save_dir, '-struct', 'Ref_data');
            catch
              disp(['error occuring 3 for ' File_List{i}]);
            end

            %---------------------
        end
    case 4
      for i=1:length(File_List)
            try
                cur_file=File_List{i};
                [pathstr,name,ext,versn] = fileparts(cur_file);
                save_dir=strcat(pathstr,name);
                save_dir=strcat(save_dir,'_LM_Ref.mat');
                cur_data=load(cur_file);
                Fields_list=fields(cur_data);
                %---------------------
                Ref_data=[];
                for k=1:length(Fields_list)
                    cur_var=cur_data.(Fields_list{k});

                    cur_ave=mean(cur_var([57,100],:));
                    cur_var=cur_var-repmat(cur_ave(end,:),size(cur_var,1),1);
                    Ref_data.(Fields_list{k})=cur_var;                                          
                end
                save(save_dir, '-struct', 'Ref_data');
            catch
              disp(['error occuring 4 for ' File_List{i}]);
            end

            %---------------------
      end
     
        ;
end

 h = msgbox('111 Calculation completed.');




% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global File_List;
File_List={};



% --- Executes on selection change in listbox_files.
function listbox_files_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox_files contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_files


% --- Executes during object creation, after setting all properties.
function listbox_files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


