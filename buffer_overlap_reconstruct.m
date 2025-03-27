function x_reconstructed = buffer_overlap_reconstruct(segments, overlap, orig_len)
% RECONSTRUCT_OVERLAP Reconstructs a vector from overlapping segments.
%
%   x_reconstructed = reconstruct_overlap(segments, overlap, orig_len)
%
%   segments  : Matrix where each column is a segment.
%   overlap   : Overlap percentage (0 to 100).
%   orig_len  : Original signal length before segmentation.
%
%   x_reconstructed : Reconstructed output vector (cropped to original length).

    [win_len, num_segments] = size(segments);
    step = round(win_len * (1 - overlap / 100)); % Step size
    total_len = (num_segments - 1) * step + win_len; % Reconstructed length
    x_reconstructed = zeros(total_len, 1);
    weight = zeros(total_len, 1);

    % Overlap-add reconstruction
    for i = 1:num_segments
        start_idx = (i - 1) * step + 1;
        x_reconstructed(start_idx:start_idx + win_len - 1) = ...
            x_reconstructed(start_idx:start_idx + win_len - 1) + segments(:, i);
        weight(start_idx:start_idx + win_len - 1) = ...
            weight(start_idx:start_idx + win_len - 1) + 1;
    end

    % Normalize overlapping regions
    x_reconstructed = x_reconstructed ./ weight;

    % Crop to original length
    x_reconstructed = x_reconstructed(1:orig_len);
end
