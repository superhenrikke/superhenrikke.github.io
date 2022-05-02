%%  FUCKING RENAME YOUR STIMS (variables) PROPERLY don't use "-" or "_" or mix the two,
% have a damn naming convention

%j = nirs.modules.RenameStims();
%j.listOfChanges =  {  'obj1' , 'RestingState' ;  'obj2' , 'EasyGame' ;  'obj3' , 'RampGame' ;  'obj4' , 'HardGame' ; }; %raw = j.run(raw);

%%

%sample = nirs.io.loadNIRx('C:\NIRx\Data\2021-03-10\2021-03-10_002')

%load('raw_no_stimuli.mat');

% Load sample recording to obtaion correct montage information 
folder3 = 'D:\tetris\2022-03-31_002'
raw_sample_recording= nirs.io.loadDirectory(folder3)

% Remove unnecessary demographic information 
raw_sample_recording.demographics = raw_sample_recording.demographics.remove('Age')
raw_sample_recording.demographics = raw_sample_recording.demographics.remove('Name')
raw_sample_recording.demographics = raw_sample_recording.demographics.remove('Gender')
raw_sample_recording.demographics = raw_sample_recording.demographics.remove('Contact_Information')
raw_sample_recording.demographics = raw_sample_recording.demographics.remove('Study_Type')
raw_sample_recording.demographics = raw_sample_recording.demographics.remove('Experiment_History')
raw_sample_recording.demographics = raw_sample_recording.demographics.remove('Additional_Notes')

%% Load data; Create dataset of all participants


fnirs_dir_list = {'../analysis/proccessed_data\\234\\234_fnirs.csv',
 '../analysis/proccessed_data\\235\\235_fnirs.csv',
 '../analysis/proccessed_data\\236\\236_fnirs.csv',
 '../analysis/proccessed_data\\237\\237_fnirs.csv',
 '../analysis/proccessed_data\\238\\238_fnirs.csv',
 '../analysis/proccessed_data\\239\\239_fnirs.csv',
 '../analysis/proccessed_data\\240\\240_fnirs.csv',
 '../analysis/proccessed_data\\241\\241_fnirs.csv',
 '../analysis/proccessed_data\\242\\242_fnirs.csv',
 '../analysis/proccessed_data\\243\\243_fnirs.csv',
 '../analysis/proccessed_data\\245\\245_fnirs.csv',
 '../analysis/proccessed_data\\246\\246_fnirs.csv',
 '../analysis/proccessed_data\\247\\247_fnirs.csv',
 '../analysis/proccessed_data\\248\\248_fnirs.csv',
 '../analysis/proccessed_data\\249\\249_fnirs.csv',
 '../analysis/proccessed_data\\250\\250_fnirs.csv',
 '../analysis/proccessed_data\\251\\251_fnirs.csv',
 '../analysis/proccessed_data\\252\\252_fnirs.csv',
 '../analysis/proccessed_data\\253\\253_fnirs.csv',
 '../analysis/proccessed_data\\254\\254_fnirs.csv',
 '../analysis/proccessed_data\\255\\255_fnirs.csv',
 '../analysis/proccessed_data\\256\\256_fnirs.csv',
 '../analysis/proccessed_data\\257\\257_fnirs.csv',
 '../analysis/proccessed_data\\258\\258_fnirs.csv',
 '../analysis/proccessed_data\\259\\259_fnirs.csv',
 '../analysis/proccessed_data\\261\\261_fnirs.csv',
 '../analysis/proccessed_data\\263\\263_fnirs.csv',
 '../analysis/proccessed_data\\266\\266_fnirs.csv',
 '../analysis/proccessed_data\\267\\267_fnirs.csv',
 '../analysis/proccessed_data\\268\\268_fnirs.csv'}

