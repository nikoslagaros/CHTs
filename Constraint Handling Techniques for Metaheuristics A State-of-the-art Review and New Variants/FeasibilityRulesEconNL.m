function [f] = FeasibilityRulesEconNL(f_real,p_violation,epsilonv)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
global f_bestFeasible no_dv
f=f_real;

if(p_violation > epsilonv)
    %f=max(f_bestFeasible,f_real)*p_violation;
    
    if(p_violation ~= 0.0)
    f_max = max(f_bestFeasible,f_real);
    if f_max < 0
        f=f_max/p_violation;
    elseif f_max == 0
        f=f_max + no_dv*p_violation;
    else
        f=f_max*p_violation;
    end
    end

    if(p_violation == 0.0)
        if f_bestFeasible > f_real
            f_bestFeasible = f_real;
        end
    end
end

end

