% Assignment 1: Digit recognition using a single layer perceptron
% Deep Learning — Spring 2017, 
% Information Technology University (ITU) Lahore
% Written by Muhammad Faisal (mscs16004@itu.edu.pk)

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

pair = [2, 8];
disp(['Selected digits: ' num2str(pair(1)) ' vs ' num2str(pair(2))]);

idxs = (train_labels == pair(1) | train_labels == pair(2));
new_train_images = train_images(:,idxs);
new_train_labels = train_labels(idxs);

idxs = (test_labels == pair(1) | test_labels == pair(2));
new_test_images = test_images(:,idxs);
new_test_labels = test_labels(idxs);

%% Logistic Regression Code
ind = find(new_train_labels == pair(1));
new_train_labels(ind) = 0;
ind = find(new_train_labels == pair(2));
new_train_labels(ind) = 1;

ind = find(new_test_labels == pair(1));
new_test_labels(ind) = 0;
ind = find(new_test_labels == pair(2));
new_test_labels(ind) = 1;

[imageSize, num_images] = size(new_train_images);
w = (rand(imageSize, 1)-0.25)/100;

%training and updating weights using gradient descent
   [imageSize, num_images] = size(new_train_images);
   maxIter = 100;
   LR = 0.0001;

    for j = 1:maxIter
        up = zeros(imageSize,1);
        for k = 1:num_images
                up = up + computeCost1( new_train_images(:,k), new_train_labels(k), w )* new_train_images(:,k);
        end
        w = w + LR * up;
    end

%classifier
predictions = classifier( new_test_images, w );

evaluation( new_test_labels, predictions );