stim_dir_list = {'../analysis/proccessed_data\\234\\234_stimuli.csv',
 '../analysis/proccessed_data\\235\\235_stimuli.csv',
 '../analysis/proccessed_data\\236\\236_stimuli.csv',
 '../analysis/proccessed_data\\237\\237_stimuli.csv',
 '../analysis/proccessed_data\\238\\238_stimuli.csv',
 '../analysis/proccessed_data\\239\\239_stimuli.csv',
 '../analysis/proccessed_data\\240\\240_stimuli.csv',
 '../analysis/proccessed_data\\241\\241_stimuli.csv',
 '../analysis/proccessed_data\\242\\242_stimuli.csv',
 '../analysis/proccessed_data\\243\\243_stimuli.csv',
 '../analysis/proccessed_data\\245\\245_stimuli.csv',
 '../analysis/proccessed_data\\246\\246_stimuli.csv',
 '../analysis/proccessed_data\\247\\247_stimuli.csv',
 '../analysis/proccessed_data\\248\\248_stimuli.csv',
 '../analysis/proccessed_data\\249\\249_stimuli.csv',
 '../analysis/proccessed_data\\250\\250_stimuli.csv',
 '../analysis/proccessed_data\\251\\251_stimuli.csv',
 '../analysis/proccessed_data\\252\\252_stimuli.csv',
 '../analysis/proccessed_data\\253\\253_stimuli.csv',
 '../analysis/proccessed_data\\254\\254_stimuli.csv',
 '../analysis/proccessed_data\\255\\255_stimuli.csv',
 '../analysis/proccessed_data\\256\\256_stimuli.csv',
 '../analysis/proccessed_data\\257\\257_stimuli.csv',
 '../analysis/proccessed_data\\258\\258_stimuli.csv',
 '../analysis/proccessed_data\\259\\259_stimuli.csv',
 '../analysis/proccessed_data\\261\\261_stimuli.csv',
 '../analysis/proccessed_data\\263\\263_stimuli.csv',
 '../analysis/proccessed_data\\266\\266_stimuli.csv',
 '../analysis/proccessed_data\\267\\267_stimuli.csv',
 '../analysis/proccessed_data\\268\\268_stimuli.csv'}


raw_dataset = []
for i=1:1:length(fnirs_dir_list)
    fnirs_dir = fnirs_dir_list{i};
    stim_dir = stim_dir_list{i};

    % format data into a raw
    fnirs = importdata(fnirs_dir, ',');
    stimuli = importdata(stim_dir, ',');
    timestamp = fnirs.data(:,1);
    channels = fnirs.data(:,2:end);
    % raw = a sample recording
    raw = raw_sample_recording;
    raw.data = channels;
    raw.time = timestamp;
    raw.description = fnirs_dir;
    disp(fnirs_dir)
    
    % Add demographics
    newstr = split(fnirs_dir, '\\');
    participant_id = str2num(newstr{2});
    subject = newstr{2};
    raw.demographics('subject') = subject;
    raw.demographics('participant_id') = participant_id; % for string legg til firkantparates rundt tror jeg
    
    % Add stimuli
    % 1. alternative. 1 condition per tetris game, 4 conditions total 
%     T = create_table_4_stimuli(stimuli);
%     % Format condition names correctly
%     T.RestingState.name = T.RestingState.name{1,1};
%     T.EasyGame.name = T.EasyGame.name{1,1};
%     T.RampGame.name = T.RampGame.name{1,1};
%     T.HardGame.name = T.HardGame.name{1,1};

    % 2. alternative. 4 conditions per tetris game. 13 conditions total. 
    T = create_table_4_stimuli_per_tetris_game_2(stimuli);

    % Change stimuli 
    j = nirs.modules.ChangeStimulusInfo();
    j.ChangeTable = T;
    raw = j.run(raw);
  
    % append to raw dataset
    raw_dataset = [raw_dataset raw];
end

raw_dataset.draw()

raw = raw_dataset

%% Adding demographic information
j = nirs.modules.AddDemographics();
% This job contains a field (demoTable) that is used to populate the
% demographics.  This can be programatically or simply read from a CSV file
%
% In the demo data, we provide a CSV file with demographics info.
additional_demographics = 'D:\tetris\analysis\SPSS\demographics_pruned_for_fNIRS_mixed_model.csv'
j.demoTable = readtable(additional_demographics);% [root_dir filesep 'demo_data' filesep 'data' filesep 'demographics.csv'] );

% We are going to match the subject column in the above table
j.varToMatch = 'participant_id';  % Change this to participant id
% Note "subject" (or whatever you are matching based on) needs to be an
% entry in BOTH the CSV file and the nirs.core.<> class that you are
% loading the demographics to.  

% This is a job, so we need to run it like the others.  In this case, let's
% run the job on the SubjStats variable we just created.  We could, of
% course, have ran this job earlier on the raw data
raw = j.run(raw); %SubjStats);

