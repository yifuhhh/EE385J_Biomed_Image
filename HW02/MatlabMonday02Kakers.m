0.% Kiernan Akers (kma3282) 
% Matlab Monday 02

%% Problem 1 (A, B, C, D)
% 
% A.) 
    % The relationship between tumor hypoxia and tumor vasculature is
    % the inability of the tumor's vascular network to sustain normoxic
    % conditions for the rapidly growning tumor.  Some portions of the
    % tumor do not have the necessary vessel network to supply a
    % sustainable amount of oxygen. 

% B.) 
load matlab_monday_02
control_mm = [];
x = [1 2 3 4 5]; % 0, 1, 3, 4, 7 

control_mm(1) = mean(control_d0.SUV(control_d0.roi_muscle (:)==1));
control_mm(2) = mean(control_d1.SUV(control_d1.roi_muscle (:)==1));
control_mm(3) = mean(control_d3.SUV(control_d3.roi_muscle (:)==1));
control_mm(4) = mean(control_d4.SUV(control_d4.roi_muscle (:)==1));
control_mm(5) = mean(control_d7.SUV(control_d7.roi_muscle (:)==1));

control_mm_ci = [];
control_mm_ci(1) = 1.96*std(control_d0.SUV(control_d0.roi_muscle(:)==1))/sqrt(sum(control_d0.SUV(control_d0.roi_muscle(:)==1)));
control_mm_ci(2) = 1.96*std(control_d1.SUV(control_d1.roi_muscle(:)==1))/sqrt(sum(control_d1.SUV(control_d1.roi_muscle(:)==1)));
control_mm_ci(3) = 1.96*std(control_d3.SUV(control_d3.roi_muscle(:)==1))/sqrt(sum(control_d3.SUV(control_d3.roi_muscle(:)==1)));
control_mm_ci(4) = 1.96*std(control_d4.SUV(control_d4.roi_muscle(:)==1))/sqrt(sum(control_d4.SUV(control_d4.roi_muscle(:)==1)));
control_mm_ci(5) = 1.96*std(control_d7.SUV(control_d7.roi_muscle(:)==1))/sqrt(sum(control_d7.SUV(control_d7.roi_muscle(:)==1)));

treated_mm(1) = mean(treated_d0.SUV(treated_d0.roi_muscle(:)==1));
treated_mm(2) = mean(treated_d1.SUV(treated_d1.roi_muscle(:)==1));
treated_mm(3) = mean(treated_d3.SUV(treated_d3.roi_muscle(:)==1));
treated_mm(4) = mean(treated_d4.SUV(treated_d4.roi_muscle(:)==1));
treated_mm(5) = mean(treated_d7.SUV(treated_d7.roi_muscle(:)==1));

treated_mm_ci = [];
treated_mm_ci(1) = 1.96*std(treated_d0.SUV(treated_d0.roi_muscle(:)==1))/sqrt(sum(treated_d0.SUV(treated_d0.roi_muscle(:)==1)));
treated_mm_ci(2) = 1.96*std(treated_d1.SUV(treated_d1.roi_muscle(:)==1))/sqrt(sum(treated_d1.SUV(treated_d1.roi_muscle(:)==1)));
treated_mm_ci(3) = 1.96*std(treated_d3.SUV(treated_d3.roi_muscle(:)==1))/sqrt(sum(treated_d3.SUV(treated_d3.roi_muscle(:)==1)));
treated_mm_ci(4) = 1.96*std(treated_d4.SUV(treated_d4.roi_muscle(:)==1))/sqrt(sum(treated_d4.SUV(treated_d4.roi_muscle(:)==1)));
treated_mm_ci(5) = 1.96*std(treated_d7.SUV(treated_d7.roi_muscle(:)==1))/sqrt(sum(treated_d7.SUV(treated_d7.roi_muscle(:)==1)));

