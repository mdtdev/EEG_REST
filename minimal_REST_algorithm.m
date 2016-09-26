% Here is my attempt to build a program to do the re-referencing for EEG data that
% follows the ideas from the paper: Yao, Dezhong. 2001. "A Method to Standardize a
% Reference of Scalp EEG Recordings to a Point at Infinity." Physiological
% Measurement 22 (4): 693. doi:10.1088/0967-3334/22/4/305. This is based on (1) my
% reading of the Yao paper, (2) loose adaptation of the non-working code from Dr.
% Yao's website, and (3) the use of Yao's "LeadField.exe" program to generate the
% lead field. I had to create a three-dimensional array of electrode locations for
% the Emotiv EPOC/EPOC+ that was based on the various emotiv.ced files floating
% around the internet.

% Load and compute on the lead field:

    tolerance = 0.05;   % From the original code from Dr. Yao

    G = load('Lead_Field.dat');   % This is computed for each electrode configuration

    % For speed the following section can be pre-computed; it is re-computed
    % here, I suppose, because it has to assume that the lead field can change
    % on a regular basis?

    G = G';                       % Not sure why we don't just store the transpose?
    G_ave = mean(G);
    G_ave = G - repmat(G_ave,size(G,1),1);
    Ra=G*pinv(G_ave,0.05);
    clear G;
    clear G_ave;




    cur_var=cur_data.(Fields_list{k});

    cur_ave=mean(cur_var);
    cur_var=cur_var-repmat(cur_ave,size(cur_var,1),1);
    cur_var=Ra*cur_var;
    Ref_data.(Fields_list{k})=cur_var;



    for i=1:length(File_List)
      %            set(handles.listbox_files, 'String', File_List);
      set(handles.listbox_files, 'Value', i);
      %try
      cur_file=File_List{i};
      [pathstr,name,ext] = fileparts(cur_file);
      save_dir=strcat(pathstr,'\\');     %MDT change
      save_dir=strcat(save_dir,name);

      save_dir=strcat(save_dir,'_REST_Ref.mat');
      %                 save_dir=strcat
      cur_data=load(cur_file);
      Fields_list=fields(cur_data);
      %---------------------
      Ref_data=[];
      for k=1:length(Fields_list)
        cur_var=cur_data.(Fields_list{k});

        cur_ave=mean(cur_var);
        cur_var=cur_var-repmat(cur_ave,size(cur_var,1),1);
        cur_var=Ra*cur_var;
        Ref_data.(Fields_list{k})=cur_var;
      end
      save(save_dir, '-struct', 'Ref_data');
      %catch
      disp(['error 1 occuring for ' File_List{i}]);
      %end

      %---------------------
    end

  case 2

  for i=1:length(File_List)
    try
      cur_file=File_List{i};
      [pathstr,name,ext,versn] = fileparts(cur_file);
      save_dir=strcat(pathstr,name);
      save_dir=strcat(save_dir,'_AVERAGE_Ref.mat');
      cur_data=load(cur_file);
      Fields_list=fields(cur_data);
      %---------------------
      Ref_data=[];
      for k=1:length(Fields_list)
        cur_var=cur_data.(Fields_list{k});

        cur_ave=mean(cur_var);
        cur_var=cur_var-repmat(cur_ave,size(cur_var,1),1);
        Ref_data.(Fields_list{k})=cur_var;
      end
      save(save_dir, '-struct', 'Ref_data');

    catch
      disp(['error 2 occuring for ' File_List{i}]);
    end

    %---------------------
  end
  case 3
  for i=1:length(File_List)
    try
      cur_file=File_List{i};
      [pathstr,name,ext,versn] = fileparts(cur_file);
      save_dir=strcat(pathstr,name);
      save_dir=strcat(save_dir,'_CZ_Ref.mat');
      cur_data=load(cur_file);
      Fields_list=fields(cur_data);
      %---------------------
      Ref_data=[];
      for k=1:length(Fields_list)
        cur_var=cur_data.(Fields_list{k});

        %             cur_ave=mean(cur_var);
        cur_var=cur_var-repmat(cur_var(end,:),size(cur_var,1),1);
        Ref_data.(Fields_list{k})=cur_var;
      end
      save(save_dir, '-struct', 'Ref_data');
    catch
      disp(['error 3 occuring for ' File_List{i}]);
    end

    %---------------------
  end
  case 4
  for i=1:length(File_List)
    try
      cur_file=File_List{i};
      [pathstr,name,ext,versn] = fileparts(cur_file);
      save_dir=strcat(pathstr,name);
      save_dir=strcat(save_dir,'_LM_Ref.mat');
      cur_data=load(cur_file);
      Fields_list=fields(cur_data);
      %---------------------
      Ref_data=[];
      for k=1:length(Fields_list)
        cur_var=cur_data.(Fields_list{k});

        cur_ave=mean(cur_var([57,100],:));
        cur_var=cur_var-repmat(cur_ave(end,:),size(cur_var,1),1);
        Ref_data.(Fields_list{k})=cur_var;
      end
      save(save_dir, '-struct', 'Ref_data');
    catch
      disp(['error 4 occuring for ' File_List{i}]);
    end

    %---------------------
  end

  ;
end