% View demographics information by typing:
demographics = nirs.createDemographicsTable(raw);
disp(demographics);

% TODO: Add performance (i.e., tetris scores here too) Maybe, I don't know
% what I would do if I add performance. Figure that out first, then add if
% it is relevant.



%% draw test

figure

raw(1).probe.draw1020
figure;
raw(1).probe.defaultdrawfcn='3D mesh';  % now it will draw in 3D on the atlas head
%raw.probe.defaultdrawfcn='3D ball'; 
raw(1).probe.draw()



%% Preproccesing and first level stats
job = nirs.modules.default_modules.single_subject;

% you can see the whole pipeline by converting it to a list 
List=nirs.modules.pipelineToList(job);
disp(List);
% we can edit the List and convert back.  Here, let's lower the sample rate
% to make this run faster
% List{9}to view GLM
List{4}.Fs=1;  % change the sample rate of the Resample module
List{9}.verbose = true;
% note the GLM runs like O(n^2) so this will be ~100x faster to run but at the
% loss of statistical power (ok for this demo, but I usually run at 5Hz for real studies).
job = nirs.modules.listToPipeline(List);  % convert back to pipeline

SubjStats = job.run(raw)

Hb.draw()
    
%% not used atm
%t = timeit(job.run(raw))
% visual inspection
SubjStats(1).variables %this should show conditions + sd pair + hbo/hbr

SubjStats(1).draw('tstat', [-10 10], 'q <0.05') % q is p-value corrected. We should use this. Cite Benjamin-Hochberg (1995). 

%%
%% QA for Subject Level Stats

% generates a table with leverage for subj, condition & channel
groupLeverage = nirs.util.grouplevelleveragestats(SubjStats);


%TODO: Understand this, in particular which variable(s) to base
% exclusion criteria on
% https://en.wikipedia.org/wiki/Leverage_(statistics)

% Remove outlier subjects
j = nirs.modules.RemoveOutlierSubjects();
j.cutoff = 0.05; % 0.051; % Huppert: p-value cutoff (2 subjects almost exactly at p = 0.05, in original analysis
% with v 615 were removed at 0.05, current version set to 0.051 to exclude them)
GoodSubjs = j.run(SubjStats);
j.cite
%   file_idx    source    detector     type            cond          lev_unweighted    pval_unweighted    lev_weighted    pval_weighted    lev_condition    pval_condition    lev_subject    pval_subject
idx = find(groupLeverage.pval_subject < 0.022); 
disp(groupLeverage(idx, :)); 
%% Group Level mixed effects
job = nirs.modules.MixedEffects();
% This will run the "fitlme" function in Matlab.  This supports a range of
% models and allows random effects terms to be included.  However, this
% model can take a long time and use alot of memory for large models.  The
% FIR model has 18 conditions (8+10) x 70 channel for a total of 1260 elements

job.formula='beta ~ -1 + cond';  % using random effects will work, but will take a while to run
                                % let's use the fixed effects only modle
                                
 GroupStats=job.run(SubjStats);
%% 2-nd level (Group Stats) statistics
job = nirs.modules.MixedEffects();

% Here we must specify the encoding for categorical variables, such as
% group and condition.  Options are 'full', 'reference', 'effects'. 
% job.dummyCoding = 'full'  

job.formula = 'beta ~ -1 + cond + (1|subject)'; % Main effects of condition, controlling for subject. 

% (in final analysis) change defaults to: run robust stats, include diagnostics, and print
% what's happening while the model runs
job.robust = true;
job.include_diagnostics=true;
job.verbose = true;

% For ROI(Based on Example_Using_ROIs.m from toolbox)
% We also need to turn the "add_diagnotstics" flag to true.  This will run
% a few extra steps in the Mixed Effects model that will allow us to do
% scatter plots later on.


GroupStats = job.run(GoodSubjs);   % this took about 50s on my computer, but larger datasets could run into memory swap issues.
% This took approx 3 min. Henrikke. 

%% Vizualization of 2-nd level (Group Stats) stats
% Conditions relative to baseline (Beer-Lambert law baseline)
% Draw the probe using t-stat & false discovery rate (q value)
GroupStats.draw('tstat', [-5 5], 'q < 0.05')

