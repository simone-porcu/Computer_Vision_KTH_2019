pkg load image
pkg load statistics
addpath Functions
addpath bildat_lab3

K = 16;               % number of clusters used 8
L = 500;              % number of iterations
seed = 14;           % seed used for random initialization
scale_factor = 1.0;  % image downscale factor
image_sigma = 0.5;   % image preblurring scale 0.5

I = imread('bildat_lab3/orange.jpg');
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

tic
[ segm, centers ] = kmeans_segm(I, K, L, seed);
toc
Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
imwrite(Inew,'bildat_lab3/result/kmeans1.png')
imwrite(I,'bildat_lab3/result/kmeans2.png')

% used for comparing two types of center init
function init_centers(I, K, L, Iback, seed, naive_init)
  [ segm, centers ] = kmeans_segm(I, K, L, seed, naive_init);
  Inew = mean_segments(Iback, segm);
  I = overlay_bounds(Iback, segm);
  imwrite(Inew,'bildat_lab3/result/kmeans1_naiveinit.png')
  imwrite(I,'bildat_lab3/result/kmeans2_naiveinit.png')
end

function display_kmeans(K, L, seed, scale_factor, image_sigma)
  [t1, t1back] = load_img('bildat_lab3/tiger1.jpg', scale_factor, image_sigma);
  [t2, t2back] = load_img('bildat_lab3/tiger2.jpg', scale_factor, image_sigma);
  [t3, t3back] = load_img('bildat_lab3/tiger3.jpg', scale_factor, image_sigma);
  [orange, oback] = load_img('bildat_lab3/orange.jpg', scale_factor, image_sigma);
  
  [ segm_t1, centers_t1 ] = kmeans_segm(t1, K, L, seed);
  [ segm_t2, centers_t2 ] = kmeans_segm(t2, K, L, seed);
  [ segm_t3, centers_t3 ] = kmeans_segm(t3, K, L, seed);
  [ segm_o, centers_o ] = kmeans_segm(orange, K, L, seed);

  subplot(4, 2, 1);
  Inew_t1 = mean_segments(t1back, segm_t1);
  imshow(Inew_t1);
  
  subplot(4, 2, 2);
  I_t1 = overlay_bounds(t1back, segm_t1);
  imshow(I_t1);
  
  imwrite(Inew_t1,'bildat_lab3/result/kmeans1_t1.png')
  imwrite(I_t1,'bildat_lab3/result/kmeans2_t1.png')
  
  subplot(4, 2, 3);
  Inew_t2 = mean_segments(t2back, segm_t2);
  imshow(Inew_t2);
  
  subplot(4, 2, 4);
  I_t2 = overlay_bounds(t2back, segm_t2);
  imshow(I_t2);
  
  imwrite(Inew_t2,'bildat_lab3/result/kmeans1_t2.png')
  imwrite(I_t2,'bildat_lab3/result/kmeans2_t2.png')
  
  subplot(4, 2, 5);
  Inew_t3 = mean_segments(t3back, segm_t3);
  imshow(Inew_t3);
  
  subplot(4, 2, 6);
  I_t3 = overlay_bounds(t3back, segm_t3);
  imshow(I_t3);
  
  imwrite(Inew_t3,'bildat_lab3/result/kmeans1_t3.png')
  imwrite(I_t3,'bildat_lab3/result/kmeans2_t3.png')
  
  subplot(4, 2, 7);
  Inew_o = mean_segments(oback, segm_o);
  imshow(Inew_o);
  
  subplot(4, 2, 8);
  I_o = overlay_bounds(oback, segm_o);
  imshow(I_o);
  
  imwrite(Inew_o,'bildat_lab3/result/kmeans1_o.png')
  imwrite(I_o,'bildat_lab3/result/kmeans2_o.png')
end

function [I, Iback]=load_img(path, scale_factor, image_sigma)
  I = imresize(imread(path), scale_factor);
  Iback = I;
  d = 2*ceil(image_sigma*2) + 1;
  h = fspecial('gaussian', [d d], image_sigma);
  I = imfilter(I, h);
end

% display_kmeans(K, L, 14, scale_factor, image_sigma);

% init_centers(I, K, L, Iback, seed, true);