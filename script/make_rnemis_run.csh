#!/bin/csh 

foreach RES ("360x180" "720x360" "21" "31" "42" "63" "85" "106" "159")
  foreach IEMIS(0 1 2 3 )

     setenv IEMIS $IEMIS 
     setenv resolution "$RES" 
     
     ncl rnemis.ncl 
     
     rm ../work/out*.nc 

   end
end