figure
subplot (1,2,1) 
errorbar(x,treated_mm, treated_mm_ci,'-r','LineWidth',2);
hold 
errorbar(x,control_mm, control_mm_ci,'-b','LineWidth',2);
title('SUV in Muscle')
xlabel('Time Points (Days: 0, 1, 3, 4, 7)')
ylabel('Stnadard Uptake Value (SUV)')
set(gca,'FontSize',10,'LineWidth',2)
legend('Treated','Control','Location','Northoutside','Orientation','horizontal')

control_mm_norm = control_mm(:)/0.2397;
control_mm_ci_norm = control_mm_ci(:)/0.2397;

treated_mm_norm = treated_mm(:)/0.2642;
treated_mm_ci_norm = treated_mm_ci(:)/0.2642;

subplot (1,2,2)
errorbar(x, treated_mm_norm, treated_mm_ci_norm, '-r', 'Linewidth',2)
hold
errorbar(x, control_mm_norm, control_mm_ci_norm, '-b', 'Linewidth',2)
title('SUV in Muscle (Norm by Day 0)')
xlabel('Time Points (Days: 0, 1, 3, 4, 7)')
ylabel('Stnadard Uptake Value (SUV)')
set(gca,'FontSize',10,'LineWidth',2)
legend('Treated','Control','Location','Northoutside','Orientation','horizontal')

% C.)

control_tm = [];
 
control_tm(1) = mean(control_d0.SUV(control_d0.roi_tumor(:)==1));
control_tm(2) = mean(control_d1.SUV(control_d1.roi_tumor(:)==1));
control_tm(3) = mean(control_d3.SUV(control_d3.roi_tumor(:)==1));
control_tm(4) = mean(control_d4.SUV(control_d4.roi_tumor(:)==1));
control_tm(5) = mean(control_d7.SUV(control_d7.roi_tumor(:)==1));

control_tm_ci = [];
control_tm_ci(1) = 1.96*std(control_d0.SUV(control_d0.roi_tumor(:)==1))/sqrt(sum(control_d0.SUV(control_d0.roi_tumor(:)==1)));
control_tm_ci(2) = 1.96*std(control_d1.SUV(control_d1.roi_tumor(:)==1))/sqrt(sum(control_d1.SUV(control_d1.roi_tumor(:)==1)));
control_tm_ci(3) = 1.96*std(control_d3.SUV(control_d3.roi_tumor(:)==1))/sqrt(sum(control_d3.SUV(control_d3.roi_tumor(:)==1)));
control_tm_ci(4) = 1.96*std(control_d4.SUV(control_d4.roi_tumor(:)==1))/sqrt(sum(control_d4.SUV(control_d4.roi_tumor(:)==1)));
control_tm_ci(5) = 1.96*std(control_d7.SUV(control_d7.roi_tumor(:)==1))/sqrt(sum(control_d7.SUV(control_d7.roi_tumor(:)==1)));

treated_tm = [];

treated_tm(1) = mean(treated_d0.SUV(treated_d0.roi_tumor(:)==1));
treated_tm(2) = mean(treated_d1.SUV(treated_d1.roi_tumor(:)==1));
treated_tm(3) = mean(treated_d3.SUV(treated_d3.roi_tumor(:)==1));
treated_tm(4) = mean(treated_d4.SUV(treated_d4.roi_tumor(:)==1));
treated_tm(5) = mean(treated_d7.SUV(treated_d7.roi_tumor(:)==1));

