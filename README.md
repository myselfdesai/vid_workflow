# vid_workflow
Contains scripts for understanding basic video encoding process and file operations. Scripts are meant to be run on stand alone local environemnt.


## System Dependencies
```
Ruby 2.6.2
Bundler 2.2.24
ffmpeg (latest version)
FTP and AWS S3 Access
OS: Ubuntu 22.04.3 LTS
```

## Steps to run script locally
```
1. Clone repo and navigate to project directory
2. Install dependencies: bundle install --path vendor
3. Run Script: bundle exec ruby vid_workflow.rb 
```

## Operations Handled as part of current script

### 1. Source files from local FTP server
![Source Files from FTP](./images/1-Source-files-from-FTP.png?raw=true "Source Files from FTP")


### 2. Source files being downloaded from local FTP server. Progress and status of download operation  can also be seen.
![Files-being-read-from-FTP](./images/2-Files-being-read-from-FTP.png?raw=true "Files-being-read-from-FTP")


### 3. Source files in local Disk. We can notice that files have been renamed to remove 'ID' and also post download we deleted corrupted/partial-uploads because of this file 'test.mxf' is not visible.
![Source-Files-in-Local_Disk](./images/3-Source-Files-in-Local_Disk.png?raw=true "Source-Files-in-Local_Disk")


### 4. Validating corrupt and valid Downloaded Files
![Validating corrupt downloaded File](./images/4-Validation-vod-files.png?raw=true "Validating corrupt downloaded file File")
![Validating valid downloaded File](./images/5-file-validation.png?raw=true "Validating valid downloaded File")


### 5. Validating Transcoding Operation for given profiles.
![Validating Transcoding Operation](./images/6-Validate-transcode-operation.png?raw=true "Validating Transcoding Operation")


### 6. Transcoded Files in Local Disk.
![Transcoded Files in Local Disk](./images/7-Transcoded-Files-In-Local_Disk.png?raw=true "Transcoded Files in Local Disk")


## High Level Design of Basic Video Transcoding Workflow
(Scope of work is limited to simulate file operations in VoD encoding workflow) 
![High Level Video Encoding Flow](./images/Vide-Encoding-HLD.png?raw=true "High Level Video Encoding Flow")
