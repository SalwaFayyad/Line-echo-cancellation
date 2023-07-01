%Salwa Fayyad 1200430 , Sondos Farrah 1200905 , Katya Kobari 1201478

close all;
clear all;
clc;
load('path.mat');
load('css.mat');

Xc = [css,css ,css ,css, css];
N= length(Xc);%5600*5
y = conv(path, Xc);

InputPower = 10 * log10((1/N) * sum(abs(Xc).^2))
OutputPower = 10 * log10((1/N) * sum(abs(y).^2))
ERL = OutputPower-InputPower
