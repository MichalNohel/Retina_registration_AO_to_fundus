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













