clear all; close all;

fuera=1;
folder_name='/home/edna/Documents/trabajo/research/ata/1ra_tanda/Analisis/ResAllTemp';
files=dir(fullfile(folder_name,'*.csv'));
for j=1:length(files)
   datos = dlmread (strcat(folder_name,"/",files(j).name) , ",");
%cd(curr_folder)
  datos=datos(2:end,:);
  tiempo=datos(:,2);
  nombre=erase(files(j).name,".csv");
  tempe(j)=str2num (nombre);
  for i=3:size(datos)(2)
    dato=datos(1:end,[2,i]); %get the data im interested in
    datotemp=[dato(2:end,:);dato(end,:)]; %have a temp moved vector to substract
    dato(find(abs(dato(:,2)-datotemp(:,2))>fuera),:)=[]; %erase all the data that is out of bounds
    dato(find(dato(end,2)==dato(:,2)),:)=[];%erase data when frontier does not move
    [p,s]=polyfit(dato(:,1),dato(:,2),1); %fit the data
    dp=sqrt (diag (s.C)/s.df)*s.normr; % obtain the error of the fit values
    m(i-2)=p(1); %obtain slope
    dm(i-2)=dp(1); %obtain error
  
% figure(i)
%  plot(tiempo,datos(:,i), "+")
%  hold on;
%  plot(tiempo, p(1)*tiempo+p(2))
  endfor
  m=m';
  m(find(dm>0.2))=[]; %eliminate strange fits
  v(j)=mean(m);
  dv(j)=std(m);

endfor
figure (1);
errorbar(tempe,v, dv,'+')
xlabel ("Temperature (ªC)");
ylabel ("Velociti (mm/s)");
print "Tvplot.pdf";