function varargout = snap_filter()
% GUI snap_filter
% Purpose is to filter and sort properties for simple and easy analysis
% Secondary purpose is to get predefined variables:
%       varargout{1} = VAR_ARR - 4D char array holding user-friendly name,
%                       variable name and type respectively
%       Note to access secondary purpose must call function with exactly
%       one output. Function will return variable and exit.
%---------------------------------------------------------------------
% Initialization tasks

% the headings control the data in the table
table_headings = {};
table_datum = {};
table_defaults = {'Street Number', 'Street Name','Street Type', 'Suburb',...
    'Sold Price ($)', 'Sold Date'};
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
tLIST_W = 0.18;
tFULL_H = (1 - 2*tY_GAP);
tBUTTON_W = 0.12;
tBUTTON_H = 0.18;
tTXT_W = 0.08;
tTXT_H = 0.18;
% states
DISPLAY_MODE = 2;
FILTER_MODE = 0;
IS_CHAR = 0;
IS_NUM = 1;
IS_LOGIC = 2;
% colour constants
BG_COLOUR = [0.9412, 0.9412, 0.912];
LITE_COLOUR = [0.8, 0.8, 0.8];
% index constants
V1 = 1;
V2 = 2;
DESC = 3;
KEYWORD = 4;
% index constants for VAR_ARR
NAME = 1; % user friendly description
VAR = 2; % programming variable
TYPE = 3; % variable type: logical, *int*, char*
CONTROL = 4; % variable name of associated uicontrol
XLSTR = 200; % length of notes strings
STR = 20; % standard string length
HIGH_ROWS =6;
ADDRESS_ROWS = 5;
BUILD_ROWS = 7;
FEATURES_ROWS=12;
CONSTRUCTION_ROWS=2;
ROOFING_ROWS=3;
FRONT_YARD_ROWS=3;
FRONT_FACADE_ROWS=3;
PARKING_ROWS=7;
FLOORING_ROWS=7;
KITCHEN_ROWS=5;
BATHROOM_ROWS=8;
BEDROOM_ROWS=9;
CLIMATE_ROWS=3;
BACK_YARD_ROWS=12;
OTHER_ROWS=10;
INSPECTION_ROWS=3;
SALES_ROWS=13;
NOTES_ROWS=7;
% string arrays
BOOLEAN_STRS = {'Is','Is Not'};
NUMBERS_STRS = {'Below', 'Above', 'Between', 'Exactly'};
HIGH_STRS = repmat(' ',HIGH_ROWS,STR); idx = 1;
str='Address'; HIGH_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Build Stats'; HIGH_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Comments'; HIGH_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Features'; HIGH_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Inspection'; HIGH_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Sales'; HIGH_STRS(idx,1:length(str)) = str;
ADDRESS_STRS = repmat(' ',ADDRESS_ROWS,STR); idx = 1;
str='Unit Number'; ADDRESS_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Street Number'; ADDRESS_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Street Name'; ADDRESS_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Street Type'; ADDRESS_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Suburb'; ADDRESS_STRS(idx,1:length(str)) = str;
BUILD_STRS = repmat(' ',BUILD_ROWS,STR); idx = 1;
str='Year Built'; BUILD_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Year Renovated'; BUILD_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Modern'; BUILD_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Maisonnette'; BUILD_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Land Area'; BUILD_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Living Area'; BUILD_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Frontage'; BUILD_STRS(idx,1:length(str)) = str;
FEATURES_STRS = repmat(' ',FEATURES_ROWS,STR); idx = 1;
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
CONSTRUCTION_STRS = repmat(' ',CONSTRUCTION_ROWS,STR); idx = 1;
str='Construction'; CONSTRUCTION_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='C (Construction)'; CONSTRUCTION_STRS(idx,1:length(str)) = str;
ROOFING_STRS = repmat(' ',ROOFING_ROWS,STR); idx = 1;
str='Roofing'; ROOFING_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='C (Roofing)'; ROOFING_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='D (Roofing)'; ROOFING_STRS(idx,1:length(str)) = str;
FRONT_YARD_STRS = repmat(' ',FRONT_YARD_ROWS,STR); idx = 1;
str='C (Front Yard)'; FRONT_YARD_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='D (Front Yard)'; FRONT_YARD_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='S (Front Yard)'; FRONT_YARD_STRS(idx,1:length(str)) = str;
FRONT_FACADE_STRS = repmat(' ',FRONT_FACADE_ROWS,STR); idx = 1;
str='Front Facade'; FRONT_FACADE_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='C (Front Facade)'; FRONT_FACADE_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='D (Front Facade)'; FRONT_FACADE_STRS(idx,1:length(str)) = str;
PARKING_STRS = repmat(' ',PARKING_ROWS,STR); idx = 1;
str='# Garages'; PARKING_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='# Carports'; PARKING_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='# Secure'; PARKING_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='# Off-street'; PARKING_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='C (Parking)'; PARKING_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='D (Parking)'; PARKING_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Dual-Access?'; PARKING_STRS(idx,1:length(str)) = str;
FLOORING_STRS = repmat(' ',FLOORING_ROWS,STR); idx = 1;
str='Tiles?'; FLOORING_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Slates?'; FLOORING_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Floorboards?'; FLOORING_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Vinyl?'; FLOORING_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Carpet?'; FLOORING_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='C (Flooring)'; FLOORING_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='D (Flooring)'; FLOORING_STRS(idx,1:length(str)) = str;
KITCHEN_STRS = repmat(' ',KITCHEN_ROWS,STR); idx = 1;
str='Open Living?'; KITCHEN_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Pantry?'; KITCHEN_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='C (Kitchen)'; KITCHEN_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='D (Kitchen)'; KITCHEN_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='S (Kitchen)'; KITCHEN_STRS(idx,1:length(str)) = str;
BATHROOM_STRS = repmat(' ',BATHROOM_ROWS,STR); idx = 1;
str='# Baths'; BATHROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='# Showers'; BATHROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='# Toilets'; BATHROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='# Spas'; BATHROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='C (Bathroom)'; BATHROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='D (Bathroom)'; BATHROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='S (Bathroom)'; BATHROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Heatlamps?'; BATHROOM_STRS(idx,1:length(str)) = str;
BEDROOM_STRS = repmat(' ',BEDROOM_ROWS,STR); idx = 1;
str='# Bedrooms'; BEDROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='# WIRs'; BEDROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='# BIRs'; BEDROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='# Kid Rooms'; BEDROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='# Ensuites'; BEDROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='# BR Toilets'; BEDROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='C (Bedroom)'; BEDROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='D (Bedroom)'; BEDROOM_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='S (Bedroom)'; BEDROOM_STRS(idx,1:length(str)) = str;
CLIMATE_STRS = repmat(' ',CLIMATE_ROWS,STR); idx = 1;
str='Heating'; CLIMATE_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Cooling'; CLIMATE_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Coverage'; CLIMATE_STRS(idx,1:length(str)) = str;
BACK_YARD_STRS = repmat(' ',BACK_YARD_ROWS,STR); idx = 1;
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
OTHER_STRS = repmat(' ',OTHER_ROWS,STR); idx = 1;
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
INSPECTION_STRS = repmat(' ',INSPECTION_ROWS,STR); idx = 1;
str='Date (Inspection)'; INSPECTION_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Start (Inspection)'; INSPECTION_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='End (Inspection)'; INSPECTION_STRS(idx,1:length(str)) = str;
SALES_STRS = repmat(' ',SALES_ROWS,STR); idx = 1;
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
str='Sold Date'; SALES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Days on Market'; SALES_STRS(idx,1:length(str)) = str;
NOTES_STRS = repmat(' ',NOTES_ROWS,STR); idx = 1;
str='Reno Ideas'; NOTES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='General'; NOTES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Suburb Notes'; NOTES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Street Notes'; NOTES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Local Neighbourhood'; NOTES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Agent Notes'; NOTES_STRS(idx,1:length(str)) = str; idx = idx + 1;
str='Buyer Types'; NOTES_STRS(idx,1:length(str)) = str; idx = idx + 1;

