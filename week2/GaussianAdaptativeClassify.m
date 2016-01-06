function [mean_dataset, sd_dataset,background] = GaussianAdaptativeClassify (inputFolder,dirList,j,gaussianColor,sd_dataset,mean_dataset,alpha,p,WriteResults,datasetName)
   %Classify for the Recursive Gaussian modeling for background substraction

   img = imread(strcat(inputFolder,dirList(j).name));
   if ~gaussianColor 
       img = rgb2gray(img);
   end 
       
   background = (abs(img-mean_dataset)) >= (alpha*(sd_dataset+2));
 
   img_back=uint8(background).*img;
   
    mean_dataset = p*img_back+(1-p)*mean_dataset;
    sd_dataset = sqrt(double(p*(img_back-mean_dataset).^2)+double((1-p)*sd_dataset.^2));
   
   if(WriteResults)
       imwrite(background,strcat('./results/recursive/backgroundMask/',datasetName,'/',num2str(j),'_alpha_',num2str(alpha),'_p_',num2str(p),'.png'));
   end
   background=uint8(background).*255;
end