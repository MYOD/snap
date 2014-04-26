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
    data.idea_idx = 1;
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
    data.modern = false(data.max,1);
    data.maisonette = false(data.max,1);
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
    data.dual_access = false(data.max,1);
%   columns - flooring
    data.tile = false(data.max,1);
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
    data.heatlamp = false(data.max,1);
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
    data.pergola = false(data.max,1);
    data.verandah = false(data.max,1);
    data.verandah_c = zeros(data.max,1,'int8');
    data.verandah_d = zeros(data.max,1,'int8');
    data.verandah_s = zeros(data.max,1,'int8');
    data.grass = zeros(data.max,1,'int8');
    data.grass_c = zeros(data.max,1,'int8');
    data.grass_d = zeros(data.max,1,'int8');
    data.grass_s = zeros(data.max,1,'int8');
%   columns - other features
    data.swim = false(data.max,1);
    data.swim_c = zeros(data.max,1,'int8');
    data.swim_d = zeros(data.max,1,'int8');
    data.swim_s = zeros(data.max,1,'int8');
    data.shed = zeros(data.max,1,'int8');
    data.shed_types = repmat(' ',data.max,LSTR);
    data.granny_flat = false(data.max,1);
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
    data.low_list_price_old = zeros(data.max,1,'uint32');
    data.high_list_price_old = zeros(data.max,1,'uint32');
    data.list_date_old = repmat(' ',data.max,SSTR);
    data.list_agent_old = repmat(' ',data.max,LSTR);
    data.agency_old = repmat(' ',data.max,(LSTR + SSTR));
    data.low_list_price_curr = zeros(data.max,1,'uint32');
    data.high_list_price_curr = zeros(data.max,1,'uint32');
    data.list_date_curr = repmat(' ',data.max,SSTR);
    data.list_agent_curr = repmat(' ',data.max,LSTR);
    data.agency_curr = repmat(' ',data.max,(LSTR + SSTR));
    data.sold_price = zeros(data.max,1,'uint32');
    data.sold_date = repmat(' ',data.max,SSTR);
    
%   agent names list: 
    data.agent_names = repmat(' ',2,LSTR);
    data.agent_names(1,1) = '-';
    data.agent_names(2,1:7) = 'Add New';
    
%   internal structure to help snap remember what agency each agent is
%   attached to
    data.agents_agency = '';
    