treated_tm_ci = [];
treated_tm_ci(1) = 1.96*std(treated_d0.SUV(treated_d0.roi_tumor(:)==1))/sqrt(sum(treated_d0.SUV(treated_d0.roi_tumor(:)==1)));
treated_tm_ci(2) = 1.96*std(treated_d1.SUV(treated_d1.roi_tumor(:)==1))/sqrt(sum(treated_d1.SUV(treated_d1.roi_tumor(:)==1)));
treated_tm_ci(3) = 1.96*std(treated_d3.SUV(treated_d3.roi_tumor(:)==1))/sqrt(sum(treated_d3.SUV(treated_d3.roi_tumor(:)==1)));
treated_tm_ci(4) = 1.96*std(treated_d4.SUV(treated_d4.roi_tumor(:)==1))/sqrt(sum(treated_d4.SUV(treated_d4.roi_tumor(:)==1)));
treated_tm_ci(5) = 1.96*std(treated_d7.SUV(treated_d7.roi_tumor(:)==1))/sqrt(sum(treated_d7.SUV(treated_d7.roi_tumor(:)==1)));

figure
subplot (1,3,1) 
errorbar(x,treated_tm, treated_tm_ci,'-r','LineWidth',2);
hold 
errorbar(x,control_tm, control_tm_ci,'-b','LineWidth',2);
title('SUV in Tumor')
xlabel('Time Points (Days: 0, 1, 3, 4, 7)')
ylabel('Stnadard Uptake Value (SUV)')
set(gca,'FontSize',10,'LineWidth',2)
legend('Treated','Control','Location','Northoutside','Orientation','horizontal')

control_tm_norm = control_tm(:)/0.3829;
control_tm_ci_norm = control_tm_ci(:)/0.3829;

treated_tm_norm = treated_tm(:)/0.3459;
treated_tm_ci_norm = treated_tm_ci(:)/0.3459;

subplot (1,3,2)
errorbar(x, treated_tm_norm, treated_tm_ci_norm, '-r', 'Linewidth',2)
hold
errorbar(x, control_tm_norm, control_tm_ci_norm, '-b', 'Linewidth',2)
title('SUV in Tumor (Norm by Day 0)')
xlabel('Time Points (Days: 0, 1, 3, 4, 7)')
ylabel('Stnadard Uptake Value (SUV)')
set(gca,'FontSize',10,'LineWidth',2)
legend('Treated','Control','Location','Northoutside','Orientation','horizontal')

control_tm_mm_norm = (control_tm ./control_mm)/ 1.5973;
control_tm_mm_ci_norm = (control_tm_ci ./control_mm)/ 1.5973;

treated_tm_mm_norm = (treated_tm ./treated_mm)/ 1.3094;
treated_tm_mm_ci_norm = (treated_tm_ci ./treated_mm)/ 1.3094 ;

subplot (1,3,3)
errorbar(x, control_tm_mm_norm, control_tm_mm_ci_norm, '-b', 'Linewidth', 2)
hold
errorbar(x, treated_tm_mm_norm, treated_tm_mm_ci_norm, '-r', 'Linewidth', 2)
title('SUV in Tumor (Norm by Day 0 and Muscle)')
xlabel('Time Points (Days: 0, 1, 3, 4, 7)')
ylabel('Stnadard Uptake Value (SUV)')
set(gca,'FontSize',10,'LineWidth',2)
legend('Treated','Control','Location','Northoutside','Orientation','horizontal')

% D.) 
    % The SUV allows us to quantify the uptake of the PET agent (in this
    % case FDG).  The SUV is the ratio of the calculated concentration of
    % the agent to the whole body concentration of the agent.  We
    % normalized ur measurements to a muscle measurement because muscle
    % tissue is generally abundant with glucose and therefore FDG should
    % accumulate in muscle tissue as well.  Having an abundance of the PET
    % agent should give us better results.  Based off of these two mice, it
    % seems tat these imaging measure do support our hypothesis on what
    % Tratsuzumab is doing to the tumor.
%% Problem 2 
load DCE_example
[sy sx st] = size(dyn_s);
%% Part A

options = optimset('TolFun',1e-12,'TolX',1e-12);options = optimset(options,'LargeScale','on');
options = optimset(options,'Display','off');options = optimset(options,'MaxIter',150,'MaxFunEval',2000);

%%ROI Time Course for muscle and tumor
for t = 1:st
    d = Ct(:,:,t);
    muscle_tc(t) = mean(d(muscle_mask(:)==1));
