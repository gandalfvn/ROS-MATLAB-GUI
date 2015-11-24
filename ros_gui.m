function varargout = ros_gui(varargin)
  % ROS_GUI MATLAB code for ros_gui.fig
  %      ROS_GUI, by itself, creates a new ROS_GUI or raises the existing
  %      singleton*.
  %
  %      H = ROS_GUI returns the handle to a new ROS_GUI or the handle to
  %      the existing singleton*.
  %
  %      ROS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
  %      function named CALLBACK in ROS_GUI.M with the given input arguments.
  %
  %      ROS_GUI('Property','Value',...) creates a new ROS_GUI or raises the
  %      existing singleton*.  Starting from the left, property value pairs are
  %      applied to the GUI before ros_gui_OpeningFcn gets called.  An
  %      unrecognized property name or invalid value makes property application
  %      stop.  All inputs are passed to ros_gui_OpeningFcn via varargin.
  %
  %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
  %      instance to run (singleton)".
  %
  % See also: GUIDE, GUIDATA, GUIHANDLES

  % Edit the above text to modify the response to help ros_gui

  % Last Modified by GUIDE v2.5 23-May-2015 00:55:56

  % Begin initialization code - DO NOT EDIT
  gui_Singleton = 1;
  gui_State = struct('gui_Name',       mfilename, ...
					 'gui_Singleton',  gui_Singleton, ...
					 'gui_OpeningFcn', @ros_gui_OpeningFcn, ...
					 'gui_OutputFcn',  @ros_gui_OutputFcn, ...
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

% --- Executes just before ros_gui is made visible.
function ros_gui_OpeningFcn(hObject, eventdata, handles, varargin)
  % This function has no output args, see OutputFcn.
  % hObject    handle to figure
  % eventdata  reserved - to be defined in a future version of MATLAB
  % handles    structure with handles and user data (see GUIDATA)
  % varargin   command line arguments to ros_gui (see VARARGIN)

  % Choose default command line output for ros_gui
  handles.output = hObject;
  % Update handles structure
  guidata(hObject, handles);

% UIWAIT makes ros_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = ros_gui_OutputFcn(hObject, eventdata, handles)
  % varargout  cell array for returning output args (see VARARGOUT);
  % Get default command line output from handles structure
  handles.TopicList.String = rostopic('list');
  handles.ActiveTopicList.String = rostopic('list');
  handles.NodeList.String = rosnode('list');
  handles.ActiveTopicList.Enable = 'on';
  handles.NewTopicBox.Enable = 'off';
  handles.MessageType.Enable = 'off';
  handles.MessageType.String = rosmsg('list');
end

% --- Executes on selection change in TopicList.
function TopicList_Callback(hObject, eventdata, handles)
  n = hObject.Value;                          % gets the index of selected value in TopicList
  topic = strjoin(hObject.String(n));         % geth the name of the topic
  info = rostopic('info', topic);

  handles.TopicType.String = info.MessageType;    % updates the TopicType value
  try
    handles.PubList.Enable = 'on';
    handles.PubList.String = info.Publishers.NodeName;
  catch
    handles.PubList.Enable = 'off';
  end
  try
    handles.SubList.Enable = 'on';
    handles.SubList.String = info.Subscribers.NodeName;
  catch
    handles.SubList.Enable = 'off';
  end

  % if a node is created or destroyed while the GUI is running
  tmp = hObject.Value;
  hObject.String = rostopic('list');
  hObject.Value = tmp;

  handles.MsgInfo.String = sprintf('\n%s', rosmsg('show', handles.TopicType.String));      % displays message type info
end

% --- Executes during object creation, after setting all properties.
function TopicList_CreateFcn(hObject, eventdata, handles)
  % hObject    handle to TopicList (see GCBO)
  % eventdata  reserved - to be defined in a future version of MATLAB
  % handles    empty - handles not created until after all CreateFcns called
  % Hint: listbox controls usually have a white background on Windows.
  %       See ISPC and COMPUTER.
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end
end


% --- Executes during object deletion, before destroying properties.
function TopicList_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to TopicList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
  % hObject    handle to figure1 (see GCBO)
  % eventdata  reserved - to be defined in a future version of MATLAB
  % handles    structure with handles and user data (see GUIDATA)
  rosshutdown;
end

% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
  % hObject    handle to figure1 (see GCBO)
  % eventdata  reserved - to be defined in a future version of MATLAB
  % handles    empty - handles not created until after all CreateFcns called
  rosinit('localhost', 11311);
end

% --- Executes on selection change in NodeList.
function NodeList_Callback(hObject, eventdata, handles)
  % if a node is created or destroyed while the GUI is running
  tmp = hObject.Value;
  hObject.String = rosnode('list');
  hObject.Value = tmp;
end

% --- Executes during object creation, after setting all properties.
function NodeList_CreateFcn(hObject, eventdata, handles)
  % Hint: listbox controls usually have a white background on Windows.
  %       See ISPC and COMPUTER.
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end
end

% --- Executes on selection change in PubList.
function PubList_Callback(hObject, eventdata, handles)
end

% --- Executes during object creation, after setting all properties.
function PubList_CreateFcn(hObject, eventdata, handles)
  % Hint: popupmenu controls usually have a white background on Windows.
  %       See ISPC and COMPUTER.
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end
end


% --- Executes on selection change in SubList.
function SubList_Callback(hObject, eventdata, handles)
end

% --- Executes during object creation, after setting all properties.
function SubList_CreateFcn(hObject, eventdata, handles)
  % Hint: popupmenu controls usually have a white background on Windows.
  %       See ISPC and COMPUTER.
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end
end


function PubMessage_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of PubMessage as text
%        str2double(get(hObject,'String')) returns contents of PubMessage as a double

end

% --- Executes during object creation, after setting all properties.
function PubMessage_CreateFcn(hObject, eventdata, handles)
  % Hint: edit controls usually have a white background on Windows.
  %       See ISPC and COMPUTER.
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end

end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
  if handles.TopicActive.Value == 1
    n = handles.ActiveTopicList.Value;
    topic = strjoin(handles.ActiveTopicList.String(n));
    msginfo = rostopic('info', topic);
    msgtype = msginfo.MessageType;
    
  elseif handles.TopicNew.Value == 1
    topic = handles.NewTopicBox.String;
    n = handles.MessageType.Value;
    msgtype = strjoin(handles.MessageType.String(n));
    
  end
  assignin('base', 'topic', topic);
  assignin('base', 'msgtype', msgtype);
  evalin('base', 'pub = rospublisher(topic, msgtype);');
  evalin('base', 'msg = rosmessage(msgtype);');
  
  for i=1:size(handles.PubMessage.String, 1)
    cmd = strcat('msg.', handles.PubMessage.String(i,:));
    evalin('base', cmd);
  end
  
  evalin('base', 'send(pub, msg);');

end

% --- Executes on selection change in ActiveTopicList.
function ActiveTopicList_Callback(hObject, eventdata, handles)

  % Update the topic list to check for new nodes and topics
  tmp = hObject.Value;
  hObject.String = rostopic('list');
  hObject.Value = tmp;

  topic = get(hObject, 'String');
  n = get(hObject, 'Value');
  info = rostopic('info', strjoin(topic(n)));
  type = info.MessageType;
  handles.PubMessage.String = rosmsg('show', type);
end

% --- Executes during object creation, after setting all properties.
function ActiveTopicList_CreateFcn(hObject, eventdata, handles)
  % Hint: popupmenu controls usually have a white background on Windows.
  %       See ISPC and COMPUTER.
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end
end

function NewTopicBox_Callback(hObject, eventdata, handles)
end

% --- Executes during object creation, after setting all properties.
function NewTopicBox_CreateFcn(hObject, eventdata, handles)
  % Hint: edit controls usually have a white background on Windows.
  %       See ISPC and COMPUTER.
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end
end


% --- Executes on button press in TopicActive.
function TopicActive_Callback(hObject, eventdata, handles)
  handles.NewTopicBox.Enable = 'off';
  handles.ActiveTopicList.Enable = 'on';
  handles.MessageType.Enable = 'off';
% Hint: get(hObject,'Value') returns toggle state of TopicActive
end


% --- Executes on selection change in AllTopics.
function AllTopics_Callback(hObject, eventdata, handles)
end

% --- Executes during object creation, after setting all properties.
function AllTopics_CreateFcn(hObject, eventdata, handles)
  % Hint: popupmenu controls usually have a white background on Windows.
  %       See ISPC and COMPUTER.
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end
end


% --- Executes on selection change in MessageType.
function MessageType_Callback(hObject, eventdata, handles)
  n = hObject.Value;
  msgtype = strjoin(hObject.String(n));
  handles.PubMessage.String = rosmsg('show', msgtype);
end

% --- Executes during object creation, after setting all properties.
function MessageType_CreateFcn(hObject, eventdata, handles)
  % Hint: popupmenu controls usually have a white background on Windows.
  %       See ISPC and COMPUTER.
  if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
  end
end


% --- Executes on button press in TopicNew.
function TopicNew_Callback(hObject, eventdata, handles)
  handles.ActiveTopicList.Enable = 'off';
  handles.NewTopicBox.Enable = 'on';
  handles.MessageType.Enable = 'on';
% Hint: get(hObject,'Value') returns toggle state of TopicNew
end

% --- Executes during object creation, after setting all properties.
function uibuttongroup1_CreateFcn(hObject, eventdata, handles)
end
