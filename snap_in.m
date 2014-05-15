function snap_in(load_idx)
% GUI snap_in
% description: Purpose is to input house inspection data
% inputs: load_idx (int) - the index of the property to edit. 
%                    if 0, then adds new entry   
% 
%---------------------------------------------------------------------
% Initialization tasks

% define CONSTANTS
% data control constants
DATA_INCREMENT = 200; % if columns must be grown, increase by DATA_INCREMENT
NOTES_INCREMENT = 15;
XSSTR = 5; %extra-small input string length
SSTR = 8;
LSTR = 20;
XLSTR = 200;
% constants that guide uicontrol dimensions
TXT_H = 0.03;
TXT_W = 0.12;
STXT_W = 0.08; %smaller
XSTXT_W = 0.06; %extra-small
POPUP_H = 0.03; %popup heights can't be controlled in windows
POPUP_W = 0.14;
COMMENT_W = 0.86;
COMMENT_H = 0.05;
LETTER_W = 0.02;
NUM_W = 0.06;
X_GAP = 0.005;
Y_GAP = 0.038;
PANEL_W = 0.98;
PANEL_H = 0.77;
% reusable cell-arrays for popup values
RATINGS = {'-1','0','1','2','3','4','5','6'}; % -1: unknown, 0: Nil or N/A
NUMS = {'-1','0','1','2','3','4','5','6','7','8'};
% colour constants
BG_COLOUR = [0.9412, 0.9412, 0.912];
LITE_COLOUR = [0.8, 0.8, 0.8];


% get variable names, user friendly descriptions and types
% index constants for VAR_ARR
XSCH = 'char5';
SCH = 'char8';
LCH = 'char20';
CH28 = 'char28';
XLCH = 'char200';
I8 = 'int8';
U8 = 'uint8';
U16 = 'uint16';
U32 = 'uint32';
LOG = 'logical';
NAME = 1; % user friendly description
VAR = 2; % programming variable
TYPE = 3; % variable type: logical, *int*, char*
VAR_ARR = snap_filter();

% load key data
data_file = 'snap_data/snap_data.mat';
if exist(data_file,'file')
    data = 0; % avoids runtime error
    load(data_file);
    
% first time initialisation    
else

    % initialise data struct
    data_init();
    
end


%  Create and then hide the GUI as it is being constructed.
h_fig = figure('Visible','off','MenuBar','none','toolbar','none',...
    'numbertitle','off','Position',[1,11,720,650],'name','Snap: input',...
    'CloseRequestFcn',{@exit_callback},'tag','snap_in');

%---------------------------------------------------------------------
%  Construct the components of the figure

