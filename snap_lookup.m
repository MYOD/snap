function snap_lookup
% GUI snap_lookup
% Purpose is to to input house inspection data

%---------------------------------------------------------------------
% Initialization tasks

% define constants
Y_GAP = 0.038;
POPUP_H = 0.03; %popup heights can't be controlled in windows
POPUP_W = 0.35;
LIST_H = 0.78;
LIST_W = 0.8;

% boolean to avoid giving focus back to snap when opening snap_in
OK = false;

% variables to be shared in callbacks
suburb_key = 0;


%  Create and then hide the GUI as it is being constructed.
h_fig = figure('Visible','off','MenuBar','none','toolbar','none',...
    'numbertitle','off','Position',[1,11,300,400],'name','Snap: lookup',...
    'CloseRequestFcn',{@exit_callback},'tag','snap_lookup');

%---------------------------------------------------------------------
%  Construct the components of the figure

LINE_Y= 1- POPUP_H - Y_GAP/2;
suburb_popup = uicontrol('parent',h_fig,'Style','popup',...
    'String',{'Craigmore','Elizabeth East','Elizabeth Vale','Ingle Farm'...
    'Para Hills','Para Vista'},'Units','normalized',...
    'Position',[(1-POPUP_W)/2,LINE_Y,POPUP_W,POPUP_H],'callback',{@suburb_callback});
LINE_Y= LINE_Y - LIST_H - Y_GAP;
address_list = uicontrol('parent',h_fig,'Style','listbox',...
    'Units','normalized','Position', ...
    [(1-LIST_W)/2,LINE_Y,LIST_W,LIST_H]);
LINE_Y= LINE_Y- 3*POPUP_H - Y_GAP/2;
ok_button = uicontrol('parent',h_fig,'Style','pushbutton',...
    'Units','normalized','String','OK','Position',...
    [(1-POPUP_W)/2,LINE_Y,POPUP_W,3*POPUP_H],'callback',{@ok_callback});

%---------------------------------------------------------------------
%  Initialization tasks

% load snap data
data = 0; % avoids runtime error
data_file = 'snap_data/snap_data.mat';
if exist(data_file,'file')
    load(data_file,'data');
else
    errordlg([data_file ' not found!!'],[data_file 'Not Found!!']);
    return;
end

% manually invoke the suburb_callback for first use
suburb_callback(suburb_popup,0);

% Move the GUI to the center of the screen.
movegui(h_fig,'center')

% Make the GUI visible.
set(h_fig,'Visible','on');

% initialise focus
uicontrol(suburb_popup);

%---------------------------------------------------------------------
    %  Callbacks for MYGUI
    
%   the figure has been requested to close
    function exit_callback(source,eventdata)
        
        if  ~OK % not opening snap_in
            % if snap exist refocus on that
            master_handle = findall(0,'tag','snap');
            if ishandle(master_handle)
                figure(master_handle);
            end
        end
        % close sub gui
        delete(h_fig)

    end

%   user changed suburb; show different addresses
    function suburb_callback(source,eventdata)
        
        %find the indices of all properties with this suburb
        suburb = get(source,'string');
        suburb = suburb{get(source,'value')};
        suburb_idx = strcmp(suburb,cellstr(data.suburb));
        
        %create a key to go back to global idx
        tmp = (1:size(data.suburb,1));
        suburb_key = tmp(suburb_idx);
        clear tmp;
            
        % display addresses
        unit_nos = data.unit_no(suburb_idx,:);
        street_nos = data.street_no(suburb_idx,:);
        streets = data.street(suburb_idx,:);
        types = data.st_type(suburb_idx,:);
        %alphabetise by street name
        [streets, order] = sortrows(streets);
        street_nos = street_nos(order,:);
        unit_nos = unit_nos(order,:);
        types = types(order,:);
        addresses = [deblank(unit_nos) repmat('/',size(streets,1),1) ...
            deblank(street_nos) repmat(' ',size(streets,1),1) ...
            deblank(streets) repmat(' ',size(streets,1),1) deblank(types)];
        set(address_list,'value',1,'string', addresses);
        
        %key needs to be re-arranged accordingly
        suburb_key = suburb_key(order);
        
    end

%   user hit OK button
    function ok_callback(source,eventdata)
        
        %open snap_in with desired property
        snap_in(suburb_key(get(address_list,'Value')));
%         %NOTE: known that this will fail if 'string' of address_list is
%         %empty. Don't care.
        
        % indicate that another GUI will open so don't refocus on snap
        OK = true;

        % quit this gui
        exit_callback(h_fig,0);
        
    end

%---------------------------------------------------------------------
%  Utility functions for snap_lookup


end