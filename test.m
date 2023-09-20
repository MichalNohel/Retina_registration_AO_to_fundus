%% Retina registration of AO to fundus
clear all
close all
clc
path_to_AO='D:\Registrace_oci\Data\AO\';
path_to_fundus='D:\Registrace_oci\Data\SLO\';
%% Donalies
name_fundus='Donalies_I_1088854_OD.png';
name_AO='OD_20150909124229_X5.0T_Y-5.0_Z-30.0_DONALIES_Ingrid.png';


AO=imread([path_to_AO name_AO]);
fundus=imread([path_to_fundus name_fundus]);