% adress components
LINE_Y=1- POPUP_H - Y_GAP/2;
TMP_X = X_GAP;
address_txt = uicontrol('parent',h_fig,'Style','text',...
    'FontWeight','bold','String','Address:','Units','normalized',...
    'Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
unit_no_edit = uicontrol('parent',h_fig,'Style','edit',...
    'Units','normalized','String','Unit #','Position', ...
    [TMP_X,LINE_Y,STXT_W,TXT_H],'Callback',{@edit_callback},...
    'userData',SSTR);
TMP_X=TMP_X+X_GAP+STXT_W;
of_text = uicontrol('parent',h_fig,'Style','text',...
    'Units','normalized','String','of','Position',...
    [TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
street_no_edit = uicontrol('parent',h_fig,'Style','edit',...
    'Units','normalized','String','St. #','Position',...
    [TMP_X,LINE_Y,STXT_W,TXT_H],'Callback',{@edit_callback},...
    'userData',SSTR);
TMP_X=TMP_X+X_GAP+STXT_W;
street_edit = uicontrol('parent',h_fig,'Style','edit',...
    'Units','normalized','String','Street','Position',...
    [TMP_X,LINE_Y,TXT_W,TXT_H],'Callback',{@edit_callback},...
    'userData',LSTR);
TMP_X=TMP_X+X_GAP+TXT_W;
st_type_popup = uicontrol('parent',h_fig,'Style','popup',...
    'Units','normalized','String',{'Ave','Bowl','Cct','Cl','Cres','Crt',...
    'Dr','Gr','Pl','Rd','Rise','St','Tce'},...
    'Position', [TMP_X,LINE_Y,STXT_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
suburb_popup = uicontrol('parent',h_fig,'Style','popup',...
    'Units','normalized','String',{'Craigmore','Elizabeth East',...
    'Elizabeth Vale','Ingle Farm','Para Hills','Para Vista'},...
    'Position',[TMP_X,LINE_Y,POPUP_W,POPUP_H]);

% inspection components
LINE_Y=LINE_Y- POPUP_H - Y_GAP/2;
TMP_X = X_GAP;
inspection_txt = uicontrol('parent',h_fig,'Style','text',...
    'FontWeight','bold','String','Inspection:','Units','normalized',...
    'Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
inspect_date_edit = uicontrol('parent',h_fig,'Style','edit',...
    'Units','normalized','String','dd/mm/yy','Position',...
    [TMP_X,LINE_Y,STXT_W,TXT_H],'Callback',{@edit_callback},...
    'userData',SSTR);
TMP_X=TMP_X+X_GAP+STXT_W;
inspect_start_edit = uicontrol('parent',h_fig,'Style','edit',...
    'Units','normalized','String','HH:MM','Position',...
    [TMP_X,LINE_Y,STXT_W,TXT_H],'Callback',{@edit_callback},...
    'userData',XSSTR);
TMP_X=TMP_X+X_GAP+STXT_W;
inspect_to_text = uicontrol('parent',h_fig,'Style','text',...
    'Units','normalized','String','to','Position',...
    [TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
inspect_end_edit = uicontrol('parent',h_fig,'Style','edit',...
    'Units','normalized','String','HH:MM','Position',...
    [TMP_X,LINE_Y,STXT_W,TXT_H],'Callback',{@edit_callback},...
    'userData',XSSTR);
TMP_X=TMP_X+X_GAP+STXT_W;
modern_text = uicontrol('parent',h_fig,'Style','text',...
    'fontweight','bold','String','Modern:','Units','normalized',...
    'Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
yes_radio = uicontrol('parent',h_fig,'Style','radio',...
    'String','Yes','Units','normalized',...
    'Position',[TMP_X,LINE_Y,XSTXT_W,TXT_H],'Callback',...
    {@yes_radio_callback});
TMP_X=TMP_X+X_GAP+XSTXT_W;
no_radio = uicontrol('parent',h_fig,'Style','radio',...
    'String','No','Units','normalized',...
    'Position',[TMP_X,LINE_Y,XSTXT_W,TXT_H],'Callback',...
    {@no_radio_callback});
TMP_X=TMP_X+X_GAP+XSTXT_W;

maisonette_check = uicontrol('parent',h_fig,'Style','check',...
    'String','Maisonette','Units','normalized',...
    'Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);


% done button
done_button = uicontrol('parent',h_fig,'Style','pushbutton',...
    'FontWeight','bold','String','SAVE!','Units','normalized',...
    'Position',[0.85,LINE_Y,STXT_W,2*TXT_H],...
    'Callback',{@done_callback});

% key data components
LINE_Y=LINE_Y- POPUP_H - Y_GAP/2;
TMP_X = X_GAP;
built_txt = uicontrol('parent',h_fig,'Style','text',...
    'Units','normalized','String','Built:','Position',...
    [TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
built_edit = uicontrol('parent',h_fig,'Style','edit',...
    'Units','normalized','String','','Position',...
    [TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
last_reno_txt = uicontrol('parent',h_fig,'Style','text',...
    'Units','normalized','String','Last Renovated:','Position',...
    [TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
last_reno_edit = uicontrol('parent',h_fig,'Style','edit',...
    'Units','normalized','String','','Position',...
    [TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
land_area_txt = uicontrol('parent',h_fig,'Style','text',...
    'Units','normalized','String','Land Area:','Position',...
    [TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
land_area_edit = uicontrol('parent',h_fig,'Style','edit',...
    'Units','normalized','String','','Position',...
    [TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
land_area_sqm = uicontrol('parent',h_fig,'Style','text',...
    'Units','normalized','String','sqm','Position',...
    [TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
floor_area_txt = uicontrol('parent',h_fig,'Style','text',...
    'Units','normalized','String','Living Area:','Position',...
    [TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
floor_area_edit = uicontrol('parent',h_fig,'Style','edit',...
    'Units','normalized','String','','Position',...
    [TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
floor_area_sqm = uicontrol('parent',h_fig,'Style','text',...
    'Units','normalized','String','sqm','Position',...
    [TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
frontage_txt = uicontrol('parent',h_fig,'Style','text',...
    'Units','normalized','String','Frontage:','Position',...
    [TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
frontage_edit = uicontrol('parent',h_fig,'Style','edit',...
    'Units','normalized','String','','Position',...
    [TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
frontage_m = uicontrol('parent',h_fig,'Style','text',...
    'Units','normalized','String','m','Position',...
    [TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;

% panels
features_panel = uipanel('position',[X_GAP, Y_GAP/2, PANEL_W, PANEL_H]);
comments_panel = uipanel('position',[X_GAP, Y_GAP/2, PANEL_W, PANEL_H]);
sales_panel = uipanel('position',[X_GAP, Y_GAP/2, PANEL_W, PANEL_H]);

% tab buttons
TMP_X = X_GAP;
features_tab = uicontrol('parent',h_fig,'Style','pushbutton',...
    'String','Features','Units','normalized',...
    'Position',[TMP_X,PANEL_H+Y_GAP/2,TXT_W,1.3*TXT_H],...
    'Callback',{@features_callback});
TMP_X = TMP_X+TXT_W - X_GAP;
comments_tab = uicontrol('parent',h_fig,'Style','pushbutton',...
    'String','Comments','Units','normalized',...
    'Position',[TMP_X,PANEL_H+Y_GAP/2,TXT_W,1.3*TXT_H],...
    'Callback',{@comments_callback});
TMP_X = TMP_X+TXT_W - X_GAP;
sales_tab = uicontrol('parent',h_fig,'Style','pushbutton',...
    'String','Sales Data','Units','normalized',...
    'Position',[TMP_X,PANEL_H+Y_GAP/2,TXT_W,1.3*TXT_H],...
    'Callback',{@sales_callback});

%---------------------------------------------------------------------
%  Construct the components of features panel

% block components
LINE_Y=1- POPUP_H - Y_GAP/2;
TMP_X = X_GAP;
block_txt = uicontrol('parent',features_panel,'Style','text','String','Block:',...
    'FontWeight','bold','Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
corner_check = uicontrol('parent',features_panel,'Style','checkbox',...
    'Units','normalized','String','Corner',...
    'Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
highset_check = uicontrol('parent',features_panel,'Style','checkbox',...
    'Units','normalized','String','Highset',...
    'Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
lowset_check = uicontrol('parent',features_panel,'Style','checkbox',...
    'Units','normalized','String','Lowset',...
    'Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
noise_check = uicontrol('parent',features_panel,'Style','checkbox',...
    'Units','normalized','String','Noisy/Busy',...
    'Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
sloped_check = uicontrol('parent',features_panel,'Style','checkbox',...
    'Units','normalized','String','Sloped',...
    'Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);


% construction components
LINE_Y=LINE_Y - POPUP_H - Y_GAP;
TMP_X = X_GAP;
construction_txt = uicontrol('parent',features_panel,'Style','text','String','Construction:',...
    'FontWeight','bold','Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
construction_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',{'-','Double Brick','Brick Veneer','Fibreboard'},'Position',...
    [TMP_X,LINE_Y,POPUP_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+POPUP_W;
construction_c_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','C','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
construction_c_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+2*X_GAP+NUM_W;
% roofing components

roofing_txt = uicontrol('parent',features_panel,'Style','text','String','Roofing:',...
    'FontWeight','bold','Units','normalized','Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
roofing_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',{'-','Tiles','Shingles','Metal'},'Position',...
    [TMP_X,LINE_Y,POPUP_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+POPUP_W;
roofing_c_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','C','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
roofing_c_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
roofing_d_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','D','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
roofing_d_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
ceiling_check = uicontrol('parent',features_panel,'Style','checkbox',...
    'Units','normalized','String','High Ceiling',...
    'Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);

% front yard/facade components
TMP_X= X_GAP;
LINE_Y=LINE_Y - POPUP_H - Y_GAP;
front_yard_txt = uicontrol('parent',features_panel,'Style','text','String','Front Yard:',...
    'FontWeight','bold','Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
front_yard_c_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','C','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
front_yard_c_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
front_yard_d_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','D','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
front_yard_d_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
front_yard_s_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','S','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
front_yard_s_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W+0.1;
front_facade_txt = uicontrol('parent',features_panel,'Style','text','String','Front Facade:',...
    'FontWeight','bold','Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
front_facade_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',{'-','Brick','Paint','Render','Panels'},'Position',...
    [TMP_X,LINE_Y,POPUP_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+POPUP_W;
front_facade_c_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','C','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
front_facade_c_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
front_facade_d_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','D','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
front_facade_d_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);

% parking components 
TMP_X = X_GAP;
LINE_Y=LINE_Y - POPUP_H - Y_GAP;
parking_txt = uicontrol('parent',features_panel,'Style','text','String','Parking:',...
    'FontWeight','bold','Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
garages_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',NUMS,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
garage_txt = uicontrol('parent',features_panel,'Style','text','String','garage(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
carports_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',NUMS,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
carport_txt = uicontrol('parent',features_panel,'Style','text','String','carport(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
secures_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',NUMS,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
secure_txt = uicontrol('parent',features_panel,'Style','text','String','secure,',...
    'Units','normalized','Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
offstreets_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',NUMS,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
offstreet_txt = uicontrol('parent',features_panel,'Style','text','String','off-street,',...
    'Units','normalized','Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
parking_c_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','C','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
parking_c_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
parking_d_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','D','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
parking_d_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X = 2*X_GAP + TXT_W;
LINE_Y=LINE_Y - POPUP_H - Y_GAP/2;
dual_access_check = uicontrol('parent',features_panel,'Style','checkbox',...
    'Units','normalized','String','Dual-Access',...
    'Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);

% flooring components
TMP_X = X_GAP;
LINE_Y=LINE_Y - POPUP_H - Y_GAP;
flooring_txt = uicontrol('parent',features_panel,'Style','text','String','Flooring:',...
    'FontWeight','bold','Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
tile_check = uicontrol('parent',features_panel,'Style','checkbox',...
    'Units','normalized','String','Tile',...
    'Position',[TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
slate_check = uicontrol('parent',features_panel,'Style','checkbox',...
    'Units','normalized','String','Slate',...
    'Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
floorboard_check = uicontrol('parent',features_panel,'Style','checkbox',...
    'Units','normalized','String','Floorboard',...
    'Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
vinyl_check = uicontrol('parent',features_panel,'Style','checkbox',...
    'Units','normalized','String','Vinyl',...
    'Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
carpet_check = uicontrol('parent',features_panel,'Style','checkbox',...
    'Units','normalized','String','Carpet',...
    'Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
flooring_c_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','C','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
flooring_c_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
flooring_d_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','D','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
flooring_d_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);

% kitchen components
TMP_X = X_GAP;
LINE_Y=LINE_Y - POPUP_H - Y_GAP;
kitchen_txt = uicontrol('parent',features_panel,'Style','text','String','Kitchen:',...
    'FontWeight','bold','Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
open_living_check = uicontrol('parent',features_panel,'Style','checkbox','Units','normalized',...
    'String','Open Living',...
    'Position',[TMP_X,LINE_Y,TXT_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
pantry_check = uicontrol('parent',features_panel,'Style','checkbox','Units','normalized',...
    'String','Pantry',...
    'Position',[TMP_X,LINE_Y,STXT_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
kitchen_c_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','C','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
kitchen_c_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
kitchen_d_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','D','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
kitchen_d_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
kitchen_s_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','S','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
kitchen_s_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;

% living components
living_txt = uicontrol('parent',features_panel,'Style','text','String','Living:',...
    'FontWeight','bold','Units','normalized','Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
living_c_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','C','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
living_c_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
living_d_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','D','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
living_d_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
living_s_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','S','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
living_s_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);

% bathroom components
TMP_X = X_GAP;
LINE_Y=LINE_Y - POPUP_H - Y_GAP;
bathroom_txt = uicontrol('parent',features_panel,'Style','text','String','Bathroom:',...
    'FontWeight','bold','Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
toilets_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',NUMS,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
toilet_txt = uicontrol('parent',features_panel,'Style','text','String','toilet(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
showers_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',NUMS,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
shower_txt = uicontrol('parent',features_panel,'Style','text','String','shower(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
baths_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',NUMS,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
bath_txt = uicontrol('parent',features_panel,'Style','text','String','bath(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
spas_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',NUMS,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
spa_txt = uicontrol('parent',features_panel,'Style','text','String','spa(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
bathroom_c_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','C','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
bathroom_c_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
bathroom_d_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','D','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
bathroom_d_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
bathroom_s_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','S','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
bathroom_s_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X = X_GAP + TXT_W;
LINE_Y=LINE_Y - POPUP_H - Y_GAP/2;
wcs_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',NUMS,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
wc_txt = uicontrol('parent',features_panel,'Style','text','String','W.C.(s)',...
    'Units','normalized','Position',[TMP_X,LINE_Y,XSTXT_W,TXT_H]);

% bedroom components
TMP_X = X_GAP;
LINE_Y=LINE_Y - POPUP_H - Y_GAP;
bedroom_txt = uicontrol('parent',features_panel,'Style','text','String','Bedroom:',...
    'FontWeight','bold','Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+TXT_W;
bedrooms_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',NUMS,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
bedrooms_txt = uicontrol('parent',features_panel,'Style','text','String','BR(s)',...
    'Units','normalized','Position',[TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+XSTXT_W;
wirs_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',NUMS,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
wir_txt = uicontrol('parent',features_panel,'Style','text','String','WIR(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
birs_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',NUMS,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
bir_txt = uicontrol('parent',features_panel,'Style','text','String','BIR(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
kids_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',NUMS,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
kids_txt = uicontrol('parent',features_panel,'Style','text','String','kid(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
ensuites_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',NUMS,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
ensuite_txt = uicontrol('parent',features_panel,'Style','text','String','ensuite(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
brts_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',NUMS,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
brt_txt = uicontrol('parent',features_panel,'Style','text','String','toilet(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X = X_GAP + TXT_W;
LINE_Y=LINE_Y - POPUP_H - Y_GAP/2;
bedroom_c_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','C','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
bedroom_c_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
bedroom_d_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','D','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
bedroom_d_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
bedroom_s_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','S','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
bedroom_s_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);

% climate control components
TMP_X= X_GAP;
LINE_Y=LINE_Y - POPUP_H - Y_GAP;
cc_txt = uicontrol('parent',features_panel,'Style','text','String','Temp Control:',...
    'FontWeight','bold','Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
heating_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','Heating','Position', [TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
heating_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
cooling_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','Cooling','Position', [TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
cooling_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
coverage_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','Coverage','Position', [TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
coverage_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);

% backyard components
TMP_X = X_GAP;
LINE_Y=LINE_Y - POPUP_H - Y_GAP;
back_yard_txt = uicontrol('parent',features_panel,'Style','text','String','Backyard:',...
    'FontWeight','bold','Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
back_yard_c_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','C','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
back_yard_c_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
back_yard_d_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','D','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
back_yard_d_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
back_yard_s_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','S','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
back_yard_s_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
verandah_check = uicontrol('parent',features_panel,'Style','checkbox','Units','normalized',...
    'String','Verandah','Position',...
    [TMP_X,LINE_Y,TXT_W,POPUP_H],'callback',{@verandah_callback});
TMP_X=TMP_X+TXT_W;
pergola_check = uicontrol('parent',features_panel,'Style','checkbox','Units','normalized',...
    'String','Pergola','Position',...
    [TMP_X,LINE_Y,STXT_W,POPUP_H],'callback',{@verandah_callback});
TMP_X=TMP_X+X_GAP+STXT_W;
alfresco_check = uicontrol('parent',features_panel,'Style','checkbox','Units','normalized',...
    'String','Alfresco','Position',...
    [TMP_X,LINE_Y,TXT_W,POPUP_H],'callback',{@verandah_callback});
TMP_X=TMP_X+TXT_W;
verandah_c_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','C','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
verandah_c_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
verandah_d_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','D','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
verandah_d_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
verandah_s_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','S','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
verandah_s_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X = X_GAP+TXT_W;
LINE_Y=LINE_Y - POPUP_H - Y_GAP/2;
grass_check = uicontrol('parent',features_panel,'Style','checkbox','Units','normalized',...
    'String','Grass','Position',...
    [TMP_X,LINE_Y,STXT_W,POPUP_H],'Callback',{@grass_callback});
TMP_X=TMP_X+X_GAP+STXT_W;
grass_c_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','C','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
grass_c_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
grass_d_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','D','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
grass_d_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
grass_s_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','S','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
grass_s_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);

% Other notable features components
TMP_X = X_GAP;
LINE_Y=LINE_Y - POPUP_H - Y_GAP;
of_txt = uicontrol('parent',features_panel,'Style','text','String','Other:',...
    'FontWeight','bold','Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
swim_check = uicontrol('parent',features_panel,'Style','checkbox',...
    'String','Swimming Pool','Units','normalized',...
    'Position',[TMP_X,LINE_Y,TXT_W+0.01,TXT_H],'Callback',{@swim_callback});
TMP_X=TMP_X+X_GAP+TXT_W+0.01;
swim_c_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','C','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
swim_c_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
swim_d_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','D','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
swim_d_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
swim_s_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','S','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
swim_s_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
shed_check = uicontrol('parent',features_panel,'Style','checkbox','Units','normalized',...
    'String','Sheds','Position',...
    [TMP_X,LINE_Y,STXT_W,POPUP_H],'Callback',{@shed_callback});
TMP_X=TMP_X+X_GAP+STXT_W;
shed_types_edit = uicontrol('parent',features_panel,'Style','edit',...
    'Units','normalized','String','','horizontalAlignment','left',...
    'Position', [TMP_X,LINE_Y,2*TXT_W,TXT_H],'Callback',{@edit_callback},...
    'userData',LSTR);
TMP_X = X_GAP+TXT_W;
LINE_Y=LINE_Y - POPUP_H - Y_GAP/2;
granny_flat_check = uicontrol('parent',features_panel,'Style','checkbox','Units','normalized',...
    'String','Granny Flat','Position',...
    [TMP_X,LINE_Y,TXT_W,POPUP_H],'callback',{@granny_flat_callback});
TMP_X=TMP_X+X_GAP+TXT_W;
granny_flat_c_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','C','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
granny_flat_c_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
granny_flat_d_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','D','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
granny_flat_d_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
granny_flat_s_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','S','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
granny_flat_s_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',RATINGS,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);

%---------------------------------------------------------------------
%  Construct the components of comments panel

% good reno ideas components
TMP_X = X_GAP;
LINE_Y= 1 - COMMENT_H - Y_GAP;
ideas_txt = uicontrol('parent',comments_panel,'Style','text','String','Reno Ideas:',...
    'FontWeight','bold','Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
idea_notes_edit = uicontrol('parent',comments_panel,'Style','edit',...
    'Units','normalized',...
    'String','','min',0,'max',10,'horizontalAlignment','left',...
    'Position', [TMP_X,LINE_Y-COMMENT_H/2,COMMENT_W,COMMENT_H],...
    'Callback',{@edit_callback},'userData',XLSTR);

% general comments components
TMP_X = X_GAP;
LINE_Y=LINE_Y - COMMENT_H - Y_GAP;
general_txt = uicontrol('parent',comments_panel,'Style','text','String','General:',...
    'FontWeight','bold','Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
general_notes_edit = uicontrol('parent',comments_panel,'Style','edit','Units','normalized',...
    'String','','min',0,'max',10,'horizontalAlignment','left',...
    'Position', [TMP_X,LINE_Y-COMMENT_H/2,COMMENT_W,COMMENT_H],...
    'Callback',{@edit_callback},'userData',XLSTR);

% suburb comments components
TMP_X = X_GAP;
LINE_Y=LINE_Y - COMMENT_H - Y_GAP;
suburb_comment_txt = uicontrol('parent',comments_panel,'Style','text','String','Suburb:',...
    'FontWeight','bold','Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
suburb_notes_edit = uicontrol('parent',comments_panel,'Style','edit','Units','normalized',...
    'String','','min',0,'max',10,'horizontalAlignment','left',...
    'Position', [TMP_X,LINE_Y-COMMENT_H/2,COMMENT_W,COMMENT_H],...
    'Callback',{@edit_callback},'userData',XLSTR);

% street comments components
TMP_X = X_GAP;
LINE_Y=LINE_Y - COMMENT_H - Y_GAP;
street_comment_txt = uicontrol('parent',comments_panel,'Style','text','String','Street:',...
    'FontWeight','bold','Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
street_notes_edit = uicontrol('parent',comments_panel,'Style','edit','Units','normalized',...
    'String','','min',0,'max',10,'horizontalAlignment','left',...
    'Position', [TMP_X,LINE_Y-COMMENT_H/2,COMMENT_W,COMMENT_H],...
    'Callback',{@edit_callback},'userData',XLSTR);

% local neighbourhood components
TMP_X = X_GAP;
LINE_Y=LINE_Y - COMMENT_H - Y_GAP;
local_comment_txt = uicontrol('parent',comments_panel,'Style','text','String','Proximity:',...
    'FontWeight','bold','Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
local_notes_edit = uicontrol('parent',comments_panel,'Style','edit','Units','normalized',...
    'String','','min',0,'max',10,'horizontalAlignment','left',...
    'Position', [TMP_X,LINE_Y-COMMENT_H/2,COMMENT_W,COMMENT_H],...
    'Callback',{@edit_callback},'userData',XLSTR);

% Agent components
TMP_X = X_GAP;
LINE_Y=LINE_Y - COMMENT_H - Y_GAP;
agent_txt = uicontrol('parent',comments_panel,'Style','text','String','Agent:',...
    'FontWeight','bold','Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
agent_notes_edit = uicontrol('parent',comments_panel,'Style','edit','Units','normalized',...
    'String','','min',0,'max',10,'horizontalAlignment','left',...
    'Position', [TMP_X,LINE_Y-COMMENT_H/2,COMMENT_W,COMMENT_H],...
    'Callback',{@edit_callback},'userData',XLSTR);

% Buyer components
TMP_X = X_GAP;
LINE_Y=LINE_Y - COMMENT_H - Y_GAP;
buyers_txt = uicontrol('parent',comments_panel,'Style','text','String','Buyers:',...
    'FontWeight','bold','Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
buyer_notes_edit = uicontrol('parent',comments_panel,'Style','edit','Units','normalized',...
    'String','','min',0,'max',10,'horizontalAlignment','left',...
    'Position', [TMP_X,LINE_Y-COMMENT_H/2,COMMENT_W,COMMENT_H],...
    'Callback',{@edit_callback},'userData',XLSTR);

%---------------------------------------------------------------------
%  Construct the components of comments panel

% oldest listing components
LINE_Y= 1 - POPUP_H - Y_GAP/2;
TMP_X = X_GAP;
oldest_txt = uicontrol('parent',sales_panel,'Style','text',...
    'String','Oldest Listing: ','Units','normalized',...
    'FontWeight','Bold','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
list_price_old_txt = uicontrol('parent',sales_panel,'Style','text',...
    'String','Price: $','Units','normalized',...
    'Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
low_list_price_old_edit = uicontrol('parent',sales_panel,'Style','edit',...
    'Units','normalized','String','','Position',...
    [TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
list_price_old_to = uicontrol('parent',sales_panel,'Style','text',...
    'String','to','Units','normalized',...
    'Position',[TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
high_list_price_old_edit = uicontrol('parent',sales_panel,'Style','edit',...
    'Units','normalized','String','','Position',...
    [TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
list_date_old_txt = uicontrol('parent',sales_panel,'Style','text',...
    'String','Date:','Units','normalized',...
    'Position',[TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
list_date_old_edit = uicontrol('parent',sales_panel,'Style','edit',...
    'Units','normalized','String','dd/mm/yy','Position',...
    [TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
TMP_X_COPY = TMP_X;
list_agent_old_txt = uicontrol('parent',sales_panel,'Style','text',...
    'String','Agent:','Units','normalized',...
    'Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
list_agent_old_popup = uicontrol('parent',sales_panel,'Style','popup',...
    'Units','normalized','String',data.agent_names,'Position',...
    [TMP_X,LINE_Y,1.4*POPUP_W,POPUP_H],'Callback',{@agent_old_callback}); 
TMP_X=TMP_X+X_GAP+1.4*POPUP_W;
list_agent_old_edit = uicontrol('parent',sales_panel,'Style','edit',...
    'Units','normalized','String','','Position',...
    [TMP_X,LINE_Y,1.4*TXT_W,TXT_H],'Callback',{@edit_callback},...
    'userData',LSTR,'Visible','off');
LINE_Y = LINE_Y - POPUP_H - Y_GAP/2;
TMP_X = TMP_X_COPY;
clear('TMP_X_COPY');
agency_old_txt = uicontrol('parent',sales_panel,'Style','text',...
    'String','Agency:','Units','normalized',...
    'Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
agency_old_popup = uicontrol('parent',sales_panel,'Style','popup',...
    'Units','normalized','String',data.agencies,'Position',...
    [TMP_X,LINE_Y,1.4*POPUP_W,POPUP_H],'Callback',{@agency_old_callback}); 
TMP_X=TMP_X+X_GAP+1.4*POPUP_W;
agency_old_edit = uicontrol('parent',sales_panel,'Style','edit',...
    'Units','normalized','String','','Position',...
    [TMP_X,LINE_Y,1.4*TXT_W,TXT_H],'Callback',{@edit_callback},...
    'userData',(LSTR + SSTR),'Visible','off');

% current listing components
LINE_Y= LINE_Y - POPUP_H - Y_GAP;
TMP_X = X_GAP;
current_txt = uicontrol('parent',sales_panel,'Style','text',...
    'String','Curr. Listing: ','Units','normalized',...
    'FontWeight','bold','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
list_price_curr_txt = uicontrol('parent',sales_panel,'Style','text',...
    'String','Price: $','Units','normalized',...
    'Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
low_list_price_curr_edit = uicontrol('parent',sales_panel,'Style','edit',...
    'Units','normalized','String','','Position',...
    [TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
list_price_curr_to = uicontrol('parent',sales_panel,'Style','text',...
    'String','to','Units','normalized',...
    'Position',[TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
high_list_price_curr_edit = uicontrol('parent',sales_panel,'Style','edit',...
    'Units','normalized','String','','Position',...
    [TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
list_date_curr_txt = uicontrol('parent',sales_panel,'Style','text',...
    'String','Date:','Units','normalized',...
    'Position',[TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
list_date_curr_edit = uicontrol('parent',sales_panel,'Style','edit',...
    'Units','normalized','String','dd/mm/yy','Position',...
    [TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
TMP_X_COPY = TMP_X;
list_agent_curr_txt = uicontrol('parent',sales_panel,'Style','text',...
    'String','Agent:','Units','normalized',...
    'Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
list_agent_curr_popup = uicontrol('parent',sales_panel,'Style','popup',...
    'Units','normalized','String',data.agent_names,'Position',...
    [TMP_X,LINE_Y,1.4*POPUP_W,POPUP_H],'Callback',{@agent_curr_callback}); 
TMP_X=TMP_X+X_GAP+1.4*POPUP_W;
list_agent_curr_edit = uicontrol('parent',sales_panel,'Style','edit',...
    'Units','normalized','String','','Position',...
    [TMP_X,LINE_Y,1.4*TXT_W,TXT_H],'Callback',{@edit_callback},...
    'userData',LSTR,'Visible','off');
LINE_Y= LINE_Y - POPUP_H - Y_GAP/2;
TMP_X = 2*X_GAP + TXT_W;
agent_start_txt = uicontrol('parent',sales_panel,'Style','text',...
    'String','Date agent started (if applicable):','Units','normalized',...
    'Position',[TMP_X,LINE_Y,2*TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+2*TXT_W;
agent_start_edit = uicontrol('parent',sales_panel,'Style','edit',...
    'Units','normalized','String','dd/mm/yy','Position',...
    [TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X = TMP_X_COPY;
clear('TMP_X_COPY');
agency_old_txt = uicontrol('parent',sales_panel,'Style','text',...
    'String','Agency:','Units','normalized',...
    'Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
agency_curr_popup = uicontrol('parent',sales_panel,'Style','popup',...
    'Units','normalized','String',data.agencies,'Position',...
    [TMP_X,LINE_Y,1.4*POPUP_W,POPUP_H],'Callback',{@agency_curr_callback});
TMP_X=TMP_X+X_GAP+1.4*POPUP_W;
agency_curr_edit = uicontrol('parent',sales_panel,'Style','edit',...
    'Units','normalized','String','','Position',...
    [TMP_X,LINE_Y,1.4*TXT_W,TXT_H],'Callback',{@edit_callback},...
    'userData',(LSTR + SSTR),'Visible','off');

% sold components
LINE_Y= LINE_Y - POPUP_H - Y_GAP;
TMP_X = X_GAP;
sold_info_txt = uicontrol('parent',sales_panel,'Style','text',...
    'String','Sold Info: ','Units','normalized',...
    'FontWeight','bold','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
sold_price_txt = uicontrol('parent',sales_panel,'Style','text',...
    'String','Price: $','Units','normalized',...
    'Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
sold_price_edit = uicontrol('parent',sales_panel,'Style','edit',...
    'Units','normalized','String','','Position',...
    [TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
sold_date_txt = uicontrol('parent',sales_panel,'Style','text',...
    'String','Date:','Units','normalized',...
    'Position',[TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
sold_date_edit = uicontrol('parent',sales_panel,'Style','edit',...
    'Units','normalized','String','dd/mm/yy','Position',...
    [TMP_X,LINE_Y,STXT_W,TXT_H]);

%---------------------------------------------------------------------
%  Initialization tasks

% if necessary load existing property for edit
if load_idx ~= 0
    
    data2controls();    
    
end


% Move the GUI to the center of the screen.
movegui(h_fig,'east')

% By default, start on the features tab
features_callback(features_tab,0);

% Call the check callbacks
verandah_callback(verandah_check,0);
grass_callback(grass_check,0);
swim_callback(swim_check,0);
shed_callback(shed_check,0);
granny_flat_callback(granny_flat_check,0);

% improve tab order
% uistack(features_tab,'down',2);


% Make the GUI visible.
set(h_fig,'Visible','on');



%---------------------------------------------------------------------
    %  Callbacks for MYGUI
    
%   user selected the features tab
    function features_callback(source,eventdata)
        
%       make tab colour look 'selected'
        set(features_tab,'backgroundColor',BG_COLOUR);
        set(comments_tab,'backgroundColor',LITE_COLOUR);
        set(sales_tab,'backgroundColor',LITE_COLOUR);
        
        %   make this panel the only visible
        set(features_panel,'visible','on');
        set(comments_panel,'visible','off');
        set(sales_panel,'visible','off');
        
    end

%   user selected the comments tab
    function comments_callback(source,eventdata)
        
%       make tab colour look 'selected'
        set(features_tab,'backgroundColor',LITE_COLOUR);
        set(comments_tab,'backgroundColor',BG_COLOUR);
        set(sales_tab,'backgroundColor',LITE_COLOUR);
        
        %   make this panel the only visible
        set(features_panel,'visible','off');
        set(comments_panel,'visible','on');
        set(sales_panel,'visible','off');
        
        % put focus on first component
        uicontrol(idea_notes_edit);
        
    end

%   user selected the sales tab
    function sales_callback(source,eventdata)
        
%       make tab colour look 'selected'
        set(features_tab,'backgroundColor',LITE_COLOUR);
        set(comments_tab,'backgroundColor',LITE_COLOUR);
        set(sales_tab,'backgroundColor',BG_COLOUR);
        
        %   make this panel the only visible
        set(features_panel,'visible','off');
        set(comments_panel,'visible','off');
        set(sales_panel,'visible','on');
        
        % put focus on first component
        uicontrol(low_list_price_old_edit);
        
    end

%   user pushed the done button
    function done_callback(source,eventdata)
    
        %---------------------------------------------------------
        % collect user data input to GUI
        
        % perform some checks to ensure user entered minimum data
        if ~get(yes_radio,'Value') && ~get(no_radio,'Value')
            errordlg('You must specify if modern or dated',...
                'Specify Modern/Dated');
            return;
        end
        
        tmpVal = deblank(get(street_edit,'String'));
        if strcmp(tmpVal,'Street') || strcmp(tmpVal,'')
            % user didn't enter compulsory value
            errordlg('You must specify a street name!',...
                'Need Street Name');
            return;
        end
        
        tmpVal = deblank(get(street_no_edit,'String'));
        if strcmp(tmpVal,'St. #') || strcmp(tmpVal,'')
            % user didn't enter compulsory value
            errordlg('You must specify a street number!',...
                'Need Street Number');
            return;
        end
        
        if strcmp(deblank(get(unit_no_edit,'String')),'Unit #')
            set(unit_no_edit,'String','')
        end
        
        if strcmpi(get(list_agent_curr_edit,'Visible'),'on') && ...
                strcmp(deblank(get(list_agent_curr_edit,'string')),'')
            
            errordlg('Attempted to add current agent as empty string',...
                'Agent Must Have a Name');
            return;
            
        end        
        
        if strcmpi(get(list_agent_old_edit,'Visible'),'on') && ...
                strcmp(deblank(get(list_agent_old_edit,'string')),'')
            
            errordlg('Attempted to add old agent as empty string',...
                'Agent Must Have a Name');
            return;
            
        end
        
        if strcmpi(get(agency_old_edit,'Visible'),'on') && ...
                strcmp(deblank(get(agency_old_edit,'string')),'')
            errordlg('Attempted to add old agency as empty string',...
                'Agency Must Have a Name');
            return;
        end
        
        if strcmpi(get(agency_curr_edit,'Visible'),'on') && ...
                strcmp(deblank(get(agency_curr_edit,'string')),'')
            errordlg('Attempted to add current agency as empty string',...
                'Agency Must Have a Name');
            return;
        end
        
        
        % get data from GUI components and add to data struct
        controls2data();
    
        % associate agent with agency
        associate_agency();
        
        % expands the number of rows of data struct's elements if necessary
        expand_data();
                
%        save the updated data
        save(data_file,'data','-v6');

%       close the GUI    
        exit_callback(source,eventdata);

    end

%   the figure has been requested to close
    function exit_callback(source,eventdata)
        
        % if snap exist refocus on that
        master_handle = findall(0,'tag','snap');
        if ishandle(master_handle)
            figure(master_handle);
        end
        delete(h_fig)

    end

%   limit the number of characters in a editbox
    function edit_callback(source,eventdata)
        limit = get(source,'userData');
        
        s = get(source,'string');
        if (length(s) > limit)
            s = s(1:limit);
            set(source,'string',s);
            warndlg(['String truncated to ' num2str(limit) ' characters'],...
                'Max String Size Exceeded');
        end
        
    end
      
%   yes radio button selected
    function yes_radio_callback(source,eventdata)
%         ensure the value of this radio button is the opposite of the 
%         other radio button
        val = get(source,'value');
        set(no_radio,'value',~val);
    
    end

%   no radio button selected
    function no_radio_callback(source,eventdata)
%         ensure the value of this radio button is the opposite of the 
%         other radio button
        val = get(source,'value');
        set(yes_radio,'value',~val);
    
    end

%   user made a selection in the old agent names popup list
    function agent_old_callback(source,eventdata)

        selection = get(source,'string');
        selection = deblank(selection(get(source,'Value'),:));

        if strcmp(selection,'Add New')
            % in the case user selects Add New, then let the edit box appear
           set(list_agent_old_edit,'Visible','On');
        elseif strcmp(selection,'-')
%            in the case user didn't select anything, just ensure edit box
%            hidden
            set(list_agent_old_edit,'Visible','Off');
        else % user selected a predefined agent
            % no need for the edit box:
            set(list_agent_old_edit,'Visible','Off');
            % make the agency popup correspond to this agent
            idx = strcmp(cellstr(data.agent_names(3:end,:)),selection);
            agency = deblank(data.agents_agency(idx,:));
            idx = strcmp(cellstr(data.agencies),agency);
            idx = idx.*(1:length(idx))';
            set(agency_old_popup,'Value',sum(idx));
        end  
        
    end

%   user made a selection in the curr agent names popup list
    function agent_curr_callback(source,eventdata)

        selection = get(source,'string');
        selection = deblank(selection(get(source,'Value'),:));

        if strcmp(selection,'Add New')
            % in the case user selects Add New, then let the edit box appear
           set(list_agent_curr_edit,'Visible','On');
        elseif strcmp(selection,'-')
%            in the case user didn't select anything, just ensure edit box
%            hidden
            set(list_agent_curr_edit,'Visible','Off');
        else % user selected a predefined agent
            % no need for the edit box:
            set(list_agent_curr_edit,'Visible','Off');
            % make the agency popup correspond to this agent
            idx = strcmp(cellstr(data.agent_names(3:end,:)),selection);
            agency = deblank(data.agents_agency(idx,:));
            idx = strcmp(cellstr(data.agencies),agency);
            idx = idx.*(1:length(idx))';
            set(agency_curr_popup,'Value',sum(idx));
        end  
        
    end

%   user made a selection in the old agency popup list
    function agency_old_callback(source,eventdata)
        
        selection = get(source,'string');
        selection = deblank(selection(get(source,'Value'),:));
        
        if strcmp(selection,'Add New')
            % in the case user selects Add New, then let the edit box appear
            set(agency_old_edit,'Visible','On');
        else
            set(agency_old_edit,'Visible','off');
        end
            
    end

%   user made a selection in the current agency popup list
    function agency_curr_callback(source,eventdata)
        
        selection = get(source,'string');
        selection = deblank(selection(get(source,'Value'),:));
        
        if strcmp(selection,'Add New')
            % in the case user selects Add New, then let the edit box appear
            set(agency_curr_edit,'Visible','On');
        else
            set(agency_curr_edit,'Visible','off');
        end
            
    end

%   user hit pergola/verandah checkbox
    function verandah_callback(source,eventdata)
        
        % if at least one selected enable popup boxes
        if get(verandah_check,'Value') || get(pergola_check,'Value') || ...
                get (alfresco_check,'Value')
            set(verandah_c_popup,'enable','on');
            set(verandah_d_popup,'enable','on');
            set(verandah_s_popup,'enable','on');
        else %disable
            set(verandah_c_popup,'enable','off');
            set(verandah_d_popup,'enable','off');
            set(verandah_s_popup,'enable','off');
        end 
           
    end

    %   user hit grass checkbox
    function grass_callback(source,eventdata)
        
        % if selected enable popup boxes
        if get(grass_check,'Value')
            set(grass_c_popup,'enable','on');
            set(grass_d_popup,'enable','on');
            set(grass_s_popup,'enable','on');
        else %disable
            set(grass_c_popup,'enable','off');
            set(grass_d_popup,'enable','off');
            set(grass_s_popup,'enable','off');
        end 
           
    end

    %   user hit swimming pool checkbox
    function swim_callback(source,eventdata)
        
        % if selected enable popup boxes
        if get(swim_check,'Value')
            set(swim_c_popup,'enable','on');
            set(swim_d_popup,'enable','on');
            set(swim_s_popup,'enable','on');
        else %disable
            set(swim_c_popup,'enable','off');
            set(swim_d_popup,'enable','off');
            set(swim_s_popup,'enable','off');
        end 
           
    end

    %   user hit sheds checkbox
    function shed_callback(source,eventdata)
        
        % if selected enable shed edit box
        if get(shed_check,'Value')
            set(shed_types_edit,'enable','on');
        else %disable
            set(shed_types_edit,'enable','off');
        end 
           
    end

    %   user hit granny_flat checkbox
    function granny_flat_callback(source,eventdata)
        
        % if selected enable popup boxes
        if get(granny_flat_check,'Value')
            set(granny_flat_c_popup,'enable','on');
            set(granny_flat_d_popup,'enable','on');
            set(granny_flat_s_popup,'enable','on');
        else %disable
            set(granny_flat_c_popup,'enable','off');
            set(granny_flat_d_popup,'enable','off');
            set(granny_flat_s_popup,'enable','off');
        end 
           
    end

%---------------------------------------------------------------------
%  Utility functions for snap_in

    % function data_init
    % description: initialise empty data structure
    function data_init()
        
        % unique id for each property
        data.idx = 1; 
        
        % initial number of rows
        rows = 200; % initial size for most data structures
        c_rows = 50; % initial size for notes data structures
        
        for i = 1:size(VAR_ARR,1) % initialise each variable
            
            var = deblank(VAR_ARR(i,:,VAR));
            switch deblank(VAR_ARR(i,:,TYPE))
                
                case XSCH
                    eval(['data.' var ' = repmat('' '',rows,5);']);
                case SCH
                    eval(['data.' var ' = repmat('' '',rows,8);']);
                case LCH
                    eval(['data.' var ' = repmat('' '',rows,20);']);
                case CH28
                    eval(['data.' var ' = repmat('' '',rows,28);']);
                case XLCH
                    % each note has its own idx, key and notes
                    % 'notes' is the data structure itself (holding the
                    % notes). 'idx' points to the next free row. The
                    % indicess of 'key' correspond to indices of 'notes'
                    % and the values of key correspond to propertie's
                    % unique ID
                    eval(['data.' var 'idx = 1;']);
                    eval(['data.' var 'key = zeros(c_rows,1,''' U16 ''');']);
                    eval(['data.' var 'notes = repmat('' '',c_rows,200);']);
                case I8
                    eval(['data.' var ' = zeros(rows,1,''' I8 ''');']);
                case U8
                    eval(['data.' var ' = zeros(rows,1,''' U8 ''');']);
                case U16
                    eval(['data.' var ' = zeros(rows,1,''' U16 ''');']);
                case U32
                    eval(['data.' var ' = zeros(rows,1,''' U32 ''');']);
                case LOG
                    eval(['data.' var ' = false(rows,1);']);
                    
            end
            
        end
        
        %   agent names list (seen in the popup):
        data.agent_names = repmat(' ',2,LSTR);
        data.agent_names(1,1) = '-';
        data.agent_names(2,1:7) = 'Add New';
        
        %   internal structure to help snap remember what agency each agent is
        %   attached to
        data.agents_agency = '';
        
        %   agencies list (seen in the popup):
        data.agencies = repmat(' ',2,(LSTR + SSTR));
        data.agencies(1,1) = '-';
        data.agencies(2,1:7) = 'Add New';
        
        %   save data to disk
        save(data_file,'data','-v6');
            
    end

    % helper fn: controls2data
    % description: saves data collected in GUI to data struct 
    %              performs checks to edit property or save new one
    function controls2data()
       
        % determine where to save
        if load_idx ~= 0
            % we want to overwrite this property
            idx = load_idx;
        else
            % we want to add a new property
            idx = data.idx;
            % update the index for the next entry
            data.idx = data.idx + 1;
        end
                
        for i = 1:size(VAR_ARR,1) % for each variable
            
            % retrieve variable and type to save it as
            var = deblank(VAR_ARR(i,:,VAR));
            type = deblank(VAR_ARR(i,:,TYPE));
            
            % determine the corresponding handle
            if strcmp(var,'modern') % special case
             
                % store modern boolean (as logical)
                data.modern(idx) = get(yes_radio,'Value');
                
            elseif exist([var '_popup'],'var')
                
                % get popup value from control
                tmpVal = eval(['get(' var '_popup,''String'')']);
                if ischar(tmpVal) % popup string is char array
                    tmpVal = eval(['tmpVal(get(' var '_popup,''Value''),:)']);
                else % popup string is cellstr
                    tmpVal = eval(['tmpVal{get(' var '_popup,''Value'')}']);
                end
                
                % save it according to type
                if ~strcmp(tmpVal,'')
                    if eval(['ischar(data.' var ')']) %string
                        % be safe for editing pad tmpVal with space 
                        eval(['data.' var '(idx,:) = [tmpVal,repmat('' '...
                            ''',1,size(data.' var ', 2) - length(tmpVal))];']);
                    else % numeric
                        
                        eval(['data.' var '(idx) = str2num([type ''('' tmpVal '')'']);']);
                        
                    end
                end
                
            elseif exist([var '_check'],'var')
                
                eval(['data.' var '(idx) = get(' var '_check,''Value'');']);
                
            elseif exist([var '_edit'],'var')
                
                % store unit no (as chars)
                tmpVal = eval(['deblank(get(' var '_edit,''String''))']);
                % save it according to type
                if ~strcmp(tmpVal,'')
                    if eval(['ischar(data.' var ')']) %string
                        eval(['data.' var '(idx,:) = [tmpVal,repmat('' '...
                            ''',1,size(data.' var ', 2) - length(tmpVal))];']);
                    else % numeric
                        
                        eval(['data.' var '(idx) = str2num([type ''('' tmpVal '')'']);']);
                        
                    end
                end
                
            elseif exist([var 'notes_edit'],'var')
                
                tmpVal = eval(['deblank(get(' var 'notes_edit,''String''))']);
                % check if user previously entered comment (only possible in
                % editing)
                tmpIndexed = eval(['(data.' var 'key == idx)']);
                if ~strcmp(tmpVal,'')
                    if sum(tmpIndexed) == 1 % yes, overwrite previous comment
                        eval(['data.' var 'notes(tmpIndexed,:) = [tmpVal,repmat('' '...
                            ''',1,size(data.' var 'notes, 2) - length(tmpVal))];']);
                    else %no, add to end
                        
                        eval(['data.' var 'key(data.' var 'idx) = idx;']);
                        eval(['data.' var 'notes(data.' var 'idx,:) = [tmpVal,repmat('' '...
                            ''',1,size(data.' var 'notes, 2) - length(tmpVal))];']);
                        eval(['data.' var 'idx = data.' var 'idx + 1;']);
                        
                    end
                end
                
            elseif strcmp(var,'dom') % calculate the days on market
                
                % get sale date, list date- curr & list date- old
                s_date = deblank(get(sold_date_edit, 'String'));
                lo_date = deblank(get(list_date_old_edit,'String'));
                lc_date = deblank(get(list_date_curr_edit,'string'));
                
                % can't calculate DOM without a sold date
                if strcmp(s_date,'') || strcmp(s_date,'dd/mm/yy') % no sold date
                   
                    data.dom(idx) = 0;
                    
                else % is a sold date, try to find when it was first advertised
                    
                    if strcmp(lo_date,'') || strcmp(lo_date,'dd/mm/yy') % no old list date
                        
                        % check if there is a current list date
                        if strcmp(lc_date,'') || strcmp(lc_date,'dd/mm/yy') % no current list date
                            data.dom(idx) = 0;
                        else % DOM = sold date - curr list date + 1
                            % convert dates to numbers
                            s_date = datenum(s_date,'dd/mm/yy');
                            lc_date = datenum(lc_date,'dd/mm/yy');
                            data.dom(idx) = s_date - lc_date + 1;
                            
                        end
                    
                    else % DOM = sold date - old list date + 1
                       % convert dates to numbers
                       s_date = datenum(s_date,'dd/mm/yy');
                       lo_date = datenum(lo_date,'dd/mm/yy');
                       data.dom(idx) = s_date - lo_date + 1;
                    end
                    
                end
                
                
            else
                errordlg('Unaccounted for situation. Please tell Peter.',...
                    'Peter Forgot Something');
                return;
            end
        end
        
        
    end

    % helper fn: data2controls 
    % description: uses load_idx to set all uicontrols to saved values
    %               for that particular property
    function data2controls()
        
       for i = 1:size(VAR_ARR,1) % for each variable
       
           % retrieve variable
           var = deblank(VAR_ARR(i,:,VAR));
           
           % determine the corresponding handle
           if strcmp(var,'modern') % special case
           
               if data.modern(load_idx) == 1
                   set(yes_radio,'Value',1);
                   set(no_radio,'Value',0);
               else
                   set(no_radio,'Value',1);
                   set(yes_radio,'Value',0);
               end
               
           elseif exist([var '_popup'],'var')
               
               tmpHaystack = eval(['get(' var '_popup,''String'')']);
               if eval(['ischar(data.' var ')'])
                   tmpNeedle = eval(['deblank(data.' var '(load_idx,:))']);
               else
                   tmpNeedle = eval(['int2str(data.' var '(load_idx))']);
               end
               tmpIndexed = strcmp(cellstr(tmpNeedle),tmpHaystack);
               tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
               tmpAns = tmpCoded(tmpIndexed);
               eval(['set(' var '_popup,''Value'',tmpAns)']);
       
           elseif exist([var '_check'],'var')
           
               eval(['set(' var '_check,''Value'', data.' var '(load_idx))']);
               
           elseif exist([var '_edit'],'var')
             
               if eval(['ischar(data.' var ')'])
                   eval(['set(' var '_edit,''String'',data.' var '(load_idx,:))']);
               else
                   eval(['set(' var '_edit,''String'',int2str(data.' var '(load_idx)))']);
               end
               
           elseif exist([var 'notes_edit'],'var')
               
               % if a comment exists for this property, load it.
               tmpIndexed = eval(['data.' var 'key == load_idx']);
               if sum(tmpIndexed) ~= 0
                   eval(['set(' var 'notes_edit,''string'',data.' var 'notes(tmpIndexed,:))']);
               end
               
           elseif strcmp(var,'dom')
               
               % do nothing - these variables don't have anything to do
               % with the snap_in GUI.
               
           else
               errordlg('Unaccounted for situation. Please tell Peter.',...
                   'Peter Forgot Something');
               return;
           end
       end
       
       
       
    end



    % helper fn: expand_data()
    % description: expands rows of data struct elements as neccessary
    function expand_data()
       
       for i = 1:size(VAR_ARR,1) % for each variable
       
           % retrieve variable and type
           var = deblank(VAR_ARR(i,:,VAR));
           type = deblank(VAR_ARR(i,:,TYPE));
           
           
           if isfield(data,var) % not a note
           
               % NOTE this is a waste of processing time, checking all
               % variable when only need to check one 
               
               % only expand if full
               if data.idx == eval(['(size(data.' var ',1) + 1)'])
               
                   if eval(['ischar(data.' var ')']) % char
                       
                       eval(['data.' var ' = [data.' var ' ; repmat('' '','...
                           ' DATA_INCREMENT,size(data.' var ',2))];']);
                       
                   elseif eval(['isnumeric(data.' var ')']) % int
                       
                       eval(['data.' var ' = [data.' var ' ; zeros('...
                           'DATA_INCREMENT, 1, ''' type ''')];']);
                       
                   else % logical
                       
                       eval(['data.' var ' = [data.' var ' ; false(' ...
                           'DATA_INCREMENT,1)];']);
                       
                   end
                   
               end
               
           else  % is a note
               
               % only expand if full
               if eval(['data.' var 'idx == (size(data.' var 'key,1) + 1)'])
                    
                   % expand the key
                   eval(['data.' var 'key = [data.' var 'key; ' ...
                       'zeros(NOTES_INCREMENT,1,''uint16'')];']);
                   % as well as the notes 
                   eval(['data.' var 'notes = [data.' var 'notes; ' ...
                       'repmat('' '',NOTES_INCREMENT,XLSTR)]']);
                   
               end
               
           end
           
       end
        
        
    end


    % helper fn: associate_agency
    % purpose is to 'remember' the agency of each agent in the case that
    % the user has added a new agent or agency
    function associate_agency()

        % determine where to save
        if load_idx ~= 0
            % we want to overwrite this property
            idx = load_idx;
        else
            % we want to add a new property
            idx = data.idx - 1; % subtract one as we would have already incremented
        end
        
        
        for curr_old = {'old', 'curr'}

            % user wants to add a new agency
            if eval(['strcmpi(get(agency_' curr_old{1} '_edit,''Visible''),''on'')'])
                %add the name to the names list
                agency = eval(['deblank(get(agency_' curr_old{1} '_edit,''string''))']);
                matches = strcmp(cellstr(agency),data.agencies);
                if sum(matches) == 0 % haven't yet added this agency
                    data.agencies = [data.agencies; repmat(' ',1,(LSTR +SSTR))];
                    data.agencies(end,:) = [agency, repmat(' ',1,...
                        size(data.agencies,2) - length(agency))];
                    % sort it
                    data.agencies = [data.agencies(1:2,:); ...
                        sortrows(data.agencies(3:end,:))];
                    
                    % add the name as this properties old agency
                    eval(['data.agency_' curr_old{1} '(idx,:) = [agency, ' ...
                        'repmat('' '',1,size(data.agency_' curr_old{1} ',2) '...
                        '- length(agency))];']);
                else % already added the agency
                    errordlg('Attempted to add existing agency',...
                        'Attempted To Add Existing Agency');
                    return;
                end
            else % agency is whatever is in the popup box
                
                agency = eval(['get(agency_' curr_old{1} '_popup,''String'')']);
                agency = eval(['deblank(agency(get(agency_' curr_old{1} '_popup,''Value''),:))']);
                
            end
            
            % get selected agent
            agent = eval(['get(list_agent_' curr_old{1} '_popup,''String'')']);
            agent = eval(['deblank(agent(get(list_agent_' curr_old{1} '_popup,''Value''),:))']);
            
            % user wants to add a new agent
            if strcmp(agent,'Add New')
                
                %add the name to the names list
                new_agent = eval(['deblank(get(list_agent_' curr_old{1} '_edit,''string''))']);
                matches = strcmp(cellstr(new_agent),data.agent_names);
                if sum(matches) == 0 % haven't yet added this agent
                    data.agent_names = [data.agent_names; repmat(' ',1,LSTR)];
                    data.agent_names(end,:) = [new_agent, repmat(' ',1,...
                        size(data.agent_names,2) - length(new_agent))];
                    %           sort it
                    [sorted, order] = sortrows(data.agent_names(3:end,:));
                    data.agent_names = [data.agent_names(1:2,:); ...
                        sorted];
                    % store the corresponding agency for this agent
                    data.agents_agency = [data.agents_agency; ...
                        repmat(' ',1,(LSTR + SSTR))];
                    data.agents_agency(end,:) = [agency, repmat(' ',1,...
                        size(data.agents_agency,2) - length(agency))];
                    % the agents agency list must be sorted in the same way
                    data.agents_agency = data.agents_agency(order,:);
                    
                    %           add the name as this properties old listing agent
                    eval(['data.list_agent_' curr_old{1} '(idx,:) = [new_agent, ' ...
                        'repmat('' '',1,size(data.list_agent_' curr_old{1} ',2) '...
                        '- length(new_agent))];']);
                else % already added the agent
                    errordlg('Attempted to add existing agent',...
                        'Attempted To Add Existing Agent');
                    return;
                end
                
            elseif ~strcmp(agent,'-') % user didn't add a new name, but may have added a different agency for this agent
                
                % store the corresponding agency for this agent
                tmp_idx = strcmp(cellstr(data.agent_names(3:end,:)),agent);
                data.agents_agency(tmp_idx,1:length(agency)) = agency;
                
            end
            
            
        end    
    end






%-------------------------------------------------------------------
% end of code
end