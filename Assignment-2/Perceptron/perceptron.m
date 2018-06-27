% Assignment 1: Digit recognition using a single layer perceptron
% Deep Learning — Spring 2017, 
% Information Technology University (ITU) Lahore
% Written by Ali Hassan (mscs15049@itu.edu.pk)

clc; close all; clear;
%% Dataset paths
% Update the following paths to the folder where you’ve extracted 
% MNIST dataset in your system
train_data_dir = 'E:\Semester2\Deep Learning\assignment2\assignment2\src\MNIST\';
train_data_path   = [train_data_dir 'train-images.idx3-ubyte'];
train_label_path  = [train_data_dir 'train-labels.idx1-ubyte'];

test_data_path   = [train_data_dir 't10k-images.idx3-ubyte'];
test_label_path  = [train_data_dir 't10k-labels.idx1-ubyte'];

%% Loading Images
% helper functions from UFLDL tutorial 
% http://ufldl.stanford.edu/wiki/index.php/Using_the_MNIST_Dataset
train_images = loadMNISTImages(train_data_path);
train_labels = loadMNISTLabels(train_label_path);

test_images = loadMNISTImages(test_data_path);
test_labels = loadMNISTLabels(test_label_path);

%% Setting up training and testing data
% In your first assignment you are required to implement a perceptron for 
% binary classification. Therefore you don’t need all 10 categories. 
% Change the following ‘pair’ variable to select whichever two digits you 
% want to classify.

pair = [6, 9];
disp(['Selected digits: ' num2str(pair(1)) ' vs ' num2str(pair(2))]);

idxs = (train_labels == pair(1) | train_labels == pair(2));
new_train_images = train_images(:,idxs);
new_train_labels = train_labels(idxs);

idxs = (test_labels == pair(1) | test_labels == pair(2));
new_test_images = test_images(:,idxs);
new_test_labels = test_labels(idxs);

%% Visualize selected pair of digits
imW = 28; imH = 28; % image size
idx = randperm(size(new_train_images,2),100);
% making a grid of 10x10 containing 100 examples
k = 1;
vis_im = [];
for i=1:10
    imw = [];
   for j = 1:10
       im = reshape(new_train_images(:,idx(k)), [imW, imH]);
       imw = [imw, im, ones(imW,1)];
       k = k+1;
   end
   vis_im = [vis_im; imw; ones(1,size(imw,2))];
end

figure; imagesc(vis_im); colormap gray; title(['Selected digits: ' ...
    num2str(pair(1)) ' & ' num2str(pair(2))]);

%% Training
% !! Write your perceptron training code here !!
w = training( new_train_images, new_train_labels );

%% Testing
% !! Write your classification code here !!
L = testing( w, new_test_images );

% Following lines randomly guess the digit for each test example. Its 
% accuracy is roughly 50%. Explain in your report why that is the case, 
% and whatever you do, your implementation have to produce at least 1.3x 
% better results. Otherwise your solution will not be accepted.

N = numel(new_test_labels);
predictions = [zeros(1,N), ones(1,N)]; 
predictions = predictions(randperm(2*N));
predictions(predictions==1) = pair(1);
predictions(predictions==0) = pair(2);

%% Evaluation
% !! Write your evaluation code here !! 

% You are required to compute all of the following quantities.
% (1) True positive
% (2) False positive
% (3) True negative
% (4) False negative 
% (5) Precision
% (6) Recall
% (7) Accuracy

L(L==-1) = pair(1);
L(L==1) = pair(2);

evaluation( new_test_labels, L );
