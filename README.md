# A global radon flux map

This repository includes data and scripts to generate a global radon flux map. 
The global map was put together using regional fluxes reported recently in the 
literature. More details can be found in Zhang et al. (2011).  


Script (under folder "script") 

   script/make_rnemis_run.csh : c-shell script to call rnemis.ncl  
   
   script/rnemis.ncl: NCL script to create the global radon flux data by merging regional and global radon flux maps. 
   
   This script will call CDO to remap data to target resolutions. 
   
   Description: 
   
     E0: WCRP1995 emission 
     E1: WCRP1995 magnitude with Schery1998 time information  
     E2: Schery1998  Schery et al. (1998) scaled by 1.6 
     E3: merged emission (china,europe,russia,usa,aus,schery1998) 

Data 

   rnemis_ECHAM : radon flux data prepared for the ECHAM model (T21-T159)
   rnemis_r360x180 : radon flux data on 1x1 grid 
   rnemis_r720x360 : radon flux data on 0.5x0.5 grid 


Reference: 

   Zhang, K., Feichter, J., Kazil, J., Wan, H., Zhuo, W., Griffiths, A. D.,
   Sartorius, H., Zahorowski, W., Ramonet, M., Schmidt, M., Yver, C.,
   Neubert, R. E. M., and Brunke, E.-G.:
   Radon activity in the lower troposphere and its impact on ionization rate:
   a global estimate using different radon emissions,
   Atmos. Chem. Phys., 11, 7817-7838,
   https://doi.org/10.5194/acp-11-7817-2011, 2011.
 
