% Cem Güleç - 150117828

function PSNR = problem3()
    
    % step 1 
    % importing original image and converting it from 'uint8' type to 'double' type
    % input  : original.jpg (359x479)
    % output : original.jpg with type 'double' (359x479)
    base_img = imread('C:\Users\Cem\Documents\GitHub\Multimedia-Workspace\HW1\original.jpg');
    original_img = im2double(base_img);
    
    
    % step 2: defining variables and filters
    MSE = 0;
    MAXl = 255;
    [N1, N2] = size(original_img);
    lowpass_filter = [1/9 1/9 1/9;...
                      1/9 1/9 1/9;...
                      1/9 1/9 1/9];
                  
    convolve_filter = [0.25 0.5 0.25;...
                       0.5  1   0.5 ;...
                       0.25 0.5 0.25];
    
    % low-pass filtering the original image
    % output : filtered image (359x479)
    filtered_img = imfilter(original_img, lowpass_filter, 'replicate');

    
    % step 3: Obtaining the down-sampled image
    % In order to do this, removing the 2nd, 4th, all the way to the 358th row
    % Also removing the 2nd, 4th, all the way to the 478th column
    % input  : filtered image (359x479)
    % output : down sampled image (180x240)
    filtered_img(2:2:end, :) = [];
    filtered_img(:, 2:2:end) = [];
    downsampled_img = filtered_img(:,:);
    
    
    % step 4: Applying spatial domain processing
    % This step, up-samples this low resolution 
    % image to the original resolution
    % input  : down sampled image (180x240)
    % output : spatial domain applied image (359x479)
    zero_inserted_img = zeros(size(original_img));
    
    for i = 1:N1
        for j = 1:N2
            if((mod(i,2) == 1) && (mod(j,2) == 1))
                x = cast((i+1)/2, 'uint8');
                y = cast((j+1)/2, 'uint8');
                zero_inserted_img(i,j) = downsampled_img(x, y);
            end
        end
    end
    
   
    % step 5: Convolution application to have the up-sampled image
    % input  : spatial domain applied image (359x479) 
    % output : up sampled image (359x479)
    upsampled_img = imfilter(zero_inserted_img, convolve_filter);
    
    
    % step 6: computing MSE and then PSNR values
    % Here, every corresponding index is multiplied by 255
    % in order to convert it into 'int' type
    for i = 1:N1
         for j= 1:N2
             MSE = MSE + (upsampled_img(i,j).*255 - original_img(i,j).*255).^2;
         end
     end
     
     MSE = MSE/(N1*N2);
     
     PSNR = 10 * log10(MAXl^2 / MSE);

    fprintf('PSNR value= %.3f\n', PSNR);
end