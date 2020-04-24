
% yyaxis right;
pop = population{:,1}/1e8;
pLats = population{:,2};

plot(pop, pLats, '--','DisplayName', 'Population (100s millions)', 'Color' ,'blue','LineWidth',2);

% area(pop, pLats,'FaceColor',[0.7 0.7 0.7],'EdgeColor','k');
% ax2 = axes('Position',ax1_pos,'XAxisLocation','top','YAxisLocation','right','FaceColor','none');

%ax2 = axes('Position',ax1_pos,'XAxisLocation','top','YAxisLocation','right','Color',[0 0 .7]);

%plot(pop, pLats,'Parent',ax2,'DisplayName', 'Population (100s millions)', 'Color' ,'blue','LineWidth',2);

%set(gcf,'color','w');
set(gcf,'Position',[-2159 604 1430 1194])