% There was no sicgnificant activation from experimental baseline condition
% (RestingState)

%% ROI 
% Based on Example_Using_ROIs.m from toolbox

% If I detemine the sub-regions beforehand I think it's easiest to specify
% ROI's manually.
% Is it necessary to register the probe before defining ROI? I think not,
% since it's already known in this case. 

% Example 2:
% We can also use a registered probe object to define anatomica ROIs'

% First lets register the probe.  See the registration_demo.m for more
% details

% Is the probe from NIRSite already registered to the 10-20 space? I think
% it is on the ICM152-atlas. Perhaps not on Coling27?

probe = GroupStats.probe;
disp(probe.optodes_registered)
%           Name              X         Y          Z            Type         Units 
%  {'Source-0001'  }    -46.867    60.341      38.11    {'Source'    }    {'mm'}
%     {'Source-0002'  }    -52.021    83.925    -13.559    {'Source'    }    {'mm'}
%     {'Source-0003'  }    -31.302    86.942     21.101    {'Source'    }    {'mm'}
%     {'Source-0004'  }     6.1614    61.003     64.528    {'Source'    }    {'mm'}
%     {'Source-0005'  }      3.449    101.56    -2.1492    {'Source'    }    {'mm'}
%     {'Source-0006'  }     39.502    86.504     17.799    {'Source'    }    {'mm'}
%     {'Source-0007'  }     56.018    60.099     33.263    {'Source'    }    {'mm'}
%     {'Source-0008'  }     56.391    83.276    -18.384    {'Source'    }    {'mm'}
%     {'Detector-0001'}     -61.43    59.625     11.218    {'Detector'  }    {'mm'}
%     {'Detector-0002'}    -23.478    60.848     57.647    {'Detector'  }    {'mm'}
%     {'Detector-0003'}    -26.304    99.022    -7.6604    {'Detector'  }    {'mm'}
%     {'Detector-0004'}     5.0613    88.132     35.434    {'Detector'  }    {'mm'}
%     {'Detector-0005'}     34.782    60.708     54.829    {'Detector'  }    {'mm'}
%     {'Detector-0006'}      32.05     98.49    -10.281    {'Detector'  }    {'mm'}
%     {'Detector-0007'}     67.804    59.325     5.2723    {'Detector'  }    {'mm'}
%     {'F3'           }    -46.867    60.341      38.11    {'FID-anchor'}    {'mm'}
%     {'AF7'          }    -52.021    83.925    -13.559    {'FID-anchor'}    {'mm'}
%     {'AF3'          }    -31.302    86.942     21.101    {'FID-anchor'}    {'mm'}
%     {'Fz'           }     6.1614    61.003     64.528    {'FID-anchor'}    {'mm'}
%      {'Fpz'          }      3.449    101.56    -2.1492    {'FID-anchor'}    {'mm'}
%     {'AF4'          }     39.502    86.504     17.799    {'FID-anchor'}    {'mm'}
%     {'F4'           }     56.018    60.099     33.263    {'FID-anchor'}    {'mm'}
%     {'AF8'          }     56.391    83.276    -18.384    {'FID-anchor'}    {'mm'}
%     {'F5'           }     -61.43    59.625     11.218    {'FID-anchor'}    {'mm'}
%     {'F1'           }    -23.478    60.848     57.647    {'FID-anchor'}    {'mm'}
%     {'Fp1'          }    -26.304    99.022    -7.6604    {'FID-anchor'}    {'mm'}
%     {'AFz'          }     5.0613    88.132     35.434    {'FID-anchor'}    {'mm'}
%     {'F2'           }     34.782    60.708     54.829    {'FID-anchor'}    {'mm'}
%     {'Fp2'          }      32.05     98.49    -10.281    {'FID-anchor'}    {'mm'}
%     {'F6'           }     67.804    59.325     5.2723    {'FID-anchor'}    {'mm'}

Name{1}='FpZ';
xyz(1,:)=[0 -12 0];
Type{1}='FID-anchor';  % This is an anchor point
Units{1}='mm';

%Now let's add a few more
Name{2}='Cz';
xyz(2,:)=[0 100 0];
Type{2}='FID-attractor';  % This is an attractor
Units{2}='mm';

