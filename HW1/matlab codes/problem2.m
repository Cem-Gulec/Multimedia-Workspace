function result = problem2()

    % importing original image and converting
    % it from 'uint8' type to 'double' type
    base_img = imread('C:\Users\Cem\Documents\GitHub\Multimedia-Workspace\HW1\Lena.gif');
    original_img = im2double(base_img);
    
    imshow(original_img, []);
    
    % defining variables
    MSE=0;
    MAXl = 255;
    [N1, N2] = size(original_img);
    lowpass_filter = [1/25 1/25 1/25 1/25 1/25;...
                      1/25 1/25 1/25 1/25 1/25;...
                      1/25 1/25 1/25 1/25 1/25;...
                      1/25 1/25 1/25 1/25 1/25;...
                      1/25 1/25 1/25 1/25 1/25];
    
    % filtering
    filtered_img = imfilter(original_img, lowpass_filter, 'replicate');
    imshow(filtered_img, []);
    
    
    % computing MSE and then PSNR values
    
    for i = 1:N1
        for j= 1:N2
            MSE = MSE + (original_img(i,j) - filtered_img(i,j)).^2;
        end
    end
           
    
    tmp_val = MAXl^2 / MSE;
    
    PSNR = 10 * log10(tmp_val);
    
    display(PSNR)
    whos
end