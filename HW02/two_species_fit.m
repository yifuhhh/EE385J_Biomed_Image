function residual = two_species_fit(params,ICs,time,measure)

%(1) First run ODE45 with our "guess" of the model parameters
   [~, model] = ode45(@(t,y) two_species(t,params,y),time,ICs);
            % Exact same call as beore

%(2)  Then calculate the residual between the model and measurement
residual = sum(model-measure,2); % the residual needs to be a [length(time) x 1] array

%(3) Then plot the current iteration of results
plot(time,model(:,1),'-r',time,model(:,2),'-b',time,measure(:,1),'.k',time,measure(:,2),'.g','MarkerSize',15,'LineWidth',2)
xlabel('Time (minutes)','FontSize',20)
ylabel('# of species','FontSize',20)
set(gca,'FontSize',20,'LineWidth',2);
legend('Model N','Model Q','Meas. N','Meas. Q','orientation','horizontal','location','Northoutside')
axis square;
drawnow
end
