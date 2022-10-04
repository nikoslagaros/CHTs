function [I] = srsort(f,phi,pf,n)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% initialize index
I=zeros(1,n);
  for i=1:n
    I(i) =i;
  end

% perform stochastic bubble sort
 for i=1:n
    Is = 0;
    G=rand(1,n-1);
    for j=1:n-1
      if phi(round(I(j))) == phi(round(I(j+1))) && phi(round(I(j)))==0 || G(j)<pf
        if f(round(I(j))) > f(round(I(j+1)))
          Is = I(j);
          I(j) = I(j+1);
          I(j+1) = Is ;
        end
      else
          if phi(round(I(j))) > phi(round(I(j+1))) 
          Is = I(j);
          I(j) = I(j+1);
          I(j+1) = Is ;
          end
      end
    end
    if (Is == 0) 
        break ;
    end
end
end
