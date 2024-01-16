
# codonnier_network

Just add this package in the app and ready to rock the server when it is idle.

# How to add
## Step 1. Generate SSH Key pair
* Enter the below command in your terminal and hit enter.
```
ssh-keygen -t ed25519 -C "priyankgandhi000@gmail.com"
```
* Then it will ask you to add path for saving a file, you can give any location or hit enter again.
* Then it will ask you passphrase, you can add password for the file or hit enter again.
* As you hit the enter your SSH Key file is generated. Here is the default location
```
/Users/imac/.ssh/id_ed25519.pub
```

## Step 2. Add your public key to your Github account
* Navigate to your profile page on github at this [link](https://github.com/settings/profile).
* Click on SSH and GPG keys link on the left.  
  ![https://miro.medium.com/v2/resize:fit:464/format:webp/1*QDyD_dBGslH48DkrlCeLsg.png](https://miro.medium.com/v2/resize:fit:464/format:webp/1*QDyD_dBGslH48DkrlCeLsg.png)
* Click on the “New SSH Key” button.  
  ![https://miro.medium.com/v2/resize:fit:720/format:webp/1*Hky_1UssI8UZmzMhXiLgwQ.png](https://miro.medium.com/v2/resize:fit:720/format:webp/1*Hky_1UssI8UZmzMhXiLgwQ.png)
* Give it any name in the title.
* Locate the file *.pub and open it. And copy the contents of it and paste it in Key text box.
* Press Add SSH Key button.

## Step 3. Add/Update your config file with this content.
* Enter the below command in your terminal and hit enter.
```
touch ~/.ssh/config
```
* It will create a file in the inside the folder.
* Then enter below command and hit enter.
```
open ~/.ssh/config
```
* It will open the config file then enter below lines and save it.

```
Host github
  HostName github.com  
  PreferredAuthentications publickey # authentication mechanism  
  User git # standard username when authenticating with git  
  AddKeysToAgent yes  
  UseKeychain yes  
  IdentityFile ---Location of file---/FileName
```

## Step 4. Add the package dependency to your flutter project as shown below.
* Open pubspec.yml and add dependency as shown below:
```
dependencies:
  codonnier_network:
    git:
      url: https://github.com/priyankgandhi0/codonnier_network.git
      ref: main
```
* Note: ref is optional and can be skipped. If you have a branch, you can change it to point to that branch.

## Step 5. Update the dependencies
* Navigate to your flutter project and  
  `flutter pub get`
* If this command shows an error then please close and re-open the project. And execute `flutter pub get` command again.