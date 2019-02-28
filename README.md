A global radon flux map
==================================

This repository includes data and scripts to generate a global radon flux map. 
The global map was put together using regional fluxes reported recently in the 
literature. More details can be found in 
[Zhang et al. (2011)](https://www.atmos-chem-phys.net/11/7817/2011/)


.. figure:: global_radon_flux.png
   :scale: 20 %
   :alt: Global radon flux data 
   :align: center
   
   

Script
--------------------

   - [script/make_rnemis_run.csh](https://github.com/kaizhangpnl/global_radon_flux_map/blob/master/script/make_rnemis_run.csh) : c-shell script to call rnemis.ncl  
   - [script/rnemis.ncl](https://github.com/kaizhangpnl/global_radon_flux_map/blob/master/script/rnemis.ncl) : NCL script to create the global radon flux data by merging regional and global radon flux maps. 
     This script will call CDO to remap data to target resolutions. 
   - Description: 
     E0: ``WCRP1995`` emission 
     E1: ``WCRP1995`` magnitude with ``Schery1998`` time information  
     E2: ``Schery1998``  Schery et al. (1998) scaled by 1.6 
     E3: merged emission based on Zhang et al. ACP2011 (china, europe, russia, usa, aus, schery1998, schery2004_ocean) 

Data
-------------------- 

   - [rnemis_ECHAM](https://github.com/kaizhangpnl/global_radon_flux_map/tree/master/rnemis_ECHAM) : radon flux data prepared for the ``ECHAM`` model (``T21``-``T159``)
   - [rnemis_r360x180](https://github.com/kaizhangpnl/global_radon_flux_map/tree/master/rnemis_r360x180) : radon flux data on ``1x1`` grid 
   - [rnemis_r720x360](https://github.com/kaizhangpnl/global_radon_flux_map/tree/master/rnemis_r720x360) : radon flux data on ``0.5x0.5`` grid 


Reference
-------------------- 

 - Zhang, K., Feichter, J., Kazil, J., Wan, H., Zhuo, W., Griffiths, A. D.,
   Sartorius, H., Zahorowski, W., Ramonet, M., Schmidt, M., Yver, C.,
   Neubert, R. E. M., and Brunke, E.-G.:
   Radon activity in the lower troposphere and its impact on ionization rate:
   a global estimate using different radon emissions,
   Atmos. Chem. Phys., 11, 7817-7838,
   https://doi.org/10.5194/acp-11-7817-2011, 2011.

- Szegvary, T., Leuenberger, M. C., and Conen, F.: 
  Predicting terrestrial 222Rn flux using gamma dose rate as a proxy, 
  Atmos. Chem. Phys., 7, 2789-2795, 
  https://doi.org/10.5194/acp-7-2789-2007, 2007. 

-  Griffiths, A. D., Zahorowski, W., Element, A., and Werczynski, S.: 
   A map of radon flux at the Australian land surface, 
   Atmos. Chem. Phys., 10, 8969-8982, 
   https://doi.org/10.5194/acp-10-8969-2010, 2010. 

- Schery, S.D. and Wasiolek, M.A., 1998. 
  Modeling radon flux from the earth’s surface. Radon and Thoron in the human environment, 
  pp.207-217.

-  Schery, S. D., and S. Huang (2004), 
   An estimate of the global distribution of radon emissions from the ocean, 
   Geophys. Res. Lett., 31, L19104, doi:10.1029/2004GL021051. 

- Zhuo, W., Guo, Q., Chen, B. and Cheng, G., 2008. 
  Estimating the amount and distribution of radon flux density from the soil surface in China. 
  Journal of environmental radioactivity, 99(7), pp.1143-1148.
  
