% Cem Güleç - 150117828

function result = problem2()

    % loading images and converting them to double format
    % also defining variables later to be used
    noise_free_img = imread('C:\Users\Cem\Documents\GitHub\Multimedia-Workspace\HW2\images\original.jpg');
    noisy_img = imread('C:\Users\Cem\Documents\GitHub\Multimedia-Workspace\HW2\images\noisy.jpg');
    noise_free_img_cnv = im2double(noise_free_img); % noise free image converted
    noisy_img_cnv = im2double(noisy_img); % noisy image converted
    [N1, N2] = size(noisy_img_cnv);
    [MSE1, MSE2, MSE3] = deal(0, 0, 0);
    MAXl = 255;
    
    % filtering for the first time
    filtered_noisy = medfilt2(noisy_img_cnv);
    
    % filtering for the second time
    second_filtered_noisy = medfilt2(filtered_noisy);
    
    % having a subplot containing images (1), (2), (3) steps
    subplot(1,3,1), subimage(noisy_img_cnv)
    title('Noisy image')
    subplot(1,3,2), subimage(filtered_noisy)
    title('Median filtered')
    subplot(1,3,3), subimage(second_filtered_noisy)
    title('2x Median filtered')
    
    % calculating PSNR value for 3 different cases
    for i = 1:N1
         for j= 1:N2
             MSE1 = MSE1 + (noise_free_img_cnv(i,j).*255 - noisy_img_cnv(i,j).*255).^2;
             MSE2 = MSE2 + (noise_free_img_cnv(i,j).*255 - filtered_noisy(i,j).*255).^2;
             MSE3 = MSE3 + (noise_free_img_cnv(i,j).*255 - second_filtered_noisy(i,j).*255).^2;
         end
    end
           
    MSE1 = MSE1/(N1*N2);
    MSE2 = MSE2/(N1*N2);
    MSE3 = MSE3/(N1*N2);
          
    PSNR1 = 10 * log10(MAXl^2 / MSE1);
    PSNR2 = 10 * log10(MAXl^2 / MSE2);
    PSNR3 = 10 * log10(MAXl^2 / MSE3);
    
    % displaying lastly found values
    fprintf('PSNR value of step(4)= %.2f\n', PSNR1);
    fprintf('PSNR value of step(5)= %.2f\n', PSNR2);
    fprintf('PSNR value of step(6)= %.2f\n', PSNR3);
    
end