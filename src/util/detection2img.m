function img = detection2img( img, poses )
% Renders detections in Matlab
renderThreshold = 0.05;
%   Detailed explanation goes here
for iPose = 1:size(poses,1)
    pose = poses(iPose,:);
    %         % draw circles
    %         for iPart = 1:18
    %             hold on;
    %             plot(1920*pose(3*iPart-2), 1080*pose(3*iPart-1));
    %         end
    
    % draw lines
    for iPair = 1:length(POSE_COCO_PAIRS)/2

        
        hold on;
        pt1 = [size(img,2)*pose(3*POSE_COCO_PAIRS(2*iPair-1) - 2), size(img,1)*pose(3*POSE_COCO_PAIRS(2*iPair-1) - 1)];
        pt2 = [size(img,2)*pose(3*POSE_COCO_PAIRS(2*iPair) - 2),   size(img,1)*pose(3*POSE_COCO_PAIRS(2*iPair) - 1)];
        color = POSE_COCO_COLORS_RENDER_GPU(mod(iPair-1,18)+1,:);
%         img = cv.line(img, pt1, pt2, 'Thickness', 2, 'Color', color);
        minx = max(1, floor(min(pt1(1),pt2(1))));
        miny = max(1, floor(min(pt1(2),pt2(2))));
        maxx = min(1920, ceil(max(pt1(1),pt2(1))));
        maxy = min(1080, ceil(max(pt1(2),pt2(2))));
        subimg = img(miny:maxy,minx:maxx,:);
        subimg = cv.line(subimg, pt1 - [minx, miny], pt2-[minx, miny], 'Thickness', 2, 'Color', color);
        img(miny:maxy,minx:maxx,:) = subimg;
    end
    
end

end

