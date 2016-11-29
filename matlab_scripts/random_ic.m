%% Function for random IC
function [toettcher2008_sim_update] = random_ic

% Load model
toettcher2008 = IQMmodel('model_toettcher2008.txt');

% Simulate model and generate data with default IC values
toettcher2008_sim = IQMsimulate(toettcher2008,120); %simulation time = 120

% Fetch the IC vector
IC_default = IQMinitialconditions(toettcher2008); %IC-vector w/ default IC

% Change the IC randomly
a = 0.00000000000000; %Lower bound
b = 1.00000000000000; %Upper bound
IC_rndm = (b-a).*rand(1,31) + a; %Create random IC
IC_rndm_range = [min(IC_rndm) max(IC_rndm)]; %Determine extreme IC-values

%Update the IQM-model with new IC values
toettcher2008_ICupdate = IQMinitialconditions(toettcher2008,IC_rndm);

%Simulate and generate data w/ new IC values (Random)
toettcher2008_sim_update = IQMsimulate(toettcher2008_ICupdate,120);
end