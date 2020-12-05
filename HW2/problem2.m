function result = problem2()

    noise_free_img = imread('C:\Users\Cem\Documents\GitHub\Multimedia-Workspace\HW2\images\original.jpg');
    noisy_img = imread('C:\Users\Cem\Documents\GitHub\Multimedia-Workspace\HW2\images\noisy.jpg');
    noise_free_img_cnv = im2double(noise_free_img); % noise free image converted
    noisy_img_cnv = im2double(noisy_img); % noisy image converted
    [N1, N2] = size(noisy_img_cnv);
    MSE=0;
    MAXl = 255;
    
    %imshow(noisy_img_cnv)
    
    filtered_noisy = medfilt2(noisy_img_cnv);
    %imshow(filtered_noisy)
    
    second_filtered_noisy = medfilt2(filtered_noisy);
    %imshow(second_filtered_noisy)
    
    % calculating PSNR value
    for i = 1:N1
         for j= 1:N2
             MSE = MSE + (noise_free_img_cnv(i,j).*255 - second_filtered_noisy(i,j).*255).^2;
         end
    end
           
    MSE = MSE/(N1*N2);
          
    PSNR = 10 * log10(MAXl^2 / MSE);
     
    fprintf('PSNR value= %.2f\n', PSNR);
    
end