% construct arrays that maps lowest level descriptions to variables
VAR_ROWS = ADDRESS_ROWS + BUILD_ROWS + CONSTRUCTION_ROWS + ROOFING_ROWS + ...
    FRONT_YARD_ROWS + FRONT_FACADE_ROWS + PARKING_ROWS + FLOORING_ROWS + ...
    KITCHEN_ROWS + BATHROOM_ROWS + BEDROOM_ROWS + CLIMATE_ROWS + ...
    BACK_YARD_ROWS + OTHER_ROWS + INSPECTION_ROWS + SALES_ROWS + NOTES_ROWS;
% DESC_ARR = repmat(' ',VAR_ROWS,STR); % holds user friendly descriptions
VAR_ARR = repmat(' ',[VAR_ROWS,STR, 3]); % holds corresponding variable names
VAR_ARR(:,:,NAME) = [ADDRESS_STRS; BUILD_STRS; CONSTRUCTION_STRS; ROOFING_STRS; ...
    FRONT_YARD_STRS; FRONT_FACADE_STRS; PARKING_STRS; FLOORING_STRS; ...
    KITCHEN_STRS; BATHROOM_STRS; BEDROOM_STRS; CLIMATE_STRS; BACK_YARD_STRS;...
    OTHER_STRS; INSPECTION_STRS; SALES_STRS; NOTES_STRS];
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
idx = 1;
str='unit_no'; VAR_ARR(idx,1:length(str),VAR) = str;
str=SCH; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='street_no'; VAR_ARR(idx,1:length(str),VAR) = str;
str=SCH; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='street'; VAR_ARR(idx,1:length(str),VAR) = str; 
str=LCH; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='st_type'; VAR_ARR(idx,1:length(str),VAR) = str;
str=SCH; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='suburb'; VAR_ARR(idx,1:length(str),VAR) = str; 
str=LCH; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='built'; VAR_ARR(idx,1:length(str),VAR) = str; 
str=U16; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='last_reno'; VAR_ARR(idx,1:length(str),VAR) = str;
str=U16; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='modern'; VAR_ARR(idx,1:length(str),VAR) = str; 
str=LOG; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='maisonette'; VAR_ARR(idx,1:length(str),VAR) = str;
str=LOG; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='land_area'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=U16; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='floor_area'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=U16; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='frontage'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=U8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='construction'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=LCH; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='construction_c'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='roofing'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=LCH; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='roofing_c'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='roofing_d'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='front_yard_c'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='front_yard_d'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='front_yard_s'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='front_facade'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=LCH; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='front_facade_c'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='front_facade_d'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='garages'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='carports'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='secures'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='offstreets'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='parking_c'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='parking_d'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='dual_access'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=LOG; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='tile'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=LOG; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='slate'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=LOG; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='floorboard'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=LOG; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='vinyl'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=LOG; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='carpet'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=LOG; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='flooring_c'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='flooring_d'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='open_living'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=LOG; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='pantry'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=LOG; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='kitchen_c'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='kitchen_d'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='kitchen_s'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='baths'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='showers'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='toilets'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='spas'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='bathroom_c'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='bathroom_d'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='bathroom_s'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='heatlamp'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=LOG; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='bedrooms'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='wirs'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='birs'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='kids'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='ensuites'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='brts'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='bedroom_c'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='bedroom_d'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='bedroom_s'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='heating'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='cooling'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='coverage'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='back_yard_c'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='back_yard_d'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='back_yard_s'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='pergola'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=LOG; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='verandah'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=LOG; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='verandah_c'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='verandah_d'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='verandah_s'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='grass'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=LOG; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='grass_c'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='grass_d'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='grass_s'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='swim'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=LOG; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='swim_c'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='swim_d'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='swim_s'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='shed'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=LOG; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='shed_types'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=LCH; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='granny_flat'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=LOG; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='granny_flat_c'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='granny_flat_d'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='granny_flat_s'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=I8; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='inspect_date'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=SCH; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='inspect_start'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=XSCH; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='inspect_end'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=XSCH; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='low_list_price_old'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=U32; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='high_list_price_old'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=U32; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='list_date_old'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=SCH; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='list_agent_old'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=LCH; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='agency_old'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=CH28; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='low_list_price_curr'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=U32; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='high_list_price_curr'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=U32; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='list_date_curr'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=SCH; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='list_agent_curr'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=LCH; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='agency_curr'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=CH28; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='sold_price'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=U32; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='sold_date'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=SCH; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='dom'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=U16; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='idea_'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=XLCH; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='general_'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=XLCH; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='suburb_'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=XLCH; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='street_'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=XLCH; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='local_'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=XLCH; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='agent_'; VAR_ARR(idx,1:length(str),VAR) = str;  
str=XLCH; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;
str='buyer_'; VAR_ARR(idx,1:length(str),VAR) = str;
str=XLCH; VAR_ARR(idx,1:length(str),TYPE) = str; idx = idx + 1;

