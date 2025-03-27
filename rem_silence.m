
%% remove silence and set intensity


%% add dependencies
clear
addpath(genpath('deps'))

%% get giles list

inpath = '../Brian_munson_narratives/female/';
outpath = ['../Brian_munson_narratives_remsilence/female'];

if ~exist(outpath, 'dir')
    mkdir(outpath)
end

dbs = -30;

files  = dir(fullfile(inpath, '*.wav'));
files = cellstr(char(files.name));

%%


%% remove silences add 300 ms silence between long chunks and stitch signal together.  Also writes the audio output

for i = 1:length(files)

    fname = fullfile(inpath, files{i});

    [segments, fs] = detectVoiced(fname)


    shortest_sil = 0.3*fs; % silence to add
    sil = zeros(shortest_sil,1);


    numsegs = length(segments);

    tmp = [];
    for idx = 1:numsegs

        tmp = cat(1, tmp, sil, segments{idx});

    end


    rms_sound_dB = norm(tmp)/sqrt(length(tmp));
    ratio = (10^(dbs/20))/rms_sound_dB;
    outsignal = ratio*tmp;


    outname = files{i};

    outname  = strsplit(outname, '.');

    outname = [outname{1}, '_',outname{2}, '.wav'];

    disp(['processing ', fname])
    audiowrite(fullfile(outpath, outname), outsignal, fs);

end

%%

%%

fname