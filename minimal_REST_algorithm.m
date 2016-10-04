% Here is my attempt to build a program to do the re-referencing for EEG
% data that follows the ideas from the paper: 
%
% Yao, Dezhong. 2001. "A Method to Standardize a Reference of Scalp EEG
% Recordings to a Point at Infinity." Physiological Measurement 22 (4):
% 693. doi:10.1088/0967-3334/22/4/305.
%
% This is based on (1) my reading of the Yao paper, (2) loose adaptation of
% the non-working code from Dr. Yao's website, and (3) the use of Yao's
% "LeadField.exe" program to generate the lead field. I had to create a
% three-dimensional array of electrode locations for the Emotiv EPOC/EPOC+
% that was based on the various emotiv.ced files floating around the
% internet.

% Load and compute on the lead field from Yao's LeadField.exe program:

G = load('Emotiv_leadField_14.dat');   % Computed for Emotiv EPOC

% For speed the following section can be pre-computed; it is re-computed
% here, I suppose, because it has to assume that the lead field can change
% on a regular basis? This section makes the R_a matrix from the paper.

G     = G';                       % Why don't we just store the transpose?
G_ave = mean(G);
G_ave = G - repmat(G_ave,size(G,1),1);
Ra    = G*pinv(G_ave);   %,0.05);

% Now we load an electrodes by samples data matrix:

load EPOC_demo_data   % Variable: epocTestData

% The rest is simple matrix math:

cur_ave = mean(epocTestData);   % Mean of EEG at each sample point

% Subtract the average from the original data:

cur_var = epocTestData - repmat(cur_ave,size(epocTestData,1),1);

cur_var = Ra*cur_var;  % Multiply by Ra

% Here is the way the paper says to do it!

Va = epocTestData;
Vprime = Ra*Va;
Vprimea = mean(Vprime);

Vprime_final = Va + repmat(Vprimea, size(Va, 1), 1);






