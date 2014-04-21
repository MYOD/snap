function snap_in
% GUI snap_in
% Purpose is to to input house inspection data

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

% load key data
data_file = 'snap_data/snap_data.mat';
if exist(data_file,'file')
    load(data_file);
    
% first time initialisation    
else

    %   indices for data structures
    data.max = 200; % this is expected DATA_MAX number of properties
    data.idea_max = 30;
    data.general_max = 30;
    data.suburb_max = 30;
    data.street_max = 30;
    data.local_max = 30;
    data.agent_max = 30;
    data.buyer_max = 50;

    data.idx = 1; %unique to each property
    data.ideas_idx = 1;
    data.general_idx = 1;
    data.suburb_idx = 1;
    data.street_idx = 1;
    data.local_idx = 1;
    data.agent_idx = 1;
    data.buyer_idx = 1;

%     columns - address
    data.unit_no = repmat(' ',data.max,SSTR);
    data.street_no = repmat(' ',data.max,SSTR);
    data.street = repmat(' ',data.max,LSTR);
    data.st_type = repmat(' ',data.max,SSTR);
    data.suburb = repmat(' ',data.max,LSTR);
%     columns - inspection
    data.inspect_date = repmat(' ',data.max,SSTR);
    data.inspect_start = repmat(' ',data.max,XSSTR);
    data.inspect_end = repmat(' ',data.max,XSSTR);
%   columns - key data
    data.modern = zeros(data.max,1,'int8');
    data.maisonette = zeros(data.max,1,'int8');
    data.built = zeros(data.max,1,'uint16');
    data.last_reno = zeros(data.max,1,'uint16');
    data.land_area = zeros(data.max,1,'uint16');
    data.floor_area = zeros(data.max,1,'uint16');
    data.frontage = zeros(data.max,1,'uint8');
%   columns - construction
    data.construction = repmat(' ',data.max,LSTR);
    data.construction_c = zeros(data.max,1,'int8');    
%   columns - roofing
    data.roofing = repmat(' ',data.max,LSTR);
    data.roofing_c = zeros(data.max,1,'int8');
    data.roofing_d = zeros(data.max,1,'int8');    
%   columns - front yard
    data.front_yard_c = zeros(data.max,1,'int8');
    data.front_yard_d= zeros(data.max,1,'int8');
    data.front_yard_s = zeros(data.max,1,'int8');
%   columns - front facade
    data.front_facade = repmat(' ',data.max,LSTR);
    data.front_facade_c = zeros(data.max,1,'int8');
    data.front_facade_d = zeros(data.max,1,'int8');    
%   columns - parking
    data.garages = zeros(data.max,1,'int8');
    data.carports = zeros(data.max,1,'int8');
    data.secures = zeros(data.max,1,'int8');
    data.offstreets = zeros(data.max,1,'int8');  
    data.parking_c = zeros(data.max,1,'int8');
    data.parking_d = zeros(data.max,1,'int8');
%   columns - flooring
    data.tile = zeros(data.max,1,'int8');
    data.slate = zeros(data.max,1,'int8');
    data.floorboard = zeros(data.max,1,'int8');
    data.vinyl = zeros(data.max,1,'int8');
    data.carpet = zeros(data.max,1,'int8');
    data.flooring_c = zeros(data.max,1,'int8');
    data.flooring_d = zeros(data.max,1,'int8');
%   columns - kitchen
    data.open_living = zeros(data.max,1,'int8');
    data.pantry = zeros(data.max,1,'int8');
    data.kitchen_c = zeros(data.max,1,'int8');
    data.kitchen_d = zeros(data.max,1,'int8');
    data.kitchen_s = zeros(data.max,1,'int8');
%   columns - bathroom
    data.baths = zeros(data.max,1,'int8');
    data.showers = zeros(data.max,1,'int8');
    data.spas = zeros(data.max,1,'int8');
    data.toilets = zeros(data.max,1,'int8');
    data.bathroom_c = zeros(data.max,1,'int8');
    data.bathroom_d = zeros(data.max,1,'int8');
    data.bathroom_s = zeros(data.max,1,'int8');
    data.heatlamp = zeros(data.max,1,'int8');
%   columns - bedroom
    data.bedrooms = zeros(data.max,1,'int8');
    data.wirs = zeros(data.max,1,'int8');
    data.birs = zeros(data.max,1,'int8');
    data.kids = zeros(data.max,1,'int8');
    data.ensuites = zeros(data.max,1,'int8');
    data.brts = zeros(data.max,1,'int8'); %BR toilets
    data.bedroom_c = zeros(data.max,1,'int8');
    data.bedroom_d = zeros(data.max,1,'int8');
    data.bedroom_s = zeros(data.max,1,'int8');
%   columns - climate control
    data.heating = zeros(data.max,1,'int8');
    data.cooling = zeros(data.max,1,'int8');
    data.coverage = zeros(data.max,1,'int8');
%   columns - backyard
    data.back_yard_c = zeros(data.max,1,'int8');
    data.back_yard_d = zeros(data.max,1,'int8');
    data.back_yard_s = zeros(data.max,1,'int8');
    data.pergola = zeros(data.max,1,'int8');
    data.verandah = zeros(data.max,1,'int8');
    data.verandah_c = zeros(data.max,1,'int8');
    data.verandah_d = zeros(data.max,1,'int8');
    data.verandah_s = zeros(data.max,1,'int8');
    data.grass = zeros(data.max,1,'int8');
    data.grass_c = zeros(data.max,1,'int8');
    data.grass_d = zeros(data.max,1,'int8');
    data.grass_s = zeros(data.max,1,'int8');
%   columns - other features
    data.swim = zeros(data.max,1,'int8');
    data.swim_c = zeros(data.max,1,'int8');
    data.swim_d = zeros(data.max,1,'int8');
    data.swim_s = zeros(data.max,1,'int8');
    data.shed = zeros(data.max,1,'int8');
    data.shed_types = repmat(' ',data.max,LSTR);
    data.granny_flat = zeros(data.max,1,'int8');
    data.granny_flat_c = zeros(data.max,1,'int8');
    data.granny_flat_d = zeros(data.max,1,'int8');
    data.granny_flat_s = zeros(data.max,1,'int8');
%   columns - comments
    data.idea_key = zeros(data.idea_max,1,'uint16');
    data.idea_notes = repmat(' ',data.idea_max,XLSTR);
    data.general_key = zeros(data.general_max,1,'uint16');
    data.general_notes = repmat(' ',data.general_max,XLSTR);
    data.suburb_key = zeros(data.suburb_max,1,'uint16');
    data.suburb_notes = repmat(' ',data.suburb_max,XLSTR);
    data.street_key = zeros(data.street_max,1,'uint16');
    data.street_notes = repmat(' ',data.street_max,XLSTR);
    data.local_key = zeros(data.local_max,1,'uint16');
    data.local_notes = repmat(' ',data.local_max,XLSTR);
    data.agent_key = zeros(data.agent_max,1,'uint16');
    data.agent_notes = repmat(' ',data.agent_max,XLSTR);
    data.buyer_key = zeros(data.buyer_max,1,'uint16');
    data.buyer_notes = repmat(' ',data.buyer_max,XLSTR);
