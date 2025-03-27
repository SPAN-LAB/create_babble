function segments = buffer_overlap_segment(x, win_len, overlap, windowfun)
% SEGMENT_OVERLAP Segments a vector into overlapping segments with minimal padding.
%
%   segments = segment_overlap(x, win_len, overlap)
%
%   x        : Input vector.
%   win_len  : Length of each segment.
%   overlap  : Overlap percentage (0 to 100).
%
%   segments : Matrix where each column is a segment.

    if nargin < 4
        windowfun = 'hann';
    end
    win = window(['@', windowfun], win_len);

    if overlap < 0 || overlap >= 100
        error('Overlap must be between 0 and 100 (exclusive).');
    end
    
    step = round(win_len * (1 - overlap / 100)); % Step size
    num_segments = ceil((length(x) - win_len) / step) + 1; % Total number of segments

    % Initialize the matrix
    segments = zeros(win_len, num_segments);

    % Fill in segments
    for i = 1:num_segments
        start_idx = (i - 1) * step + 1;
        end_idx = start_idx + win_len - 1;

        if end_idx > length(x)  % If last segment exceeds length, pad with zeros
            segment_data = zeros(win_len, 1);
            segment_data(1:length(x) - start_idx + 1) = x(start_idx:end);
        else
            segment_data = x(start_idx:end_idx);
        end

        segments(:, i) = win.*segment_data;
    end
end
