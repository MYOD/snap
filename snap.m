function snap
% GUI snap
% Master GUI: combines all features of snap.
% snap is designed to record and make direct comparisons across many
% properties.

%---------------------------------------------------------------------
% Initialization tasks

% Allow just one instance of snap
h = findall(0,'tag','snap');
if ~isempty(h)

      %Figure exists so bring Figure to the focus
      figure(h);
      return;
      
end;

% define constants
Y_GAP = 0.1;
BUTTON_H = 0.09; %popup heights can't be controlled in windows
BUTTON_W = 0.35;
TITLE_H = 0.13;
TITLE_W = 0.35;
GUI_W = 300;
GUI_H = 400;

% position the GUI just to the right a bit
screen = get(0,'ScreenSize');

%  Create and then hide the GUI as it is being constructed.
h_fig = figure('Visible','off','MenuBar','none','toolbar','none',...
    'numbertitle','off','Position',[screen(3)/2,(screen(4) - GUI_W)/2, ...
    GUI_W,GUI_H],'name','Snap',...
    'CloseRequestFcn',{@exit_callback},'tag','snap');

%---------------------------------------------------------------------
%  Construct the components of the figure

LINE_Y= 1 - TITLE_H - Y_GAP;
snap_txt = uicontrol('parent',h_fig,'Style','text',...
    'Units','normalized','String','snap','Position',...
    [(1-TITLE_W)/2,LINE_Y,TITLE_W,TITLE_H],'fontSize',30);
LINE_Y= LINE_Y - BUTTON_H - Y_GAP;
add_button = uicontrol('parent',h_fig,'Style','pushbutton',...
    'Units','normalized','String','Add Property','Position',...
    [(1-BUTTON_W)/2,LINE_Y,BUTTON_W,BUTTON_H],'callback',{@add_callback});
LINE_Y= LINE_Y - BUTTON_H - Y_GAP/2;
view_button = uicontrol('parent',h_fig,'Style','pushbutton',...
    'Units','normalized','String','View/Edit Property','Position',...
    [(1-BUTTON_W)/2,LINE_Y,BUTTON_W,BUTTON_H],'callback',{@view_callback});
LINE_Y= LINE_Y - BUTTON_H - Y_GAP/2;
analyse_button = uicontrol('parent',h_fig,'Style','pushbutton',...
    'Units','normalized','String','Analyse','Position',...
    [(1-BUTTON_W)/2,LINE_Y,BUTTON_W,BUTTON_H],'callback',{@analyse_callback});
LINE_Y= LINE_Y - TITLE_H - Y_GAP;
info_txt = uicontrol('parent',h_fig,'Style','text',...
    'Units','normalized','String','','Position',...
    [(1-2*TITLE_W)/2,LINE_Y,2*TITLE_W,1.4*TITLE_H],'fontSize',14);

%---------------------------------------------------------------------
%  Initialization tasks

% % load snap data
% data = 0; % avoids runtime error
% data_file = 'snap_data/snap_data.mat';
% if exist(data_file,'file')
%     load(data_file,'data');
% else
%     errordlg([data_file 'not found!!'],[data_file 'Not Found!!']);
% end


% Move the GUI to the center of the screen.
% movegui(h_fig,'east')

% Make the GUI visible.
set(h_fig,'Visible','on');

% initialise focus
uicontrol(add_button);

%---------------------------------------------------------------------
%  Callbacks

%   the figure has been requested to close
    function exit_callback(source,eventdata)
        
        % to display a question dialog box
        selection = questdlg('Do you want to upload a copy of your data?',...
            'Upload Data?',...
            'Yes','No','Cancel','Yes');
        switch selection,
            case 'Yes',
                
                git_upload();
                
            case 'Cancel'
                %don't even quit
                return
        end
        
        %close sub-GUIs if any open
        filter_handle = findall(0,'tag','snap_in');
        filter_handle = [filter_handle; findall(0,'tag','snap_filter')];
        filter_handle = [filter_handle; findall(0,'tag','snap_lookup')];
        delete(filter_handle);
                
        % close the gui
        delete(h_fig);
        
    end

%   user hit Add Property button
    function add_callback(source,eventdata)
        
        % check if it exists
        in_handle = findall(0,'tag','snap_in');
        
        if ~isempty(in_handle)
            % already open, bring to focus
            figure(in_handle);
        else
            %open snap_in as a blank canvas
            snap_in(0);
            
        end
        
    end

%   user hit View/Edit Property button
    function view_callback(source,eventdata)
        
        %check if sub-GUI is already open
        lookup_handle = findall(0,'tag','snap_lookup');
        
        if ~isempty(lookup_handle)
            %already open, bring to focus
            figure(lookup_handle);
        else
            %open snap_lookup
            snap_lookup;
        end
        
    end

%   user hit Analyse button
    function analyse_callback(source,eventdata)
        
        %check if sub-GUI is already open
        filter_handle = findall(0,'tag','snap_filter');
        
        if ~isempty(filter_handle)
           %already open, bring to focus
           figure(filter_handle);
        else
            %   open snap_filter
            snap_filter;
        end
    end


%---------------------------------------------------------------------
%  Utility functions for snap

    function git_upload()

        % inform user of intention and that this will take time
        set(info_txt,'string',...
            sprintf('PLEASE WAIT!\nsnap data being uploaded to web'));
        
        %for the silencing of system commands
        if ispc
            oblivion = 'NUL';
        else
            oblivion = '/dev/null';
        end
        
        data_path = 'snap_data'; %relative path to data folder
        data_file = 'snap_data.mat';
        % ensure folder exists
        if ~ exist(data_path,'dir')
            errordlg([data_path 'not found!!'],[data_file 'Folder Not Found!!']);
            return;
        end
        r = cd(data_path);
        % ensure file exist
        if ~ exist(data_file,'file')
            errordlg([data_file 'not found!!'],[data_file 'File Not Found!!']);
            return;
        end
%       commit changes
        system(['git commit -a -m "snap auto update" > ' ...
            oblivion]);
%       push changes
        system(['git push origin master > ' oblivion]);        
        cd(r);                
        
    end


end