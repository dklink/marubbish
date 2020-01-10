#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jan  9 14:01:13 2020

@author: dklink

Trying to explore the whiteshark dataset and visualize some things
"""

data_root = '../WHITESHARK/'

import xarray as xr

ds = xr.open_dataset(data_root + '4km/surf_his.0060.nc')