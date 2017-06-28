function [best_comb] = M2Marea(results_save,errordata,y,f,ic,y_0,t_period,statenames)
% This function calculates the area unter the curve 
% 
% 
% [Syntax]
% [best_comb] = M2Marea(results_save,errordata,y,f,ic,y_0,t_period,statenames)
% 
% [INPUT]
% results_save:
% errordata:
% y:                number: Datapoints
% f:                cell:   Function handles
% ic:               number: Initial conditions
% y_0:              number: Start of the cell cylce
% t_period:         number: Cell cycle period
% statenames:       cell:   Names of the species
% 
% [OUTPUT]
% best_comb:        struct: Contains the results for all combinations
%
% [EXAMPLE]
% Pending
k=1;
binsize = 0.1;

best_comb = cell(size(ic,1)-2,5);
f_combo = results_save.y_previous;
bestcombo = results_save.best;
number_species = minus(size(ic,1),size(bestcombo,2));
x = linspace(0,1,size(f_combo,2));
while k < number_species
j = 1:size(ic,1);
j = setdiff(j,bestcombo);%Exclude numbers that were already used
best_additional = zeros(1,size(ic,2));
if k == 1
for i = j

   best_additional(1,i) = trapz(x,y(i,:)-f_combo);
   B = trapz(x,f_combo);%Area under curve
end

else
    % Wanderlust recalculate
    combo = combo_wanderlust(errordata(bestcombo,:),t_period,y_0(bestcombo),statenames);
    x_wand = normdata(combo.a_E);
    y_wand = combo.Variance_A;
    ywant = moving_average(x_wand, y_wand, x, binsize);

B(k) = trapz(x,ywant);
    for i = j
        
    best_additional(1,i) = trapz(x,y(i,:)-ywant);

    end
end

best_additional(best_additional == 0) = NaN;
[area,T] = min(best_additional);
f_combo = f{T}(x);
best_comb{k,1} = bestcombo;% Best combination
best_comb{k,2} = T;%
best_comb{k,3} = area;
best_comb{k,4} = best_additional;
best_comb{k,5} = B;
bestcombo = horzcat(best_comb{k,1},best_comb{k,2});%remove sort
k = k+1;
disp(k)
end
end
