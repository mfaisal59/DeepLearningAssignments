
clc; close all; clear;
% Dataset paths
%% 
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

%% Training one vs all SVM classifier
[W, B] = trainSVM(train_images, train_labels);

%% Testing one vs all SVM classifier
classes = unique(test_labels);
num_test = size(test_images,2);
confidences = W*test_images+repmat(B,1,num_test);
[~, indices] = max(confidences);
predictions = classes(indices);

generateConfusionMatrix( predictions, test_labels )