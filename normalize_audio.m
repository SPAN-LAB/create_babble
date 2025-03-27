
%% remove silence and set intensity


%% add dependencies
clear
addpath(genpath('deps'))

%% get giles list

inpath = '../alice_orig/';
outpath = '../alice_norm';


if ~(exist(outpath))
    mkdir(outpath)
end

dbs = -30;

files  = dir(fullfile(inpath, '*.wav'));
files = cellstr(char(files.name));


%% remove silences add 300 ms silence between long chunks and stitch signal together.  Also writes the audio output

for i = 1:length(files)

    fname = fullfile(inpath, files{i});



    [tmp, fs] = audioread(fname);
    

    rms_sound_dB = norm(tmp)/sqrt(length(tmp));
    ratio = (10^(dbs/20))/rms_sound_dB;
    outsignal = ratio*tmp;


    outname = files{i};

    outname  = strsplit(outname, '.');

    outname = ['alice_', outname{1}, '.wav'];

    audiowrite(fullfile(outpath, outname), outsignal, fs);

end

%%

%%

fname