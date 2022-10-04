function [p_violation] = calc_p_violation(gn)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global iMeth
p_violation = 0.0;
if iMeth == 2 || iMeth == 5 || iMeth > 6
    p_violation_is = nonzeros(gn)+1;
    if ~isempty(p_violation_is)
        p_violation_tmp1 = max(p_violation_is)*(1+length(p_violation_is)/length(gn));
        p_violation_tmp2 = mean(p_violation_is)*(1+length(p_violation_is)/length(gn));
        p_violation_tmp3 = median(p_violation_is)*(1+length(p_violation_is)/length(gn));
        p_violation_tmp4 = max(p_violation_is);
        if(length(p_violation_is)/length(gn)) < 0.005
        p_violation_tmp5 = (1+length(p_violation_is)/length(gn));
        end
        if iMeth == 7 || iMeth == 10
        p_violation = p_violation_tmp1;
        elseif iMeth == 8 || iMeth == 11
        p_violation = p_violation_tmp2;
        elseif iMeth == 9 || iMeth == 12
        p_violation = p_violation_tmp3;
        else
        p_violation = p_violation_tmp4;    
        end
    end
end
end

