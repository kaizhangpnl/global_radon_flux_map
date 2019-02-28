A global radon flux map based on *Zhang et al. (2011)*
==================================

This repository includes data and scripts to generate a global radon flux map. 
The global map was put together using regional fluxes reported recently in the 
literature. More details can be found in 
[Zhang et al. (2011)](https://www.atmos-chem-phys.net/11/7817/2011/)

<a href="https://github.com/kaizhangpnl/global_radon_flux_map/blob/master/figures/global_radon_flux.png"><img src="https://github.com/kaizhangpnl/global_radon_flux_map/blob/master/figures/global_radon_flux.png" align="center" width="500" ></a> 


<a href="https://github.com/kaizhangpnl/global_radon_flux_map/blob/master/figures/global_radon_flux_table.png"><img src="https://github.com/kaizhangpnl/global_radon_flux_map/blob/master/figures/global_radon_flux_table.png" align="center" width="500" ></a> 

Script
--------------------

   - [script/make_rnemis_run.csh](https://github.com/kaizhangpnl/global_radon_flux_map/blob/master/script/make_rnemis_run.csh) : c-shell script to call rnemis.ncl  
   - [script/rnemis.ncl](https://github.com/kaizhangpnl/global_radon_flux_map/blob/master/script/rnemis.ncl) : NCL script to create the global radon flux data by merging regional and global radon flux maps. 
     This script will call [*CDO*](https://code.mpimet.mpg.de/projects/cdo/wiki/Cdo#Documentation) to remap data to target resolutions. 
   - Description: 
       - E0: ``WCRP1995`` emission 
       - E1: ``WCRP1995`` magnitude with ``Schery1998`` time information  
       - E2: ``Schery1998``  Schery et al. (1998) scaled by 1.6 
       - E3: merged emission based on Zhang et al. ACP2011 (china, europe, russia, usa, aus, schery1998, schery2004_ocean) 

Data
-------------------- 

   - [rnemis_ECHAM](https://github.com/kaizhangpnl/global_radon_flux_map/tree/master/rnemis_ECHAM) : radon flux data prepared for the *ECHAM* model (``T21``-``T159``)
   - [rnemis_r360x180](https://github.com/kaizhangpnl/global_radon_flux_map/tree/master/rnemis_r360x180) : radon flux data on ``1°x1°`` grid 
   - [rnemis_r720x360](https://github.com/kaizhangpnl/global_radon_flux_map/tree/master/rnemis_r720x360) : radon flux data on ``0.5°x0.5°`` grid 


Evaluation
-------------------- 
Based on recent reports in the literature on radon emission,
an up-to-date global radon emission map is compiled with
regional details and seasonal variation. The simulated radon
activity concentration is evaluated against surface radon measurements
at `51` locations. Results show that the global
model *ECHAM5* can reasonably reproduce the variations of
surface radon concentrations observed at various locations.
On the whole, the newly compiled emission map leads to
better results compared to the `WCRP1995` protocol and the
widely used `SW1998` map. The merged map is not only
helpful for this study, but probably also useful for other researchers
working on numerical modelling of radon transport
and the transport and deposition processes of `210Pb`. 

<a href="https://github.com/kaizhangpnl/global_radon_flux_map/blob/master/figures/radon_surface_conc.png"><img src="https://github.com/kaizhangpnl/global_radon_flux_map/blob/master/figures/radon_surface_conc.png" align="center" width="700" ></a> 


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
 - Griffiths, A. D., Zahorowski, W., Element, A., and Werczynski, S.: 
   A map of radon flux at the Australian land surface, 
   Atmos. Chem. Phys., 10, 8969-8982, 
   https://doi.org/10.5194/acp-10-8969-2010, 2010. 
 - Schery, S. D. and Wasiolek, M.A., 1998. 
   Modeling radon flux from the earth’s surface. Radon and Thoron in the human environment, 
   pp.207-217.
 - Schery, S. D., and S. Huang (2004), 
   An estimate of the global distribution of radon emissions from the ocean, 
   Geophys. Res. Lett., 31, L19104, doi:10.1029/2004GL021051. 
 - Zhuo, W., Guo, Q., Chen, B. and Cheng, G., 2008. 
   Estimating the amount and distribution of radon flux density from the soil surface in China. 
   Journal of environmental radioactivity, 99(7), pp.1143-1148.
  
Acknowlegement 
-------------------- 
Original regional flux maps were provided by Dr. `W. Zhuo` (China), Dr. `A. D. Griffiths` (Australia), Dr. `T. Szegvary` and Dr. `F. Conen` (Europe, Russia, and USA). Global radon flux used for other regions were provided by Dr. `S. D. Schery`. 

