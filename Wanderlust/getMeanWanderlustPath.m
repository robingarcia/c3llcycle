function G = getMeanWanderlustPath(G,data,opts,zero_val)


%% Function to get the mean wanderlust path
%
% The path is generated by applying a moving average over the coordinates of the
% datapoints along the wanderlustpath. 
%
%% Inpt
%
% G			- Wanderlust struct
% data		- nxd data used to generate wanderlust path
% opts		- options struct for plotting
% 		+ doplots
% 		+ Ynames 
%		+ PathIndex
%
%% Output
%
% G.x		- x = linspace(0,1,100); of normalized mean path position
% G.y		- dx100 path coordinates from moving average
% G.fh		- Handle to the plot
%%%

% check inputs

y = data;
[n,d] = size(y);

doplots = 0;
if nargin > 2
	if isfield(opts,'doplots')
		doplots = opts.doplots;
	end
end
if doplots
	if (isfield(opts,'Ynames') && isfield(opts,'PathIndex'))
		dimension_names = opts.Ynames(opts.PathIndex);
	else 
		dimension_names = sprintfc('dim %i',1:d);
	end
end


% normalize all paths and take the mean
normGT = bsxfun(@times,(bsxfun(@minus,G.T,min(G.T')')), 1./(max(G.T')'- min(G.T')'));
x= mean(normGT);

% generate path coordinates with moving average
xwant = linspace(0,1,100);
binsize =0.2;
ywant = moving_average(x,y',xwant,binsize);

if doplots
% subplot layout
% possible combinations of dimensions in 2d
C = nchoosek(1:d,2); %WChooseK ? 
a = floor(size(C,1)^(1/2));
b = ceil(size(C,1)/a);
[I,~]=find(C==zero_val);%Position of zero column
I = sort(I);

rect = [20 20 800 600];
G.fh = figure('Color','w','Position',rect);

for i = 1:size(C,1)
	if i ~= I
    subplot(a,b,i)
	[~,dens,X,Y] = kde2d(data(:,C(i,:)));
	pcolor(X,Y,dens); shading interp							% density
	hold on
	scatter(data(:,C(i,1)),data(:,C(i,2)),1,'w.')				% all datapoints 
	scatter(data(G.Opts.s,C(i,1)),data(G.Opts.s,C(i,2)),1,'rx')				% start points
	plot(ywant(C(i,1),:),ywant(C(i,2),:),'r','LineWidth',3)		% path
	xlabel(dimension_names{C(i,1)})
	ylabel(dimension_names{C(i,2)})
    else
    end
end
end

G.x = xwant;
G.y = ywant;



