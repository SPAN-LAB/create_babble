
## **Step 1** 

    run the rem_silence.m script to remove long silences from the audio narrative. This script also normalizes the audiofiles. 

## **Step 2**
    
    run the create_babble.m script to prepare the multitalker babbles of the desired intensity. 
    All the audio files are equated in intensity before mixing. However, there is no easy way of creating the same intensity from each speaker later. 
    This noise can be used to mix with speeech when the noise needs to be the same level as speech or other SNRs. However, this cannot be used if we want each talker to be of a certain level

### Dependecies

    fun_set_rms.m sets the intensities

    buffer_overlap_segment.m, and buffer_overlap_reconstruct.m were created to modify rms levels by chopping the signal into
    mulitple overlapping windows. These havent been used in the above scripts. However, the commented text in create_babble show the usage of these scripts. 
    
    

