#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jan 16 18:06:36 2020

@author: dklink

tricky trick, we need to know the light intensity vs time anywhere on earth!
daily shape, which changes seasonally based on latitude.

thanks stackexchange https://astronomy.stackexchange.com/questions/25572/sunlight-intensity-during-a-day
would be good to find a legit source :p
"""

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

def alpha(t: pd.DatetimeIndex, lat, lon):    
    decl_sun = np.radians(-23.45) * np.cos((2*np.pi/365) * (t.dayofyear.values + 10))

    local_hour = t.hour.values + lon/15
    hr_angle = np.radians(15)*(local_hour-12)
    
    alpha = np.arcsin(np.sin(decl_sun)*np.sin(np.radians(lat)) + np.cos(decl_sun)*np.cos(np.radians(lat))*np.cos(hr_angle))
    alpha[alpha < 0] = 0
    
    return alpha

t = pd.date_range(start='2000-01-01 12:00', end='2001-01-01 12:00', freq='D')
lat = 80
lon = 0
plt.plot(t, alpha(t, lat, lon))
plt.xlabel("gmt hour")
plt.ylabel("Noon light intensity")
plt.title('lat = {}, lon = {}'.format(lat, lon))