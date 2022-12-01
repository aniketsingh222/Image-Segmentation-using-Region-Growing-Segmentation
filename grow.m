function [ regions ] = grow( image , i , j ,value , treshold , regions , 
region_label )
 
 if ( ( image ( i , j) - value ) <= treshold && regions(i,j) == 0 )
 
 regions ( i , j ) = region_label ;
 
 if ( Acceptable_Next_Pixel ( i+1 , j+1 , regions) == 1 ) 
 regions = grow( image , i+1 , j+1 ,value , treshold , regions 
, region_label );
 end
 
 if ( Acceptable_Next_Pixel ( i , j-1 , regions) == 1 ) 
 regions = grow( image , i , j-1 ,value , treshold , regions , 
region_label );
 end
 
 if ( Acceptable_Next_Pixel ( i , j+1 , regions) == 1 ) 
 regions = grow( image , i , j+1 ,value , treshold , regions , 
region_label );
 end
 
 
 if ( Acceptable_Next_Pixel ( i+1 , j-1 , regions) == 1 ) 
 regions = grow( image , i+1 , j-1 ,value , treshold , regions 
, region_label );
 end
 
 if ( Acceptable_Next_Pixel ( i+1 , j , regions) == 1 ) 
 regions = grow( image , i+1 , j ,value , treshold , regions , 
region_label );
 end
 
 if ( Acceptable_Next_Pixel ( i+1 , j+1 , regions) == 1 ) 
 regions = grow( image , i+1 , j+1 ,value , treshold , regions 
, region_label );
 end
 
 end
end
function [ T ] = Acceptable_Next_Pixel ( i , j , regions)
[ r , c ] = size (regions);
T = 0 ;
if ( (i <= r) && (j <= c) && (i >= 1) && (j >= 1) )
 
 if ( regions(i,j) == 0 )
 
 T = 1;
 
 end
end
end