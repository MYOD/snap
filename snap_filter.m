function snap_filter
% GUI snap_filter
% Purpose is to filter and sort properties for simple and easy analysis

%---------------------------------------------------------------------
% Initialization tasks

% the headings control the data in the table
table_headings = {};
table_datum = {};
table_defaults = {'Street Number', 'Street Name','Street Type', 'Suburb',...
                   'Sold Price', 'Sold Date'};
% define constants
% main figure dimensions
Y_GAP = 0.02;
X_GAP = 0.02;
FULL_W = 0.96;
INFO_H = 0.12;
TAB_W = 0.09;
TAB_H = 0.03;
PANEL_H = 0.2;
SMALL_TABLE = [X_GAP (INFO_H+2*Y_GAP) FULL_W 0.57];
LARGE_TABLE = [X_GAP (INFO_H+2*Y_GAP) FULL_W (SMALL_TABLE(4)+ PANEL_H)];
% top panel dimensions
% define constants
% main figure dimensions
tY_GAP = 0.02;
tX_GAP = 0.02;
tLIST_W = 0.2;
tFULL_H = (1 - 2*tY_GAP);
tBUTTON_W = 0.16;
tBUTTON_H = 0.18;

% colour constants
BG_COLOUR = [0.9412, 0.9412, 0.912];
LITE_COLOUR = [0.8, 0.8, 0.8];

