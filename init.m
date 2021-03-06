%init vals
Resize_Width = 64;
Resize_Height = 64;
Face_Class_Num = 20;
Individual_Face_Num = 35;
DB_MAX = 695;
QUERY_MAX = 161;

%init path
db_path = '/path/to/DB/jpeg/';
db_path_crop = '/path/to/Query/crop_hist/';

query_path = '/path/to/Query/jpeg/';
query_path_regex = '/path/to/Query/jpeg/*.jpg';
query_path_l = '/path/to/*jpg';
query_path_crop = '/path/to/crop_hist/';

% ŠçŒŸoƒIƒuƒWƒFƒNƒg’è‹`    
detector = vision.CascadeObjectDetector(); 

%features definition
HOG_Cell_Size = 16;
DCT_Size = 6;
