# Multi-Camera Overlap Tracking  

[DeepCC](https://github.com/SamvitJ/Duke-DeepCC)

[Guan's doc](https://hackmd.io/@ap87P5fsRy-EPWKAC7uQsA/S1oqH5BGS?fbclid=IwAR3KI0dc908wKxD2o7qXd_8I8D7UWyqydWAQY9gTi698yCrVt9YYBDJlwYg)

## For Tracking Stage(in matlab)  

1. Run ```compile``` to obtain mex files for the solvers and helper functions.

2. Get the parameter and create the result folder

```matlab=
player = 1;
track= 1;
opts = get_opts(player, track);
create_experiment_dir(opts);
```

3. Compute feature

```matlab=
compute_L0_features(opts);
```

4. Tracklet 

```matlab=
compute_L1_tracklets3D(opts);
```

5. Trajectory computation & Trajectory reconnection

```matlab=
compute_L2_trajectories3D(opts);
```

6. Evaluate the result openp

```matlab=
opts.eval_dir = 'L2-trajectories';
fix_gt;
% to ensure the video ground truth's time are correctly.
[allMets, metsBenchmark, metsMultiCam] = my_evaluate(opts);
% run the single camera evaluation
[TP, FN, FP, IDSW MOTA] =     gt_demo(opts);
% run the multi-camera evaluation

```