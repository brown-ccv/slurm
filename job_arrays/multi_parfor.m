function multi_parfor(tmpdir,task_id)

% create a local cluster object
pc = parcluster('local')

% explicitly set the JobStorageLocation to the temp directory that was created in your sbatch script
pc.JobStorageLocation = strcat(getenv('HOME'),'/matlab_temp_dir', getenv('$SLURM_ARRAY_TASK_ID'))
pc.JobStorageLocation = strcat(tmpdir, '/', getenv('$SLURM_ARRAY_TASK_ID'))

% start the matlabpool with maximum available workers
% control how many workers by setting ntasks in your sbatch script
parpool(pc, str2num(getenv('SLURM_CPUS_PER_TASK')))

% run a parallel for loop
parfor i = 1:100
    ones(10,10)
end
