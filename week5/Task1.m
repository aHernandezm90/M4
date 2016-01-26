function [ output_args ] = Task1( params )
%TASK1 Implementation of TASK 1

%Video file reader - Read Input
reader = vision.VideoFileReader(params.videoInput);

%Stauffer, C. and Grimson - Background substraction
detector = vision.ForegroundDetector('NumGaussians', 3, ...
            'NumTrainingFrames', 50, 'MinimumBackgroundRatio', 0.5,'LearningRate',0.008);
%Blob detector
blobAnalyser = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
            'AreaOutputPort', true, 'CentroidOutputPort', true, ...
            'MinimumBlobArea', 400);
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

%Initialize iteration counter
itCounter = 0;

while ~isDone(reader)
    %Refresh iteration counter
    itCounter = itCounter + 1;
    
    %1.Actual frame
    frame = reader.step();
    
    %2.Substraction
    mask = detector.step(frame);
    
    %3.Remove noise
    mask = bwareaopen(mask, 300);
    mask = imclose(mask, strel('disk', 3));
    
    %4.Get the actual blobs
    [~, centroids, bboxes] = blobAnalyser.step(mask);
    
    %5.Predict the Location of the actual tracks
    [tracks] = Kalman_predictNewLocationsOfTracks(tracks);
    [assignments, unassignedTracks, unassignedDetections] = Kalman_detectionToTrackAssignment(tracks,centroids);
    Kalman_updateAssignedTracks(assignments,tracks,centroids,bboxes)
    Kalman_updateUnassignedTracks(tracks,unassignedTracks);
    Kalman_deleteLostTracks(tracks);
    Kalman_createNewTracks(centroids,bboxes,tracks,unassignedDetections,nextId);
    
    if ~isempty(bboxes)
        mask = uint8(repmat(mask, [1, 1, 3])) .* 255;
        %Compute velocity
        %From previous calculation, we know that each pixel corresponds to
        %0,1250m and between each frame and the time lapse between frames 
        %is 0,0330s
%         lengthLapse = 0.1250;
%         timeLpase = 0.0330;
        
        %Compute labels
        mask = insertObjectAnnotation(mask, 'rectangle',bboxes, unassignedDetections);
        imshow(mask,[]);
        pause(0.001);
    end
end


        
end

