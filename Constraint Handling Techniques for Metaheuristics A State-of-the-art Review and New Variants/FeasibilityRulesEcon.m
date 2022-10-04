function [f] = FeasibilityRulesEcon(f_real,sum,fmax,epsilon)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
f=f_real;
if sum > epsilon
    f = fmax + sum;
end
end

