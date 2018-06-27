function generateConfusionMatrix( predictions, test_labels )

    classes = unique(test_labels);
    num_classes = length(classes);
    confusion_matrix = zeros(num_classes, num_classes);
    for i=1:length(predictions)
        row = find(test_labels(i) == classes);
        column = find(predictions(i) == classes);
        confusion_matrix(row, column) = confusion_matrix(row, column) + 1;
    end
    
    save 'confusionMat.mat' confusion_matrix;
    
    num_test_per_cat = length(test_labels) / num_classes;
    confusion_matrix = confusion_matrix ./ num_test_per_cat;   
    accuracy = mean(diag(confusion_matrix));
    fprintf(     'Accuracy (mean of diagonal of confusion matrix) is %.3f\n', accuracy);
    
    fig_handle = figure; 
    imagesc(confusion_matrix, [0 1]); 
    set(fig_handle, 'Color', [.988, .988, .988])
    axis_handle = get(fig_handle, 'CurrentAxes');
    set(axis_handle, 'XTick', 1:15)
    set(axis_handle, 'XTickLabel', classes)
    set(axis_handle, 'YTick', 1:15)
    set(axis_handle, 'YTickLabel', classes)

    visualization_image = frame2im(getframe(fig_handle));
    % getframe() is unreliable. Depending on the rendering settings, it will
    % grab foreground windows instead of the figure in question. It could also
    % return a partial image.
    imwrite(visualization_image, 'confusion_matrix.png')
    save 'confusionMat1.mat' confusion_matrix;
end