end
subplot (1,2,1)
plot(scantime,muscle_tc,'.r')
axis square
xlabel('Time (minutes)')
ylabel('[CA]')
title('ROI Time Course - Muscle')
legend('Muscle','Location','Northoutside','Orientation','horizontal')
set(gca)

% Fitting ROI time course for muscle and computing Ktrans and Ve values
params_guess  = [0.1 0.3];  % initial guesses for ktrans params(1)  and ve params(2)
LB = [0 0];  % lower bounds
UB = [10 1]; % upper bounds for parameters;

R1_muscle = mean(R1_base(muscle_mask(:)==1));  % You need to change this for each voxel
S_inh_muscle = mean(S_inh(muscle_mask(:)==1)); % you need to change this for each voxel

% Evaluate the 2 compartment (myToftsFunSI) model
model_out = myToftsFunSI(params_guess,scantime,...
    AIF,flip,TR,R1_muscle,length(scantime),Rel,S_inh_muscle);
data_to_fit = muscle_tc;  % you need to change this for each voxel
R1_data = mean(R1_base(muscle_mask(:)==1));  % You need to change this for each voxel
S_inh_data = mean(S_inh(muscle_mask(:)==1)); % you need to change this for each voxel

 [params] = lsqcurvefit('myToftsFunSI',params_guess,scantime,...
                    data_to_fit,LB, UB,options,AIF,flip,TR,R1_data,...
                    length(scantime),Rel,S_inh_data);
                
model_out = myToftsFunSI(params,scantime,...
    AIF,flip,TR,R1_data,length(scantime),Rel,S_inh_data);

subplot (1,2,2)
plot(scantime,muscle_tc,'.r',scantime,model_out)
axis square
xlabel('Time (minutes)')
ylabel('[CA]')
legend('Measured','Model Guess','Location','Northoutside','Orientation','horizontal')
set(gca)
title('Model Guess of ROI time Course - Muscle')
disp(['Ktrans = ' num2str(params(1))])
disp(['ve = ' num2str(params(2))])

%% Part B
Ktransm = zeros(sy,sx);
Vem = zeros(sy,sx);


for x = 1:128
    for y = 1:128
        d = Ct(:,:,t);
        if muscle_mask(x,y)==1 %%%for if statement always use == instead of = 
            data_to_fit = squeeze(Ct(x,y,:))';
            R1_data = R1_base(x,y);
            S_inh_data = S_inh(x,y);
   
            [params] = lsqcurvefit('myToftsFunSI',params_guess,scantime,...
                    data_to_fit,LB, UB,options,AIF,flip,TR,R1_data,...
                    length(scantime),Rel,S_inh_data);
    
            Ktransm(x,y) = params(1);
            Vem(x,y) = params(2);
        end
    end
end

%%Now that I have the Ktrans and Ve calculated for each voxel within the
%%muscle ROI I need to calculate the mean 

%Grab all the non zero elements within the Ktrans and Ve matrix
n1 = nnz(Ktransm);
n2 = nnz(Vem);

%calculate the mean of Ktransm and Vem
meanKtransm = mean(Ktransm(Ktransm~=0));
meanVem = mean(Vem(Vem~=0));

%calculate the 95% confidence interval of Ktransm
meanKtransm_err = 1.96*std(Ktransm(Ktransm~=0))/sqrt(n1);
meanVem_err = 1.96*std(Vem(Vem~=0))/sqrt(n2);

subplot (1,2,1)
imagesc(Ktransm)
axis image;
axis off;
title('Ktrans Values for Each Voxel - Muscle') 
colorbar

subplot (1,2,2)
imagesc(Vem)
axis square;
axis off;
title('Ve Values for Each Voxel - Muscle') 
colorbar

%% Part C
for t = 1:st
    d = Ct(:,:,t);
    tumor_tc(t) = mean(d(tumor_mask(:)==1));