%   agencies list: 
    data.agencies = repmat(' ',2,(LSTR + SSTR));
    data.agencies(1,1) = '-';
    data.agencies(2,1:7) = 'Add New';    
    
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
    'Dr','Gr','Rd','St',},...
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
TMP_X=TMP_X+X_GAP+STXT_W;
modern_text = uicontrol('parent',h_fig,'Style','text',...
    'String','Modern:','Units','normalized',...
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

% construction components
LINE_Y=1- POPUP_H - Y_GAP/2;
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
TMP_X = 2*X_GAP + TXT_W;
LINE_Y=LINE_Y - POPUP_H - Y_GAP/2;
dual_access_check = uicontrol('parent',features_panel,'Style','checkbox',...
    'Units','normalized','String','Dual-Access',...
    'Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);

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
toilet_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',NUMS,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
toilet_txt = uicontrol('parent',features_panel,'Style','text','String','toilet(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
spa_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
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
    [TMP_X,LINE_Y,STXT_W,POPUP_H],'callback',{@verandah_callback});
TMP_X=TMP_X+X_GAP+STXT_W;
verandah_check = uicontrol('parent',features_panel,'Style','checkbox','Units','normalized',...
    'String','Verandah','Position',...
    [TMP_X,LINE_Y,TXT_W,POPUP_H],'callback',{@verandah_callback});
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
of_txt = uicontrol('parent',features_panel,'Style','text','String','Other Features:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
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
shed_edit = uicontrol('parent',features_panel,'Style','edit',...
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
LINE_Y= 1 - POPUP_H - Y_GAP/2;
TMP_X = X_GAP;
list_price_old_txt = uicontrol('parent',sales_panel,'Style','text',...
    'String','Old List Price: $','Units','normalized',...
    'Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
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
list_price_curr_txt = uicontrol('parent',sales_panel,'Style','text',...
    'String','New List Price: $','Units','normalized',...
    'Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
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

% if necessary load existing property for edit
if load_idx ~= 0
%   address
    set(unit_no_edit,'String',data.unit_no(load_idx,:));
    set(street_no_edit,'String',data.street_no(load_idx,:));
    set(street_edit,'String',data.street(load_idx,:));
    tmpHaystack = get(st_type_popup,'String');
    tmpNeedle = deblank(data.st_type(load_idx,:));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(st_type_popup,'Value',tmpAns);
    tmpHaystack = get(suburb_popup,'String');
    tmpNeedle = deblank(data.suburb(load_idx,:));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(suburb_popup,'Value',tmpAns);
%   inspection
    set(inspect_date_edit,'String',data.inspect_date(load_idx,:));
    set(inspect_start_edit,'String',data.inspect_start(load_idx,:));
    set(inspect_end_edit,'String',data.inspect_end(load_idx,:));
%   key data
    if data.modern(load_idx) == 1
        set(yes_radio,'Value',1);
        set(no_radio,'Value',0);
    else
        set(no_radio,'Value',1);
        set(yes_radio,'Value',0);
    end
    set(maisonette_check,'Value',data.maisonette(load_idx));
    set(built_edit,'String',int2str(data.built(load_idx)));
    set(last_reno_edit,'String',int2str(data.last_reno(load_idx)));
    set(land_area_edit,'String',int2str(data.land_area(load_idx)));
    set(floor_area_edit,'String',int2str(data.floor_area(load_idx)));
    set(frontage_edit,'String',int2str(data.frontage(load_idx)));
%   construction
    tmpHaystack = get(construction_popup,'String');
    tmpNeedle = deblank(data.construction(load_idx,:));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(construction_popup,'Value',tmpAns);
    tmpHaystack = get(construction_c_popup,'String');
    tmpNeedle = int2str(data.construction_c(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(construction_c_popup,'Value',tmpAns);
%   roofing
    tmpHaystack = get(roofing_popup,'String');
    tmpNeedle = deblank(data.roofing(load_idx,:));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(roofing_popup,'Value',tmpAns);
    tmpHaystack = get(roofing_c_popup,'String');
    tmpNeedle = int2str(data.roofing_c(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(roofing_c_popup,'Value',tmpAns);
    tmpHaystack = get(roofing_d_popup,'String');
    tmpNeedle = int2str(data.roofing_d(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(roofing_d_popup,'Value',tmpAns);
%   front yard
    tmpHaystack = get(front_yard_c_popup,'String');
    tmpNeedle = int2str(data.front_yard_c(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(front_yard_c_popup,'Value',tmpAns);
    tmpHaystack = get(front_yard_d_popup,'String');
    tmpNeedle = int2str(data.front_yard_d(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(front_yard_d_popup,'Value',tmpAns);
    tmpHaystack = get(front_yard_s_popup,'String');
    tmpNeedle = int2str(data.front_yard_s(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(front_yard_s_popup,'Value',tmpAns);
%   front facade
    tmpHaystack = get(front_facade_popup,'String');
    tmpNeedle = deblank(data.front_facade(load_idx,:));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(front_facade_popup,'Value',tmpAns);
    tmpHaystack = get(front_facade_c_popup,'String');
    tmpNeedle = int2str(data.front_facade_c(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(front_facade_c_popup,'Value',tmpAns);
    tmpNeedle = int2str(data.front_facade_d(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(front_facade_d_popup,'Value',tmpAns);
%   parking
    tmpHaystack = get(garage_popup,'String');
    tmpNeedle = int2str(data.garages(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(garage_popup,'Value',tmpAns);
    tmpHaystack = get(carport_popup,'String');
    tmpNeedle = int2str(data.carports(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(carport_popup,'Value',tmpAns);
    tmpHaystack = get(secure_popup,'String');
    tmpNeedle = int2str(data.secures(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(secure_popup,'Value',tmpAns);
    tmpHaystack = get(offstreet_popup,'String');
    tmpNeedle = int2str(data.offstreets(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(offstreet_popup,'Value',tmpAns);
    tmpHaystack = get(parking_c_popup,'String');
    tmpNeedle = int2str(data.parking_c(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(parking_c_popup,'Value',tmpAns);
    tmpHaystack = get(parking_d_popup,'String');
    tmpNeedle = int2str(data.parking_d(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(parking_d_popup,'Value',tmpAns);
    set(dual_access_check,'Value',data.dual_access(load_idx));
%   flooring
    set(tile_check,'Value',data.tile(load_idx));
    set(slate_check,'Value',data.slate(load_idx));
    set(floorboard_check,'Value',data.floorboard(load_idx));
    set(vinyl_check,'Value',data.vinyl(load_idx));
    set(carpet_check,'Value',data.carpet(load_idx));
    tmpHaystack = get(flooring_c_popup,'String');
    tmpNeedle = int2str(data.flooring_c(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(flooring_c_popup,'Value',tmpAns);
    tmpHaystack = get(flooring_d_popup,'String');
    tmpNeedle = int2str(data.flooring_d(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(flooring_d_popup,'Value',tmpAns);
%   kitchen
    set(open_living_check,'Value',data.open_living(load_idx));
    set(pantry_check,'Value',data.pantry(load_idx));
    tmpHaystack = get(kitchen_c_popup,'String');
    tmpNeedle = int2str(data.kitchen_c(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(kitchen_c_popup,'Value',tmpAns);
    tmpHaystack = get(kitchen_d_popup,'String');
    tmpNeedle = int2str(data.kitchen_d(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(kitchen_d_popup,'Value',tmpAns);
    tmpHaystack = get(kitchen_s_popup,'String');
    tmpNeedle = int2str(data.kitchen_s(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(kitchen_s_popup,'Value',tmpAns);    
%   bathroom
    tmpHaystack = get(bath_popup,'String');
    tmpNeedle = int2str(data.baths(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(bath_popup,'Value',tmpAns);
    tmpHaystack = get(shower_popup,'String');
    tmpNeedle = int2str(data.showers(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(shower_popup,'Value',tmpAns);
    tmpHaystack = get(toilet_popup,'String');
    tmpNeedle = int2str(data.toilets(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(toilet_popup,'Value',tmpAns);    
    tmpHaystack = get(spa_popup,'String');
    tmpNeedle = int2str(data.spas(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(spa_popup,'Value',tmpAns);
    tmpHaystack = get(bathroom_c_popup,'String');
    tmpNeedle = int2str(data.bathroom_c(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(bathroom_c_popup,'Value',tmpAns);
    tmpHaystack = get(bathroom_d_popup,'String');
    tmpNeedle = int2str(data.bathroom_d(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(bathroom_d_popup,'Value',tmpAns);
    tmpHaystack = get(bathroom_s_popup,'String');
    tmpNeedle = int2str(data.bathroom_s(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(bathroom_s_popup,'Value',tmpAns);    
    set(heatlamp_check,'Value',data.heatlamp(load_idx));
%   bedroom
    tmpHaystack = get(bedroom_popup,'String');
    tmpNeedle = int2str(data.bedrooms(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(bedroom_popup,'Value',tmpAns);
    tmpHaystack = get(wir_popup,'String');
    tmpNeedle = int2str(data.wirs(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(wir_popup,'Value',tmpAns);
    tmpHaystack = get(bir_popup,'String');
    tmpNeedle = int2str(data.birs(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(bir_popup,'Value',tmpAns);    
    tmpHaystack = get(kids_popup,'String');
    tmpNeedle = int2str(data.kids(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(kids_popup,'Value',tmpAns);
    tmpHaystack = get(ensuite_popup,'String');
    tmpNeedle = int2str(data.ensuites(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(ensuite_popup,'Value',tmpAns);
    tmpHaystack = get(brt_popup,'String');
    tmpNeedle = int2str(data.brts(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(brt_popup,'Value',tmpAns);    
    tmpHaystack = get(bedroom_c_popup,'String');
    tmpNeedle = int2str(data.bedroom_c(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(bedroom_c_popup,'Value',tmpAns);
    tmpHaystack = get(bedroom_d_popup,'String');
    tmpNeedle = int2str(data.bedroom_d(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(bedroom_d_popup,'Value',tmpAns);
    tmpHaystack = get(bedroom_s_popup,'String');
    tmpNeedle = int2str(data.bedroom_s(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(bedroom_s_popup,'Value',tmpAns);    
%   climate control
    tmpHaystack = get(heating_popup,'String');
    tmpNeedle = int2str(data.heating(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(heating_popup,'Value',tmpAns);
    tmpHaystack = get(cooling_popup,'String');
    tmpNeedle = int2str(data.cooling(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(cooling_popup,'Value',tmpAns);
    tmpHaystack = get(coverage_popup,'String');
    tmpNeedle = int2str(data.coverage(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(coverage_popup,'Value',tmpAns);        
%     backyard
    tmpHaystack = get(back_yard_c_popup,'String');
    tmpNeedle = int2str(data.back_yard_c(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(back_yard_c_popup,'Value',tmpAns);
    tmpHaystack = get(back_yard_d_popup,'String');
    tmpNeedle = int2str(data.back_yard_d(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(back_yard_d_popup,'Value',tmpAns);
    tmpHaystack = get(back_yard_s_popup,'String');
    tmpNeedle = int2str(data.back_yard_s(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(back_yard_s_popup,'Value',tmpAns);    
    set(pergola_check,'Value',data.pergola(load_idx));
    set(verandah_check,'Value',data.verandah(load_idx));
    tmpHaystack = get(verandah_c_popup,'String');
    tmpNeedle = int2str(data.verandah_c(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(verandah_c_popup,'Value',tmpAns);
    tmpHaystack = get(verandah_d_popup,'String');
    tmpNeedle = int2str(data.verandah_d(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(verandah_d_popup,'Value',tmpAns);
    tmpHaystack = get(verandah_s_popup,'String');
    tmpNeedle = int2str(data.verandah_s(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(verandah_s_popup,'Value',tmpAns);    
    set(grass_check,'Value',data.grass(load_idx));
    tmpHaystack = get(grass_c_popup,'String');
    tmpNeedle = int2str(data.grass_c(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(grass_c_popup,'Value',tmpAns);
    tmpHaystack = get(grass_d_popup,'String');
    tmpNeedle = int2str(data.grass_d(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(grass_d_popup,'Value',tmpAns);
    tmpHaystack = get(grass_s_popup,'String');
    tmpNeedle = int2str(data.grass_s(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(grass_s_popup,'Value',tmpAns);    
%   other features
    set(swim_check,'Value',data.swim(load_idx));
    tmpHaystack = get(swim_c_popup,'String');
    tmpNeedle = int2str(data.swim_c(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(swim_c_popup,'Value',tmpAns);
    tmpHaystack = get(swim_d_popup,'String');
    tmpNeedle = int2str(data.swim_d(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(swim_d_popup,'Value',tmpAns);
    tmpHaystack = get(swim_s_popup,'String');
    tmpNeedle = int2str(data.swim_s(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(swim_s_popup,'Value',tmpAns);    
    set(shed_check,'Value',data.shed(load_idx));
    set(shed_edit,'String',data.shed_types(load_idx,:));
    set(granny_flat_check,'Value',data.granny_flat(load_idx));
    tmpHaystack = get(granny_flat_c_popup,'String');
    tmpNeedle = int2str(data.granny_flat_c(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(granny_flat_c_popup,'Value',tmpAns);
    tmpHaystack = get(granny_flat_d_popup,'String');
    tmpNeedle = int2str(data.granny_flat_d(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(granny_flat_d_popup,'Value',tmpAns);
    tmpHaystack = get(granny_flat_s_popup,'String');
    tmpNeedle = int2str(data.granny_flat_s(load_idx));
    tmpIndexed = strncmp(tmpNeedle,tmpHaystack,length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(granny_flat_s_popup,'Value',tmpAns);    
%   comments
    tmpIndexed = data.idea_key == load_idx;
    set(ideas_edit,'string',data.idea_notes(tmpIndexed,:));
    tmpIndexed = data.general_key == load_idx;
    set(general_edit,'string',data.general_notes(tmpIndexed,:));
    tmpIndexed = data.suburb_key == load_idx;
    set(suburb_comment_edit,'string',data.suburb_notes(tmpIndexed,:));
    tmpIndexed = data.street_key == load_idx;
    set(street_comment_edit,'string',data.street_notes(tmpIndexed,:));
    tmpIndexed = data.local_key == load_idx;
    set(local_comment_edit,'string',data.local_notes(tmpIndexed,:));
    tmpIndexed = data.agent_key == load_idx;
    set(agent_edit,'string',data.agent_notes(tmpIndexed,:));
    tmpIndexed = data.buyer_key == load_idx;
    set(buyers_edit,'string',data.buyer_notes(tmpIndexed,:));
%   sales
    set(low_list_price_old_edit,'String',data.low_list_price_old(load_idx,:));
    set(high_list_price_old_edit,'String',data.high_list_price_old(load_idx,:));
    set(list_date_old_edit,'String',data.list_date_old(load_idx,:));
    tmpHaystack = get(list_agent_old_popup,'String');
    tmpNeedle = deblank(data.list_agent_old(load_idx,:));
    tmpIndexed = strncmp(tmpNeedle,cellstr(tmpHaystack),length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(list_agent_old_popup,'Value',tmpAns);
    tmpHaystack = get(agency_old_popup,'String');
    tmpNeedle = deblank(data.agency_old(load_idx,:));
    tmpIndexed = strncmp(tmpNeedle,cellstr(tmpHaystack),length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(agency_old_popup,'Value',tmpAns);    
    set(low_list_price_curr_edit,'String',data.low_list_price_curr(load_idx,:));
    set(high_list_price_curr_edit,'String',data.high_list_price_curr(load_idx,:));
    set(list_date_curr_edit,'String',data.list_date_curr(load_idx,:));
    tmpHaystack = get(list_agent_curr_popup,'String');
    tmpNeedle = deblank(data.list_agent_curr(load_idx,:));
    tmpIndexed = strncmp(tmpNeedle,cellstr(tmpHaystack),length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(list_agent_curr_popup,'Value',tmpAns);
    tmpHaystack = get(agency_curr_popup,'String');
    tmpNeedle = deblank(data.agency_curr(load_idx,:));
    tmpIndexed = strncmp(tmpNeedle,cellstr(tmpHaystack),length(tmpNeedle));
    tmpCoded = tmpIndexed.*(1:length(tmpIndexed))';
    tmpAns = tmpCoded(tmpIndexed);
    set(agency_curr_popup,'Value',tmpAns);
    set(sold_price_edit,'String',data.sold_price(load_idx,:));
    set(sold_date_edit,'String',data.sold_date(load_idx,:));
    
end


% Move the GUI to the center of the screen.
movegui(h_fig,'center')

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
        uicontrol(ideas_edit);
        
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
%        collect user data input to GUI
        
        % save over existing property if editing
        if load_idx ~=0
           idx_tmp = data.idx;
           data.idx = load_idx;
        end

        % store unit no (as chars)
        tmpVal = deblank(get(unit_no_edit,'String'));
        if ~strcmp(tmpVal,'Unit #') && ~strcmp(tmpVal,'')
            data.unit_no(data.idx,1:length(tmpVal)) = tmpVal;    
        end
        
        % store house no (as chars)
        tmpVal = deblank(get(street_no_edit,'String'));
        if ~strcmp(tmpVal,'St. #') && ~strcmp(tmpVal,'')
            data.street_no(data.idx,1:length(tmpVal)) = tmpVal;  
        else % user didn't enter compulsory value
            errordlg('You must specify a street number!',...
                'Need Street Number');
            return;
        end
        
        % store street (as chars)
        tmpVal = deblank(get(street_edit,'String'));
        if ~strcmp(tmpVal,'Street') && ~strcmp(tmpVal,'')
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
        if ~strcmp(tmpVal,'HH:MM') && ~strcmp(tmpVal,'')
            data.inspect_start(data.idx,1:length(tmpVal)) = tmpVal;
        end
        
        % store inspection end time (as chars)
        tmpVal = get(inspect_end_edit,'String');
        if ~strcmp(tmpVal,'HH:MM') && ~strcmp(tmpVal,'')
            data.inspect_end(data.idx,1:length(tmpVal)) = tmpVal;
        end
        
        % store modern boolean (as logical)
        if ~get(yes_radio,'Value') && ~get(no_radio,'Value')
            errordlg('You must specify if modern or dated',...
                'Specify Modern/Dated');
            return;
        end
        data.modern(data.idx) = logical(get(yes_radio,'Value'));
        
        % store maisonette boolean (as logical)
        data.maisonette(data.idx) = logical(get(maisonette_check,'Value'));
        
        % store built year (as uint16)
        tmpVal = get(built_edit,'String');
        if ~strcmp(tmpVal,'')
            data.built(data.idx) = str2num(['uint16(' tmpVal ')']);
        end
        
        % store last renovated year (as uint16)
        tmpVal = get(last_reno_edit,'String');
        if ~strcmp(tmpVal,'')
            data.last_reno(data.idx) = str2num(['uint16(' tmpVal ')']);
        end
        
        % store land area (as uint16)
        tmpVal = get(land_area_edit,'String');
        if ~strcmp(tmpVal,'')
            data.land_area(data.idx) = str2num(['uint16(' tmpVal ')']);
        end
        
        % store floor area (as uint16)
        tmpVal = get(floor_area_edit,'String');
        if ~strcmp(tmpVal,'')
            data.floor_area(data.idx) = str2num(['uint16(' tmpVal ')']);
        end
        
        % store frontage (as uint8)
        tmpVal = get(frontage_edit,'String');
        if ~strcmp(tmpVal,'')
            data.frontage(data.idx) = str2num(['uint8(' tmpVal ')']);
        end
        
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

        % store dual-access boolean (as logical)
        data.dual_access(data.idx) = logical(get(dual_access_check,'Value'));
        
        % store tile boolean (as logical)
        data.tile(data.idx) = logical(get(tile_check,'Value'));
        
        % store slate boolean (as logical)
        data.slate(data.idx) = logical(get(slate_check,'Value'));
        
        % store floorboard boolean (as floorboard)
        data.floorboard(data.idx) = logical(get(floorboard_check,'Value'));
        
        % store vinyl boolean (as logical)
        data.vinyl(data.idx) = logical(get(vinyl_check,'Value'));
        
        % store carpet boolean (as logical)
        data.carpet(data.idx) = logical(get(carpet_check,'Value'));
        
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
        
        % store number of spas (as int8)
        tmpVal = get(spa_popup,'String');
        tmpVal = tmpVal{get(spa_popup,'Value')};
        data.spas(data.idx) = str2num(['int8(' tmpVal ')']);
        
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
        
        % store heatlamp boolean (as logical)
        data.heatlamp(data.idx) = logical(get(heatlamp_check,'Value'));
        
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
        
        % store pergola boolean (as logical)
        data.pergola(data.idx) = logical(get(pergola_check,'Value'));

        % store verandah boolean (as logical)
        data.verandah(data.idx) = logical(get(verandah_check,'Value'));
        
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
        
        % store swimming pool boolean (as logical)
        data.swim(data.idx) = logical(get(swim_check,'Value'));
        
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
        
        % store shed boolean (as logical)
        data.shed(data.idx) = logical(get(shed_check,'Value'));

        % store shed descriptions (as chars)
        tmpVal = deblank(get(shed_edit,'String'));
        if ~strcmp(tmpVal,'')
            data.shed_types(data.idx,1:length(tmpVal)) = tmpVal;
        end
        
        % store granny flat boolean (as logical)
        data.granny_flat(data.idx) = logical(get(granny_flat_check,'Value'));
        
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
        tmpVal = deblank(get(ideas_edit,'String'));                
        % check if user previously entered comment (only possible in
        % editing)
        tmpIndexed = (data.idea_key == load_idx);
        if sum(tmpIndexed) == 1 % yes, overwrite previous comment
            data.idea_notes(tmpIndexed,1:length(tmpVal)) = tmpVal;
        else %no, add to end if comment exists
            if ~strcmp(tmpVal,'')
                data.idea_key(data.idea_idx) = data.idx;
                data.idea_notes(data.idea_idx,1:length(tmpVal)) = tmpVal;
                data.idea_idx = data.idea_idx + 1;
            end
        end
        
        % store general comments (as chars)
        tmpVal = deblank(get(general_edit,'String'));                
        % check if user previously entered comment (only possible in
        % editing)
        tmpIndexed = (data.general_key == load_idx);
        if sum(tmpIndexed) == 1 % yes, overwrite previous comment
            data.general_notes(tmpIndexed,1:length(tmpVal)) = tmpVal;
        else %no, add to end if comment exists
            if ~strcmp(tmpVal,'')
                data.general_key(data.general_idx) = data.idx;
                data.general_notes(data.general_idx,1:length(tmpVal)) = tmpVal;
                data.general_idx = data.general_idx + 1;
            end
        end
        
        % store suburb notes (as chars)
        tmpVal = deblank(get(suburb_comment_edit,'String'));                
        % check if user previously entered comment (only possible in
        % editing)
        tmpIndexed = (data.suburb_key == load_idx);
        if sum(tmpIndexed) == 1 % yes, overwrite previous comment
            data.suburb_notes(tmpIndexed,1:length(tmpVal)) = tmpVal;
        else %no, add to end if comment exists
            if ~strcmp(tmpVal,'')
                data.suburb_key(data.suburb_idx) = data.idx;
                data.suburb_notes(data.suburb_idx,1:length(tmpVal)) = tmpVal;
                data.suburb_idx = data.suburb_idx + 1;
            end
        end
        
        % store street notes (as chars)
        tmpVal = deblank(get(street_comment_edit,'String'));                
        % check if user previously entered comment (only possible in
        % editing)
        tmpIndexed = (data.street_key == load_idx);
        if sum(tmpIndexed) == 1 % yes, overwrite previous comment
            data.street_notes(tmpIndexed,1:length(tmpVal)) = tmpVal;
        else %no, add to end if comment exists
            if ~strcmp(tmpVal,'')
                data.street_key(data.street_idx) = data.idx;
                data.street_notes(data.street_idx,1:length(tmpVal)) = tmpVal;
                data.street_idx = data.street_idx + 1;
            end
        end
        
        % store local neighbourhood notes (as chars)
        tmpVal = deblank(get(local_comment_edit,'String'));                
        % check if user previously entered comment (only possible in
        % editing)
        tmpIndexed = (data.local_key == load_idx);
        if sum(tmpIndexed) == 1 % yes, overwrite previous comment
            data.local_notes(tmpIndexed,1:length(tmpVal)) = tmpVal;
        else %no, add to end if comment exists
            if ~strcmp(tmpVal,'')
                data.local_key(data.local_idx) = data.idx;
                data.local_notes(data.local_idx,1:length(tmpVal)) = tmpVal;
                data.local_idx = data.local_idx + 1;
            end
        end
        
        % store agent notes (as chars)
        tmpVal = deblank(get(agent_edit,'String'));                
        % check if user previously entered comment (only possible in
        % editing)
        tmpIndexed = (data.agent_key == load_idx);
        if sum(tmpIndexed) == 1 % yes, overwrite previous comment
            data.agent_notes(tmpIndexed,1:length(tmpVal)) = tmpVal;
        else %no, add to end if comment exists
            if ~strcmp(tmpVal,'')
                data.agent_key(data.agent_idx) = data.idx;
                data.agent_notes(data.agent_idx,1:length(tmpVal)) = tmpVal;
                data.agent_idx = data.agent_idx + 1;
            end
        end
        
        % store buyer notes (as chars)
        tmpVal = deblank(get(buyers_edit,'String'));                
        % check if user previously entered comment (only possible in
        % editing)
        tmpIndexed = (data.buyer_key == load_idx);
        if sum(tmpIndexed) == 1 % yes, overwrite previous comment
            data.buyer_notes(tmpIndexed,1:length(tmpVal)) = tmpVal;
        else %no, add to end if comment exists
            if ~strcmp(tmpVal,'')
                data.buyer_key(data.buyer_idx) = data.idx;
                data.buyer_notes(data.buyer_idx,1:length(tmpVal)) = tmpVal;
                data.buyer_idx = data.buyer_idx + 1;
            end
        end
        
        % store low old listing price (as uint32)
        tmpVal = deblank(get(low_list_price_old_edit,'String'));
        if ~strcmp(tmpVal,'')
            data.low_list_price_old(data.idx) = str2num(['uint32(' tmpVal ')']);
        end
        
        % store high old listing price (as uint32)
        tmpVal = deblank(get(high_list_price_old_edit,'String'));
        if ~strcmp(tmpVal,'')
            data.high_list_price_old(data.idx) = str2num(['uint32(' tmpVal ')']);
        end
        
        % store old listing date (as chars)
        tmpVal = deblank(get(list_date_old_edit,'String'));
        if ~strcmp(tmpVal,'')
            data.list_date_old(data.idx,1:length(tmpVal)) = tmpVal;
        end
                
        % store old agency (as chars)
        %first check if user wants to add to the names list
        if strcmpi(get(agency_old_edit,'Visible'),'on')
%          implies that user intends to add agency
%           check that not empty string
            agency = deblank(get(agency_old_edit,'string'));
            if strcmp(agency,'') 
                errordlg('Attempted to add old agency as empty string',...
                    'Agency Must Have a Name');
                return;
            end
            
            %add the name to the names list
            data.agencies = [data.agencies; repmat(' ',1,(LSTR +SSTR))];
            data.agencies(end,1:length(agency)) = agency;
%           sort it
            data.agencies = [data.agencies(1:2,:); ...
                                sortrows(data.agencies(3:end,:))];
            
%           add the name as this properties old agency
            data.agency_old(data.idx,1:length(agency)) = agency;
            
        else % otherwise, simply grab it from the popup box
                            
                agency = get(agency_old_popup,'String');
                agency = deblank(agency(get(agency_old_popup,'Value'),:));
                data.agency_old(data.idx,1:length(agency)) = agency;

        end  
        
        % store old listing agent (as chars)
        %first check if user wants to add to the names list
        if strcmpi(get(list_agent_old_edit,'Visible'),'on')
%          implies that user intends to add agent
%           check that not empty string
            new_agent = deblank(get(list_agent_old_edit,'string'));
            if strcmp(new_agent,'') 
                errordlg('Attempted to add old agent as empty string',...
                    'Agent Must Have a Name');
                return;
            end
            
            %add the name to the names list
            data.agent_names = [data.agent_names; repmat(' ',1,LSTR)];
            data.agent_names(end,1:length(new_agent)) = new_agent;
%           sort it
            [sorted, order] = sortrows(data.agent_names(3:end,:));
            data.agent_names = [data.agent_names(1:2,:); ...
                sorted];
            % store the corresponding agency for this agent
            data.agents_agency = [data.agents_agency; ...
                repmat(' ',1,(LSTR + SSTR))];
            data.agents_agency(end,1:length(agency)) = agency;
            % the agents agency list must be sorted in the same way
            data.agents_agency = data.agents_agency(order,:);
            
%           add the name as this properties old listing agent
            data.list_agent_old(data.idx,1:length(new_agent)) = new_agent;
            
        else % otherwise, simply grab it from the popup box
                            
                tmpVal = get(list_agent_old_popup,'String');
                tmpVal = deblank(tmpVal(get(list_agent_old_popup,'Value'),:));
                data.list_agent_old(data.idx,1:length(tmpVal)) = tmpVal;
                
                % store the corresponding agency for this agent
                idx = strcmp(cellstr(data.agent_names(3:end,:)),tmpVal);
                data.agents_agency(idx,1:length(tmpVal)) = tmpVal;

        end  
                
        % store low current listing price (as uint32)
        tmpVal = deblank(get(low_list_price_curr_edit,'String'));
        if ~strcmp(tmpVal,'')
            data.low_list_price_curr(data.idx) = str2num(['uint32(' tmpVal ')']);
        end
        
        % store high current listing price (as uint32)
        tmpVal = deblank(get(high_list_price_curr_edit,'String'));
        if ~strcmp(tmpVal,'')
            data.high_list_price_curr(data.idx) = str2num(['uint32(' tmpVal ')']);
        end
        
        % store current listing date (as chars)
        tmpVal = deblank(get(list_date_curr_edit,'String'));
        if ~strcmp(tmpVal,'')
            data.list_date_curr(data.idx,1:length(tmpVal)) = tmpVal;
        end
        
        % store current agency (as chars)
        %first check if user wants to add to the names list
        if strcmpi(get(agency_curr_edit,'Visible'),'on')
%          implies that user intends to add agency
%           check that not empty string
            agency = deblank(get(agency_curr_edit,'string'));
            if strcmp(agency,'') 
                errordlg('Attempted to add current agency as empty string',...
                    'Agency Must Have a Name');
                return;
            end
            
            %add the name to the names list
            data.agencies = [data.agencies; repmat(' ',1,(LSTR +SSTR))];
            data.agencies(end,1:length(agency)) = agency;
%           sort it
            data.agencies = [data.agencies(1:2,:); ...
                                sortrows(data.agencies(3:end,:))];
            
%           add the name as this properties old agency
            data.agency_curr(data.idx,1:length(agency)) = agency;
            
        else % otherwise, simply grab it from the popup box
                            
                agency = get(agency_curr_popup,'String');
                agency = deblank(agency(get(agency_curr_popup,'Value'),:));
                data.agency_curr(data.idx,1:length(agency)) = agency;

        end  
        
        % store current listing agent (as chars)
        %first check if user wants to add to the names list
        if strcmpi(get(list_agent_curr_edit,'Visible'),'on')
%          implies that user intends to add agent
%           check that not empty string
            new_agent = deblank(get(list_agent_curr_edit,'string'));
            if strcmp(new_agent,'') 
                errordlg('Attempted to add current agent as empty string',...
                    'Agent Must Have a Name');
                return;
            end
            
            %add the name to the names list
            data.agent_names = [data.agent_names; repmat(' ',1,LSTR)];
            data.agent_names(end,1:length(new_agent)) = new_agent;
%           sort it
            [sorted, order] = sortrows(data.agent_names(3:end,:));
            data.agent_names = [data.agent_names(1:2,:); ...
                sorted];
            % store the corresponding agency for this agent
            data.agents_agency = [data.agents_agency; ...
                repmat(' ',1,(LSTR + SSTR))];
            data.agents_agency(end,1:length(agency)) = agency;
            % the agents agency list must be sorted in the same way
            data.agents_agency = data.agents_agency(order,:);
            
%           add the name as this properties old listing agent
            data.list_agent_curr(data.idx,1:length(new_agent)) = new_agent;
            
        else % otherwise, simply grab it from the popup box
                            
                tmpVal = get(list_agent_curr_popup,'String');
                tmpVal = deblank(tmpVal(get(list_agent_curr_popup,'Value'),:));
                data.list_agent_curr(data.idx,1:length(tmpVal)) = tmpVal;
                
                % store the corresponding agency for this agent
                idx = strcmp(cellstr(data.agent_names(3:end,:)),tmpVal);
                data.agents_agency(idx,1:length(tmpVal)) = tmpVal;

        end  
        
        % store sold price (as uint16)
        tmpVal = deblank(get(sold_price_edit,'String'));
        if ~strcmp(tmpVal,'')
            data.sold_price(data.idx) = str2num(['uint32(' tmpVal ')']);
        end
        
        % store sold date (as chars)
        tmpVal = deblank(get(sold_date_edit,'String'));
        if ~strcmp(tmpVal,'')
            data.sold_date(data.idx,1:length(tmpVal)) = tmpVal;
        end
        
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
            data.modern = [data.modern ; false(DATA_INCREMENT,1)];
            data.maisonette = [data.maisonette ; logical(DATA_INCREMENT,1)];
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
            data.dual_access = [data.dual_access; false(DATA_INCREMENT,1)];
            %   columns - flooring
            data.tile = [data.tile; false(DATA_INCREMENT,1)];
            data.slate = [data.slate; false(DATA_INCREMENT,1)];
            data.floorboard = [data.floorboard; false(DATA_INCREMENT,1)];
            data.vinyl = [data.vinyl; false(DATA_INCREMENT,1)];
            data.carpet = [data.carpet ;false(DATA_INCREMENT,1)];
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
            data.heatlamp = [data.heatlamp ;false(DATA_INCREMENT,1)];
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
            data.pergola = [data.pergola ;false(DATA_INCREMENT,1)];
            data.verandah = [data.verandah ;false(DATA_INCREMENT,1)];
            data.verandah_c = [data.verandah_c ;zeros(DATA_INCREMENT,1,'int8')];
            data.verandah_d = [data.verandah_d ;zeros(DATA_INCREMENT,1,'int8')];
            data.verandah_s = [data.verandah_s ;zeros(DATA_INCREMENT,1,'int8')];
            data.grass = [data.grass ;zeros(DATA_INCREMENT,1,'int8')];
            data.grass_c = [data.grass_c ;zeros(DATA_INCREMENT,1,'int8')];
            data.grass_d = [data.grass_d ;zeros(DATA_INCREMENT,1,'int8')];
            data.grass_s = [data.grass_s ;zeros(DATA_INCREMENT,1,'int8')];
            %   columns - other features
            data.swim = [data.swim ;false(DATA_INCREMENT,1)];
            data.swim_c = [data.swim_c ;zeros(DATA_INCREMENT,1,'int8')];
            data.swim_d = [data.swim_d ;zeros(DATA_INCREMENT,1,'int8')];
            data.swim_s = [data.swim_s ;zeros(DATA_INCREMENT,1,'int8')];
            data.shed = [data.shed ;false(DATA_INCREMENT,1)];
            data.shed_types = [data.shed_types; repmat(' ',DATA_INCREMENT,LSTR)];
            data.granny_flat = [data.granny_flat ;false(DATA_INCREMENT,1)];
            data.granny_flat_c = [data.granny_flat_c ;zeros(DATA_INCREMENT,1,'int8')];
            data.granny_flat_d = [data.granny_flat_d ;zeros(DATA_INCREMENT,1,'int8')];
            data.granny_flat_s = [data.granny_flat_s ;zeros(DATA_INCREMENT,1,'int8')];
            % sales
            data.low_list_price_old = [data.low_list_price_old ; zeros(DATA_INCREMENT,1,'uint32')];
            data.high_list_price_old = [data.high_list_price_old ; zeros(DATA_INCREMENT,1,'uint32')];
            data.list_date_old = [data.list_date_old; repmat(' ',DATA_INCREMENT,SSTR)];
            data.list_agent_old = [data.list_agent_old; repmat(' ',DATA_INCREMENT,LSTR)];
            data.agency_old = [data.agency_old; ...
                repmat(' ',DATA_INCREMENT,(SSTR + LSTR))];
            data.low_list_price_curr = [data.low_list_price_curr ;...
                zeros(DATA_INCREMENT,1,'uint32')];
            data.high_list_price_curr = [data.high_list_price_curr ;...
                zeros(DATA_INCREMENT,1,'uint32')];
            data.list_date_curr = [data.list_date_curr; repmat(' ',DATA_INCREMENT,SSTR)];
            data.list_agent_curr = [data.list_agent_curr; repmat(' ',DATA_INCREMENT,LSTR)];
            data.agency_curr = [data.agency_curr; ...
                repmat(' ',DATA_INCREMENT,(SSTR + LSTR))];            
            data.sold_price = [data.sold_price ; zeros(DATA_INCREMENT,1,'uint32')];
            data.sold_date = [data.sold_date; repmat(' ',DATA_INCREMENT,SSTR)];
            
            
            % increment the data_max limit
            data.max = data.max + DATA_INCREMENT;
        end
        if data.idea_idx == (data.idea_max + 1)
            
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
        if load_idx == 0 % new entry added
            % update the index for the next entry
            data.idx = data.idx + 1;
        else % entry edited
            data.idx = idx_tmp;
        end
        
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
        delete(h_fig)
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
        if get(verandah_check,'Value') || get(pergola_check,'Value')
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
            set(shed_edit,'enable','on');
        else %disable
            set(shed_edit,'enable','off');
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


end