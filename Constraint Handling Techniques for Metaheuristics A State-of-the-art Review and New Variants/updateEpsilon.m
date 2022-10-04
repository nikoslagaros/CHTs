function [epsilon, epsilonv]=updateEpsilon(rf,cp,tau,alpha,fi_max,FEs,Tc,fiv_max)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
epsilon = 0.0;
epsilonv = 1.0;
if rf < alpha && FEs < Tc
    epsilon = epsilon*(1-FEs/Tc)^cp;
    epsilonv = epsilonv*(1-FEs/Tc)^cp;
elseif rf >= alpha && FEs < Tc
    epsilon = (1+tau)*fi_max;
    epsilonv = (1+tau)*fiv_max;
else
    epsilon = 0.0;
    epsilonv = 0.0;
end
end

