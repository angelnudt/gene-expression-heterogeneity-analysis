clc
clear
load proper_section_allbrain.txt
% load proper_section_rightbrain.txt
% % proper_section_allbrain=proper_section_leftbrain;
% proper_section_allbrain=proper_section_rightbrain;
[m,n]=size(proper_section_allbrain);
% index1=1;
% index2=1;
% for i=1:m
%     if mod(i, 2) == 0   % number is even
%         proper_right(index1,1)=proper_section_allbrain(i,2);
%         index1=index1+1;
%     else
%         proper_left(index2,1)=proper_section_allbrain(i,2);   % number is oddend
%         index2=index2+1;
%     end
% end
hdr=spm_vol('BN_Atlas_246_1mm.nii');
img=spm_read_vols(hdr);
hdr.dt=[16,0];
jj=1;     %大脑标号
brainnum=proper_section_allbrain(:,1);
% [m,n]=size(proper_section_allbrain);
indexbrain=find(brainnum==jj); 
proper_section_brain1=proper_section_allbrain(indexbrain,2:n);
[mm,nn]=size(proper_section_brain1);
% img(:)=0;
k=2;      %属性标号
minvalue=min(proper_section_brain1(:,k));
maxvalue=max(proper_section_brain1(:,k));
for i=1:m
     mni_proper=proper_section_brain1(i,k);
     color(i)=(mni_proper-minvalue)/(maxvalue-minvalue);
%     xx=find(img==(2*(i-1)+1));   %left
%     xx=find(img==(2*i));         %right
      xx=find(img==i); 
     if mni_proper ~= 'NaN'
        img(xx)=color(i);
%         hdr.fname='hk_brain1_all1.nii';
%         spm_write_vol(hdr,img);
     end
end
index  = find(img>1.1);
img(index) = 0;
nanindex = find(isnan(img));
img(nanindex) = 0;
hdr.fname='hk_brain1_all.nii';
spm_write_vol(hdr,img);