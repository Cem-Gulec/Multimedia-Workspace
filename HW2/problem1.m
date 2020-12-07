% Cem Güleç - 150117828 

function result = problem1()

    % loading images and converting them to double types for proper use
    frame_1 = imread('C:\Users\Cem\Documents\GitHub\Multimedia-Workspace\HW2\images\frame1.jpg');
    frame_2 = imread('C:\Users\Cem\Documents\GitHub\Multimedia-Workspace\HW2\images\frame2.jpg');
    I1 = im2double(frame_1); % previous frame
    I2 = im2double(frame_2); % current frame
    
    % B_target is captured by given coordinates inside the frame_2 image
    B_target = I2(65:96, 81:112);
    imshow(B_target)
    
    % variables defined for later use
    temp = 15000;
    temp2 = 15000;
    MAE = 0;
    MAE_2 = 0;
    [N1, N2] = deal(257, 321);
    [M, N] = deal(32, 32);
    
    % Scanning through frame_1 image with 32x32 window
    % Then comparing this windows error rate with the 
    % B_target defined above
    for i = 1:N1
        for j = 1:N2
            % window is captured iteratively
            window = I1(i:i+31,j:j+31);
            
            % from here on MAE calculations are beginning
            % MAE is used to compare error rate between window and B_target
            for x = 1:M
                for y= 1:N
                    MAE = MAE + abs(window(x,y).*255 - B_target(x,y).*255);
                end
            end
            MAE = MAE / (M*N);
            
            % Since we are looking for the smallest MAE possible
            % If coming across any smaller than the current one
            % I put inside variable temp
            if (MAE < temp)
                temp = MAE;
                % Also capturing the coordinate of the window with
                % with the smallest MAE value
                [x_pos, y_pos] = deal(i, j);
            end
            MAE = 0;
        end
    end
    
    fprintf('MAE value= %.2f\n', temp);
    fprintf('x_pos: %.2f  y_pos: %.2f\n', x_pos, y_pos);
    
    % step(6) for estimating backward motion vector
    for r = 1:273
        for t = 1:337
            % defining B_target iteratively
            B_target_2 = I2(r:r+15, t:t+15);
            
            % for searching 64x64 search region indexes defined
            for u = r-23:r+24
                for o = t-23:t+24
                    % skip if indexes overflow
                    if (u<0 || o<0) || ( u+16>287 || o+16>351)
                        continue
                    end
                    
                    % capturing the window depending on the index
                    window_2 = I1(u:u+15, o:o+15);
                    
                    % starting to calculate MAE value
                    for x = 1:16
                        for y= 1:16
                            MAE_2 = MAE_2 + abs(window_2(x,y).*255 - B_target_2(x,y).*255);
                        end
                    end
                    MAE_2 = MAE_2 / (16*16);
                    
                    % if current MAE is less than the current temp variable
                    % write over the value to have the smallest MAE value
                    if (MAE_2 < temp2)
                        temp2 = MAE_2;
                        % Also capturing the coordinate of the window with
                        % with the smallest MAE value
                        [x_pos_2, y_pos_2] = deal(r, t);
                    end
                    MAE_2 = 0;
                end
            end
        end
    end
    
    fprintf('MAE value for the step(6)= %.2f\n', temp2);
    fprintf('x_pos: %.2f  y_pos: %.2f\n', x_pos_2, y_pos_2);
    
end