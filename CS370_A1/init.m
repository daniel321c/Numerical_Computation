
%
% Initialize data
%
clear all; close all;

%load in the image
figure();
image_data = imread('name.jpg');
flip_image = flipdim(image_data, 1);
imagesc(flip_image);
set(gca,'YDir','normal');
axis image;

i = 1;
while true
    % enter sequence of clicks
    [x{i},y{i}]=ginput;
    % breaks out of the loop when you have pressed enter twice in a row
    if isempty(x{i}) 
        x(i)=[]; y(i)=[]; % delete the empty segment
        break; 
    end
    
    i=i+1;
end
x
v=axis;
clf;

%record the collected data x/y positions, and the axis information v
%into a file, data.mat.
save('data.mat','x','y','v');