% standard string length
STR = 20;
% string arrays
HIGH_STRS = repmat(' ',6,STR); idx = 1;
str='Address'; HIGH_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Build Stats'; HIGH_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Comments'; HIGH_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Features'; HIGH_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Inspection'; HIGH_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Sales'; HIGH_STRS(idx,1:length(str)) = str;
ADDRESS_STRS = repmat(' ',5,STR); idx = 1;
str='Unit Number'; ADDRESS_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Street Number'; ADDRESS_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Street Name'; ADDRESS_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Street Type'; ADDRESS_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Suburb'; ADDRESS_STRS(idx,1:length(str)) = str;
BUILD_STRS = repmat(' ',7,STR); idx = 1;
str='Year Built'; BUILD_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Year Renovated'; BUILD_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Modern'; BUILD_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Maisonnette'; BUILD_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Land Area'; BUILD_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Living Area'; BUILD_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Frontage'; BUILD_STRS(idx,1:length(str)) = str;
FEATURES_STRS = repmat(' ',12,STR); idx = 1;
str='Construction'; FEATURES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Roofing'; FEATURES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Front Facade'; FEATURES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Front Yard'; FEATURES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Parking'; FEATURES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Flooring'; FEATURES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Kitchen'; FEATURES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Bathroom'; FEATURES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Bedroom'; FEATURES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Climate Control'; FEATURES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Back Yard'; FEATURES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Other'; FEATURES_STRS(idx,1:length(str)) = str;
CONSTRUCTION_STRS = repmat(' ',2,STR); idx = 1;
str='Construction'; CONSTRUCTION_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='C (Construction)'; CONSTRUCTION_STRS(idx,1:length(str)) = str;
ROOFING_STRS = repmat(' ',3,STR); idx = 1;
str='Roofing'; ROOFING_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='C (Roofing)'; ROOFING_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='D (Roofing)'; ROOFING_STRS(idx,1:length(str)) = str;
FRONT_YARD_STRS = repmat(' ',3,STR); idx = 1;
str='C (Front Yard)'; FRONT_YARD_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='D (Front Yard)'; FRONT_YARD_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='S (Front Yard)'; FRONT_YARD_STRS(idx,1:length(str)) = str;
FRONT_FACADE_STRS = repmat(' ',3,STR); idx = 1;
str='Front Facade'; FRONT_FACADE_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='C (Front Facade)'; FRONT_FACADE_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='D (Front Facade)'; FRONT_FACADE_STRS(idx,1:length(str)) = str;
PARKING_STRS = repmat(' ',7,STR); idx = 1;
str='# Garages'; PARKING_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='# Carports'; PARKING_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='# Secure'; PARKING_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='# Off-street'; PARKING_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='C (Parking)'; PARKING_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='D (Parking)'; PARKING_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Dual-Access?'; PARKING_STRS(idx,1:length(str)) = str;
FLOORING_STRS = repmat(' ',7,STR); idx = 1;
str='Tiles?'; FLOORING_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Slates?'; FLOORING_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Floorboards?'; FLOORING_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Vinyl?'; FLOORING_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Carpet?'; FLOORING_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='C (Flooring)'; FLOORING_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='D (Flooring)'; FLOORING_STRS(idx,1:length(str)) = str;
KITCHEN_STRS = repmat(' ',5,STR); idx = 1;
str='Open Living?'; KITCHEN_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Pantry?'; KITCHEN_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='C (Kitchen)'; KITCHEN_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='D (Kitchen)'; KITCHEN_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='S (Kitchen)'; KITCHEN_STRS(idx,1:length(str)) = str;
BATHROOM_STRS = repmat(' ',8,STR); idx = 1;
str='# Baths'; BATHROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='# Showers'; BATHROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='# Toilets'; BATHROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='# Spas'; BATHROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='C (Bathroom)'; BATHROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='D (Bathroom)'; BATHROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='S (Bathroom)'; BATHROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Heatlamps?'; BATHROOM_STRS(idx,1:length(str)) = str;
BEDROOM_STRS = repmat(' ',9,STR); idx = 1;
str='# Bedrooms'; BEDROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='# WIRs'; BEDROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='# BIRs'; BEDROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='# Kid Rooms'; BEDROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='# Ensuites'; BEDROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='# BR Toilets'; BEDROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='C (Bedroom)'; BEDROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='D (Bedroom)'; BEDROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='S (Bedroom)'; BEDROOM_STRS(idx,1:length(str)) = str;
CLIMATE_STRS = repmat(' ',3,STR); idx = 1;
str='Heating'; CLIMATE_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Cooling'; CLIMATE_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Coverage'; CLIMATE_STRS(idx,1:length(str)) = str;
BACK_YARD_STRS = repmat(' ',12,STR); idx = 1;
str='C (Back Yard)'; BACK_YARD_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='D (Back Yard)'; BACK_YARD_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='S (Back Yard)'; BACK_YARD_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Pergola?'; BACK_YARD_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Verandah?'; BACK_YARD_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='C (Verandah)'; BACK_YARD_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='D (Verandah)'; BACK_YARD_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='S (Verandah)'; BACK_YARD_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Grass?'; BACK_YARD_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='C (Grass)'; BACK_YARD_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='D (Grass)'; BACK_YARD_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='S (Grass)'; BACK_YARD_STRS(idx,1:length(str)) = str;
OTHER_STRS = repmat(' ',10,STR); idx = 1;
str='Swimming Pool?'; OTHER_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='C (Swimming Pool)'; OTHER_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='D (Swimming Pool)'; OTHER_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='S (Swimming Pool)'; OTHER_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Sheds?'; OTHER_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Shed Types'; OTHER_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Granny Flat?'; OTHER_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='C (Granny Flat)'; OTHER_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='D (Granny Flat)'; OTHER_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='S (Granny Flat)'; OTHER_STRS(idx,1:length(str)) = str;
INSPECTION_STRS = repmat(' ',3,STR); idx = 1;
str='Date (Inspection)'; INSPECTION_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Start (Inspection)'; INSPECTION_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='End (Inspection)'; INSPECTION_STRS(idx,1:length(str)) = str;
SALES_STRS = repmat(' ',12,STR); idx = 1;
str='Old Ask Low ($)'; SALES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Old Ask High ($)'; SALES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Old Asking Date'; SALES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Old Agent'; SALES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Old Agency'; SALES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Curr Ask Low ($)'; SALES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Curr Ask High ($)'; SALES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Curr Asking Date'; SALES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Curr Agent'; SALES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Curr Agency'; SALES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Sold Price ($)'; SALES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Sold Date'; SALES_STRS(idx,1:length(str)) = str;
NOTES_STRS = repmat(' ',7,STR); idx = 1;
str='Reno Ideas'; NOTES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='General'; NOTES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Suburb Notes'; NOTES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Street Notes'; NOTES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Local Neighbourhood'; NOTES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Agent Notes'; NOTES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Buyer Types'; NOTES_STRS(idx,1:length(str)) = str; idx = idx + 1;

