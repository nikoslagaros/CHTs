function [value] = Constraints(f_real,x,g,gn,sum,sumv,p_violation,evv)
%% parameters
global iMeth f_bestFeasible PF popsize evals epsilon epsilonv nogen fmax fbest
global xbest gnbest gbest fi_theta fi_max fiv_theta fiv_max
%1=feasibility rules, 2=feasibility rules NL, 3=adaptive penalty,
%4=e-constrained, 5=e-constrained NL, 6 stochstic ranking
method=iMeth;
popsize_tmp=size(f_real,1);

% e-constrained
cp=2.0; tau=0.1; alpha=0.5; gamma=0.2;

% stochastic ranking
pf=0.45;
theta=gamma*popsize;
Tc=0.80*nogen;

%% initialization
fmaxn=0.0; %worst feasible in the population (feasiblity rules)
rf=0; %proportion of feasible individuals in the population (Adaptive penatly)
f_bestFeasible_tmp=f_bestFeasible;
evals=evv;
i=evals;
     
%% Implement constraint handling method
% Stochastic ranking
if (method == 6)
    [I] = srsort(f_real,sum,pf,popsize_tmp);
    fbest = f_real(round(I(1)));
    if isnan(fbest)
        kkk1=78;
    end
    xbest = x(round(I(1)),:);
    gnbest=gn(:,round(I(1)));
    gbest=g(:,round(I(1)));  
    f(:)=f_real(round(I(:)));
    xtmp=x;
    x=xtmp(round(I(:)),:);
    ssum=sort(sum);
    fi_theta=ssum(round(theta));
    fi_max=ssum(round(popsize_tmp));
    if i == 0 
        epsilon=fi_theta;
    end
    ssumv=sort(sumv);
    fiv_theta=ssumv(round(theta));
    fiv_max=ssumv(round(popsize_tmp));  
    if i == 0
        epsilonv=fiv_theta;
    end
else
% rest 3 methods
   for j=1:popsize_tmp
       if (method == 1)
           [f(j)]=FeasibilityRules(f_real(j),sumv(j),fmax);
        elseif (method == 2 || (method > 6  && method < 10)) 
            [f(j)] = FeasibilityRulesNL(f_real(j),p_violation(j));
        elseif (method == 3)
            [f(j)] = AdaptivePenalty(f_real(j),sumv(j));
        elseif (method == 4)
            [f(j)]=FeasibilityRulesEcon(f_real(j),sum(j),fmax,epsilon);
        elseif (method == 5 || method > 9)
            [f(j)] = FeasibilityRulesEconNL(f_real(j),p_violation(j),epsilonv);
       end
       if (sum(j) == 0) 
           if fmaxn < f_real(j) 
               fmaxn = f_real(j);
           end
           if f_bestFeasible_tmp > f_real(j) 
               f_bestFeasible_tmp = f_real(j);
               fbest = f_real(j);
               xbest = x(j,:);
               gnbest = gn(:,j);
               gbest = g(:,j);                 
           end
           rf = rf + 1;
           %{
           if fbest > f(j)
               fbest = f(j);
               xbest=x(:,j);
               gnbest=gn(:,j);
               gbest=g(:,j);
           end
           %}
       end
   end
   
   rf=rf/popsize_tmp;
   if (method == 3)
       [PF] = updatePF(f,sumv,PF,rf,popsize_tmp);
   end
   if (method == 4) || (method == 5)
       [epsilon, epsilonv]=updateEpsilon(rf,cp,tau,alpha,fi_max,i,Tc,fiv_max);
       end
   if rf > 0 
       fmax=fmaxn;
       f_bestFeasible=f_bestFeasible_tmp;
   end
end
value=f(:);
end