%---------------------------------------------------------------------
%  Secondary purpose of function: if two outputs return ARRays and exit
if nargout == 1
    varargout{1} = VAR_ARR;
    return;
end

%---------------------------------------------------------------------
%  Create and then hide the GUI as it is being constructed.
h_fig = figure('Visible','off','MenuBar','none','toolbar','none',...
    'numbertitle','off','Position',[1,1,720,650],'name','Snap: filter',...
    'CloseRequestFcn',{@exit_callback},'tag','snap_filter');

%---------------------------------------------------------------------
%  Construct the components of the figure

% top tab buttons components
tmp_x = X_GAP;
filter_tab = uicontrol('parent',h_fig,'Style','pushbutton',...
    'String','Filter','Units','normalized',...
    'Position',[tmp_x,LARGE_TABLE(4)+INFO_H+3*Y_GAP,TAB_W,TAB_H],...
    'Callback',{@filter_callback});
tmp_x = tmp_x + TAB_W;
% sort_tab = uicontrol('parent',h_fig,'Style','pushbutton',...
%     'String','Sort','Units','normalized',...
%     'Position',[tmp_x,LARGE_TABLE(4)+INFO_H+3*Y_GAP,TAB_W,TAB_H],...
%     'Callback',{@sort_callback});
% tmp_x = tmp_x + TAB_W;
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
% filter_panel = uipanel('position',...
%     [X_GAP, SMALL_TABLE(2)+SMALL_TABLE(4)+Y_GAP, FULL_W, PANEL_H],...
%     'Units','normalized');
% sort_panel = uipanel('position',...
%     [X_GAP, SMALL_TABLE(2)+SMALL_TABLE(4)+Y_GAP, FULL_W, PANEL_H],...
%     'Units','normalized');
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
info_txt = uicontrol('parent',info_panel,'Style','text',...
    'Units','normalized','Position',[X_GAP, Y_GAP, FULL_W, FULL_W]);

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
    [tmp_x tY_GAP tLIST_W tFULL_H],'min',0,'max',2,'Callback',...
    {@low_callback});
