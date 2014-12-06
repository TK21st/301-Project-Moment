function MomentofInertiaMethod(Image,Template)
tic;
disp('Running...'); % Message sent to command window.
workspace % Show panel with all the variables.

Image = imread(Image);%Image is RGB
bImage = im2bw(Image,0.8);%bImage is binary(Logic Array)
bImage= imfill(bImage, 'holes');
Template = imread(Template);
bTemplate = im2bw(Template,0.8);%turn image to BW
bTemplate= imfill(bTemplate, 'holes');%fill any potential background holes

subplot(3,3,1);
imagesc(Image);
    
ImageProp=regionprops(bImage,'Centroid');
ImageCentroid=ImageProp(1).Centroid;

CC=bwconncomp(bImage);
PixelIndices=CC.PixelldxList;%has NumberofObjects number of vectors
NumberofObjects=CC.NumObjects;

boundaries = bwboundaries(bImage);	

nItemplate=MomentofInertia(Template);
nIImage=MomentofInertia(Image);

boundaries = bwboundaries(bTemplate);	
subplot(3,3,2); imshow(Template);

hold on
plot(boundaries{1}(:,2),boundaries{1}(:,1), 'g', 'LineWidth', 3);
hold off


toc;
return
function nMomentOfInertia=MomentofInertia(PixelIndices,TemplateCentroid,Pic)
length=size(PixelIndices);
rows=size(Pic,2);
MomentOfInertia=0;%I
for i=1:length
    R=mod(PixelIndices(i),rows);%Row Index
    C=ceil(PixelIndices(i)/rows);%Column Index
    MomentOfInertia=((R-TemplateCentroid(1))^2+(C-TemplateCentroid(2))^2)+MomentOfInertia;
end
nMomentOfInertia=MomentOfInertia/(length^2);
return