%---------------------------------------------------------------------
%  Create and then hide the GUI as it is being constructed.
h_fig = figure('Visible','off','MenuBar','none','toolbar','none',...
    'numbertitle','off','Position',[1,1,720,650],'name','Snap: filter',...
    'CloseRequestFcn',{@exit_callback});

%---------------------------------------------------------------------
%  Construct the components of the figure

% top tab buttons components
tmp_x = X_GAP;
filter_tab = uicontrol('parent',h_fig,'Style','pushbutton',...
    'String','Filter','Units','normalized',...
    'Position',[tmp_x,LARGE_TABLE(4)+INFO_H+3*Y_GAP,TAB_W,TAB_H],...
    'Callback',{@filter_callback});
tmp_x = tmp_x + TAB_W;
sort_tab = uicontrol('parent',h_fig,'Style','pushbutton',...
    'String','Sort','Units','normalized',...
    'Position',[tmp_x,LARGE_TABLE(4)+INFO_H+3*Y_GAP,TAB_W,TAB_H],...
    'Callback',{@sort_callback});
tmp_x = tmp_x + TAB_W;
display_tab = uicontrol('parent',h_fig,'Style','pushbutton',...
    'String','Display','Units','normalized',...
    'Position',[tmp_x,LARGE_TABLE(4)+INFO_H+3*Y_GAP,TAB_W,TAB_H],...
    'Callback',{@display_callback});
tmp_x = tmp_x + TAB_W;
hide_tab = uicontrol('parent',h_fig,'Style','pushbutton',...
    'String','Hide','Units','normalized',...
    'Position',[tmp_x,LARGE_TABLE(4)+INFO_H+3*Y_GAP,TAB_W,TAB_H],...
    'Callback',{@hide_callback});

% top panel components
filter_panel = uipanel('position',...
    [X_GAP, SMALL_TABLE(2)+SMALL_TABLE(4)+Y_GAP, FULL_W, PANEL_H],...
    'Units','normalized');
sort_panel = uipanel('position',...
    [X_GAP, SMALL_TABLE(2)+SMALL_TABLE(4)+Y_GAP, FULL_W, PANEL_H],...
    'Units','normalized');
display_panel = uipanel('position',...
    [X_GAP, SMALL_TABLE(2)+SMALL_TABLE(4)+Y_GAP, FULL_W, PANEL_H],...
    'Units','normalized');

% table component
table = uitable('Parent', h_fig, 'Units','normalized',...
    'Position', SMALL_TABLE,'visible','on','RearrangeableColumns','on');

%%% ---CODE to turn on automatic sorting
jscrollpane = findjobj(table);
jtable = jscrollpane.getViewport.getView;

% Now turn the JIDE sorting on
jtable.setSortable(true);		% or: set(jtable,'Sortable','on');
jtable.setAutoResort(true);
jtable.setMultiColumnSortable(true);
jtable.setPreserveSelectionsAfterSorting(true);
%---------

% bottom panel components
info_panel = uipanel('title','Info','position',...
    [X_GAP, Y_GAP, FULL_W, INFO_H],'Units','normalized');


%---------------------------------------------------------------------
%  Construct the components of the display panel

% list components
high_list = uicontrol('parent',display_panel,'Style','listbox',...
    'Units','normalized','String',HIGH_STRS,'Position', ...
    [tX_GAP tY_GAP tLIST_W tFULL_H],'min',0,'max',1,'Callback',...
    {@high_callback});
