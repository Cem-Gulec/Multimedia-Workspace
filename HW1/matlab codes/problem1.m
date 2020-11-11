% Cem Güleç - 150117828 

function PSNR = problem1()

    % step 1 and step 2
    % importing original image and converting it from 'uint8' type to 'double' type
    % input  : Lena.gif (256x256)
    % output : Lena.gif with type 'double' (256x256)
    base_img = imread('C:\Users\Cem\Documents\GitHub\Multimedia-Workspace\HW1\Lena.gif');
    original_img = im2double(base_img);
    
    
    % step 3: defining variables and filter
    MSE=0;
    MAXl = 255;
    [N1, N2] = size(original_img);
    lowpass_filter = [1/9 1/9 1/9;...
                      1/9 1/9 1/9;...
                      1/9 1/9 1/9];
    
                  
    % step 4: low-pass filtering the original image
    % input  : original image in 'double' type
    % output : filtered image (256x256)
    filtered_img = imfilter(original_img, lowpass_filter, 'replicate');
    
    
    % step 5: computing MSE and then PSNR values
    % Here, every corresponding index is multiplied by 255
    % in order to convert it into 'int' type
     for i = 1:N1
         for j= 1:N2
             MSE = MSE + (original_img(i,j).*255 - filtered_img(i,j).*255).^2;
         end
     end
           
     MSE = MSE/(N1*N2);
          
     PSNR = 10 * log10(MAXl^2 / MSE);
        
     fprintf('PSNR value= %.3f\n', PSNR);
end