end
subplot (1,2,1)
plot(scantime,tumor_tc,'.b')
axis square
xlabel('Time (minutes)')
ylabel('[CA]')
title('ROI Time Course - Tumor')
legend('Tumor','Location','Northoutside','Orientation','horizontal')
set(gca)

% Fitting ROI time course for muscle adn computing Ktrans and Ve values
params_guess  = [0.1 0.3];  % initial guesses for ktrans params(1)  and ve params(2)
LB = [0 0];  % lower bounds
UB = [10 1]; % upper bounds for parameters;

R1_tumor = mean(R1_base(tumor_mask(:)==1));  % You need to change this for each voxel
S_inh_tumor = mean(S_inh(tumor_mask(:)==1)); % you need to change this for each voxel

% Evaluate the 2 compartment (myToftsFunSI) model
model_out = myToftsFunSI(params_guess,scantime,...
    AIF,flip,TR,R1_muscle,length(scantime),Rel,S_inh_muscle);
data_to_fit = muscle_tc;  % you need to change this for each voxel
R1_data = mean(R1_base(tumor_mask(:)==1));  % You need to change this for each voxel
S_inh_data = mean(S_inh(tumor_mask(:)==1)); % you need to change this for each voxel

 [params] = lsqcurvefit('myToftsFunSI',params_guess,scantime,...
                    data_to_fit,LB, UB,options,AIF,flip,TR,R1_data,...
                    length(scantime),Rel,S_inh_data);
                
model_out = myToftsFunSI(params,scantime,...
    AIF,flip,TR,R1_data,length(scantime),Rel,S_inh_data);

subplot(1,2,2)
plot(scantime,tumor_tc,'.b',scantime,model_out)
axis square
xlabel('Time (minutes)')
ylabel('[CA]')
legend('Measured','Model Guess','Location','Northoutside','Orientation','horizontal')
set(gca)
title('Model Guess of ROI time Course - Tumor')
disp(['Ktrans = ' num2str(params(1))])
disp(['ve = ' num2str(params(2))])

%% Part D
Ktranst = zeros(sy,sx);
Vet = zeros(sy,sx);

for x = 1:128
    for y = 1:128
        d = Ct(:,:,t);
        if tumor_mask(x,y)==1
            data_to_fit = squeeze(Ct(x,y,:))';
            R1_data = R1_base(x,y);
            S_inh_data = S_inh(x,y);
   
            [params] = lsqcurvefit('myToftsFunSI',params_guess,scantime,...
                    data_to_fit,LB, UB,options,AIF,flip,TR,R1_data,...
                    length(scantime),Rel,S_inh_data);
    
            Ktranst(x,y) = params(1);
            Vet(x,y) = params(2);
        end
    end
end

%%Now that I have the Ktrans and Ve calculated for each voxel within the
%%Tumor ROI I need to calculate the mean 

%Grab all the non zero elements within the Ktrans and Ve matrix
n3 = nnz(Ktranst);
n4 = nnz(Vet);

%calculate the mean of Ktransm
meanKtranst = mean(Ktranst(Ktranst~=0));
meanVet = mean(Vet(Vet~=0));

%calculate the 95% confidence interval of Ktransm
meanKtranst_err = 1.96*std(Ktranst(Ktranst~=0))/sqrt(n3);
meanVet_err = 1.96*std(Vet(Vet~=0))/sqrt(n4);

subplot(1,2,1)
imagesc(Ktranst)
axis image;
axis off;
title('Ktrans Values for Each Voxel - Tumor') 
colorbar

subplot(1,2,2)
imagesc(Vet)
axis square;
axis off;
title('Ve Values for Each Voxel - Tumor') 
colorbar

%% Part E

% It seems like ROI analysis is most useful if the CN and SNR are very high
% and it is easy to distinguish apparent tumor tissue as opposed to normal
% tissue.  Voxel level analysis is most useful for more stringent analysis
% and gives a more reliable answer.