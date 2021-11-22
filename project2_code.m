%% Histogram 

% Reading in ZTF catalog search results as a table
objects = readtable("Data\ztf_search_results_11-1.csv", 'Format', 'auto', 'TreatAsEmpty', 'null'); 
important_values = objects((objects.ngoodobs >= 25), [22 26]); % Strips table to only objects 
% with ngoodobs >= 25 and includes the cols with maxmag and minmag

important_values.deltamag(1 : height(important_values)) = ...
    important_values.maxmag(1 : height(important_values)) - ...
    important_values.minmag(1 : height(important_values)) ; % Change in magnitude for each object

figure()
plot(important_values.maxmag, important_values.minmag, '.') % Plotting the CV stars max vs min magnitudes
hold on
set(gca, 'Ydir', 'reverse')
set(gca, 'Xdir', 'reverse')
ylabel('Minimum Magnitude (Most Bright)')
xlabel('Maximum Magnitude (Most Dim)')

no_change = linspace(12, 22, 100);
change_1 = no_change - 1.5;
change_2 = no_change - 4;
change_3 = no_change - 8;
plot(no_change, no_change, ':') % Plotting a line representing no change
plot(no_change, change_1, ':') % Plotting a line representing a change of 1.5
plot(no_change, change_2, ':') % Plotting a line representing a change of 4
plot(no_change, change_3, ':') % Plotting a line representing a change of 8
legend('ZTF Data', 'Zero Change in Magnitude', '1.5 Magnitude Change',...
    '4 Magnitude Change', '8 Magnitude Change', 'Location', 'southeast')
title('Minimum Magnitude vs. Maximum Magnitude')

figure()
hist = histogram(important_values.deltamag, 'BinEdges', [0 1.5 4 8 20]);
hold on
text(hist.BinEdges(1:end - 1), hist.Values, num2str(hist.Values'), 'vert','bottom','horiz','left')

xticks([0 1.5 4 8 20])
xlabel('Change in Magnitude')
ylabel('Number of CV Stars')
title('Frequency of CV Stars of Different Changes in Magnitude')