tmp_x = 2*tX_GAP + tLIST_W;
med_list = uicontrol('parent',display_panel,'Style','listbox',...
    'Units','normalized','Position', ...
    [tmp_x tY_GAP tLIST_W tFULL_H],'min',0,'max',2,'Callback',...
    {@med_callback});
tmp_x = tmp_x + tX_GAP + tLIST_W;
low_list = uicontrol('parent',display_panel,'Style','listbox',...
    'Units','normalized','Visible','off','Position', ...
    [tmp_x tY_GAP tLIST_W tFULL_H],'min',0,'max',2);

% button components
y_incr = (1 - 3*tBUTTON_H)/4; % space buttons equidistant vertically
line_y = 3*y_incr + 2*tBUTTON_H;
tmp_x = tmp_x + tX_GAP + tLIST_W;
add_button = uicontrol('parent',display_panel,'Style','pushbutton',...
    'Units','normalized','String','Add/Remove','Position', ...
    [tmp_x line_y tBUTTON_W tBUTTON_H],'callback',{@add_callback});
line_y = 2*y_incr + tBUTTON_H;
none_button = uicontrol('parent',display_panel,'Style','pushbutton',...
    'Units','normalized','String','Clear All','Position', ...
    [tmp_x line_y tBUTTON_W tBUTTON_H],'callback',{@none_callback});
line_y = y_incr;
default_button = uicontrol('parent',display_panel,'Style','pushbutton',...
    'Units','normalized','String','Show Defaults','Position', ...
    [tmp_x line_y tBUTTON_W tBUTTON_H],'callback',{@default_callback});



%---------------------------------------------------------------------
%  Initialization tasks

%%% initialise table
% set up table

set(table,'ColumnWidth','auto');
set(table, 'RowName', []); % don't need row labels

% alternate row colours
foregroundColor = [0.3 0.3 0.3]; % 0 is white, 1 is black
set(table, 'ForegroundColor', foregroundColor);
backgroundColor = [0.53 0.81 0.92; .63 .91 1]; %blue
set(table, 'BackgroundColor', backgroundColor);

% allow user to tick first column
% set(handles.table, 'ColumnEditable', ...
%     [true false false false false false false]);
%%%% end initialise table

% load snap data
data = 0; % avoids runtime error
data_file = 'snap_data/snap_data.mat';
if exist(data_file,'file')
    load(data_file,'data');
else
    errordlg([data_file 'not found!!'],[data_file 'Not Found!!']);
end

% By default, start on filter tab
display_callback(filter_tab,0);

% display default table columns
default_callback(default_button,0);

% Move the GUI to the center of the screen.
movegui(h_fig,'center')

% Make the GUI visible.
set(h_fig,'Visible','on');


%---------------------------------------------------------------------
%  Callbacks

%   the figure has been requested to close
    function exit_callback(source,eventdata)
        
        delete(h_fig);
        
    end

%   user selected the filter tab
    function filter_callback(source,eventdata)
        
        %       make tab colour look 'selected'
        set(filter_tab,'backgroundColor',BG_COLOUR);
        set(sort_tab,'backgroundColor',LITE_COLOUR);
        set(display_tab,'backgroundColor',LITE_COLOUR);
        set(hide_tab,'backgroundColor',LITE_COLOUR);
        
        %   make this panel the only visible
        set(filter_panel,'visible','on');
        set(sort_panel,'visible','off');
        set(display_panel,'visible','off');
        
        % minimise the table
        set(table,'position',SMALL_TABLE);
        
    end

%   user selected the sort tab
    function sort_callback(source,eventdata)
        
        %       make tab colour look 'selected'
        set(filter_tab,'backgroundColor',LITE_COLOUR);
        set(sort_tab,'backgroundColor',BG_COLOUR);
        set(display_tab,'backgroundColor',LITE_COLOUR);
        set(hide_tab,'backgroundColor',LITE_COLOUR);
        
        %   make this panel the only visible
        set(filter_panel,'visible','off');
        set(sort_panel,'visible','on');
        set(display_panel,'visible','off');
        
        % minimise the table
        set(table,'position',SMALL_TABLE);
        
    end