%   columns - sales
    data.list_price_old = zeros(data.max,1,'uint16');
    data.list_date_old = repmat(' ',data.max,SSTR);
    data.list_agent_old = repmat(' ',data.max,SSTR);
    data.list_price_curr = zeros(data.max,1,'uint16');
    data.list_date_curr = repmat(' ',data.max,SSTR);
    data.list_agent_curr = repmat(' ',data.max,SSTR);
    data.sold_price = zeros(data.max,1,'uint16');
    data.sold_date = repmat(' ',data.max,SSTR);
    
%   save data to disk
    save(data_file,'data','-v6');
    
end


%  Create and then hide the GUI as it is being constructed.
h_fig = figure('Visible','off','MenuBar','none','toolbar','none',...
    'numbertitle','off','Position',[1,11,720,650],'name','Snap: input',...
    'CloseRequestFcn',{@exit_callback});

%---------------------------------------------------------------------
%  Construct the components of the figure

% adress components
LINE_Y=1- POPUP_H - Y_GAP/2;
TMP_X = X_GAP;
address_txt = uicontrol('parent',h_fig,'Style','text',...
    'String','Address:','Units','normalized',...
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
    'Units','normalized','String',{'Ave','Bowl','Cct','Cl','Cres','Ct',...
    'Dr','Gr','St',},...
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
    'String','Inspection:','Units','normalized',...
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
TMP_X=TMP_X+X_GAP+2*STXT_W;
modern_check = uicontrol('parent',h_fig,'Style','check',...
    'String','Modern','Units','normalized',...
    'Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
maisonette_check = uicontrol('parent',h_fig,'Style','check',...
    'String','Maisonette','Units','normalized',...
    'Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);


% done button
done_button = uicontrol('parent',h_fig,'Style','pushbutton',...
    'String','SAVE!','Units','normalized',...
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
    'Units','normalized','String','Floor Area:','Position',...
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

% construction components
LINE_Y=1- POPUP_H - Y_GAP;
% CMTS_Y=LINE_Y - COMMENT_H - 0.01;
TMP_X = X_GAP;
construction_txt = uicontrol('parent',features_panel,'Style','text','String','Construction:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
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

% roofing components
TMP_X = X_GAP;
LINE_Y=LINE_Y - POPUP_H - Y_GAP;
roofing_txt = uicontrol('parent',features_panel,'Style','text','String','Roofing:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
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

% front yard/facade components
TMP_X= X_GAP;
LINE_Y=LINE_Y - POPUP_H - Y_GAP;
front_yard_txt = uicontrol('parent',features_panel,'Style','text','String','Front Yard:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
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
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
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
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
garage_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',NUMS,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
garage_txt = uicontrol('parent',features_panel,'Style','text','String','garage(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
carport_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',NUMS,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
carport_txt = uicontrol('parent',features_panel,'Style','text','String','carport(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
secure_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',NUMS,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
secure_txt = uicontrol('parent',features_panel,'Style','text','String','secure,',...
    'Units','normalized','Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
offstreet_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
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

% flooring components
TMP_X = X_GAP;
LINE_Y=LINE_Y - POPUP_H - Y_GAP;
flooring_txt = uicontrol('parent',features_panel,'Style','text','String','Flooring:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
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
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
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

% bathroom components
TMP_X = X_GAP;
LINE_Y=LINE_Y - POPUP_H - Y_GAP;
bathroom_txt = uicontrol('parent',features_panel,'Style','text','String','Bathroom:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
bath_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',NUMS,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
bath_txt = uicontrol('parent',features_panel,'Style','text','String','bath(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
shower_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',NUMS,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
shower_txt = uicontrol('parent',features_panel,'Style','text','String','shower(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
spa_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',NUMS,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
spa_txt = uicontrol('parent',features_panel,'Style','text','String','spa(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
toilet_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',NUMS,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
toilet_txt = uicontrol('parent',features_panel,'Style','text','String','toilet(s),',...
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
heatlamp_check = uicontrol('parent',features_panel,'Style','checkbox','Units','normalized',...
    'String','Heatlamps','Position', [TMP_X,LINE_Y,TXT_W,POPUP_H]);

% bedroom components
TMP_X = X_GAP;
LINE_Y=LINE_Y - POPUP_H - Y_GAP;
bedroom_txt = uicontrol('parent',features_panel,'Style','text','String','Bedroom: x',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+TXT_W;
bedroom_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',NUMS,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
wir_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',NUMS,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
wir_txt = uicontrol('parent',features_panel,'Style','text','String','WIR(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
bir_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
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
ensuite_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',NUMS,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
ensuite_txt = uicontrol('parent',features_panel,'Style','text','String','ensuite(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
brt_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
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
cc_txt = uicontrol('parent',features_panel,'Style','text','String','Climate Control:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
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
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
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
pergola_check = uicontrol('parent',features_panel,'Style','checkbox','Units','normalized',...
    'String','Pergola','Position',...
    [TMP_X,LINE_Y,STXT_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
verandah_check = uicontrol('parent',features_panel,'Style','checkbox','Units','normalized',...
    'String','Verandah','Position',...
    [TMP_X,LINE_Y,TXT_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
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
    [TMP_X,LINE_Y,STXT_W,POPUP_H]);
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
of_txt = uicontrol('parent',features_panel,'Style','text','String','Other Features:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
swim_check = uicontrol('parent',features_panel,'Style','checkbox','String','Swimming Pool',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W+0.01,TXT_H]);
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
    [TMP_X,LINE_Y,STXT_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
shed_edit = uicontrol('parent',features_panel,'Style','edit',...
    'Units','normalized','String','','horizontalAlignment','left',...
    'Position', [TMP_X,LINE_Y,2*TXT_W,TXT_H],'Callback',{@edit_callback},...
    'userData',LSTR);
TMP_X = X_GAP+TXT_W;
LINE_Y=LINE_Y - POPUP_H - Y_GAP/2;
granny_flat_check = uicontrol('parent',features_panel,'Style','checkbox','Units','normalized',...
    'String','Granny Flat','Position',...
    [TMP_X,LINE_Y,TXT_W,POPUP_H]);
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
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
ideas_edit = uicontrol('parent',comments_panel,'Style','edit',...
    'Units','normalized',...
    'String','','min',0,'max',10,'horizontalAlignment','left',...
    'Position', [TMP_X,LINE_Y-COMMENT_H/2,COMMENT_W,COMMENT_H],...
    'Callback',{@edit_callback},'userData',XLSTR);

% general comments components
TMP_X = X_GAP;
LINE_Y=LINE_Y - COMMENT_H - Y_GAP;
general_txt = uicontrol('parent',comments_panel,'Style','text','String','General:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
general_edit = uicontrol('parent',comments_panel,'Style','edit','Units','normalized',...
    'String','','min',0,'max',10,'horizontalAlignment','left',...
    'Position', [TMP_X,LINE_Y-COMMENT_H/2,COMMENT_W,COMMENT_H],...
    'Callback',{@edit_callback},'userData',XLSTR);

% suburb comments components
TMP_X = X_GAP;
LINE_Y=LINE_Y - COMMENT_H - Y_GAP;
suburb_comment_txt = uicontrol('parent',comments_panel,'Style','text','String','Suburb:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
suburb_comment_edit = uicontrol('parent',comments_panel,'Style','edit','Units','normalized',...
    'String','','min',0,'max',10,'horizontalAlignment','left',...
    'Position', [TMP_X,LINE_Y-COMMENT_H/2,COMMENT_W,COMMENT_H],...
    'Callback',{@edit_callback},'userData',XLSTR);

% street comments components
TMP_X = X_GAP;
LINE_Y=LINE_Y - COMMENT_H - Y_GAP;
street_comment_txt = uicontrol('parent',comments_panel,'Style','text','String','Street:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
street_comment_edit = uicontrol('parent',comments_panel,'Style','edit','Units','normalized',...
    'String','','min',0,'max',10,'horizontalAlignment','left',...
    'Position', [TMP_X,LINE_Y-COMMENT_H/2,COMMENT_W,COMMENT_H],...
    'Callback',{@edit_callback},'userData',XLSTR);

% local neighbourhood components
TMP_X = X_GAP;
LINE_Y=LINE_Y - COMMENT_H - Y_GAP;
local_comment_txt = uicontrol('parent',comments_panel,'Style','text','String','Neighbourhood:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
local_comment_edit = uicontrol('parent',comments_panel,'Style','edit','Units','normalized',...
    'String','','min',0,'max',10,'horizontalAlignment','left',...
    'Position', [TMP_X,LINE_Y-COMMENT_H/2,COMMENT_W,COMMENT_H],...
    'Callback',{@edit_callback},'userData',XLSTR);

% Agent components
TMP_X = X_GAP;
LINE_Y=LINE_Y - COMMENT_H - Y_GAP;
agent_txt = uicontrol('parent',comments_panel,'Style','text','String','Agent:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
agent_edit = uicontrol('parent',comments_panel,'Style','edit','Units','normalized',...
    'String','','min',0,'max',10,'horizontalAlignment','left',...
    'Position', [TMP_X,LINE_Y-COMMENT_H/2,COMMENT_W,COMMENT_H],...
    'Callback',{@edit_callback},'userData',XLSTR);

% Buyer components
TMP_X = X_GAP;
LINE_Y=LINE_Y - COMMENT_H - Y_GAP;
buyers_txt = uicontrol('parent',comments_panel,'Style','text','String','Buyers:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
buyers_edit = uicontrol('parent',comments_panel,'Style','edit','Units','normalized',...
    'String','','min',0,'max',10,'horizontalAlignment','left',...
    'Position', [TMP_X,LINE_Y-COMMENT_H/2,COMMENT_W,COMMENT_H],...
    'Callback',{@edit_callback},'userData',XLSTR);

%---------------------------------------------------------------------
%  Construct the components of comments panel

% oldest listing components
LINE_Y= 1- POPUP_H - Y_GAP/2;
TMP_X = X_GAP;
list_price_old_txt = uicontrol('parent',sales_panel,'Style','text',...
    'String','Old List Price: $','Units','normalized',...
    'Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
list_price_old_edit = uicontrol('parent',sales_panel,'Style','edit',...
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
list_agent_old_txt = uicontrol('parent',sales_panel,'Style','text',...
    'String','Agent:','Units','normalized',...
    'Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
list_agent_old_edit = uicontrol('parent',sales_panel,'Style','edit',...
    'Units','normalized','String','','Position',...
    [TMP_X,LINE_Y,STXT_W,TXT_H],'Callback',{@edit_callback},'userData',LSTR);


% current listing components
LINE_Y= LINE_Y - POPUP_H - Y_GAP/2;
TMP_X = X_GAP;
list_price_curr_txt = uicontrol('parent',sales_panel,'Style','text',...
    'String','New List Price: $','Units','normalized',...
    'Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
list_price_curr_edit = uicontrol('parent',sales_panel,'Style','edit',...
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
list_agent_curr_txt = uicontrol('parent',sales_panel,'Style','text',...
    'String','Agent:','Units','normalized',...
    'Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
list_agent_curr_edit = uicontrol('parent',sales_panel,'Style','edit',...
    'Units','normalized','String','','Position',...
    [TMP_X,LINE_Y,STXT_W,TXT_H],'Callback',{@edit_callback},'userData',LSTR);

% sold components
LINE_Y= LINE_Y - POPUP_H - Y_GAP/2;
TMP_X = X_GAP;
sold_price_txt = uicontrol('parent',sales_panel,'Style','text',...
    'String','Sold Price: $','Units','normalized',...
    'Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
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

% Move the GUI to the center of the screen.
movegui(h_fig,'center')

% Make the GUI visible.
set(h_fig,'Visible','on');

% By defaults start on the features tab
features_callback(features_tab,0);

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
        
    end

%   user pushed the done button
    function done_callback(source,eventdata)
    
        %---------------------------------------------------------
%        collect user data input to GUI

        % store unit no (as chars)
        tmpVal = get(unit_no_edit,'String');
        if ~strcmp(tmpVal,'Unit #')
            data.unit_no(data.idx,1:length(tmpVal)) = tmpVal;    
        end
        
        % store house no (as chars)
        tmpVal = get(street_no_edit,'String');
        if ~strcmp(tmpVal,'St. #')
            data.street_no(data.idx,1:length(tmpVal)) = tmpVal;  
        else % user didn't enter compulsory value
            errordlg('You must specify a street number!',...
                'Need Street Number');
            return;
        end
        
        % store street (as chars)
        tmpVal = get(street_edit,'String');
        if ~strcmp(tmpVal,'Street')
            data.street(data.idx,1:length(tmpVal)) = tmpVal;            
        else % user didn't enter compulsory value
            errordlg('You must specify a street name!',...
                'Need Street Name');
            return;
        end
        
        % store street type (as chars)
        tmpVal = get(st_type_popup,'String');
        tmpVal = tmpVal{get(st_type_popup,'Value')};
        data.st_type(data.idx,1:length(tmpVal)) = tmpVal;

        % store suburb type (as chars)
        tmpVal = get(suburb_popup,'String');
        tmpVal = tmpVal{get(suburb_popup,'Value')};
        data.suburb(data.idx,1:length(tmpVal)) = tmpVal;
        
        % store inspection date (as chars)
        tmpVal = get(inspect_date_edit,'String');
        if ~strcmp(tmpVal,'dd/mm/yy')
            data.inspect_date(data.idx,1:length(tmpVal)) = tmpVal;
        end
        
        % store inspection start time (as chars)
        tmpVal = get(inspect_start_edit,'String');
        if ~strcmp(tmpVal,'HH:MM')
            data.inspect_start(data.idx,1:length(tmpVal)) = tmpVal;
        end
        
        % store inspection end time (as chars)
        tmpVal = get(inspect_end_edit,'String');
        if ~strcmp(tmpVal,'HH:MM')
            data.inspect_end(data.idx,1:length(tmpVal)) = tmpVal;
        end
        
        % store modern boolean (as int8)
        data.modern(data.idx) = int8(get(modern_check,'Value'));
        
        % store maisonette boolean (as int8)
        data.maisonette(data.idx) = int8(get(maisonette_check,'Value'));
        
        % store built year (as uint16)
        tmpVal = get(built_edit,'String');
        data.built(data.idx) = str2num(['uint16(' tmpVal ')']);
        
        % store last renovated year (as uint16)
        tmpVal = get(last_reno_edit,'String');
        data.last_reno(data.idx) = str2num(['uint16(' tmpVal ')']);
        
        % store land area (as uint16)
        tmpVal = get(land_area_edit,'String');
        data.land_area(data.idx) = str2num(['uint16(' tmpVal ')']);
        
        % store floor area (as uint16)
        tmpVal = get(floor_area_edit,'String');
        data.floor_area(data.idx) = str2num(['uint16(' tmpVal ')']);
        
        % store frontage (as uint8)
        tmpVal = get(frontage_edit,'String');
        data.frontage(data.idx) = str2num(['uint8(' tmpVal ')']);
        
        % store construction (as chars)
        tmpVal = get(construction_popup,'String');
        tmpVal = tmpVal{get(construction_popup,'Value')};
        data.construction(data.idx,1:length(tmpVal)) = tmpVal;

        % store construction C (as int8)
        tmpVal = get(construction_c_popup,'String');
        tmpVal = tmpVal{get(construction_c_popup,'Value')};
        data.construction_c(data.idx) = str2num(['int8(' tmpVal ')']);
        
        % store roofing (as chars)
        tmpVal = get(roofing_popup,'String');
        tmpVal = tmpVal{get(roofing_popup,'Value')};
        data.roofing(data.idx,1:length(tmpVal)) = tmpVal;
        
        % store roofing C (as int8)
        tmpVal = get(roofing_c_popup,'String');
        tmpVal = tmpVal{get(roofing_c_popup,'Value')};
        data.roofing_c(data.idx) = str2num(['int8(' tmpVal ')']);
        
        % store roofing D (as int8)
        tmpVal = get(roofing_d_popup,'String');
        tmpVal = tmpVal{get(roofing_d_popup,'Value')};
        data.roofing_d(data.idx) = str2num(['int8(' tmpVal ')']);
        
        % store front yard C (as int8)
        tmpVal = get(front_yard_c_popup,'String');
        tmpVal = tmpVal{get(front_yard_c_popup,'Value')};
        data.front_yard_c(data.idx) = str2num(['int8(' tmpVal ')']);
        
        % store front yard D (as int8)
        tmpVal = get(front_yard_d_popup,'String');
        tmpVal = tmpVal{get(front_yard_d_popup,'Value')};
        data.front_yard_d(data.idx) = str2num(['int8(' tmpVal ')']);
        
        % store front yard S (as int8)
        tmpVal = get(front_yard_s_popup,'String');
        tmpVal = tmpVal{get(front_yard_s_popup,'Value')};
        data.front_yard_s(data.idx) = str2num(['int8(' tmpVal ')']);       
        
        % store front facade (as chars)
        tmpVal = get(front_facade_popup,'String');
        tmpVal = tmpVal{get(front_facade_popup,'Value')};
        data.front_facade(data.idx,1:length(tmpVal)) = tmpVal;      
        
        % store front facade C (as int8)
        tmpVal = get(front_facade_c_popup,'String');
        tmpVal = tmpVal{get(front_facade_c_popup,'Value')};
        data.front_facade_c(data.idx) = str2num(['int8(' tmpVal ')']);
        
        % store front facade D (as int8)
        tmpVal = get(front_facade_d_popup,'String');
        tmpVal = tmpVal{get(front_facade_d_popup,'Value')};
        data.front_facade_d(data.idx) = str2num(['int8(' tmpVal ')']);        
        
        % store number of garages (as int8)
        tmpVal = get(garage_popup,'String');
        tmpVal = tmpVal{get(garage_popup,'Value')};
        data.garages(data.idx) = str2num(['int8(' tmpVal ')']);
        
        % store number of carports (as int8)
        tmpVal = get(carport_popup,'String');
        tmpVal = tmpVal{get(carport_popup,'Value')};
        data.carports(data.idx) = str2num(['int8(' tmpVal ')']);
        
        % store number of secured car parking (as int8)
        tmpVal = get(secure_popup,'String');
        tmpVal = tmpVal{get(secure_popup,'Value')};
        data.secures(data.idx) = str2num(['int8(' tmpVal ')']);

        % store number of offstreet car parking (as int8)
        tmpVal = get(offstreet_popup,'String');
        tmpVal = tmpVal{get(offstreet_popup,'Value')};
        data.offstreets(data.idx) = str2num(['int8(' tmpVal ')']);
        
        % store parking C (as int8)
        tmpVal = get(parking_c_popup,'String');
        tmpVal = tmpVal{get(parking_c_popup,'Value')};
        data.parking_c(data.idx) = str2num(['int8(' tmpVal ')']);        
        
        % store parking D (as int8)
        tmpVal = get(parking_d_popup,'String');
        tmpVal = tmpVal{get(parking_d_popup,'Value')};
        data.parking_d(data.idx) = str2num(['int8(' tmpVal ')']);          
        
        % store tile boolean (as int8)
        data.tile(data.idx) = int8(get(tile_check,'Value'));
        
        % store slate boolean (as int8)
        data.slate(data.idx) = int8(get(slate_check,'Value'));
        
        % store floorboard boolean (as int8)
        data.floorboard(data.idx) = int8(get(floorboard_check,'Value'));
        
        % store vinyl boolean (as int8)
        data.vinyl(data.idx) = int8(get(vinyl_check,'Value'));
        
        % store carpet boolean (as int8)
        data.carpet(data.idx) = int8(get(carpet_check,'Value'));
        
        % store flooring C (as int8)
        tmpVal = get(flooring_c_popup,'String');
        tmpVal = tmpVal{get(flooring_c_popup,'Value')};
        data.flooring_c(data.idx) = str2num(['int8(' tmpVal ')']);        
        
        % store flooring D (as int8)
        tmpVal = get(flooring_d_popup,'String');
        tmpVal = tmpVal{get(flooring_d_popup,'Value')};
        data.flooring_d(data.idx) = str2num(['int8(' tmpVal ')']);       
        
        % store open living boolean (as int8)
        data.open_living(data.idx) = int8(get(open_living_check,'Value'));
        
        % store pantry boolean (as int8)
        data.pantry(data.idx) = int8(get(pantry_check,'Value'));
        
        % store kitchen C (as int8)
        tmpVal = get(kitchen_c_popup,'String');
        tmpVal = tmpVal{get(kitchen_c_popup,'Value')};
        data.kitchen_c(data.idx) = str2num(['int8(' tmpVal ')']);        
        
        % store kitchen D (as int8)
        tmpVal = get(kitchen_d_popup,'String');
        tmpVal = tmpVal{get(kitchen_d_popup,'Value')};
        data.kitchen_d(data.idx) = str2num(['int8(' tmpVal ')']);       
       
        % store kitchen S (as int8)
        tmpVal = get(kitchen_s_popup,'String');
        tmpVal = tmpVal{get(kitchen_s_popup,'Value')};
        data.kitchen_s(data.idx) = str2num(['int8(' tmpVal ')']);       
        
        % store number of baths (as int8)
        tmpVal = get(bath_popup,'String');
        tmpVal = tmpVal{get(bath_popup,'Value')};
        data.baths(data.idx) = str2num(['int8(' tmpVal ')']);
        
        % store number of showers (as int8)
        tmpVal = get(shower_popup,'String');
        tmpVal = tmpVal{get(shower_popup,'Value')};
        data.showers(data.idx) = str2num(['int8(' tmpVal ')']);
        
        % store number of toilets (as int8)
        tmpVal = get(toilet_popup,'String');
        tmpVal = tmpVal{get(toilet_popup,'Value')};
        data.toilets(data.idx) = str2num(['int8(' tmpVal ')']);
        
        % store bathroom C (as int8)
        tmpVal = get(bathroom_c_popup,'String');
        tmpVal = tmpVal{get(bathroom_c_popup,'Value')};
        data.bathroom_c(data.idx) = str2num(['int8(' tmpVal ')']);        
        
        % store bathroom D (as int8)
        tmpVal = get(bathroom_d_popup,'String');
        tmpVal = tmpVal{get(bathroom_d_popup,'Value')};
        data.bathroom_d(data.idx) = str2num(['int8(' tmpVal ')']);       
       
        % store bathroom S (as int8)
        tmpVal = get(bathroom_s_popup,'String');
        tmpVal = tmpVal{get(bathroom_s_popup,'Value')};
        data.bathroom_s(data.idx) = str2num(['int8(' tmpVal ')']);       
        
        % store heatlamp boolean (as int8)
        data.heatlamp(data.idx) = int8(get(heatlamp_check,'Value'));
        
        % store number of bedrooms (as int8)
        tmpVal = get(bedroom_popup,'String');
        tmpVal = tmpVal{get(bedroom_popup,'Value')};
        data.bedrooms(data.idx) = str2num(['int8(' tmpVal ')']);
        
        % store number of WIRs (as int8)
        tmpVal = get(wir_popup,'String');
        tmpVal = tmpVal{get(wir_popup,'Value')};
        data.wirs(data.idx) = str2num(['int8(' tmpVal ')']);
        
        % store number of BIRs (as int8)
        tmpVal = get(bir_popup,'String');
        tmpVal = tmpVal{get(bir_popup,'Value')};
        data.birs(data.idx) = str2num(['int8(' tmpVal ')']);
        
        % store number of kid rooms (as int8)
        tmpVal = get(kids_popup,'String');
        tmpVal = tmpVal{get(kids_popup,'Value')};
        data.kids(data.idx) = str2num(['int8(' tmpVal ')']);
        
        % store number of ensuites (as int8)
        tmpVal = get(ensuite_popup,'String');
        tmpVal = tmpVal{get(ensuite_popup,'Value')};
        data.ensuites(data.idx) = str2num(['int8(' tmpVal ')']);
        
        % store number of bedroom toilets (as int8)
        tmpVal = get(brt_popup,'String');
        tmpVal = tmpVal{get(brt_popup,'Value')};
        data.brts(data.idx) = str2num(['int8(' tmpVal ')']);        
        
        % store bedroom C (as int8)
        tmpVal = get(bedroom_c_popup,'String');
        tmpVal = tmpVal{get(bedroom_c_popup,'Value')};
        data.bedroom_c(data.idx) = str2num(['int8(' tmpVal ')']);        
        
        % store bedroom D (as int8)
        tmpVal = get(bedroom_d_popup,'String');
        tmpVal = tmpVal{get(bedroom_d_popup,'Value')};
        data.bedroom_d(data.idx) = str2num(['int8(' tmpVal ')']);       
       
        % store bathroom S (as int8)
        tmpVal = get(bedroom_s_popup,'String');
        tmpVal = tmpVal{get(bedroom_s_popup,'Value')};
        data.bedroom_s(data.idx) = str2num(['int8(' tmpVal ')']);       
        
        % store heating (as int8)
        tmpVal = get(heating_popup,'String');
        tmpVal = tmpVal{get(heating_popup,'Value')};
        data.heating(data.idx) = str2num(['int8(' tmpVal ')']);        
        
        % store cooling (as int8)
        tmpVal = get(cooling_popup,'String');
        tmpVal = tmpVal{get(cooling_popup,'Value')};
        data.cooling(data.idx) = str2num(['int8(' tmpVal ')']);       
       
        % store coverage (as int8)
        tmpVal = get(coverage_popup,'String');
        tmpVal = tmpVal{get(coverage_popup,'Value')};
        data.coverage(data.idx) = str2num(['int8(' tmpVal ')']);   
        
        % store backyard C (as int8)
        tmpVal = get(back_yard_c_popup,'String');
        tmpVal = tmpVal{get(back_yard_c_popup,'Value')};
        data.back_yard_c(data.idx) = str2num(['int8(' tmpVal ')']);        
        
        % store bedroom D (as int8)
        tmpVal = get(back_yard_d_popup,'String');
        tmpVal = tmpVal{get(back_yard_d_popup,'Value')};
        data.back_yard_d(data.idx) = str2num(['int8(' tmpVal ')']);       
       
        % store bathroom S (as int8)
        tmpVal = get(back_yard_s_popup,'String');
        tmpVal = tmpVal{get(back_yard_s_popup,'Value')};
        data.back_yard_s(data.idx) = str2num(['int8(' tmpVal ')']); 
        
        % store pergola boolean (as int8)
        data.pergola(data.idx) = int8(get(pergola_check,'Value'));

        % store verandah boolean (as int8)
        data.verandah(data.idx) = int8(get(verandah_check,'Value'));
        
        % store verandah C (as int8)
        tmpVal = get(verandah_c_popup,'String');
        tmpVal = tmpVal{get(verandah_c_popup,'Value')};
        data.verandah_c(data.idx) = str2num(['int8(' tmpVal ')']);        
        
        % store bedroom D (as int8)
        tmpVal = get(verandah_d_popup,'String');
        tmpVal = tmpVal{get(verandah_d_popup,'Value')};
        data.verandah_d(data.idx) = str2num(['int8(' tmpVal ')']);       
       
        % store bathroom S (as int8)
        tmpVal = get(verandah_s_popup,'String');
        tmpVal = tmpVal{get(verandah_s_popup,'Value')};
        data.verandah_s(data.idx) = str2num(['int8(' tmpVal ')']); 
        
        % store grass boolean (as int8)
        data.grass(data.idx) = int8(get(grass_check,'Value'));
        
        % store grass C (as int8)
        tmpVal = get(grass_c_popup,'String');
        tmpVal = tmpVal{get(grass_c_popup,'Value')};
        data.grass_c(data.idx) = str2num(['int8(' tmpVal ')']);        
        
        % store grass D (as int8)
        tmpVal = get(grass_d_popup,'String');
        tmpVal = tmpVal{get(grass_d_popup,'Value')};
        data.grass_d(data.idx) = str2num(['int8(' tmpVal ')']);       
       
        % store grass S (as int8)
        tmpVal = get(grass_s_popup,'String');
        tmpVal = tmpVal{get(grass_s_popup,'Value')};
        data.grass_s(data.idx) = str2num(['int8(' tmpVal ')']); 
        
        % store swimming pool boolean (as int8)
        data.swim(data.idx) = int8(get(swim_check,'Value'));
        
        % store swimming pool C (as int8)
        tmpVal = get(swim_c_popup,'String');
        tmpVal = tmpVal{get(swim_c_popup,'Value')};
        data.swim_c(data.idx) = str2num(['int8(' tmpVal ')']);        
        
        % store swimming pool D (as int8)
        tmpVal = get(swim_d_popup,'String');
        tmpVal = tmpVal{get(swim_d_popup,'Value')};
        data.swim_d(data.idx) = str2num(['int8(' tmpVal ')']);       
       
        % store swimming pool S (as int8)
        tmpVal = get(swim_s_popup,'String');
        tmpVal = tmpVal{get(swim_s_popup,'Value')};
        data.swim_s(data.idx) = str2num(['int8(' tmpVal ')']); 
        
        % store shed boolean (as int8)
        data.shed(data.idx) = int8(get(shed_check,'Value'));

        % store shed descriptions (as chars)
        tmpVal = get(shed_edit,'String');
        data.shed_types(data.idx,1:length(tmpVal)) = tmpVal;
        
        % store granny flat boolean (as int8)
        data.granny_flat(data.idx) = int8(get(granny_flat_check,'Value'));
        
        % store granny flat C (as int8)
        tmpVal = get(granny_flat_c_popup,'String');
        tmpVal = tmpVal{get(granny_flat_c_popup,'Value')};
        data.granny_flat_c(data.idx) = str2num(['int8(' tmpVal ')']);        
        
        % store granny flat D (as int8)
        tmpVal = get(granny_flat_d_popup,'String');
        tmpVal = tmpVal{get(granny_flat_d_popup,'Value')};
        data.granny_flat_d(data.idx) = str2num(['int8(' tmpVal ')']);       
        
        % store granny flat S (as int8)
        tmpVal = get(granny_flat_s_popup,'String');
        tmpVal = tmpVal{get(granny_flat_s_popup,'Value')};
        data.granny_flat_s(data.idx) = str2num(['int8(' tmpVal ')']);
        
        % store reno ideas (as chars)
        tmpVal = get(ideas_edit,'String');
        if ~strcmp(tmpVal,'')
            data.idea_key(data.ideas_idx) = data.idx;
            data.idea_notes(data.ideas_idx,1:length(tmpVal)) = tmpVal;
            data.ideas_idx = data.ideas_idx + 1;
        end
        
        % store general comments (as chars)
        tmpVal = get(general_edit,'String');
        if ~strcmp(tmpVal,'')
            data.general_key(data.general_idx) = data.idx;
            data.general_notes(data.general_idx,1:length(tmpVal)) = tmpVal;
            data.general_idx = data.general_idx + 1;
        end
        
        % store suburb notes (as chars)
        tmpVal = get(suburb_comment_edit,'String');
        if ~strcmp(tmpVal,'')
        data.suburb_key(data.suburb_idx) = data.idx;
        data.suburb_notes(data.suburb_idx,1:length(tmpVal)) = tmpVal;
        data.suburb_idx = data.suburb_idx + 1;
        end
        
        % store street notes (as chars)
        tmpVal = get(street_comment_edit,'String');
        if ~strcmp(tmpVal,'')
            data.street_key(data.street_idx) = data.idx;
            data.street_notes(data.street_idx,1:length(tmpVal)) = tmpVal;
            data.street_idx = data.street_idx + 1;
        end
        
        % store local neighbourhood notes (as chars)
        tmpVal = get(local_comment_edit,'String');
        if ~strcmp(tmpVal,'')
            data.local_key(data.local_idx) = data.idx;
            data.local_notes(data.local_idx,1:length(tmpVal)) = tmpVal;
            data.local_idx = data.local_idx + 1;
        end
        
        % store agent notes (as chars)
        tmpVal = get(agent_edit,'String');
        if ~strcmp(tmpVal,'')
            data.agent_key(data.agent_idx) = data.idx;
            data.agent_notes(data.agent_idx,1:length(tmpVal)) = tmpVal;
            data.agent_idx = data.agent_idx + 1;
        end
        
        % store buyer notes (as chars)
        tmpVal = get(buyers_edit,'String');
        if ~strcmp(tmpVal,'')
            data.buyer_key(data.buyer_idx) = data.idx;
            data.buyer_notes(data.buyer_idx,1:length(tmpVal)) = tmpVal;
            data.buyer_idx = data.buyer_idx + 1;
        end
        
        % store old listing price (as uint16)
        tmpVal = get(list_price_old_edit,'String');
        data.list_price_old(data.idx) = str2num(['uint16(' tmpVal ')']);
        
        % store old listing date (as chars)
        tmpVal = get(list_date_old_edit,'String');
        data.list_date_old(data.idx,1:length(tmpVal)) = tmpVal;
        
        % store old listing agent (as chars)
        tmpVal = get(list_agent_old_edit,'String');
        data.list_agent_old(data.idx,1:length(tmpVal)) = tmpVal;
        
        % store current listing price (as uint16)
        tmpVal = get(list_price_curr_edit,'String');
        data.list_price_curr(data.idx) = str2num(['uint16(' tmpVal ')']);
        
        % store current listing date (as chars)
        tmpVal = get(list_date_curr_edit,'String');
        data.list_date_curr(data.idx,1:length(tmpVal)) = tmpVal;
        
        % store current listing agent (as chars)
        tmpVal = get(list_agent_curr_edit,'String');
        data.list_agent_curr(data.idx,1:length(tmpVal)) = tmpVal;        

        % store sold price (as uint16)
        tmpVal = get(sold_price_edit,'String');
        data.sold_price(data.idx) = str2num(['uint16(' tmpVal ')']);
        
        % store sold date (as chars)
        tmpVal = get(sold_date_edit,'String');
        data.sold_date(data.idx,1:length(tmpVal)) = tmpVal;
        
        %---------------------------------------------------------
        %       expand columns if necessary
        if data.idx == data.max
            
            % address
            data.unit_no = [data.unit_no; repmat(' ',DATA_INCREMENT,SSTR)];
            data.street_no = [data.street_no; repmat(' ',DATA_INCREMENT,SSTR)];
            data.street = [data.street; repmat(' ',DATA_INCREMENT,LSTR)];
            data.st_type = [data.st_type; repmat(' ',DATA_INCREMENT,SSTR)];
            data.suburb = [data.suburb; repmat(' ',DATA_INCREMENT,LSTR)];
%             inspect
            data.inspect_date = [data.inspect_date; repmat(' ',DATA_INCREMENT,SSTR)];
            data.inspect_start = [data.inspect_start; repmat(' ',DATA_INCREMENT,XSSTR)];
            data.inspect_end = [data.inspect_end; repmat(' ',DATA_INCREMENT,XSSTR)];
            % key data
            data.modern = [data.modern ; zeros(DATA_INCREMENT,1,'int8')];
            data.maisonette = [data.maisonette ; zeros(DATA_INCREMENT,1,'int8')];
            data.built = [data.built ; zeros(DATA_INCREMENT,1,'uint16')];
            data.last_reno = [data.last_reno ; zeros(DATA_INCREMENT,1,'uint16')];
            data.land_area = [data.land_area ; zeros(DATA_INCREMENT,1,'uint16')];
            data.floor_area = [data.floor_area ; zeros(DATA_INCREMENT,1,'uint16')];
            data.frontage = [data.frontage ; zeros(DATA_INCREMENT,1,'uint8')];
            %   columns - construction
            data.construction = [data.construction; repmat(' ',DATA_INCREMENT,LSTR)];
            data.construction_c = [data.construction_c; zeros(DATA_INCREMENT,1,'int8')];
            %   columns - roofing
            data.roofing = [data.roofing; repmat(' ',DATA_INCREMENT,LSTR)];
            data.roofing_c = [data.roofing_c; zeros(DATA_INCREMENT,1,'int8')];
            data.roofing_d = [data.roofing_d; zeros(DATA_INCREMENT,1,'int8')];
            %   columns - front yard
            data.front_yard_c = [data.front_yard_c; zeros(DATA_INCREMENT,1,'int8')];
            data.front_yard_d = [data.front_yard_d; zeros(DATA_INCREMENT,1,'int8')];
            data.front_yard_s = [data.front_yard_s; zeros(DATA_INCREMENT,1,'int8')];
            %   columns - front facade
            data.front_facade = [data.front_facade; repmat(' ',DATA_INCREMENT,LSTR)];
            data.front_facade_c = [data.front_facade_c; zeros(DATA_INCREMENT,1,'int8')];
            data.front_facade_d = [data.front_facade_d; zeros(DATA_INCREMENT,1,'int8')];
            %   columns - parking
            data.garages = [data.garages; zeros(DATA_INCREMENT,1,'int8')];
            data.carports = [data.carports; zeros(DATA_INCREMENT,1,'int8')];
            data.secures = [data.secures; zeros(DATA_INCREMENT,1,'int8')];
            data.offstreets = [data.offstreets; zeros(DATA_INCREMENT,1,'int8')];
            data.parking_c = [data.parking_c; zeros(DATA_INCREMENT,1,'int8')];
            data.parking_d = [data.parking_d; zeros(DATA_INCREMENT,1,'int8')];
            %   columns - flooring
            data.tile = [data.tile; zeros(DATA_INCREMENT,1,'int8')];
            data.slate = [data.slate; zeros(DATA_INCREMENT,1,'int8')];
            data.floorboard = [data.floorboard; zeros(DATA_INCREMENT,1,'int8')];
            data.vinyl = [data.vinyl; zeros(DATA_INCREMENT,1,'int8')];
            data.carpet = [data.carpet ;zeros(DATA_INCREMENT,1,'int8')];
            data.flooring_c = [data.flooring_c ;zeros(DATA_INCREMENT,1,'int8')];
            data.flooring_d = [data.flooring_d ;zeros(DATA_INCREMENT,1,'int8')];
            %   columns - kitchen
            data.open_living = [data.open_living ;zeros(DATA_INCREMENT,1,'int8')];
            data.pantry = [data.pantry ;zeros(DATA_INCREMENT,1,'int8')];
            data.kitchen_c = [data.kitchen_c ;zeros(DATA_INCREMENT,1,'int8')];
            data.kitchen_d = [data.kitchen_d ;zeros(DATA_INCREMENT,1,'int8')];
            data.kitchen_s = [data.kitchen_s ;zeros(DATA_INCREMENT,1,'int8')];
            %   columns - bathroom
            data.baths = [data.baths ;zeros(DATA_INCREMENT,1,'int8')];
            data.showers = [data.showers ;zeros(DATA_INCREMENT,1,'int8')];
            data.spas = [data.spas ;zeros(DATA_INCREMENT,1,'int8')];
            data.toilets = [data.toilets ;zeros(DATA_INCREMENT,1,'int8')];
            data.bathroom_c = [data.bathroom_c ;zeros(DATA_INCREMENT,1,'int8')];
            data.bathroom_d = [data.bathroom_d ;zeros(DATA_INCREMENT,1,'int8')];
            data.bathroom_s = [data.bathroom_s ;zeros(DATA_INCREMENT,1,'int8')];
            data.heatlamp = [data.heatlamp ;zeros(DATA_INCREMENT,1,'int8')];
            %   columns - bedroom
            data.bedrooms = [data.bedrooms ;zeros(DATA_INCREMENT,1,'int8')];
            data.wirs = [data.wirs ;zeros(DATA_INCREMENT,1,'int8')];
            data.birs = [data.birs ;zeros(DATA_INCREMENT,1,'int8')];
            data.kids = [data.kids ;zeros(DATA_INCREMENT,1,'int8')];
            data.ensuites = [data.ensuites ;zeros(DATA_INCREMENT,1,'int8')];
            data.brts = [data.brts ;zeros(DATA_INCREMENT,1,'int8')]; %BR toilets
            data.bedroom_c = [data.bedroom_c ;zeros(DATA_INCREMENT,1,'int8')];
            data.bedroom_d = [data.bedroom_d ;zeros(DATA_INCREMENT,1,'int8')];
            data.bedroom_s = [data.bedroom_s ;zeros(DATA_INCREMENT,1,'int8')];
            %   columns - climate control
            data.heating = [data.heating ;zeros(DATA_INCREMENT,1,'int8')];
            data.cooling = [data.cooling ;zeros(DATA_INCREMENT,1,'int8')];
            data.coverage = [data.coverage ;zeros(DATA_INCREMENT,1,'int8')];
            %   columns - backyard
            data.back_yard_c = [data.back_yard_c ;zeros(DATA_INCREMENT,1,'int8')];
            data.back_yard_d = [data.back_yard_d ;zeros(DATA_INCREMENT,1,'int8')];
            data.back_yard_s = [data.back_yard_s ;zeros(DATA_INCREMENT,1,'int8')];
            data.pergola = [data.pergola ;zeros(DATA_INCREMENT,1,'int8')];
            data.verandah = [data.verandah ;zeros(DATA_INCREMENT,1,'int8')];
            data.verandah_c = [data.verandah_c ;zeros(DATA_INCREMENT,1,'int8')];
            data.verandah_d = [data.verandah_d ;zeros(DATA_INCREMENT,1,'int8')];
            data.verandah_s = [data.verandah_s ;zeros(DATA_INCREMENT,1,'int8')];
            data.grass = [data.grass ;zeros(DATA_INCREMENT,1,'int8')];
            data.grass_c = [data.grass_c ;zeros(DATA_INCREMENT,1,'int8')];
            data.grass_d = [data.grass_d ;zeros(DATA_INCREMENT,1,'int8')];
            data.grass_s = [data.grass_s ;zeros(DATA_INCREMENT,1,'int8')];
            %   columns - other features
            data.swim = [data.swim ;zeros(DATA_INCREMENT,1,'int8')];
            data.swim_c = [data.swim_c ;zeros(DATA_INCREMENT,1,'int8')];
            data.swim_d = [data.swim_d ;zeros(DATA_INCREMENT,1,'int8')];
            data.swim_s = [data.swim_s ;zeros(DATA_INCREMENT,1,'int8')];
            data.shed = [data.shed ;zeros(DATA_INCREMENT,1,'int8')];
            data.shed_types = [data.shed_types; repmat(' ',DATA_INCREMENT,LSTR)];
            data.granny_flat = [data.granny_flat ;zeros(DATA_INCREMENT,1,'int8')];
            data.granny_flat_c = [data.granny_flat_c ;zeros(DATA_INCREMENT,1,'int8')];
            data.granny_flat_d = [data.granny_flat_d ;zeros(DATA_INCREMENT,1,'int8')];
            data.granny_flat_s = [data.granny_flat_s ;zeros(DATA_INCREMENT,1,'int8')];
            % sales
            data.list_price_old = [data.list_price_old ; zeros(DATA_INCREMENT,1,'uint16')];
            data.list_date_old = [data.list_date_old; repmat(' ',DATA_INCREMENT,SSTR)];
            data.list_agent_old = [data.list_agent_old; repmat(' ',DATA_INCREMENT,SSTR)];
            data.list_price_curr = [data.list_price_curr ; zeros(DATA_INCREMENT,1,'uint16')];
            data.list_date_curr = [data.list_date_curr; repmat(' ',DATA_INCREMENT,SSTR)];
            data.list_agent_curr = [data.list_agent_curr; repmat(' ',DATA_INCREMENT,SSTR)];
            data.sold_price = [data.sold_price ; zeros(DATA_INCREMENT,1,'uint16')];
            data.sold_date = [data.sold_date; repmat(' ',DATA_INCREMENT,SSTR)];
            
            
            % increment the data_max limit
            data.max = data.max + DATA_INCREMENT;
        end
        if data.ideas_idx == (data.idea_max + 1)
            
            data.idea_key = [data.idea_key;...
                zeros(NOTES_INCREMENT,1,'uint16')];
            data.idea_notes = [data.idea_notes; ...
                            repmat(' ',NOTES_INCREMENT,XLSTR)];
            data.idea_max = data.idea_max + NOTES_INCREMENT;
                       
        end
        if data.general_idx == (data.general_max + 1)
            
            data.general_key = [data.general_key;...
                zeros(NOTES_INCREMENT,1,'uint16')];            
            data.general_notes = [data.general_notes; ...
                            repmat(' ',NOTES_INCREMENT,XLSTR)];
            data.general_max = data.general_max + NOTES_INCREMENT;
        end
        if data.suburb_idx == (data.suburb_max + 1)
            
            data.suburb_key = [data.suburb_key;...
                zeros(NOTES_INCREMENT,1,'uint16')];            
            data.suburb_notes = [data.suburb_notes; ...
                            repmat(' ',NOTES_INCREMENT,XLSTR)];
            data.suburb_max = data.suburb_max + NOTES_INCREMENT;           
        end
        if data.street_idx == (data.street_max + 1)
            
            data.street_key = [data.street_key;...
                zeros(NOTES_INCREMENT,1,'uint16')];            
            data.street_notes = [data.street_notes; ...
                            repmat(' ',NOTES_INCREMENT,XLSTR)];
            data.street_max = data.street_max + NOTES_INCREMENT;           
        end
        if data.local_idx == (data.local_max + 1)
            
            data.local_key = [data.local_key;...
                zeros(NOTES_INCREMENT,1,'uint16')];            
            data.local_notes = [data.local_notes; ...
                            repmat(' ',NOTES_INCREMENT,XLSTR)];
            data.local_max = data.local_max + NOTES_INCREMENT;           
        end
        if data.agent_idx == (data.agent_max + 1)
            
            data.agent_key = [data.agent_key;...
                zeros(NOTES_INCREMENT,1,'uint16')];            
            data.agent_notes = [data.agent_notes; ...
                repmat(' ',NOTES_INCREMENT,XLSTR)];
            data.agent_max = data.agent_max + NOTES_INCREMENT;
        end
        if data.buyer_idx == (data.buyer_max + 1)
            
            data.buyer_key = [data.buyer_key;...
                zeros(NOTES_INCREMENT,1,'uint16')];
            data.buyer_notes = [data.buyer_notes; ...
                repmat(' ',NOTES_INCREMENT,XLSTR)];
            data.buyer_max = data.buyer_max + NOTES_INCREMENT;
        end
        
        %---------------------------------------------------------        
%       update the index for the next entry
        data.idx = data.idx + 1;
        
%        save the updated data
        save(data_file,'data','-v6');

%       close the GUI    
        exit_callback(source,eventdata);

    end

%   the figure has been requested to close
    function exit_callback(source,eventdata)
        
        
        % to display a question dialog box
%         selection = questdlg('Close This Figure?',...
%             'Close Request Function',...
%             'Yes','No','Yes');
%         switch selection,
%             case 'Yes',
                delete(gcf)
%             case 'No'
%                 return
%         end
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
        

%---------------------------------------------------------------------
%  Utility functions for snap_in


end