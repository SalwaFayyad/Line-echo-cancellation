
close all;
clear all;
clc;
load('path.mat');
load('css.mat');

Xc = [css,css ,css ,css, css];
N= length(Xc);
y = conv(path, Xc);

input_power = 10 * log10((1/N) * sum(abs(Xc).^2))
output_power = 10 * log10((1/N) * sum(abs(y).^2))
ERL = output_power-input_power
