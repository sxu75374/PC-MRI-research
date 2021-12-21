Age = [82,74,83,73,60,74,72,55,75,73,79,78];
RI = [0.7341,0.6061,0.7721,0.6923,0.6292,0.6286,0.6243,0.6133,0.7167,0.6574,0.6731,0.6873];
PI = [1.2705,0.9247,1.4486,1.1468,1.0131,0.9742,1.008,0.993,1.3177,1.1247,1.0942,1.1418];
[R,P,RL,RU] = corrcoef(Age,RI);
[R2,P2,RL2,RU2] = corrcoef(Age,PI);
figure
scatter(Age,RI)
hold on
l = lsline ;
set(l,'LineWidth',2)
title('Age-RI')
xlabel('Age')
ylabel('RI')
dim = [.18 .55 .3 .3];
str = 'r = 0.6921, p value = 0.0126';
annotation('textbox',dim,'String',str,'FitBoxToText','on');
% str=sprintf('r= %1.2f',R(1,2));
% T = text(min(get(gca, 'xlim')), max(get(gca, 'ylim')), str); 
% set(T, 'fontsize', 14, 'verticalalignment', 'top', 'horizontalalignment', 'left');

figure
scatter(Age,PI)
hold on
l = lsline ;
set(l,'LineWidth',2)
title('Age-PI')
xlabel('Age')
ylabel('PI')
str2 = 'r = 0.5948, p value = 0.0413';
annotation('textbox',dim,'String',str2,'FitBoxToText','on');
