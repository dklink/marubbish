#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jan 13 11:59:56 2020

@author: dklink

Exploring physics in Kooi 2017
"""


import numpy as np
import matplotlib.pyplot as plt
import cartopy.crs as ccrs
import xarray as xr

def visualize_chlorophyll():
    """nifty little look at the chl a dataset"""
    ds = xr.load_dataset('../biofouling_forcing_data/A20143352014365.L3m_MO_CHL_chlor_a_4km.nc')
    chl = ds['chlor_a']
    ax = plt.axes(projection=ccrs.PlateCarree())
    plt.contourf(chl.lon, chl.lat, chl, levels=np.logspace(-4, 0, 20), transform=ccrs.PlateCarree())
    ax.coastlines()
    plt.show()

def Chl(z, i):
    chl = C_b[i] - s[i]*z + C_max[i] * np.exp(-((z-Z_max[i])/del_z[i])**2)
    chl[chl < 0] = 0
    chl[z > Z_base[i]] = 0
    
    return chl
    

C_b = [0.471, 0.533, 0.428, 0.570, 0.611, 0.390, 0.569, 0.835, 0.188] #normalized surface concentration
s = [0.135, 0.172, 0.138, 0.173, 0.214, 0.109, 0.183, 0.298, 0.000] #normalized slope
C_max = [1.572, 1.194, 1.015, 0.766, 0.676, 0.788, 0.608, 0.382, 0.885] #normalized maximum concentration
Z_max = [0.969, 0.921, 0.905, 0.814, 0.663, 0.521, 0.452, 0.512, 0.378]  #m, depth of maximum concentration
del_z = [0.393, 0.435, 0.630, 0.586, 0.539, 0.681, 0.744, 0.625, 1.081] #m, width of the peak
Z_base = [119.1, 99.9, 91, 80.2, 70.3, 63.4, 54.4, 39.8, 26.1]
chl_surf = ['<0.04', '0.04-0.08', '0.08-0.12', '0.12-0.2', '0.2-0.3', '0.3-0.4', '0.4-0.8', '0.8-2.2', '2.2-4']


def plot(chl_surf_ind):
    z = np.linspace(0, 100, 1000) # m
    plt.plot(Chl(z, chl_surf_ind), z, label=chl_surf[chl_surf_ind])
    
def vertical_dist():
    plt.figure()
    for i in range(len(C_b)):
        plot(i)
    plt.gca().invert_yaxis()
    plt.ylabel('depth (m)')
    plt.xlabel('normalized chlorophyll concentration')
    plt.legend()