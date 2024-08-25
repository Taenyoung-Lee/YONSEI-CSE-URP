%nm114_1: plot the data of a 5x2 array stored in "temp.dat"
load temp.dat
clf, plot(temp) %clear any existent figure and plot
title('the highest/lowest temperature of these days')
ylabel('degrees[C]'), xlabel('day')