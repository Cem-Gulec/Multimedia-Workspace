% Cem Güleç - 150117828 

function PSNR = problem1()

    frame_1 = imread('C:\Users\Cem\Documents\GitHub\Multimedia-Workspace\HW2\images\frame1.jpg');
    frame_2 = imread('C:\Users\Cem\Documents\GitHub\Multimedia-Workspace\HW2\images\frame2.jpg');
    I1 = im2double(frame_1); % previous frame
    I2 = im2double(frame_2); % current frame
    temp = 100;
    MAE = 0;
    
    B_target = I2(65:96, 81:112);
    
    
    for j = 1:321
        for i = 1:257
            window = I1(i:i+31,j:j+31);
            for x = 1:32
                for y= 1:32
                    MAE = MAE + abs(window(x,y).*255 - B_target(x,y).*255);
                end
            end
            MAE = MAE / (32*32);
            if (MAE < temp)
                temp = MAE;
            end
            MAE = 0;
        end
    end
    
    fprintf('PSNR value= %.2f\n', temp);
end