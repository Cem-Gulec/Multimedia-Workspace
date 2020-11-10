function result = problem1()

    % step 1 and step 2
    % importing original image and converting
    % it from 'uint8' type to 'double' type
    base_img = imread('C:\Users\Cem\Documents\GitHub\Multimedia-Workspace\HW1\Lena.gif');
    original_img = im2double(base_img);
    
    imshow(original_img, []);
    
    % step 3
    % defining variables
    MSE=0;
    MAXl = 255;
    [N1, N2] = size(original_img);
    lowpass_filter = [1/9 1/9 1/9;...
                      1/9 1/9 1/9;...
                      1/9 1/9 1/9];
    
    % step 4
    % filtering
    filtered_img = imfilter(original_img, lowpass_filter, 'replicate');
    imshow(filtered_img, []);
    
    
    % step 5
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