global hFigure;

hFigure = figure;
clf('reset');
hold on;
grid on;

plot(deaths.Date, log(deaths.Italy), 'DisplayName', 'Italy');
plot(deaths.Date, log(deaths.Spain), 'DisplayName', 'Spain');
plot(deaths.Date, log(deaths.France), 'DisplayName', 'France');
plot(deaths.Date, log(deaths.UK), 'DisplayName', 'UK');
plot(deaths.Date, log(deaths.Hubei_China), 'DisplayName', 'Hubei');
legend('Location','northwest');

chartStartDate = "18 Jan 2020";
chartYMax = 10;

% China
arrowColour = '#005500'; % dark green
addArrowText("23 Jan 2020", -1, chartStartDate, 2.81, 0.8, chartYMax, sprintf("23-Jan\nHubei Lockdown"), arrowColour);
addArrowText("31 Jan 2020", -3, chartStartDate, 5.3, 1, chartYMax, sprintf("31-Jan\nChina-Italy\nFlights Suspended"),arrowColour);
% Italy
arrowColour = '#000055'; % dark blue
addArrowText("29 Jan 2020", 0, chartStartDate, 0, 0.75, chartYMax, sprintf("29-Jan\nItaly's 1st\ndetected infection"),arrowColour);
addArrowText("23 Feb 2020", -3, chartStartDate, 1.1, 0.75, chartYMax, sprintf("23-Feb\n10 towns in\nLombardy\nquarantined"),arrowColour);
addArrowText("9 Mar 2020", -4, chartStartDate, 6.137, 0.75, chartYMax, sprintf("9-Mar\nItaly\nnationwide\nLockdown"),arrowColour);
addArrowText("14 Mar 2020", -5, chartStartDate, 7.24, 1, chartYMax, sprintf("14-Mar\nItaly 1st\nsigns of\nslowdown"),arrowColour);
addArrowText("21 Mar 2020", -3, chartStartDate, 8.48, 0.5, chartYMax, sprintf("21-Mar\nItaly\nfurther\nslowdown"),arrowColour);
%Spain
arrowColour = '#550000'; % dark red
addArrowText("7 Mar 2020", -2, chartStartDate, 2.39, 0.3, chartYMax, sprintf("7-Mar\nSpain\nLa Rioja\ntown lockdown"),arrowColour);
addArrowText("16 Mar 2020", -14, chartStartDate, 5.8348, 3, chartYMax, sprintf("16-Mar\nSpain\nfull lockdown"),arrowColour);
addArrowText("19 Mar 2020", -6, chartStartDate, 6.7214, 2, chartYMax, sprintf("19-Mar\nSpain 1st\nsigns of\nslowdown"),arrowColour);
addArrowText("25 Mar 2020", -2, chartStartDate, 8.2, 0.7, chartYMax, sprintf("25-Mar\nSpain\nfurther\nslowdown"),arrowColour);
%UK
arrowColour = '#550055'; % dark purple
addArrowText("12 Mar 2020", 1, chartStartDate, 2.0794, -0.7, chartYMax, sprintf("12-Mar\nUK Gov:\n'delay'\n'no social distancing'"),arrowColour);
addArrowText("20 Mar 2020", 2, chartStartDate, 5.1761, -0.7, chartYMax, sprintf("20-Mar\nUK schools\nclosed"),arrowColour);
addArrowText("23 Mar 2020", 2, chartStartDate, 5.81, -0.7, chartYMax, sprintf("23-Mar\nUK lockdown"),arrowColour);

title('Natural Log of Deaths');
xlabel('Date');
ylabel('ln(deaths)');
set(gcf,'Position',[-2159 1884 1430 1194])