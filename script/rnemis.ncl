;;.........................................................................
;; NCL script to create the global radon flux data by merging regional and 
;; global radon flux maps. 
;; 
;; This script will call CDO to remap data to target resolutions. 
;; 
;; Description: 
;; 
;;   E0: WCRP1995 emission 
;;   E1: WCRP1995 magnitude with Schery1998 time information  
;;   E2: Schery1998  Schery et al. (1998) scaled by 1.6 
;;   E3: merged emission (china,europe,russia,usa,aus,schery1998) 
;;
;; Kai Zhang, Max Planck Institute for Meteorology (kai.zhang@zmaw.de) 
;; 
;; 2010-10 
;;.........................................................................

   ;;........................
   ;; default settings 
   ;;........................

   IEMIS = 0
   land_limit = 0.500
   resolution = "63"
   land_limit_min = 0.1
   ntime = 12 

   r_min_flux = 0.001 ;; atoms/m2/s 
   r_max_flux = 2.000 ;; atoms/m2/s 
   l_min_flux = False ;; default 
   l_max_flux = False ;; default 

   l_landfrc_scale = False ;; default 
   l_WCRP_1995 = True  ;; default 

   l_new_russia = True
   l_new_usa    = True
   l_new_aus    = False 
   l_new_china  = True
   l_new_europe = True
   l_new_ocean_schery  = False ;; default 
   l_dflt_schery98 = False ;; default  

   l_sw1998ocn  = False 
   l_minfluxocn = False 

   l_zeropolarland = False 

   datapath = "../input/" 

   ;;........................
   ;; user settings 
   ;;........................

   IEMIS = stringtointeger( getenv("IEMIS") ) 
   resolution = getenv("resolution") 


   ;;.......................................
   ;; settings for each emission scheme 
   ;;.......................................

   ;; WCRP1995 emission  
   
   if(IEMIS.eq.0) then  
      l_min_flux = True
      l_max_flux = True
      r_min_flux = 0.000 ;; atoms/m2/s 
      r_max_flux = 5.000 ;; atoms/m2/s 
      land_limit = 0.500
      l_landfrc_scale = False ;; default 
      l_WCRP_1995 = True  ;; default  
      l_new_russia = False ;;True
      l_new_usa    = False ;;True
      l_new_aus    = False
      l_new_china  = False ;;True
      l_new_europe = False ;;True
      l_new_ocean_schery  = False ;; default 
      l_minfluxocn = True 
   end if 

   ;; WCRP1995 magnitude with Schery1998 time information   
   
   if(IEMIS.eq.1) then
      l_min_flux = True
      l_max_flux = True
      r_min_flux = 0.000 ;; atoms/m2/s
      r_max_flux = 5.000 ;; atoms/m2/s
      land_limit = 0.500
      l_landfrc_scale = False ;; default
      l_WCRP_1995 = False ;; default
      l_dflt_schery98 = False 
      l_schery98_time = True
      l_new_russia = False ;;True
      l_new_usa    = False ;;True
      l_new_aus    = False
      l_new_china  = False ;;True
      l_new_europe = False ;;True
      l_new_ocean_schery  = False ;; default
      l_minfluxocn = True 
   end if

   ;; Schery et al. (1998) scaled by 1.6 
   
   if(IEMIS.eq.2) then
      l_min_flux = True
      l_max_flux = True
      r_min_flux = 0.000 ;; atoms/m2/s
      r_max_flux = 5.000 ;; atoms/m2/s
      land_limit = 0.500
      l_landfrc_scale = False ;; default
      l_WCRP_1995 = False ;; default
      l_dflt_schery98 = True  
      l_new_russia = False ;;True
      l_new_usa    = False ;;True
      l_new_aus    = False
      l_new_china  = False ;;True
      l_new_europe = False ;;True
      l_new_ocean_schery  = False ;; default
      l_minfluxocn = True 
   end if

   ;; merged emission (china,europe,russia,usa,aus,schery1998,schery2004_ocean) 
   
   if(IEMIS.eq.3) then
      l_min_flux = True
      l_max_flux = True
      r_min_flux = 0.000 ;; atoms/m2/s
      r_max_flux = 5.000 ;; atoms/m2/s
      land_limit = 0.500
      l_landfrc_scale = False ;; default
      l_WCRP_1995 = False ;; default
      l_dflt_schery98 = True
      l_new_russia = True ;;False ;;True
      l_new_usa    = True ;;False ;;True
      l_new_aus    = True ;;False
      l_new_china  = True ;;False ;;True
      l_new_europe = True ;;False ;;True
      l_new_ocean_schery  = True ;;False ;; default
   end if

   if (l_min_flux) then
      print(" ")
      print(" smallest flux rate set to "+r_min_flux+" atoms/m2/s ")
      print(" ")
   end if
   
   ;;.......................................
   ;; set output resolution
   ;;.......................................
   
   print(" ")
   print(" set output resolution ")
   print(" ")

   pingo_grid = "t"+resolution+"grid"
   gridtype   = "T"+resolution

   if(resolution.eq."720x360") then 
      pingo_grid = "r720x360.grid"
      gridtype = "r720x360"
   end if

   if(resolution.eq."360x180") then 
      pingo_grid = "r360x180.grid"
      gridtype = "r360x180"
   end if
  
   print(" ")
   print(" gridtype: "+gridtype)
   print(" ")

   ;;.......................................
   ;; set input file name 
   ;;.......................................
   
   print(" ")
   print(" set file name ")
   print(" ")

   fna = datapath + "input." + "russia"+".nc"
   fnb = datapath + "input." + "europe"+".nc"
   fnc = datapath + "input." + "china" +".nc"
   fnd = datapath + "input." + "ocean" +".nc"
   fne = datapath + "input." + "schery"+".nc"
   fnf = datapath + "input." + "scherytime"+".nc"
   fng = datapath + "input." + "usa"+".nc"
   fnh = datapath + "input." + "aus"+".nc"

   ;;.......................................
   ;; set temp file names 
   ;;.......................................
   
   wpath = "../work/" 
   
   foa = wpath + "out."+"russia"+"."+gridtype+".nc"
   fob = wpath + "out."+"europe"+"."+gridtype+".nc"
   foc = wpath + "out."+"china" +"."+gridtype+".nc"
   fod = wpath + "out."+"ocean" +"."+gridtype+".nc"
   foe = wpath + "out."+"schery"+"."+gridtype+".nc"
   fof = wpath + "out."+"scherytime"+"."+gridtype+".nc"
   fog = wpath + "out."+"usa"+"."+gridtype+".nc"
   foh = wpath + "out."+"aus"+"."+gridtype+".nc"

   print(" output filenames: "+foa)
   print("                   "+fob)
   print("                   "+foc)
   print("                   "+fod)
   print("                   "+foe)
   print("                   "+fof)
   print("                   "+fog)
   print("                   "+foh)
   
   ;;.......................................
   ;; clean old files 
   ;;.......................................
   
   print(" ") 
   print(" clean old files ")
   print(" ") 

   system(" rm -f " + foa)
   system(" rm -f " + fob)
   system(" rm -f " + foc)
   system(" rm -f " + fod)
   system(" rm -f " + foe)
   system(" rm -f " + fof)
   system(" rm -f " + fog)
   system(" rm -f " + foh)

   ;;.......................................
   ;; remapping emission data 
   ;;.......................................
   
   print(" ")
   print(" remapping ")
   print(" ")
   print(" ")
   print(" ")
   system(" cdo remapcon,"+pingo_grid+"   "+fna+ "  " + foa) 
   system(" cdo remapcon,"+pingo_grid+"   "+fnb+ "  " + fob) 
   system(" cdo remapcon,"+pingo_grid+"   "+fnc+ "  " + foc) 
   system(" cdo remapcon,"+pingo_grid+"   "+fnd+ "  " + fod) 
   system(" cdo remapcon,"+pingo_grid+"   "+fne+ "  " + foe) 
   system(" cdo remapcon,"+pingo_grid+"   "+fnf+ "  " + fof) 
   system(" cdo remapcon,"+pingo_grid+"   "+fng+ "  " + fog) 
   system(" cdo remapcon,"+pingo_grid+"   "+fnh+ "  " + foh) 
   print(" ")
   print(" ")

   fnx = datapath+"ECHAM_T"+resolution+"_jan_surf.nc"

   if(resolution.eq."720x360") then 
      fnx = datapath+resolution+"_jan_surf.nc"
   end if 
   
   if(resolution.eq."360x180") then 
      fnx = datapath+resolution+"_jan_surf.nc"
   end if 
   
   ;;.......................................
   ;; add and read emission data files 
   ;;.......................................
   
   print(" ")
   print(" read files ")
   print(" ")

   fla = addfile(foa,"r") 
   flb = addfile(fob,"r") 
   flc = addfile(foc,"r") 
   fld = addfile(fod,"r") 
   fle = addfile(foe,"r") 
   flf = addfile(fof,"r") 
   flg = addfile(fog,"r") 
   flh = addfile(foh,"r") 
   flx = addfile(fnx,"r") 
   
   print(" ")
   print(" read variables ")
   print(" ")

   vva = fla->rnemis 
   vvb = flb->rnemis
   vvc = flc->rnemis
   vvd = fld->rnemis
   vve = fle->rnemis
   vvf = flf->rnemis
   vvg = flg->rnemis
   vvh = flh->rnemis
   oro = flx->SLM

   lat = fla->lat
   lon = fla->lon

   nx = dimsizes(lat)
   ny = dimsizes(lon)

   print(" ")
   print(" define new vars ")
   print(" ")
   
   ;;.......................................
   ;; define output variable 
   ;;.......................................
   
   vvy = new((/12,nx,ny/),"float")

   vvy!0        = "time"
   vvy&time      = fspan(1.,12.,12)
   vvy&time@long_name = "time slice since Jan"

   vvy!1        = "lat"
   vvy&lat      = lat
   vvy&lat@long_name = "latitude"

   vvy!2        = "lon"
   vvy&lon      = lon
   vvy&lon@long_name = "longitude"

   vvy@long_name = "radon flux"
   vvy@units = "atmos/cm2/s"

   vvy = -9999.

   print(" ")
   print(" combine emission over different regions ")
   print(" ")

   ;;.......................................
   ;; define working variable 
   ;;.......................................
   
   vvz = vvy

   if (.not.l_new_ocean_schery) then 
      vvd = (/ r_min_flux /)  
   end if 
   
   ;;...................................................
   ;; set radon flux region by region in the order of 
   ;; ocean -> russia -> europe -> china -> others 
   ;;...................................................

   if(l_new_ocean_schery) then 
      vvz = where(.not.ismissing(vvd),vvd,-9999.)  ;; ocean flux  
   end if 

   if (l_new_russia) then 
      vvz = where(.not.ismissing(vva),vva,vvz)    ;; russia  
   end if 

   if (l_new_europe) then 
      vvz = where(.not.ismissing(vvb),vvb,vvz)    ;; europe 
   end if 

   if (l_new_usa) then 
      vvz = where(.not.ismissing(vvg),vvg,vvz)    ;; russia  
   end if 

   if (l_new_aus) then 
      vvz = where(.not.ismissing(vvh),vvh,vvz)    ;; aus
   end if 

   if (l_new_china) then 
      vvz = where(.not.ismissing(vvc),vvc,vvz)    ;; china 
   end if 

   ;;.......................................
   ;; set other regions to Schery_1998 values  
   ;;.......................................

   if (l_dflt_schery98) then 
      vve = vve / 21. / 1.6 
      print("                               ") 
      print(" scale Schery_1998 data by 1.6 ") 
      print(" ----------------------------- ") 
      print("                               ") 
      vvz = where(vvz.lt.0.,vve,vvz)   
   end if 

   ;;.......................................
   ;; reset radon flux if WCRP95 flux 
   ;;.......................................

   if (l_WCRP_1995) then 
      print(" ")
      print(" pre-setup for WCRP95 emission")
      print(" ")
      vvz = -9999.
   end if

   ;;.......................................
   ;; scaling factor for landfrac 
   ;;.......................................

   scalef = dble2flt(oro) 

   ;;.......................................
   ;; set radon flux for other regions
   ;;.......................................

   print(" ")
   print(" set WCRP95 emission for other regions ")
   print(" ")
   
   do im = 0, ntime-1
   do ix = 0, nx-1
   do iy = 0, ny-1

      ;; if emission flux not yet set 

      if (vvz(im,ix,iy).lt.0.) then

         vvz(im,ix,iy) =  (/ vvd(im,ix,iy) /)  

         if (l_min_flux) then 
            vvz(im,ix,iy) = r_min_flux 
         end if 

         ;; standard WCRP_1995 settings 
 
         if(lat(ix).ge.-60. .and. lat(ix).lt. 60. ) then 
            vvz(im,ix,iy) = 1.
         end if

         if(lat(ix).ge.60. .and. lat(ix).lt. 70. ) then 
            vvz(im,ix,iy) = 0.5
            if(lon(iy).ge.300. .and. lon(iy).lt. 360. ) then 
               vvz(im,ix,iy) = 0.005 
            end if
         end if

         ;; set ocean flux 
         ;; zero flux when land fraction is too small 

         if(oro(ix,iy).lt.land_limit_min) then
            vvz(im,ix,iy) = (/ vvd(im,ix,iy) /)  
         end if

      end if

      ;; if l_landfrc_scale = T then scale flux according to land fraction, 

      if (l_landfrc_scale) then 
        vvz(im,ix,iy) = vvz(im,ix,iy) * scalef(ix,iy)  
      else   ;; l_landfrc_scale 
      end if ;; l_landfrc_scale  


      ;; reset emission flux over ocean when ORO less than land_limit  
      ;; this means not to use scaled land flux   
      ;; note that land_limit < land_limit_min

      if(oro(ix,iy).lt.land_limit) then
         if(l_minfluxocn) then 
            vvz(im,ix,iy) = (/ r_min_flux /) 
         end if
         if(l_new_ocean_schery) then 
            vvz(im,ix,iy) = (/ vvd(im,ix,iy) /)  
         end if
         if(l_sw1998ocn) then 
            vvz(im,ix,iy) = (/ vve(im,ix,iy) /)  
         end if
      end if

      if(oro(ix,iy).gt.land_limit) then
      if(l_zeropolarland) then  
         if(lat(ix).le.-60.) then
            vvz(im,ix,iy) = 0. 
         end if
      end if 
      end if 

   end do
   end do
   end do

   ;;.......................................
   ;; check whether unrealistic values exist 
   ;; if so, zero flux at those locations  
   ;;.......................................

   vvz = where(ismissing(vvz),0.,vvz) 
   vvz = where(vvz.lt.0.,0.,vvz) 

   ;;.......................................
   ;; copy data to output variable 
   ;;.......................................

   vvy = vvz 

   ;;.......................................
   ;; scaling based on landfrac 
   ;;.......................................
   
   if(IEMIS.eq.1) then
      vvy = vvy * vvf 
   end if 

   ;;.......................................
   ;; output file 
   ;;.......................................
   
   opath = "../output/" 
   
   fno = opath + "rnemis.E"+IEMIS+"."+gridtype+".nc"

   system("rm -f "+fno)

   flo = addfile(fno,"c")
   
   print(" ")
   print(" output files ")
   print(" ")

   flo->rnemis=vvy

   print(" ")
   print(" ")
   print(" ")
   print(" --- job successfully done --- ")
   print(" ")
   print(" ")
   print(" ")

