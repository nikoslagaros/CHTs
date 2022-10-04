function [f] = FeasibilityRules(f_real,sum,fmax)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
f=f_real;
if sum > 0.0
    f = fmax + sum;
end
end