tmp_x_copy = tmp_x + tLIST_W + tX_GAP;

% button components
y_incr = (1 - 3*tBUTTON_H)/4; % space buttons equidistant vertically
line_y = 3*y_incr + 2*tBUTTON_H;
% tmp_x = tmp_x + tX_GAP + tLIST_W;
tmp_x = 1 - tX_GAP - tBUTTON_W;
add_button = uicontrol('parent',display_panel,'Style','pushbutton',...
    'Units','normalized','Position', ...
    [tmp_x line_y tBUTTON_W tBUTTON_H],'callback',{@add_callback});
line_y = 2*y_incr + tBUTTON_H;
default_button = uicontrol('parent',display_panel,'Style','pushbutton',...
    'Units','normalized','Position', ...
    [tmp_x line_y tBUTTON_W tBUTTON_H],'callback',{@default_callback});
line_y = y_incr;
none_button = uicontrol('parent',display_panel,'Style','pushbutton',...
    'Units','normalized','Position', ...
    [tmp_x line_y tBUTTON_W tBUTTON_H],'callback',{@none_callback});



%%%%%%%%--------------- filter part of display panel

tmp_x = tmp_x_copy;
line_y = 2*tY_GAP + 0.8*tFULL_H;
filter_text = uicontrol('parent',display_panel,'Style','text','String',...
    'Filter Type:',...
    'Units','normalized','Position', [tmp_x line_y tTXT_W tTXT_H]);
tmp_x = tmp_x + tTXT_W + tX_GAP/2;

filter_popup = uicontrol('parent',display_panel,'Style','popup',...
    'Units','normalized','Position', [tmp_x line_y 1.6*tTXT_W tTXT_H],...
    'Callback',{@filt_popup_callback});

tmp_x = tmp_x_copy;
line_y = line_y - tTXT_H - tY_GAP/2;
filter_from_edit = uicontrol('parent',display_panel,'Style','edit',...
    'Units','normalized','Position', [tmp_x line_y tTXT_W tTXT_H]);
tmp_x = tmp_x + tTXT_W + tX_GAP/2;

filter_and = uicontrol('parent',display_panel,'Style','text','String','and',...
    'Units','normalized','Position', [tmp_x line_y 0.4*tTXT_W tTXT_H]);
tmp_x = tmp_x + 0.4*tTXT_W + tX_GAP/2;

filter_to_edit = uicontrol('parent',display_panel,'Style','edit',...
    'Units','normalized','Position', [tmp_x line_y tTXT_W tTXT_H]);

tmp_x = tmp_x_copy;
filters_list = uicontrol('parent',display_panel,'Style','listbox',...
    'Units','normalized','String',{},'Value',[],'Position', ...
    [tmp_x tY_GAP 1.2*tLIST_W 0.6*tFULL_H],'min',0,'max',2);


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

