function [PF] = updatePF(f,sumv,PF,rf,popsize_tmp)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global P_feas P_rate

n_positive=0;
sum_positive=0.0;
n_all=0;
if rf <= P_feas
    for i=1:popsize_tmp-1
        for j=i+1:popsize_tmp
            n_all=n_all+1;
            if sumv(i)~=0 || sumv(j)~=0
                PFC_ij=-(f(i)-f(j))/(sumv(i)-sumv(j));
                if PFC_ij > 0
                    n_positive = n_positive +1;
                    sum_positive = sum_positive + PFC_ij;
                end
            else
                a=123
            end
        end
    end
    if n_positive/n_all > 0.5
        PF = sum_positive/n_positive;        
    end
    
else
    PF=PF*P_rate;
end
end