%   user selected the display tab
    function display_callback(source,eventdata)
        
        %       make tab colour look 'selected'
        set(filter_tab,'backgroundColor',LITE_COLOUR);
        set(sort_tab,'backgroundColor',LITE_COLOUR);
        set(display_tab,'backgroundColor',BG_COLOUR);
        set(hide_tab,'backgroundColor',LITE_COLOUR);
        
        %   make this panel the only visible
        set(filter_panel,'visible','off');
        set(sort_panel,'visible','off');
        set(display_panel,'visible','on');
        
        % minimise the table
        set(table,'position',SMALL_TABLE);
        
        % by default, call the high and medium level list callback
        high_callback(high_list,0);
        med_callback(med_list,0);
        
    end

%   user selected the hide tab
    function hide_callback(source,eventdata)
        
        %       make tab colour look 'selected'
        set(filter_tab,'backgroundColor',LITE_COLOUR);
        set(sort_tab,'backgroundColor',LITE_COLOUR);
        set(display_tab,'backgroundColor',LITE_COLOUR);
        set(hide_tab,'backgroundColor',BG_COLOUR);
        
        %   hide the panels
        set(filter_panel,'visible','off');
        set(sort_panel,'visible','off');
        set(display_panel,'visible','off');
        
        %         expand the table
        set(table,'position',LARGE_TABLE);
        
    end

%   user made a selection in the high level display list
    function high_callback(source, eventdata)
        
        %         change options of med list
        %           do not allow a default value of 1
        selection = deblank(HIGH_STRS(get(high_list,'Value'),:));
        
        % reset value to 1
        set(med_list,'Value',1);
        
        switch selection
            case 'Address'
                set(med_list,'string',ADDRESS_STRS);
                set(med_list,'max',2); %enable multiple selection
            case 'Build Stats'
                set(med_list,'string',BUILD_STRS);
                set(med_list,'max',2); %enable multiple selection
            case 'Comments'
                set(med_list,'string',NOTES_STRS);
                set(med_list,'max',2); %enable multiple selection
            case 'Features'
                set(med_list,'string',FEATURES_STRS);
                set(med_list,'max',0); %disable multiple selection
            case 'Inspection'
                set(med_list,'string',INSPECTION_STRS);
                set(med_list,'max',2); %enable multiple selection
            case 'Sales'
                set(med_list,'string',SALES_STRS);
                set(med_list,'max',2); %enable multiple selectionn
        end
        
        % now that medium list has changed, better prompt it's callback
        med_callback(med_list,0);
        
    end

%   user made a selection in the medium level display list
    function med_callback(source,eventdata)
        
        %         change options of low list
        %           do not allow a default value of 1
        selection = deblank(HIGH_STRS(get(high_list,'Value'),:));
        
        
        
        switch selection
            case 'Features' % only one requiring low level list
                
                % reset value to 1
                set(low_list,'Value',1);
                
                med_select = ...
                    deblank(FEATURES_STRS(get(med_list,'Value'),:));
                
                switch med_select
                    case 'Construction'
                        set(low_list,'string',CONSTRUCTION_STRS);
                    case 'Roofing'
                        set(low_list,'string',ROOFING_STRS);
                    case 'Front Facade'
                        set(low_list,'string',FRONT_FACADE_STRS);
                    case 'Front Yard'
                        set(low_list,'string',FRONT_YARD_STRS);
                    case 'Parking'
                        set(low_list,'string',PARKING_STRS);
                    case 'Flooring'
                        set(low_list,'string',FLOORING_STRS);
                    case 'Kitchen'
                        set(low_list,'string',KITCHEN_STRS);
                    case 'Bathroom'
                        set(low_list,'string',BATHROOM_STRS);
                    case 'Bedroom'
                        set(low_list,'string',BEDROOM_STRS);
                    case 'Climate Control'
                        set(low_list,'string',CLIMATE_STRS);
                    case 'Back Yard'
                        set(low_list,'string',BACK_YARD_STRS);
                    case 'Other'
                        set(low_list,'string',OTHER_STRS);
                end
                
                % make sure list is visible
                set(low_list,'Visible','on');
                
            otherwise
                % make sure list is not visible
                set(low_list,'Visible','off');
        end
    end

