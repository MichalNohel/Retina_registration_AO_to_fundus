%% Retina registration of AO to fundus
clear all
close all
clc
path_to_AO='D:\Registrace_oci\Data\AO\';
path_to_fundus='D:\Registrace_oci\Data\SLO\';
%% Donalies Ingrid
% name_fundus='Donalies_I_1088854_OD.png';
% name_AO='OD_20150909124229_X5.0T_Y-5.0_Z-30.0_DONALIES_Ingrid.png';

%% Kauerauf Cornelia
name_AO='OD_20150909103446_X5.0N_Y5.0_Z50.0_KAUERAUF_Cornelia.png';
name_fundus='Kauerauf_C_723617_0_OD.png'

AO=im2double(imread([path_to_AO name_AO]));
fundus=im2double(imread([path_to_fundus name_fundus]));

%%
name=name_AO(19:end)
for i=1:length(name)
    switch name(i)
        case 'X'
            pom_num_start=i+1;
            for m=pom_num_start:i+7
                if name(m)=='_'
                    pom_num_stop=m-1
                    break
                end
            end
            pom_X=name(pom_num_start:pom_num_stop);
            X_posun=str2num(pom_X(1:end-1))
            continue

         case 'Y'
            pom_num_start=i+1;
            for m=pom_num_start:i+7
                if name(m)=='_'
                    pom_num_stop=m-1
                    break
                end
            end
            pom_Y=name(pom_num_start:pom_num_stop);
            Y_posun=str2num(pom_Y(1:end-1))

    end
end


%%
figure
subplot(1,2,1)
imshow(fundus)
subplot(1,2,2)
imshow(AO)

%%
velikost_obrazu=size(fundus);
%%
stred=[250,200];
sirka_vyrezu=100;
vyrez_fundus=fundus(stred(1)-sirka_vyrezu:stred(1)+sirka_vyrezu-1,stred(2)-sirka_vyrezu:stred(2)+sirka_vyrezu-1);
imshow(vyrez_fundus)
%%
figure
subplot(1,2,1)
imshow(vyrez_fundus)
subplot(1,2,2)
imshow(AO)
%% Elastix inicialization

% [~,help] = system('D:\Registrace_oci\Data\elastix\elastix.exe --help')
% [~,elastix_version] = system('D:\Registrace_oci\Data\elastix\elastix.exe --version')

outputdir='D:\Registrace_oci\Data\TempFile';
try
    rmdir(outputdir,'s')
catch err
end
mkdir(outputdir)
%%
fixed=vyrez_fundus;
moving=AO;
moving=imresize(moving,0.2);

% fixed=AO;
% moving=vyrez_fundus;
% fixed=imresize(fixed,0.2);

moving=medfilt2(moving,[9 9]);

figure
subplot(1,3,1)
imshow(fixed,[])
title('Refer')
subplot(1,3,2)
imshow(moving,[])
title('Moving')
%%

imwrite(fixed,"D:\Registrace_oci\Data\TempFile\fixed.png")
imwrite(moving,"D:\Registrace_oci\Data\TempFile\moving.png")



%% Registratio - RIGID AND AFFINE

% run ELASTIX

file='D:\Registrace_oci\Data\parametricFiles\Parameters_Affine.txt';

CMD=['D:\Registrace_oci\Data\elastix\elastix.exe ' '-f ' [outputdir '\fixed.png '] ' -m ' [outputdir '\moving.png '] ' -out ' outputdir ,' -p '  file];           
system(CMD);


%% read resulting RAW and save to variable - registered
[registered]=raw2mat([outputdir '\result.0.mhd']);


%% display
figure
subplot(1,3,1)
imshow(fixed,[])
title('Refer')
subplot(1,3,2)
imshow(moving,[])
title('Moving')
subplot(1,3,3)
imshow(registered,[])
title('Registered')

%%
% figure
% subplot(1,2,1)
% imshowpair(fixed,moving)
% subplot(1,2,2)
% imshowpair(fixed,registered)






