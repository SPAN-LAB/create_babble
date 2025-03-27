clear;clc;close all

%%
tic
male_path = '../Brian_munson_narratives_remsilence/male/';
female_path = '../Brian_munson_narratives_remsilence/female/';
outfs = 44100;

outpath = '../output_babble/';

if ~exist(outpath, 'dir'), mkdir(outpath), end

male_files  = dir(fullfile(male_path, '*.wav'));
female_files  = dir(fullfile(female_path, '*.wav'));

male_files = cellstr([char(male_files.folder),repmat('/', length(male_files),1), char(male_files.name)]);
female_files = cellstr([char(female_files.folder),repmat('/', length(female_files),1),char(female_files.name)]);

dbs = -40;

talker = 8; % Use only even numbers

male_files = male_files(1:talker/2);
female_files = female_files(1:talker/2);

all_files = cat(1, male_files, female_files);

%% load audio files and set the rms
all_aud = {}; aud_len = [];
for i = 1:length(all_files)
    [aud,fs] = audioread(all_files{i});

    if fs~=outfs
        aud = resample(aud, outfs, fs); % ensure all the audio files have the same rms
    end
    aud = fun_set_rms(aud, dbs); % ensure all the narratives are the same rms
    all_aud{i,1} = aud;
    aud_len(i) = length(aud);
end


%% trimming the audio files
min_len = min(aud_len);
func = @(x) x(1:min_len,1);
tmp = cellfun(func, all_aud, 'UniformOutput',false);
tmp = cell2mat(tmp');

%% randomize the sequences of the narratives to create the babble
tmp_rand = [];
for i =1:size(tmp,2)
    randidx = randperm(min_len);
    randidx = randidx(1);
    tmp_rand(:,i) = cat(1,tmp(randidx:end,i), tmp(1:randidx-1,i));
end


%% write the babble into an audio file
out = sum(tmp_rand,2);
out = fun_set_rms(out, dbs);

outname = [num2str(talker), '_talker_babble'];
audname = [outname, '.wav'];
verbose_name = [outname, '.txt.'];

audiowrite(fullfile(outpath, audname), out, fs)


fid = fopen(fullfile(outpath, outname), 'wt');
fprintf(fid,'%s \r\r','VERBOSE OUTPUT OF THE Babble prep :');
fprintf(fid, '%s \r\r', datestr(now))
fprintf(fid,'%s \r', ['Speech Level: ', num2str(dbs), 'dB' ]);
fprintf(fid, '%s \r', 'Input files - ');
for i =1:length(all_files)
    fprintf(fid,'%s  \r', all_files{i});
end
fprintf(fid, '%s \r', '');
fprintf(fid, '%s \r', 'Output files - ');

fprintf(fid,'%s  \r', fullfile(outpath, audname));

fprintf(fid, '%s \r\r', ' ');
fprintf(fid, '%s \r', '--------------------ALL THE BEST FOR YOUR SPEECH PERCEPTION RESEARCH-------------------- ');
fclose(fid)
toc
fprintf(1,'%s \r', ['The verbose file has been written in ' outpath] );


%%
% i = 1;
% buffer_size = 2;
% 
% disp('reading audio files')
% [aud, fs] = audioread(fullfile('../',files{i}));
% if size(aud,2)>1
% aud = aud(:,1);
% end
% %%
% buffer_size_n = buffer_size*fs;
% B = buffer(aud, buffer_size_n) ;


%%

% win_len = 1*fs;
% overlap = 50;
% orig_len = length(aud);
% segments = buffer_overlap_segment(aud, win_len, overlap, 'tukeywin');
% segments = fun_set_rms(segments, -30);
% 
% x_reconstructed = buffer_overlap_reconstruct(segments, overlap, orig_len);

%%


% rms_sound_dB = rms(B,1);
% 
%     ratio = (10^(dbs/20))./rms_sound_dB;
%     signal = ratio.*B;
% 
%     signal = reshape(signal, [numel(signal),1]);
%%


%%

%%