function M2M_allstartP(simdata,UB,LB,PERIOD)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
%% upper and lower bound
for i=1:5
    xlim([900 1000])
    grid on
    plot(simdata{1,i}.time,simdata{1,i}.statevalues(:,5),'k','LineWidth',2)
    hold on
    plot(simdata{1,i}.time(UB(i)),simdata{1,i}.statevalues(UB(i),5),'r*','LineWidth',3)
    hold on
    plot(simdata{1,i}.time(LB(i)),simdata{1,i}.statevalues(LB(i),5),'g*','LineWidth',3)
    line=linspace(simdata{1,i}.time(LB(i)),simdata{1,i}.time(UB(i)),PERIOD(i));
    hold on
    plot(line,simdata{1,i}.statevalues(LB(i):UB(i)-1,5),'LineWidth',3)
    xlabel('time (h)'), ylabel('concentration (AU)')
end
%     matlab2tikz

end

