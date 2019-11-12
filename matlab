#read images
img = imread('filename.png')

#resize (enlarge) the the MSI max. int. image to have te same pix/distance as the FISH image to avoid loss of information
#(pixel size MSI x pixel number MSI)/(pixel size FISH)

resMSI = imresize(MSI,scale)
#or
resMSI = imresize(MSI,[numrows numcols])

#define which image (movingpoints) is aligned to the template (fixedpoints)
fixedPoints = resMSI;
movingPoints = FISH;

#open function to select registration landmarks
cpselect(movingPoints,fixedPoints)

#calculate registration vector with desired registration type and receive movingPoints1/fixedPoints1
tform = fitgeotrans(movingPoints1,fixedPoints1,'registrationtype') #affine, similarity


#apply registration vector to "warp" image
Jregistered = imwarp("FISH image",tform,'OutputView',imref2d(size("resizedMSI")))


#create and display false color overlay to check registration
falsecolorOverlay = imfuse("resizedMSI",Jregistered)
imshow(falsecoloroverlay)

#export image
imwrite (Jregistered, 'pout2.png')

#extract color channels
img = imread('filename.png'); % Read image
red = img(:,:,1); % Red channel
green = img(:,:,2); % Green channel
blue = img(:,:,3); % Blue channel
a = zeros(size(img, 1), size(img, 2));
just_red = cat(3, red, a, a);
just_green = cat(3, a, green, a);
just_blue = cat(3, a, a, blue);
back_to_original_img = cat(3, red, green, blue);
figure, imshow(img), title('Original image')
figure, imshow(just_red), title('Red channel')
figure, imshow(just_green), title('Green channel')
figure, imshow(just_blue), title('Blue channel')
figure, imshow(back_to_original_img), title('Back to original image')


#Extract xy coordinates and greyvalues from processed microscopy image
[x,y]=meshgrid(1:size(A,1), 1:size(A,2));
result=[x(:),y(:),A(:)]
