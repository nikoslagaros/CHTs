function [f] = AdaptivePenalty(f_real,sumv)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
global PF
f=f_real+PF*sumv;
end