% By default, have no filters
keep_rows = true(data.idx-1,1);
filter_hist = cell(0,4);
% By default, start on filter tab
filter_callback(filter_tab,0);

% display default table columns
set(high_list,'userData',DISPLAY_MODE); %trick gui to think its in display mode
default_callback(default_button,0);
set(high_list,'userData',FILTER_MODE);

% Move the GUI to the center of the screen.
movegui(h_fig,'center')

% Make the GUI visible.
set(h_fig,'Visible','on');


%---------------------------------------------------------------------
%  Callbacks

%   the figure has been requested to close
    function exit_callback(source,eventdata)
        
        % if snap exist refocus on that
        master_handle = findall(0,'tag','snap');
        if ishandle(master_handle)
            figure(master_handle);
        end
        delete(h_fig);
        
    end

%   user selected the filter tab
    function filter_callback(source,eventdata)
        
        %       make tab colour look 'selected'
        set(filter_tab,'backgroundColor',BG_COLOUR);
        %         set(sort_tab,'backgroundColor',LITE_COLOUR);
        set(display_tab,'backgroundColor',LITE_COLOUR);
        set(hide_tab,'backgroundColor',LITE_COLOUR);
        
        % indicate in FILTER state
        set(high_list,'UserData',FILTER_MODE);
        
        % refresh display of high,med,low listboxes
        set(high_list,'Value',1);
        high_callback(high_list,0);
        
        % hide/show appropriate components
        set(filter_text,'visible','on');
        set(filters_list,'visible','on');
        set(filter_popup,'visible','on');
        set(default_button,'visible','on');
        set(add_button','String','Add New Filter');
        set(default_button,'String','Remove');
        set(none_button,'String','Clear All');
        
        % minimise the table
        set(table,'position',SMALL_TABLE);
        
        %   make this panel the only visible
        %         set(filter_panel,'visible','on');
        %         set(sort_panel,'visible','off');
        set(display_panel,'visible','on');
        
        
    end

% %   user selected the sort tab
%     function sort_callback(source,eventdata)
%
%         %       make tab colour look 'selected'
%         set(filter_tab,'backgroundColor',LITE_COLOUR);
%         %         set(sort_tab,'backgroundColor',BG_COLOUR);
%         set(display_tab,'backgroundColor',LITE_COLOUR);
%         set(hide_tab,'backgroundColor',LITE_COLOUR);
%
%         %   make this panel the only visible
%         %         set(filter_panel,'visible','off');
%         %         set(sort_panel,'visible','on');
%         set(display_panel,'visible','on');
%
%         % remove filters list, add defaults button
%         set(filters_list,'visible','off');
%         set(default_button,'visible','on');
%
%         % minimise the table
%         set(table,'position',SMALL_TABLE);
%
%     end

%   user selected the display tab
    function display_callback(source,eventdata)
        
        
        % indicate desire that multiple selection be on
        set(high_list,'UserData',DISPLAY_MODE);
        
        % reset values to 1
        set(high_list,'Value',1);
        high_callback(high_list,0);
        
        %       make tab colour look 'selected'
        set(filter_tab,'backgroundColor',LITE_COLOUR);
        %         set(sort_tab,'backgroundColor',LITE_COLOUR);
        set(display_tab,'backgroundColor',BG_COLOUR);
        set(hide_tab,'backgroundColor',LITE_COLOUR);
        
        %   make this panel the only visible
        %         set(filter_panel,'visible','off');
        %         set(sort_panel,'visible','off');
        set(display_panel,'visible','on');
        
        % hide/show appropriate components
        set(filter_text,'visible','off');
        set(filters_list,'visible','off');
        set(filter_popup,'visible','off');
        set(filter_from_edit,'visible','off');
        set(filter_and,'visible','off');
        set(filter_to_edit,'visible','off');
        set(default_button,'visible','on');
        set(add_button','String','Add/Remove');
        set(default_button,'String','Show Defaults');
        set(none_button,'String','Clear All');
        
        % minimise the table
        set(table,'position',SMALL_TABLE);
        
    end

%   user selected the hide tab
    function hide_callback(source,eventdata)
        
        %       make tab colour look 'selected'
        set(filter_tab,'backgroundColor',LITE_COLOUR);
        %         set(sort_tab,'backgroundColor',LITE_COLOUR);
        set(display_tab,'backgroundColor',LITE_COLOUR);
        set(hide_tab,'backgroundColor',BG_COLOUR);
        
        %   hide the panels
        %         set(filter_panel,'visible','off');
        %         set(sort_panel,'visible','off');
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
                set(med_list,'max',get(high_list,'UserData')); %enable multiple selection
            case 'Build Stats'
                set(med_list,'string',BUILD_STRS);
                set(med_list,'max',get(high_list,'UserData')); %enable multiple selection
            case 'Comments'
                set(med_list,'string',NOTES_STRS);
                set(med_list,'max',get(high_list,'UserData')); %enable multiple selection
            case 'Features'
                set(med_list,'string',FEATURES_STRS);
                set(med_list,'max',0); %disable multiple selection always
            case 'Inspection'
                set(med_list,'string',INSPECTION_STRS);
                set(med_list,'max',get(high_list,'UserData')); %enable multiple selection
            case 'Sales'
                set(med_list,'string',SALES_STRS);
                set(med_list,'max',get(high_list,'UserData')); %enable multiple selectionn
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
                
                % call low level callback
                low_callback(low_list,0);
                
                % make sure list is visible
                set(low_list,'Visible','on');
                %                allow/disallow multiple selection at lowest level
                set(low_list,'max',get(high_list,'UserData'));
                
            otherwise
                % make sure list is not visible
                set(low_list,'Visible','off');
                
                if get(high_list,'UserData') == FILTER_MODE
                    % in filter mode lowest level listbox selection
                    % affects the filter edit box options
                    
                    % set filter components based on selection
                    med_selection = get(med_list,'String');
                    med_selection = med_selection(get(med_list,'Value'),:);
                    prep_filters(med_selection);
                    
                    %                     idx = strcmp(DESC_ARR,cellstr(med_selection));
                    %                     var = deblank(VAR_ARR(idx,:));
                    %
                    %                     if ~isfield(data,var) % implies comment column
                    %
                    %
                    %                         %                     set(filter_from_edit,'visible','on');
                    %                         %                     set(filter_and,'visible','on');
                    %                         %                     set(filter_to_edit,'visible','on');
                    %
                    %                     end
                end
        end
        
        
    end

%   user made a selection in the lowest level list
    function low_callback(source, eventdata)
        
        if get(high_list,'UserData') == FILTER_MODE
            % in filter mode lowest level listbox selection
            % affects the filter edit box options
            
            % set filter components based on selection
            low_selection = get(low_list,'String');
            low_selection = low_selection(get(low_list,'Value'),:);
            prep_filters(low_selection);
            
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
        
        if get(high_list,'UserData') == FILTER_MODE
            
            % add filter command to list
            disp_command(strs{1});
            
            % recover the key filter term
            keyword = get(filter_popup,'String');
            keyword = keyword{get(filter_popup,'Value')};
            
            % recover values from edit boxes
            v1 = deblank(get(filter_from_edit,'String'));
            v2 = deblank(get(filter_to_edit,'String'));
            
            % filter the indices
            filter_rows(v1,v2,strs{1},keyword);
            
        else % DISPLAY MODE
            
            % add/remove selected elements
            table_headings = setxor(table_headings,strs,'stable');
            
        end
        
        % update table
        update_table();
        
    end

%   user pressed the clear all button in display panel
    function none_callback(source, eventdata)
        
        if get(high_list,'UserData') == DISPLAY_MODE
            % clear all menu items
            table_headings = {};
        else %filter mode
            % clear all filters
            keep_rows = true(data.idx-1,1);
            set(filters_list,'String',{});
            filter_hist = cell(0,4);
        end
        update_table();
        
    end

%   user pressed the Show Defaults button
%   in display mode this is 'Show Defaults'
%   in filter mode this is 'Remove'
    function default_callback(source, eventdata)
        
        % In filter mode this button means remove existing filter(s)
        if get(high_list,'UserData') == FILTER_MODE
            
            % recover selections from filter list
            bad_idx = get(filters_list,'value');
            
            if isempty(bad_idx)
                warndlg(['You must select one or more existing filters' ...
                    ' from the filters list to remove'],'No Selection Made');
                return;
            end
            % remove selections from filter list
            set(filters_list,'value',[]); % as options will change
            str = get(filters_list,'string');
            str(bad_idx,:) = [];
            set(filters_list,'string',str);
            
            % remove selections from filter structure
            filter_hist(bad_idx,:) = [];
            
            % refilter
            keep_rows = true(data.idx-1,1);
            for i = 1:size(filter_hist,1)
               
                filter_rows(filter_hist{i,V1},filter_hist{i,V2},...
                    filter_hist{i,DESC},filter_hist{i,KEYWORD});
                
            end
            
        else % DISPLAY MODE,
            
            table_headings = table_defaults;
            
        end
        
        update_table();
        
    end

% user made selection in the filter popup menu
    function filt_popup_callback(source,eventdata)
        
        selection = get(source,'String');
        selection = selection(get(source,'Value'));
        
        if strcmp(selection,'Between')
            set(filter_from_edit,'visible','on');
            set(filter_and,'visible','on');
            set(filter_to_edit,'visible','on');
            
        elseif get(filter_popup,'UserData') ~= IS_LOGIC
            
            set(filter_from_edit,'visible','on');
            set(filter_and,'visible','off');
            set(filter_to_edit,'visible','off');
            
        else
            
            set(filter_from_edit,'visible','off');
            set(filter_and,'visible','off');
            set(filter_to_edit,'visible','off');
        end
        
    end


%---------------------------------------------------------------------
%  Utility functions for snap_filter

% refresh contents of table based on table_headings
    function update_table()
        
        % initialise table data structure
        table_datum = cell(sum(keep_rows),length(table_headings));
        
        % for each column to be made
        for i = 1:length(table_headings)
            
            % this is a column heading as a cellstr
            idx = strcmp(VAR_ARR(:,:,NAME),table_headings(i));
            var = deblank(VAR_ARR(idx,:,VAR));
            
            if ~isfield(data,var) % implies comment column
                
                % keep_rows encoded by its indices
                keep_coded = (1:length(keep_rows))'.*keep_rows;
                % remove zero elements
                keep_coded = keep_coded(keep_coded~=0);
                % remove rows that don't have a note
                keep_coded = eval(['intersect(keep_coded,data. ' var 'key)']);
                
                % RHS
                % get the indices of key where the value of key == index of LHS 
                [~, notes_idx] = eval(['ismember(keep_coded, data.' var 'key(1:data.' ...
                    var 'idx - 1))']);
                                
                table_datum(true(size(keep_coded)),i) = cellstr(...
                    eval(['data.' var 'notes(notes_idx,:)']));
                
            elseif eval(['ischar(data.' var ')']) % implies strings column
                
                table_datum(:,i) = cellstr(eval(['data.' var '(keep_rows,:)']));
                
            else % numeric and logical column
                
                table_datum(:,i) = num2cell(eval(['data.' var '(keep_rows)']));
                
            end
            
        end
        
        % make changes seen in the table
        set(table, 'ColumnName', table_headings); %headings
        set(table,'data',table_datum);
        % inform user of number of entries
        set(info_txt,'String',[num2str(sum(keep_rows)) ' entries']);
        
    end

%function: prep filters
% description: uses the selection to decide state of filter
%              components
% inputs: selection - string should be a member of VAR_ARR(:,:,NAME)
%                       - selection needn't be deblanked
    function prep_filters(selection)
        
        idx = strcmp(VAR_ARR(:,:,NAME),cellstr(selection));
        var = deblank(VAR_ARR(idx,:,VAR)); % corresponding variable name
        
        % reset value of popup (as options will likely change
        set(filter_popup,'value',1);
        
        if ~isfield(data,var) || eval(['ischar(data.' var ')']) % made of chars
            set(filter_popup,'String',BOOLEAN_STRS);
            set(filter_popup,'UserData',IS_CHAR);
        elseif eval(['islogical(data.' var ')']) % logical
            set(filter_popup,'String',BOOLEAN_STRS);
            set(filter_popup,'UserData',IS_LOGIC);
        elseif eval(['isnumeric(data.' var ')']) %numeric
            set(filter_popup,'String',NUMBERS_STRS);
            set(filter_popup,'UserData',IS_NUM);
        else
            errordlg('Unknown Type! Please tell Peter', 'Unknown Type');
            return;
        end
        
        
        % invoke filter popup callback
        filt_popup_callback(filter_popup,0);
        
    end

% function: disp_command
% description: will add a human readable line to the filter list
%                  explaining purpose of filter
% input: desc - string description from lowest level list
    function disp_command(desc)
        
        % recover the key filter term
        keyword = get(filter_popup,'String');
        keyword = keyword{get(filter_popup,'Value')};
        
        % recover values from edit boxes
        v1 = deblank(get(filter_from_edit,'String'));
        v2 = deblank(get(filter_to_edit,'String'));
        
        if get(filter_popup,'UserData') == IS_LOGIC
            
            command = [keyword ' ' desc];
            
        else
            
            if strcmp(keyword,'Between')
                command = [desc ' ' keyword ' ' v1 ' And ' v2];
            else
                command = [desc ' ' keyword ' ' v1];
            end
            
        end
        
        % check if command exists
        commands = get(filters_list,'String');
        if sum(strcmpi(commands,command)) ~= 0
            errordlg('Filter command already applied!',...
                'Filter Command Already Exists');
            return;
        else
            commands{length(commands)+1} = command;
            set(filters_list,'String',commands);
        end
        
        % add the command to the filter history
        row = size(filter_hist,1) + 1;
        filter_hist{row,V1} = v1;
        filter_hist{row,V2} = v1;
        filter_hist{row,DESC} = desc;
        filter_hist{row,KEYWORD} = keyword;
        
    end

% function: filter_rows
% description: filters keep_rows which ultimately determines the data
% input: v1 - user inputted string 'from' value
%        v2 - user inputted string 'to' value
%      desc - string of lowest level description
%   keyword - command selected from filter_popup
    function filter_rows(v1,v2,desc,keyword)
        
        % find correspoding variable
        idx = strcmp(cellstr(desc),VAR_ARR(:,:,NAME));
        var = deblank(VAR_ARR(idx,:,VAR));
                
        switch keyword
            
            % could be logical, char, or comment
            case 'Is'
                
                if get(filter_popup,'UserData') == IS_LOGIC
                    
                    keep_rows = keep_rows & eval(['data.' var ...
                        '(1:length(keep_rows));']);
                    
                elseif ~isfield(data,var) % is comment
                    
                    % NOTE: may want to bring in regexp() function to
                    %       enable wildcards or could add a 'Contains'
                    %       option to the users dropdown
                    
                    % matching indices w.r.t. notes
                    matches = eval(['strcmpi(cellstr(v1),data.' var ...
                        'notes(1:data.' var 'idx - 1,:))']);
                    
                    % matching indices w.r.t. snap data
                    idx = eval(['data.' var 'key(matches)']);
                    % convert this to logical indexing
                    big_idx = ismember((1:length(keep_rows))',idx);
                    keep_rows = keep_rows & big_idx;
                    
                    
                else % is char
                    
                    keep_rows = keep_rows & ...
                        eval(['strcmpi(cellstr(v1),data.' var ...
                        '(1:length(keep_rows),:))']);
                    
                end
                
            case 'Is Not'
                
                
                if get(filter_popup,'UserData') == IS_LOGIC
                    
                    keep_rows = keep_rows & ~eval(['data.' var ...
                        '(1:length(keep_rows));']);
                    
                elseif ~isfield(data,var) % is comment
                    
                    % NOTE: may want to bring in regexp() function to
                    %       enable wildcards or could add a 'Contains'
                    %       option to the users dropdown
                    
                    % matching indices w.r.t. notes
                    matches = eval(['strcmpi(cellstr(v1),data.' var ...
                        'notes(1:data.' var 'idx - 1,:))']);
                    
                    % matching indices w.r.t. snap data
                    idx = eval(['data.' var 'key(matches)']);
                    % convert this to logical indexing
                    big_idx = ismember((1:length(keep_rows))',idx);
                    keep_rows = keep_rows & ~big_idx;
                    
                    
                else % is char
                    
                    keep_rows = keep_rows & ...
                        ~eval(['strcmpi(cellstr(v1),data.' var ...
                        '(1:length(keep_rows),:))']);
                    
                end
                
                
                % here and below apply solely to numeric data
            case 'Below' % i.e. user wants var <= v1
                keep_rows = keep_rows & eval(['data.' var ...
                    '(1:length(keep_rows)) <= ' v1]);
                
            case 'Above' % i.e. user wants var >= v1
                keep_rows = keep_rows & eval(['data.' var ...
                    '(1:length(keep_rows)) >= ' v1]);
                
            case 'Between' % i.e. user wants var >= v1 and var <= v2
                keep_rows = keep_rows & ...
                    eval(['data.' var '(1:length(keep_rows)) >= '...
                    v1 ' & data.' var '(1:length(keep_rows)) <= ' v2]);
                
            case 'Exactly' % i.e. user wants var == v1
                keep_rows = keep_rows & eval(['data.' var ...
                    '(1:length(keep_rows)) == ' v1]);
                
                
        end
        
    end
%-----------------------------------------------------------------------
% end of code
end
