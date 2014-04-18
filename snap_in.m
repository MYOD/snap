function snap_in
% GUI snap_in
% Purpose is to to input house inspection data

%---------------------------------------------------------------------
% Initialization tasks

% constants that guide uicontrol dimensions
TXT_H = 0.024;
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
PANEL_H = 0.8;
% reusable cell-arrays for popup values
ratings = {'-','0','1','1.5','2','2.5','3'};
nums = {'-','0','1','2','3','4','5','6','7','8'};
% colour constants
bg_colour = [0.9412, 0.9412, 0.912];
lite_colour = [0.8, 0.8, 0.8];

%  Create and then hide the GUI as it is being constructed.
h_fig = figure('Visible','off','MenuBar','none','toolbar','none',...
    'numbertitle','off','Position',[1,11,720,650],'name','Snap: input');

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
    'Units','normalized','String','Unit #','Position',...
    [TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
of_text = uicontrol('parent',h_fig,'Style','text',...
    'Units','normalized','String','of','Position',...
    [TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
street_no_edit = uicontrol('parent',h_fig,'Style','edit',...
    'Units','normalized','String','St. #','Position',...
    [TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
street_edit = uicontrol('parent',h_fig,'Style','edit',...
    'Units','normalized','String','Street','Position',...
    [TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
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
    [TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
inspect_start_edit = uicontrol('parent',h_fig,'Style','edit',...
    'Units','normalized','String','HH:MM','Position',...
    [TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
inspect_to_text = uicontrol('parent',h_fig,'Style','text',...
    'Units','normalized','String','to','Position',...
    [TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
inspect_end_edit = uicontrol('parent',h_fig,'Style','edit',...
    'Units','normalized','String','HH:MM','Position',...
    [TMP_X,LINE_Y,STXT_W,TXT_H]);


% panels
features_panel = uipanel('position',[X_GAP, Y_GAP, PANEL_W, PANEL_H]);
comments_panel = uipanel('position',[X_GAP, Y_GAP, PANEL_W, PANEL_H]);
sales_panel = uipanel('position',[X_GAP, Y_GAP, PANEL_W, PANEL_H]);

% tab buttons
TMP_X = X_GAP;
features_tab = uicontrol('parent',h_fig,'Style','pushbutton',...
    'String','Features','Units','normalized',...
    'Position',[TMP_X,PANEL_H+Y_GAP,TXT_W,1.3*TXT_H],...
    'Callback',{@features_callback});
TMP_X = TMP_X+TXT_W - X_GAP;
comments_tab = uicontrol('parent',h_fig,'Style','pushbutton',...
    'String','Comments','Units','normalized',...
    'Position',[TMP_X,PANEL_H+Y_GAP,TXT_W,1.3*TXT_H],...
    'Callback',{@comments_callback});
TMP_X = TMP_X+TXT_W - X_GAP;
sales_tab = uicontrol('parent',h_fig,'Style','pushbutton',...
    'String','Sales Data','Units','normalized',...
    'Position',[TMP_X,PANEL_H+Y_GAP,TXT_W,1.3*TXT_H],...
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
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);

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
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
roofing_d_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','D','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
roofing_d_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);

% front yard/facade components
TMP_X= X_GAP;
LINE_Y=LINE_Y - POPUP_H - Y_GAP;
fy_txt = uicontrol('parent',features_panel,'Style','text','String','Front Yard:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
fy_c_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','C','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
fy_c_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
fy_d_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','D','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
fy_d_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
fy_s_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','S','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
fy_s_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W+0.1;
ff_txt = uicontrol('parent',features_panel,'Style','text','String','Front Facade:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
ff_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',{'-','Brick','Paint','Render','Panels'},'Position',...
    [TMP_X,LINE_Y,POPUP_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+POPUP_W;
ff_c_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','C','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
ff_c_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
ff_d_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','D','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
ff_d_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);

% garage components 
TMP_X = X_GAP;
LINE_Y=LINE_Y - POPUP_H - Y_GAP;
parking_txt = uicontrol('parent',features_panel,'Style','text','String','Parking:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
garage_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',nums,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
garage_txt = uicontrol('parent',features_panel,'Style','text','String','garage(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
carport_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',nums,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
carport_txt = uicontrol('parent',features_panel,'Style','text','String','carport(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
secure_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',nums,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
secure_txt = uicontrol('parent',features_panel,'Style','text','String','secure,',...
    'Units','normalized','Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
os_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',nums,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
os_txt = uicontrol('parent',features_panel,'Style','text','String','off-street,',...
    'Units','normalized','Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
parking_c_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','C','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
parking_c_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
parking_d_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','D','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
parking_d_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);

% flooring components
TMP_X = X_GAP;
LINE_Y=LINE_Y - POPUP_H - Y_GAP;
flooring_txt = uicontrol('parent',features_panel,'Style','text','String','Flooring:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
flooring_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',{'-','Tile','Slate','Floorboard','Vinyl','Carpet'},...
    'Position',[TMP_X,LINE_Y,POPUP_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+POPUP_W;
flooring_c_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','C','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
flooring_c_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
flooring_d_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','D','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
flooring_d_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);

% kitchen components
TMP_X = X_GAP;
LINE_Y=LINE_Y - POPUP_H - Y_GAP;
kitchen_txt = uicontrol('parent',features_panel,'Style','text','String','Kitchen:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
ol_check = uicontrol('parent',features_panel,'Style','checkbox','Units','normalized',...
    'String','Open Living',...
    'Position',[TMP_X,LINE_Y,POPUP_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+POPUP_W;
pantry_check = uicontrol('parent',features_panel,'Style','checkbox','Units','normalized',...
    'String','Pantry',...
    'Position',[TMP_X,LINE_Y,POPUP_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+POPUP_W;
kitchen_c_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','C','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
kitchen_c_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
kitchen_d_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','D','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
kitchen_d_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
kitchen_s_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','S','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
kitchen_s_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);

% bathroom components
TMP_X = X_GAP;
LINE_Y=LINE_Y - POPUP_H - Y_GAP;
bathroom_txt = uicontrol('parent',features_panel,'Style','text','String','Bathroom:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
bath_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',nums,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
bath_txt = uicontrol('parent',features_panel,'Style','text','String','bath(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
shower_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',nums,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
shower_txt = uicontrol('parent',features_panel,'Style','text','String','shower(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
spa_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',nums,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
spa_txt = uicontrol('parent',features_panel,'Style','text','String','spa(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
toilet_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',nums,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
toilet_txt = uicontrol('parent',features_panel,'Style','text','String','toilet(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
bathroom_c_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','C','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
bathroom_c_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
bathroom_d_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','D','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
bathroom_d_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
bathroom_s_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','S','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
bathroom_s_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X = X_GAP + TXT_W;
LINE_Y=LINE_Y - POPUP_H - Y_GAP/2;
hl_check = uicontrol('parent',features_panel,'Style','checkbox','Units','normalized',...
    'String','Heatlamps','Position', [TMP_X,LINE_Y,TXT_W,POPUP_H]);

% bedroom components
TMP_X = X_GAP;
LINE_Y=LINE_Y - POPUP_H - Y_GAP;
bedroom_txt = uicontrol('parent',features_panel,'Style','text','String','Bedroom: x',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+TXT_W;
bedroom_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',nums,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
wir_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',nums,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
wir_txt = uicontrol('parent',features_panel,'Style','text','String','WIR(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
bir_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',nums,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
bir_txt = uicontrol('parent',features_panel,'Style','text','String','BIR(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
kids_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',nums,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
kids_txt = uicontrol('parent',features_panel,'Style','text','String','kid(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,XSTXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+XSTXT_W;
ensuite_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',nums,'Position',...
    [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
ensuite_txt = uicontrol('parent',features_panel,'Style','text','String','ensuite(s),',...
    'Units','normalized','Position',[TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
brt_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',nums,'Position',...
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
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
bedroom_d_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','D','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
bedroom_d_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
bedroom_s_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','S','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
bedroom_s_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);

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
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
cooling_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','Cooling','Position', [TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
cooling_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
coverage_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','Coverage','Position', [TMP_X,LINE_Y,STXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
coverage_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);

% backyard components
TMP_X = X_GAP;
LINE_Y=LINE_Y - POPUP_H - Y_GAP;
by_txt = uicontrol('parent',features_panel,'Style','text','String','Backyard:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
by_c_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','C','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
by_c_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
by_d_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','D','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
by_d_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
by_s_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','S','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
by_s_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
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
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
verandah_d_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','D','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
verandah_d_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
verandah_s_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','S','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
verandah_s_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
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
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
grass_d_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','D','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
grass_d_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
grass_s_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','S','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
grass_s_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);

% Other notable features components
TMP_X = X_GAP;
LINE_Y=LINE_Y - POPUP_H - Y_GAP;
of_txt = uicontrol('parent',features_panel,'Style','text','String','Other Features:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
sp_check = uicontrol('parent',features_panel,'Style','checkbox','String','Swimming Pool',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W+0.01,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W+0.01;
sp_c_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','C','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
sp_c_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
sp_d_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','D','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
sp_d_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
sp_s_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','S','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
sp_s_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
shed_check = uicontrol('parent',features_panel,'Style','checkbox','Units','normalized',...
    'String','Sheds','Position',...
    [TMP_X,LINE_Y,STXT_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+STXT_W;
shed_edit = uicontrol('parent',features_panel,'Style','edit','Units','normalized',...
    'String','','min',0,'max',10,'horizontalAlignment','left',...
    'Position', [TMP_X,LINE_Y-COMMENT_H/4,TXT_W,COMMENT_H]);
TMP_X = X_GAP+TXT_W;
LINE_Y=LINE_Y - POPUP_H - Y_GAP/2;
gf_check = uicontrol('parent',features_panel,'Style','checkbox','Units','normalized',...
    'String','Granny Flat','Position',...
    [TMP_X,LINE_Y,TXT_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
gf_c_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','C','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
gf_c_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
gf_d_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','D','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
gf_d_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);
TMP_X=TMP_X+X_GAP+NUM_W;
gf_s_txt = uicontrol('parent',features_panel,'Style','text','Units','normalized',...
    'String','S','Position', [TMP_X,LINE_Y,LETTER_W,TXT_H]);
TMP_X=TMP_X+X_GAP+LETTER_W;
gf_s_popup = uicontrol('parent',features_panel,'Style','popup','Units','normalized',...
    'String',ratings,'Position', [TMP_X,LINE_Y,NUM_W,POPUP_H]);

%---------------------------------------------------------------------
%  Construct the components of comments panel

% good reno ideas components
TMP_X = X_GAP;
LINE_Y= 1 - COMMENT_H - Y_GAP;
ri_txt = uicontrol('parent',comments_panel,'Style','text','String','Reno Ideas:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
ri_edit = uicontrol('parent',comments_panel,'Style','edit','Units','normalized',...
    'String','','min',0,'max',10,'horizontalAlignment','left',...
    'Position', [TMP_X,LINE_Y-COMMENT_H/2,COMMENT_W,COMMENT_H]);

% general comments components
TMP_X = X_GAP;
LINE_Y=LINE_Y - COMMENT_H - Y_GAP;
general_txt = uicontrol('parent',comments_panel,'Style','text','String','General:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
general_edit = uicontrol('parent',comments_panel,'Style','edit','Units','normalized',...
    'String','','min',0,'max',10,'horizontalAlignment','left',...
    'Position', [TMP_X,LINE_Y-COMMENT_H/2,COMMENT_W,COMMENT_H]);

% suburb comments components
TMP_X = X_GAP;
LINE_Y=LINE_Y - COMMENT_H - Y_GAP;
suburb_comment_txt = uicontrol('parent',comments_panel,'Style','text','String','Suburb:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
suburb_comment_edit = uicontrol('parent',comments_panel,'Style','edit','Units','normalized',...
    'String','','min',0,'max',10,'horizontalAlignment','left',...
    'Position', [TMP_X,LINE_Y-COMMENT_H/2,COMMENT_W,COMMENT_H]);

% street comments components
TMP_X = X_GAP;
LINE_Y=LINE_Y - COMMENT_H - Y_GAP;
street_comment_txt = uicontrol('parent',comments_panel,'Style','text','String','Street:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
street_comment_edit = uicontrol('parent',comments_panel,'Style','edit','Units','normalized',...
    'String','','min',0,'max',10,'horizontalAlignment','left',...
    'Position', [TMP_X,LINE_Y-COMMENT_H/2,COMMENT_W,COMMENT_H]);

% local neighbourhood components
TMP_X = X_GAP;
LINE_Y=LINE_Y - COMMENT_H - Y_GAP;
ln_comment_txt = uicontrol('parent',comments_panel,'Style','text','String','Neighbourhood:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
ln_comment_edit = uicontrol('parent',comments_panel,'Style','edit','Units','normalized',...
    'String','','min',0,'max',10,'horizontalAlignment','left',...
    'Position', [TMP_X,LINE_Y-COMMENT_H/2,COMMENT_W,COMMENT_H]);

% Agent components
TMP_X = X_GAP;
LINE_Y=LINE_Y - COMMENT_H - Y_GAP;
agent_txt = uicontrol('parent',comments_panel,'Style','text','String','Agent:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
agent_edit = uicontrol('parent',comments_panel,'Style','edit','Units','normalized',...
    'String','','min',0,'max',10,'horizontalAlignment','left',...
    'Position', [TMP_X,LINE_Y-COMMENT_H/2,COMMENT_W,COMMENT_H]);

% Buyer components
TMP_X = X_GAP;
LINE_Y=LINE_Y - COMMENT_H - Y_GAP;
buyers_txt = uicontrol('parent',comments_panel,'Style','text','String','Buyers:',...
    'Units','normalized','Position',[TMP_X,LINE_Y,TXT_W,TXT_H]);
TMP_X=TMP_X+X_GAP+TXT_W;
buyers_edit = uicontrol('parent',comments_panel,'Style','edit','Units','normalized',...
    'String','','min',0,'max',10,'horizontalAlignment','left',...
    'Position', [TMP_X,LINE_Y-COMMENT_H/2,COMMENT_W,COMMENT_H]);



%---------------------------------------------------------------------
%  Initialization tasks
% align([hsurf,hmesh,hcontour,htext,hpopup],'Center','None');

% Initialize the GUI.
% Change units to normalized so components resize automatically.
% set([f,hsurf,hmesh,hcontour,htext,hpopup],'Units','normalized');

% Generate the data to plot.
% peaks_data = peaks(35);
% membrane_data = membrane;
% [x,y] = meshgrid(-8:.5:8);
% r = sqrt(x.^2+y.^2) + eps;
% sinc_data = sin(r)./r;
% 
% % Create a plot in the axes.
% current_data = peaks_data;
% surf(current_data);

% Assign the GUI a name to appear in the window title.
% set(f,'Name','Simple GUI')

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
        set(features_tab,'backgroundColor',bg_colour);
        set(comments_tab,'backgroundColor',lite_colour);
        set(sales_tab,'backgroundColor',lite_colour);
        
        %   make this panel the only visible
        set(features_panel,'visible','on');
        set(comments_panel,'visible','off');
        set(sales_panel,'visible','off');
        
    end

%   user selected the comments tab
    function comments_callback(source,eventdata)
        
%       make tab colour look 'selected'
        set(features_tab,'backgroundColor',lite_colour);
        set(comments_tab,'backgroundColor',bg_colour);
        set(sales_tab,'backgroundColor',lite_colour);
        
        %   make this panel the only visible
        set(features_panel,'visible','off');
        set(comments_panel,'visible','on');
        set(sales_panel,'visible','off');
        
    end

%   user selected the sales tab
    function sales_callback(source,eventdata)
        
%       make tab colour look 'selected'
        set(features_tab,'backgroundColor',lite_colour);
        set(comments_tab,'backgroundColor',lite_colour);
        set(sales_tab,'backgroundColor',bg_colour);
        
        %   make this panel the only visible
        set(features_panel,'visible','off');
        set(comments_panel,'visible','off');
        set(sales_panel,'visible','on');
        
    end
    
    %  Pop-up menu callback. Read the pop-up menu Value property to
    %  determine which item is currently displayed and make it the
    %  current data. This callback automatically has access to
    %  current_data because this function is nested at a lower level.
    function popup_menu_Callback(source,eventdata)
        % Determine the selected data set.
        str = get(source, 'String');
        val = get(source,'Value');
        % Set current data to the selected data set.
        switch str{val};
            case 'Peaks' % User selects Peaks.
                current_data = peaks_data;
            case 'Membrane' % User selects Membrane.
                current_data = membrane_data;
            case 'Sinc' % User selects Sinc.
                current_data = sinc_data;
        end
    end

%---------------------------------------------------------------------
%  Utility functions for MYGUI


end