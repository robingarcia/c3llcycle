
%% Load data

datafolder	= '../Data/';
datafile	= 'data.mat';

load(fullfile(datafolder,datafile))

% load options for ERA and wanderlust
load_options

%% Find a path through the population 
% wanderlust options
start = [-3,-1.2];
startballsize = [0.02,0.02];
wanderlust_weights = [1,1];
doplots = 1;
num_graphs = 30;
PathIndex = [1,2];
manual_path = 0;

G = PathfromWanderlust(data,options);
path = getMeanWanderlustPath(G,data,options);
plotDataAndPath(data,path,options);

%% Cell Density on the path

PathDensity = sbistFACS2PathDensity(data_scaled,path,options);

%% Transform density to age scale
gamma = log(2)/18;  % growthrate
newScale.pdf = @(a) 2*gamma*exp(-gamma.*a);
newScale.cdf = @(a) 2-2*exp(-gamma.*a);
newScale.coDomain = [0,log(2)/gamma];

NewPathDensity = sbistFACSDensityTrafo(PathDensity,newScale);