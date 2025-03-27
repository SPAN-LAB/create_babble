function signal = fun_set_rms(aud, dbs)

% Function to set the rms of a a signal 

% Inputs
% aud =  is a vector or a matrix. If aud is a matrix, the function is
% performed along the columns
% dbs = attentuation value eg, -40;


if isvector(aud)
    signal = set_rms(aud,dbs);

elseif ismatrix(aud)

    out = num2cell(aud, 1); % converting each column into a cell
    dbs = num2cell(repmat(dbs, 1,length(out)));
    out = cellfun(@set_rms, out, dbs, 'UniformOutput', false);
    signal = cell2mat(out);   
end


function signal = set_rms(aud, dbs)

    speech = aud/max(abs(aud));
    rms_sound_dB = norm(speech)/sqrt(length(speech));
    ratio = (10^(dbs/20))/rms_sound_dB;
    signal = ratio*speech;
end

end