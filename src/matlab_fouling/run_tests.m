% runs all tests in the pwd recursively

folder  = pwd;
disp(folder);
filelist = dir(fullfile(folder, '**/*.*'));  %get list of files and folders in any subfolder
filelist = filelist(~[filelist.isdir]);  %remove folders from list
nFile   = length(filelist);
success = false(1, nFile);
for k = 1:nFile
  file = filelist(k);
  try
    run(fullfile(file.folder, file.name));
    success(k) = true;
    fprintf('succeeded: %s\n', file.name);
  catch
    fprintf('!!FAILED!!: %s\n', file.name);
  end
end