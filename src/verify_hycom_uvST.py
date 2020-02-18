#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Feb 17 18:00:10 2020

@author: dklink


This takes the output u,v,S, and T of the trashtracker hycom download script
and does some visualization for validation
"""


import xarray as xr
import matplotlib.pyplot as plt
import cartopy.crs as ccrs
import numpy as np

def world_temp():
    ds = xr.load_dataset('/Users/dklink/data_science/trashtracker/utils/get hycom/nc/global_2015_02_01_00_temp_sal_3d.nc')
    surf = ds.sel(depth=0).isel(time=0)
    plot_on_map(surf, 'water_temp')
    
    # vertical profile
    atlantic = ds.sel(lon=360-25, method='nearest').isel(time=0)
    plot_section(atlantic)
    #pacific = ds.sel(lon=360-)

def world_salinity():
    ds = xr.load_dataset('/Users/dklink/data_science/trashtracker/utils/get hycom/nc/global_2015_02_01_00_temp_sal_3d.nc')
    surf = ds.sel(depth=0).isel(time=0)
    plot_on_map(surf, 'salinity', levels=np.linspace(30, 40, 20))
    
    # vertical profile
    atlantic = ds.sel(lon=360-25, method='nearest').isel(time=0)
    plot_section(atlantic, 'salinity')
    

def south_atlantic_salinity():
    S = xr.load_dataset('/Users/dklink/data_science/trashtracker/utils/get hycom/nc/S_2015_2.nc')
    S['lon'] = ((S.lon + 180) % 360) - 180
    S = S.assign_coords(x=S.lon, y=S.lat)
    S = S.roll(x=len(S.x)//2)

    S = S.isel(time=0)
    SA_S = S.sel(y=slice(-40, 0), x=slice(-50, 30))
    
    plot_on_map(SA_S, 'salinity')


def central_pacific_temp():
    """central pacific SSTs"""
    T = xr.load_dataset('/Users/dklink/data_science/trashtracker/utils/get hycom/nc/T_2015_2.nc')
    T = T.assign_coords(x=T.lon, y=T.lat)
    
    T = T.isel(time=0)
    cpT = T.sel(y=slice(-30, 30), x=slice(180, 360-75))
    plot_on_map(cpT, 'water_temp')


def NA_spd():
    u = xr.load_dataset('/Users/dklink/data_science/trashtracker/utils/get hycom/nc/u_2015_2.nc')
    u = u.assign_coords(x=u.lon, y=u.lat)
    v = xr.load_dataset('/Users/dklink/data_science/trashtracker/utils/get hycom/nc/v_2015_2.nc')
    v = v.assign_coords(x=v.lon, y=v.lat)
    
    
    # just look at north atlantic
    u = u.isel(time=0)
    NA_u = u.sel(y=slice(25, 45), x=slice(360-85, 360-30))
    v = v.isel(time=0)
    NA_v = v.sel(y=slice(25, 45), x=slice(360-85, 360-30))
    
    NA_spd = NA_v
    NA_spd['spd'] = np.sqrt(NA_u.water_u**2 + NA_v.water_v**2)
    NA_spd.spd.attrs['units'] = NA_u.water_u.units
    plot_on_map(NA_spd, 'spd')


def plot_on_map(ds, variable_name, levels=None):
    plt.figure()
    ax = plt.axes(projection=ccrs.Mollweide())
    plt.contourf(ds.lon, ds.lat, ds[variable_name], levels=levels, transform=ccrs.PlateCarree())
    cbar = plt.colorbar()
    cbar.ax.get_yaxis().labelpad = 15
    cbar.ax.set_ylabel(ds[variable_name].units, rotation=270)
    ax.coastlines()
    plt.show()
    
    
def plot_section(ds, variable_name):
    plt.figure()
    plt.contourf(ds.lat, -ds.depth, ds[variable_name])
    cbar = plt.colorbar()
    cbar.ax.get_yaxis().labelpad = 15
    cbar.ax.set_ylabel(ds[variable_name].units, rotation=270)
    plt.title('lon = {}'.format(ds.lon.values))
    plt.xlabel('latitude (deg)')
    plt.ylabel('depth (m)')
