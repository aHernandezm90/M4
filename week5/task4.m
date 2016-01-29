%% Parameters

F_update = [1 0 1 0; 0 1 0 1; 0 0 1 0; 0 0 0 1];

Npop_particles = 4000;

Xstd_rgb = 50;
Xstd_pos = 250;
Xstd_vec = 5;

Xrgb_trgt = [255; 255; 255];

path_highway = 'Dataset/highway/input/';
file_highway = dir(strcat(path_highway,'*.jpg'));
%file_gt = dir ('Dataset/highway/groundtruth/*.png');

Npix_resolution = [320 240];
Nfrm_movie = size(file_highway,1);

%% Object Tracking by Particle Filter

X = create_particles(Npix_resolution, Npop_particles);
%f = getforeground(path_highway);
mask = roipoly;
maxIterations = 200;

for k = 1:Nfrm_movie
    
    % Getting Image
    %Y_k = read(vr, k);
    Y_k1 = imread(strcat(path_highway ,file_highway(k).name));
    %gts = imread (['Dataset/highway/groundtruth/' file_gt(k).name]);
    gts = activecontour(rgb2gray(Y_k1), mask, maxIterations, 'Chan-Vese');

    Y_k = bsxfun(@times,Y_k1,gts);
    
    % Forecasting
    X = update_particles(F_update, Xstd_pos, Xstd_vec, X);
    
    % Calculating Log Likelihood
    L = calc_log_likelihood(Xstd_rgb, Xrgb_trgt, X(1:2, :), Y_k);
    
    % Resampling
    X = resample_particles(X, L);

    % Showing Image
    show_particles(X, Y_k1); 
%    show_state_estimated(X, Y_k);

end

