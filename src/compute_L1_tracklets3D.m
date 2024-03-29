function compute_L1_tracklets3D(opts)
pose = 'alpha_pose';
%pose = 'openpose';
%pose = 'detections';
% get features from camera1~camera4
opts.current_camera = 1;

sequence_window   = opts.sequence_intervals{opts.sequence};
% -- because my detection had already global to local, so we don't need
start_frame = sequence_window(1);
end_frame = sequence_window(end);

for iCam = 1:opts.num_cam
    filename = sprintf('%s/%s/L0-features/features%d.mat',opts.experiment_root,opts.experiment_name,iCam)
    %filename = sprintf('D:/Code/MultiCamOverlap/experiments_alpha/%s/L0-features/features%d.mat',opts.experiment_name,iCam)
    features_temp   = load(filename);
    detections_temp = load(fullfile(opts.dataset_path, pose, opts.experiment_name, sprintf('cam%d.mat',iCam)));
    data{iCam,1} = double(features_temp.features');
    data{iCam,2} = detections_temp.detections;
end
clear detections_temp features_temp iCam

% -- detections = [frame, x, y, cam1, cam2, cam3, cam4]
load(fullfile(opts.dataset_path, pose, opts.experiment_name, sprintf('camera_all.mat')));
%load(fullfile(opts.dataset_path, pose, opts.experiment_name, sprintf('camera_cluater3.mat')));

% -- new method to filter bad lonely detection
detections_filter = detections;
% -1 number
detections_filter(:, 8) = sum(detections_filter(:, [4:7]) == -1, 2);
filter_num = [];
for i = 1:length(detections_filter)
    detections_filter(i, 9) = sum(detections_filter(:, 1) == detections_filter(i, 1));
    if detections_filter(i, 8) ==3
        filter_num = [filter_num; i];
    end
end
detections_filter(filter_num, :) = [];
detections_filter(:, [8 9]) = [];
detections = detections_filter;

%filename_save = fullfile(opts.dataset_path, pose, opts.experiment_name, sprintf('camera_all2.mat'));
%save(filename_save,'detections');


all_dets   = detections;
frames     = cell(size(all_dets,1),1);

% frame: detection's frame
% appearance: [1120 x 4] matrix, 
% [1,1] is frame[1] in camera 1's feature
% [6,4] is frame[6] in camera 4's feature
for k = 1:size(all_dets,1)
    frames{k} = detections(k, 1);
    for iCam = 1:opts.num_cam
        appearance{k, iCam} = [];
        if detections(k, 3+iCam) ~= -1
            appearance{k, iCam} = data{iCam, 1}(detections(k, 3+iCam), :);
        end
    end
end

tracklets = struct([]);

% start to tracking tracklet
for window_start_frame   = start_frame : opts.tracklets.window_width : end_frame
     %window_start_frame = window_start_frame + opts.tracklets.window_width;
    fprintf('%d/%d\n', window_start_frame, end_frame);

    % Retrieve detections in current window
    window_end_frame     = window_start_frame + opts.tracklets.window_width - 1;
    window_frames        = window_start_frame : window_end_frame;
     % find all_dets's frame is the same in window_frame and return index 
    window_inds          = find(ismember(all_dets(:, 1),window_frames));

    % Use only valid detections
    detections_in_window = all_dets(window_inds,:);
    valid  = ones(size(detections_in_window,1),1);
    filteredDetections = detections_in_window;
    filteredFeatures = [];
    filteredFeatures.appearance = appearance(window_inds, :);

    tracklets = createTracklets3D(opts, filteredDetections, filteredFeatures, window_start_frame, window_end_frame, tracklets, data);

end


% Save tracklets
% -- tracklets info from 'smoothTracklet.m'
save(sprintf('%s/%s/L1-tracklets/tracklets_%s.mat', ...
    opts.experiment_root, ...
    opts.experiment_name, ...
    opts.sequence_names{opts.sequence}), ...
    'tracklets');

% Clean up
clear all_dets appearance detections features frames

    
end