Name{3}='T7';
xyz(3,:)=[200 -12 0];
Type{3}='FID-attractor';  % This is an attractor
Units{3}='mm';

Name{4}='T8';
xyz(4,:)=[-200 -12 0];
Type{4}='FID-attractor';  % This is an attractor
Units{4}='mm';

% Attach the FID points to the probe
fid=table(Name',xyz(:,1),xyz(:,2),xyz(:,3),Type',Units',...
    'VariableNames',{'Name','X','Y','Z','Type','Units'});
% and concatinate it to the probe
probe.optodes=[probe.optodes; fid];

% try from here

% Use the default head size
probe1020=nirs.util.registerprobe1020(probe);

% You can also customize this to a particular head size
% You need three head measurements to fully do this
headsize=Dictionary();
headsize('lpa-cz-rpa')=327.0952;
headsize('Iz-cz-nas')=354.3530;

headsize('circumference')=525.3861;
probe1020=nirs.util.registerprobe1020(probe,headsize);

%  headcircum: 525.3861
%           AP_arclength: 354.3530
%           LR_arclength: 327.0952

% But, if you only have 1 or 2 of the 3, it will try to keep the ratios the
% same and rescale
headsize=Dictionary();
headsize('circumference')=523;
probe1020=nirs.util.registerprobe1020(probe,headsize);



% we can view the probe on the 10-20 topo map
probe1020.draw1020;
% And we should see the probe aligned on the forehead.

% Again, refering to registation_demo.m for more details, we can define a
% ROI using this probe

ROI = nirs.util.convertlabels2roi(probe1020);
% We can see that this will create a ROI table with weights and names
% defined by the regions under the probe.

%    source    detector      weight               Name         
%     ______    ________    __________    ______________________
%     1         1             0.018668    'ba-10_l'             
%     2         1             0.084318    'ba-10_l'             
%     2         2               0.2581    'ba-10_l'             
%     3         2              0.15838    'ba-10_l'             
%     3         3              0.12176    'ba-10_l'             
%     4         3              0.11416    'ba-10_l'             
%     4         4              0.10007    'ba-10_l'             
%     5         4             0.078336    'ba-10_l'             
%     5         5             0.044835    'ba-10_l'             
%     6         5              0.01539    'ba-10_l'             
%     6         6            0.0045255    'ba-10_l'             
%     7         6            0.0011195    'ba-10_l'             

% This is quite large and we can see that these are the regions.
disp(unique(ROI.Name));
%     'ba-10_l'
%     'ba-10_r'
%     'ba-45_l'
%     'ba-46_l'
%     'ba-46_r'
%     'frontal_inf_tri_l'
%     'frontal_mid_l'
%     'frontal_mid_r'
%     'frontal_sup_l'
%     'frontal_sup_medial_l'
%     'frontal_sup_medial_r'
%     'frontal_sup_r'
% BA-9_L                 
% BA-10_L  
nirs.util.depthmap('BA-9',probe1020);

nirs.util.depthmap('BA-10_L',probe1020);

nirs.util.depthmap('BA-10',probe1020);
nirs.util.depthmap('ba-47',probe1020);

% We could use the table as is:
result=nirs.util.roiAverage(GroupStats,ROI);
%             ROI                Contrast      Beta          SE       DF        T            p               model              q     
%     __________________________    ________    _________    ________    ___    ________    __________    _________________    __________
% 
%     'ba-10_l:hbo'                 'A'           0.94258     0.17894    478      5.2675    2.0952e-07    [1x1 LinearModel]    1.0057e-06
%     'ba-10_r:hbo'                 'A'           0.11378     0.17982    478     0.63274       0.52721    [1x1 LinearModel]       0.55013
%     'ba-45_l:hbo'                 'A'           0.89556     0.15684    478      5.7099    1.9876e-08    [1x1 LinearModel]      1.59e-07
%     'ba-46_l:hbo'                 'A'            1.0876       0.163    478      6.6719    7.0043e-11    [1x1 LinearModel]    1.1207e-09
%     'ba-46_r:hbo'                 'A'           0.20341     0.18057    478      1.1265       0.26052    [1x1 LinearModel]       0.29081
%     'frontal_inf_tri_l:hbo'       'A'           0.86365     0.15628    478      5.5263    5.3847e-08    [1x1 LinearModel]    3.6924e-07
%     'frontal_mid_l:hbo'           'A'            1.1471     0.16159    478      7.0985    4.5866e-12    [1x1 LinearModel]    2.2016e-10
%     'frontal_mid_r:hbo'           'A'            0.2088     0.18093    478      1.1541       0.24906    [1x1 LinearModel]       0.28464
%     'frontal_sup_l:hbo'           'A'            0.9514     0.18454    478      5.1554    3.7113e-07    [1x1 LinearModel]    1.6195e-06
%     'frontal_sup_medial_l:hbo'    'A'           0.63853     0.19881    478      3.2117     0.0014084    [1x1 LinearModel]     0.0023311
%     'frontal_sup_medial_r:hbo'    'A'          0.035383     0.18348    478     0.19284       0.84717    [1x1 LinearModel]       0.86519
%     'frontal_sup_r:hbo'           'A'          0.015191     0.17824    478    0.085229       0.93212    [1x1 LinearModel]       0.93212

