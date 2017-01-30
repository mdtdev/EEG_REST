function newData = RESTreference(oldData)
% newData = RESTreference(oldData)
%
% Minimal function for REST referencing EEG data; takes a matrix of
% channels by time points. Set for Emotiv EPOC leadfield.

    % Load the "G" matrix from Yao's paper. Computed with the Yao provided
    % leadfield.exe program.
    
    G = load('Emotiv_leadField_14.dat');   % Computed for Emotiv EPOC
    
    % Set up G (this could be precomputed and saved, but...)

    G     = G';
    G_ave = mean(G);
    G_ave = G - repmat(G_ave,size(G,1),1);
    Ra    = G*pinv(G_ave);
    
    % Do the math in Yao's paper:
    
    Va           = oldData;
    Vprime       = Ra*Va;
    Vprimea      = mean(Vprime);
    Vprime_final = Va + repmat(Vprimea, size(Va, 1), 1);
    
    newData = Vprime_final;
    
end