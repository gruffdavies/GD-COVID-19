global hFigure;

hFigure = figure;
clf('reset');
hold on;
grid on;

% date ln(d) > 3
dayZeroHubei = datenum("23 Jan 2020")
dayZeroItaly = datenum("28 Feb 2020");
dayZeroSpain = datenum("9 Mar 2020")
dayZeroFrance = datenum("10 Mar 2020")
dayZeroUK = datenum("14 Mar 2020")


plot(datenum(deaths.Date) - dayZeroItaly, log(deaths.Italy), 'DisplayName', 'Italy');
plot(datenum(deaths.Date) - dayZeroSpain, log(deaths.Spain), 'DisplayName', 'Spain');
plot(datenum(deaths.Date) - dayZeroFrance, log(deaths.France), 'DisplayName', 'France');
plot(datenum(deaths.Date) - dayZeroUK , log(deaths.UK), 'DisplayName', 'UK');
plot(datenum(deaths.Date) - dayZeroHubei, log(deaths.Hubei_China), 'DisplayName', 'Hubei');

% Create ellipse
annotation(hFigure,'ellipse',...
    [0.342258741258741 0.335845896147404 0.0346643356643356 0.0351758793969849]);

% Create textarrow
annotation(hFigure,'textarrow',[0.38517745302714 0.369519832985386], [0.206237424547284 0.330985915492958],'String',{'Origin set at','ln(deaths) > 3','(>20 dead)'});



title('Natural Log of Deaths');
xlabel('Day');
ylabel('ln(deaths)');
legend1 = legend('Location','northeast');
% axes1 = axes('Parent',hFigure);
% legend1 = legend(axes1,'show');
set(legend1,...
     'Position',[0.601761706860794 0.777275016165187 0.0618915152068927 0.129713420235014]);
%set(gcf,'Position',[-2159 1884 1430 1194])
set(gcf,'Position',[220 205 1438 663]);