% We can also just request one ROI

ROI = nirs.util.convertlabels2roi(probe1020,'BA-10_L');
% or two etc
ROI = nirs.util.convertlabels2roi(probe1020,{'BA-10_L','BA-10_R'});




% Example 1-  Specify ROI's manually
source=  [1 2 2 3]';  % This will give the average of S1-D1,S2-D1,S2-D2, and S3-D2
detector=[1 1 2 2]';
ROI=table(source,detector);

result=nirs.util.roiAverage(GroupStats,ROI);
% 
%   ROI      Contrast      Beta          SE       DF        T            p               model              q    
%     _______    ________    _________    ________    ___    ________    __________    _________________    _________
%     '1:hbo'    'A'             1.137     0.32477    118      3.5008    0.00065552    [1x1 LinearModel]    0.0026221
%     '1:hbr'    'A'          -0.36919     0.17193    118     -2.1473      0.033812    [1x1 LinearModel]     0.045083
%     '1:hbo'    'A:age'      -0.27593     0.11705    118     -2.3574       0.02005    [1x1 LinearModel]     0.040101
%     '1:hbr'    'A:age'     -0.029537    0.061006    118    -0.48417       0.62916    [1x1 LinearModel]      0.62916

% default name of the ROI will be "1" because we only gave it one ROI in
% this case, but you can specificy the name using 

result=nirs.util.roiAverage(GroupStats,ROI,'myROI');
%      ROI        Contrast      Beta          SE       DF        T            p               model              q    
%     ___________    ________    _________    ________    ___    ________    __________    _________________    _________
%     'myROI:hbo'    'A'             1.137     0.32477    118      3.5008    0.00065552    [1x1 LinearModel]    0.0026221
%     'myROI:hbr'    'A'          -0.36919     0.17193    118     -2.1473      0.033812    [1x1 LinearModel]     0.045083
%     'myROI:hbo'    'A:age'      -0.27593     0.11705    118     -2.3574       0.02005    [1x1 LinearModel]     0.040101
%     'myROI:hbr'    'A:age'     -0.029537    0.061006    118    -0.48417       0.62916    [1x1 LinearModel]      0.62916
% 

% We can also use NaN for wildcards in either the source and/or detector
source=  [NaN NaN]';     % This will give the average of Any source to detector 1 and Any source to Det 2
detector=[1 2]';
ROI=table(source,detector);

% We can also add a column called weight.  This will result in a
% non-uniform weighting of the channels.

ROI.weight=[1 2]';

%  source    detector    weight
%     ______    ________    ______
% 
%     NaN       1           1      <-- All sources connected to Det-1 will be weighted by 1/3 
%     NaN       2           2      <-- All sources connected to Det-1 will be weighted by 2/3

result=nirs.util.roiAverage(GroupStats,ROI,'test')



%% contrasts
%Look at the conditions
GroupStats.conditions

% Next, specify a contrast vector
c = [0 1 0 -1]; % hard - resting state
% This means we want to contrast the 2nd (Y:group1) and 4th (Y:group1)
% conditions.  

% or we can specify a bunch of contrasts:
c = [eye(5);  % all 5 of the original variables
    0 1 0 -1 0; % X - Y for group 1
    0 0 1 0 -1; % X - Y for group 2
    0 1 -1 0 0; % G1 - G2 for X
    0 0 0 1 -1]; % G1 - G2 for Y

