function Task1( params )
%TASK1 Implementation of TASK 1

%Video file reader - Read Input
train = vision.VideoFileReader(params.videoTraining);
reader = vision.VideoFileReader(params.videoInput);

%Stauffer, C. and Grimson - Background substraction
detector = vision.ForegroundDetector('NumGaussians', params.nGaussians, ...
            'NumTrainingFrames', params.nTrainingFrames, 'MinimumBackgroundRatio', params.minBackgroundRatio,'LearningRate',params.learningRate);
%Blob detector
blobAnalyser = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
            'AreaOutputPort', true, 'CentroidOutputPort', true, ...
            'MinimumBlobArea', params.minimumBlobArea,'Connectivity', 4);
%Structure for track analysis
tracks = struct(...
            'id', {}, ...
            'bbox', {}, ...
            'kalmanFilter', {}, ...
            'age', {}, ...
            'totalVisibleCount', {}, ...
            'consecutiveInvisibleCount', {});
% ID of the next track
nextId = 1; 

% Write Output
v = VideoWriter(strcat(strrep(params.videoInput,'input','output')));
v.FrameRate = 15;
open(v);
i=0;
while ~isDone(train)
    %1.Actual frame
    frame = train.step();
    
    if (params.config)
        frame = rgb2hsv(double(frame));
    else
        frame = (double(frame));
    end
    %2.Substraction
    mask = detector.step(frame);
    i=i+1;
    if (i==200)
        break
    end
end
i
while ~isDone(reader)
    
    %1.Actual frame
    frame = reader.step();
    mask2 = (frame(:,:,1) <= 0.09);
    rgbFrame = frame;
    if (params.config)
        frame = rgb2hsv(double(frame));
    else
        frame = (double(frame));
    end
    %2.Substraction
    mask = detector.step(frame);
    
    
    %3.Remove noise
    if (params.config)
        mask = logical(mask .* not(mask2));
        mask = medfilt2(mask);
        mask = bwareaopen(mask, params.areaOpen,4);
        mask = imdilate(mask, strel('disk', 3));
        mask = imfill(mask, 'holes');
    else
          se = strel('square', 4);
          mask = medfilt2(mask,[7 7]);
          mask = bwareaopen(mask, params.areaOpen,4);
%          mask = imdilate(mask, strel('disk', 3));
          mask = imfill(mask, 'holes');
          %mask = imopen(mask, se);
    end
    %4.Get the actual blobs
    [~, centroids, bboxes] = blobAnalyser.step(mask);
%     toRemove = zeros(1,size(bboxes,1));
%     for t=1:size(bboxes,1)
%         for p=t:size(bboxes,1)
%             if (t~=p && bboxOverlapRatio(bboxes(t,:),bboxes(p,:)) >= 0.1)
%                 bboxOverlapRatio(bboxes(t,:),bboxes(p,:));
%                 toRemove(p) = 1;
%             end
%         end
%     end
    
%     for t=1:size(bboxes,1)
%         if (toRemove(t))
%             bboxes(p,:) = [];
%             centroids(p,:) = [];
%         end
%     end
    %5.Predict the Location of the actual tracks
    [tracks] = Kalman_predictNewLocationsOfTracks(tracks);
    [assignments, unassignedTracks, unassignedDetections] = Kalman_detectionToTrackAssignment(tracks,centroids);
    [tracks] = Kalman_updateAssignedTracks(assignments,tracks,centroids,bboxes);
    [tracks] = Kalman_updateUnassignedTracks(tracks,unassignedTracks);
    [tracks] = Kalman_deleteLostTracks(tracks);
    [tracks,nextId] = Kalman_createNewTracks(centroids,bboxes,tracks,unassignedDetections,nextId);
    
    if ~isempty(bboxes)
        mask = uint8(repmat(mask, [1, 1, 3])) .* 255;
        %Compute labels
        labels = [];
        for j = 1:size(bboxes,1)
            labels = [labels tracks(j).id];
        end
        rgbFrame = insertObjectAnnotation(rgbFrame, 'rectangle',bboxes, labels);
    end
    writeVideo(v,rgbFrame);
    subplot(1,2,1), imshow(rgbFrame,[]);
    subplot(1,2,2), imshow(mask,[])
    %imshow(rgbFrame,[]);
    pause(0.001);
end

close(v);


        
end

