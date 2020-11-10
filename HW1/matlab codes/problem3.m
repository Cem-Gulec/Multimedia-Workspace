function result = problem3()
    
    % step 1
    % importing original image and converting
    % it from 'uint8' type to 'double' type
    base_img = imread('C:\Users\Cem\Documents\GitHub\Multimedia-Workspace\HW1\original.jpg');
    original_img = im2double(base_img);
    
    imshow(original_img, []);
    
    % step 2
    % defining variables
    MSE = 0;
    MAXl = 255;
    [N1, N2] = size(original_img);
    lowpass_filter = [1/9 1/9 1/9;...
                      1/9 1/9 1/9;...
                      1/9 1/9 1/9];
                  
    convolve_filter = [0.25 0.5 0.25;...
                       0.5  1   0.5 ;...
                       0.25 0.5 0.25];
    
    % filtering
    filtered_img = imfilter(original_img, lowpass_filter, 'replicate');
    imshow(filtered_img, []);
    
    % step 3
    % removing rows and columns
    % removing the 2nd, 4th, all the way to the 358th row
    filtered_img(2:2:end, :) = [];
    filtered_img(:, 2:2:end) = [];
    
    
    % step 4
    zero_inserted_img = zeros(size(original_img));
    
    for i = 1:N1
        for j = 1:N2
            if((mod(i,2) == 1) && (mod(j,2) == 1))
                x = cast((i+1)/2, 'uint8');
                y = cast((j+1)/2, 'uint8');
                zero_inserted_img(i,j) = filtered_img(x, y);
            end
        end
    end
    
    % step 5
    upsampled_img = imfilter(zero_inserted_img, convolve_filter);
    
    % step 6
    for i = 1:N1
        for j= 1:N2
            MSE = MSE + (upsampled_img(i,j) - original_img(i,j)).^2;
        end
    end
           
    
    tmp_val = MAXl^2 / MSE;
    
    PSNR = 10 * log10(tmp_val);
    
    display(PSNR)
end