%   user pressed the add/remove button in display panel
%   add or remove the selected columns
    function add_callback(source, eventdata)
        
        % only look at low_list if visible
        if strcmpi(get(low_list,'Visible'),'on')
            strs = get(low_list,'String');
            idx = get(low_list,'Value');
        else % look at med_list
            strs = get(med_list,'String');
            idx = get(med_list,'Value');
        end
        
        %only care about selected strings
        strs = cellstr(strs(idx,:));
        
        % add/remove selected elements
        table_headings = setxor(table_headings,strs,'stable');
        
        % update table
        update_table();
        
    end

%   user pressed the clear all button in display panel
    function none_callback(source, eventdata)
        table_headings = {};
        
        update_table();
    end

%   user pressed the Show Defaults button in display panel
    function default_callback(source, eventdata)
    
        table_headings = table_defaults;
        update_table();
        
    end

%---------------------------------------------------------------------
%  Utility functions for snap_filter

% refresh contents of table based on table_headings
    function update_table()
        
        % initialise table data structure
        table_datum = cell((data.idx -1),length(table_headings));
        
        % add address data
        
        idx = strcmp(table_headings,'Unit Number');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = cellstr(data.unit_no(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'Street Number');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = cellstr(data.street_no(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'Street Name');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = cellstr(data.street(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'Street Type');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = cellstr(data.st_type(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'Suburb');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = cellstr(data.suburb(1:(data.idx-1),:));
        end
        
        % add Build Stats data
        
        idx = strcmp(table_headings,'Year Built');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.built(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'Year Renovated');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.last_reno(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'Modern');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(logical(data.modern(1:(data.idx-1),:)));
        end
        
        idx = strcmp(table_headings,'Maisonette');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(logical(data.maisonette(1:(data.idx-1),:)));
        end
        
        idx = strcmp(table_headings,'Land Area');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.land_area(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'Living Area');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.floor_area(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'Frontage');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.frontage(1:(data.idx-1),:));
        end
        
        % add construction data
        
        idx = strcmp(table_headings,'Construction');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = cellstr(data.construction(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'C (Construction)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.construction_c(1:(data.idx-1),:));
        end
        
        % add roofing data
        
        idx = strcmp(table_headings,'Roofing');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = cellstr(data.roofing(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'C (Roofing)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.roofing_c(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'D (Roofing)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.roofing_d(1:(data.idx-1),:));
        end
        
        % add front yard data
        
        idx = strcmp(table_headings,'C (Front Yard)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.front_yard_c(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'D (Front Yard)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.front_yard_d(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'S (Front Yard)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.front_yard_s(1:(data.idx-1),:));
        end
        
        % add front facade data
        
        idx = strcmp(table_headings,'Front Facade');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = cellstr(data.front_facade(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'C (Front Facade)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.front_facade_c(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'D (Front Facade)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.front_facade_d(1:(data.idx-1),:));
        end
        
        % add parking data
        
        idx = strcmp(table_headings,'# Garages');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.garages(1:(data.idx-1),:));
        end

        idx = strcmp(table_headings,'# Carports');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.carports(1:(data.idx-1),:));
        end

        idx = strcmp(table_headings,'# Secure');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.secures(1:(data.idx-1),:));
        end

        idx = strcmp(table_headings,'# Off-street');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.offstreets(1:(data.idx-1),:));
        end

        idx = strcmp(table_headings,'C (Parking)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.parking_c(1:(data.idx-1),:));
        end
        idx = strcmp(table_headings,'D (Parking)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.parking_d(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'Dual-Access?');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(logical(data.dual_access(1:(data.idx-1),:)));
        end

        % add flooring data
        
        idx = strcmp(table_headings,'Tiles?');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(logical(data.tile(1:(data.idx-1),:)));
        end
        
        idx = strcmp(table_headings,'Slates?');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(logical(data.slate(1:(data.idx-1),:)));
        end
        
        idx = strcmp(table_headings,'Floorboards?');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(logical(data.floorboard(1:(data.idx-1),:)));
        end
        
        idx = strcmp(table_headings,'Vinyl?');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(logical(data.vinyl(1:(data.idx-1),:)));
        end
        
        idx = strcmp(table_headings,'Carpet?');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(logical(data.carpet(1:(data.idx-1),:)));
        end
        
        idx = strcmp(table_headings,'C (Flooring)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.flooring_c(1:(data.idx-1),:));
        end
        idx = strcmp(table_headings,'D (Flooring)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.flooring_d(1:(data.idx-1),:));
        end
        
        % add kitchen data
        
        idx = strcmp(table_headings,'Open Living?');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(logical(data.open_living(1:(data.idx-1),:)));
        end
        
        idx = strcmp(table_headings,'Pantry?');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(logical(data.pantry(1:(data.idx-1),:)));
        end
        
        idx = strcmp(table_headings,'C (Kitchen)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.kitchen_c(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'D (Kitchen)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.kitchen_d(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'S (Kitchen)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.kitchen_s(1:(data.idx-1),:));
        end
        
%       add bathroom data
        
        idx = strcmp(table_headings,'# Baths');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.baths(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'# Showers');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.showers(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'# Toilets');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.toilets(1:(data.idx-1),:));
        end        
        
        idx = strcmp(table_headings,'# Spas');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.spas(1:(data.idx-1),:));
        end

        idx = strcmp(table_headings,'C (Bathroom)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.bathroom_c(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'D (Bathroom)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.bathroom_d(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'S (Bathroom)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.bathroom_s(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'Heatlamps?');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(logical(data.heatlamp(1:(data.idx-1),:)));
        end
        
        % get bedroom data
        
        idx = strcmp(table_headings,'# Bedrooms');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.bedrooms(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'# WIRs');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.wirs(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'# BIRs');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.birs(1:(data.idx-1),:));
        end        
        
        idx = strcmp(table_headings,'# Kid Rooms');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.kids(1:(data.idx-1),:));
        end

        idx = strcmp(table_headings,'# Ensuites');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.ensuites(1:(data.idx-1),:));
        end        
        
        idx = strcmp(table_headings,'# BR Toilets');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.brts(1:(data.idx-1),:));
        end        
        
        idx = strcmp(table_headings,'C (Bedroom)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.bedroom_c(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'D (Bedroom)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.bedroom_d(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'S (Bedroom)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.bedroom_s(1:(data.idx-1),:));
        end
        
        % add climate control data
        
        idx = strcmp(table_headings,'Heating');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.heating(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'Cooling');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.cooling(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'Coverage');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.coverage(1:(data.idx-1),:));
        end
        
        % add back yard data
        
        idx = strcmp(table_headings,'C (Back Yard)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.back_yard_c(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'D (Back Yard)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.back_yard_d(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'S (Back Yard)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.back_yard_s(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'Pergola?');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(logical(data.pergola(1:(data.idx-1),:)));
        end
        
        idx = strcmp(table_headings,'Verandah?');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(logical(data.verandah(1:(data.idx-1),:)));
        end
        
        idx = strcmp(table_headings,'C (Verandah)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.verandah_c(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'D (Verandah)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.verandah_d(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'S (Verandah)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.verandah_s(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'Grass?');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(logical(data.grass(1:(data.idx-1),:)));
        end
        
        idx = strcmp(table_headings,'C (Grass)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.grass_c(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'D (Grass)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.grass_d(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'S (Grass)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.grass_s(1:(data.idx-1),:));
        end
        
        % add other feature data
        
        idx = strcmp(table_headings,'Swimming Pool?');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(logical(data.swim(1:(data.idx-1),:)));
        end
        
        idx = strcmp(table_headings,'C (Swimming Pool)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.swim_c(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'D (Swimming Pool)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.swim_d(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'S (Swimming Pool)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.swim_s(1:(data.idx-1),:));
        end        
        
        idx = strcmp(table_headings,'Sheds?');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(logical(data.shed(1:(data.idx-1),:)));
        end
        
        idx = strcmp(table_headings,'Shed Types');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = cellstr(data.shed_types(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'Granny Flat?');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(logical(data.granny_flat(1:(data.idx-1),:)));
        end
        
        idx = strcmp(table_headings,'C (Granny Flat)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.granny_flat_c(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'D (Granny Flat)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.granny_flat_d(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'S (Granny Flat)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.granny_flat_s(1:(data.idx-1),:));
        end
        
        % add inspection data
        
        idx = strcmp(table_headings,'Date (Inspection)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = cellstr(data.inspect_date(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'Start (Inspection)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = cellstr(data.inspect_start(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'End (Inspection)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = cellstr(data.inspect_end(1:(data.idx-1),:));
        end
        
        % add sales data
        
        idx = strcmp(table_headings,'Old Ask Low ($)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.low_list_price_old(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'Old Ask High ($)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.high_list_price_old(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'Old Asking Date');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = cellstr(data.list_date_old(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'Old Agent');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = cellstr(data.list_agent_old(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'Old Agency');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = cellstr(data.agency_old(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'Curr Ask Low ($)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.low_list_price_curr(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'Curr Ask High ($)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.high_list_price_curr(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'Curr Asking Date');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = cellstr(data.list_date_curr(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'Curr Agent');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = cellstr(data.list_agent_curr(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'Curr Agency');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = cellstr(data.agency_curr(1:(data.idx-1),:));
        end
        
        idx = strcmp(table_headings,'Sold Price ($)');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = num2cell(data.sold_price(1:(data.idx-1),:));
        end        
        
        idx = strcmp(table_headings,'Sold Date');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(:,idx) = cellstr(data.sold_date(1:(data.idx-1),:));
        end        
        
        % add notes data
        
        idx = strcmp(table_headings,'Reno Ideas');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(data.idea_key(1:data.ideas_idx-1),idx) = ...
                cellstr(data.idea_notes(1:(data.ideas_idx-1),:));
        end
        
        idx = strcmp(table_headings,'General');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(data.general_key(1:data.general_idx-1),idx) = ...
                cellstr(data.general_notes(1:(data.general_idx-1),:));
        end
        
        idx = strcmp(table_headings,'Suburb Notes');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(data.suburb_key(1:data.suburb_idx-1),idx) = ...
                cellstr(data.suburb_notes(1:(data.suburb_idx-1),:));
        end
        
        idx = strcmp(table_headings,'Street Notes');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(data.street_key(1:data.street_idx-1),idx) = ...
                cellstr(data.street_notes(1:(data.street_idx-1),:));
        end
        
        idx = strcmp(table_headings,'Local Neighbourhood');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(data.local_key(1:data.local_idx-1),idx) = ...
                cellstr(data.local_notes(1:(data.local_idx-1),:));
        end
        
        idx = strcmp(table_headings,'Agent Notes');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(data.agent_key(1:data.agent_idx-1),idx) = ...
                cellstr(data.agent_notes(1:(data.agent_idx-1),:));
        end
        
        idx = strcmp(table_headings,'Buyer Types');
        if sum(idx) ~= 0 % belongs in the table
            table_datum(data.buyer_key(1:data.buyer_idx-1),idx) = ...
                cellstr(data.buyer_notes(1:(data.buyer_idx-1),:));
        end
        
        % make changes seen in the table
        set(table, 'ColumnName', table_headings); %headings
        set(table,'data',table_datum);
        
    end


end