% Hypotheses:
% Ramp4 >Ramp3 > Ramp2 > Ramp1
% Hard1 = Hard2 = Hard3 = Hard4
% Easy1 = Easy2 = Easy3 = Easy4
% Easy(i) < Hard(i) (easygame yields less activation for all combinations)
% Then I expect some threshold to be present in ramp, which if above it,
% easy will yield lower activation compared to hard
% e.g., Ramp4, Ramp3 > Easy(i), Ramp2 = Easy(i), Ramp1 < Easy(i)
% e.g., Ramp1, Ramp2, Ramp3 < Hard(i), Ramp4 >= Hard(i)

% contasts
c = { 'RampGame4-RampGame3', 'RampGame3-RampGame2', 'RampGame2-RampGame1'} 
%'RampGame4-RampGame2', 

c = { 'HardGame4-EasyGame4', 'HardGame4-EasyGame3','HardGame4-EasyGame2', 'HardGame4-EasyGame1',
    'HardGame3-EasyGame4', 'HardGame3-EasyGame3','HardGame3-EasyGame2', 'HardGame3-EasyGame1', 
    'HardGame2-EasyGame4', 'HardGame2-EasyGame3','HardGame2-EasyGame2', 'HardGame2-EasyGame1', 
    'HardGame1-EasyGame4', 'HardGame1-EasyGame3','HardGame1-EasyGame2', 'HardGame1-EasyGame1'}

% OR 
% c ={'HardGame-EasyGame', 'HardGame-RampGame', 'RampGame-EasyGame'}
c2 = { 'HardGame-RestingState', 'EasyGame-RestingState','RampGame-RestingState'}

c = { 'HardGame1-RestingState', 'HardGame2-RestingState','HardGame3-RestingState','HardGame4-RestingState'}

c = { 'HardGame4-EasyGame4', 'HardGame4-EasyGame3','HardGame4-EasyGame2', 'HardGame4-EasyGame1'}

c = { 'RampGame4-RampGame1', 'RampGame4-RampGame2', 'RampGame2-RampGame1', 'RampGame4-RampGame3'} %, 'HardGame2-RestingState','HardGame3-RestingState','HardGame4-RestingState'}
c = {'RampGame2-RampGame1'}

% Calculate stats with the ttest function
ContrastStats = GroupStats.ttest(c);

ContrastStats.table


idx = find(ContrastStats.q < 0.05); 
SignificantContrastStats = ContrastStats.table; 
SignificantContrastStats = SignificantContrastStats(idx, :); 
disp(SignificantContrastStats);

ContrastStats.draw('tstat',[-10 10],'q<0.05')
ContrastStats.draw('tstat',[],'q<0.05')
close all;

GroupStats.draw('tstat',[-10 10],'q<0.05')

%% an example of how to filter a table
head(GroupStats.variables)
GroupStats.variables.cond = 'hand_Right'

T = GroupStats.table()

groupHandedness = strcmpi(GroupStats.variables.cond , 'hand_Right')
groupHandednessT = T(groupHandedness, :)

idx = find(T(groupHandedness, :).q < 0.05); 
siggroupHandednessT = groupHandednessT(idx, :);
disp(siggroupHandednessT)
% Holy shit there was a significant main effect of handedness on activation
% 

%SignificantContrastStats = ContrastStats.table; 
SignificantContrastStats = ContrastStats.table(idx, :); 
disp(SignificantContrastStats);

% 'hand_Right'     
%% Save output
close all;
% Save the figures 
dir = '\\fil.nice.ntnu.no\nice\p455\analysis'
figs_folder = [dir, '\figures']; % need to make this folder if it doesn't already exist
ContrastStats.printAll('tstat', [], 'q < 0.05', figs_folder, 'tif')
%GroupStats.printAll('tstat', [], 'q < 0.05', figs_folder, 'tif')

% save the stats tables
stats_folder = [dir, '\statistics']; % need to make this folder if it doesn't already exist
%writetable(GroupStats.table(),[stats_folder files  ep 'GroupStats128.csv'])
writetable(ContrastStats.table(), [stats_folder, '\2021-12-02-ContrastStats.csv'])
writetable(SignificantContrastStats, [stats_folder, '\2021-12-02-SignificantContrastStats.csv'])

%% cite articles
job.cite