# Tarsplit readme

## Overview
Tarsplit is essentially just like running tar and then split, but without needing to create an intermediate file.

Tarsplit should be capable of resuming if interrupted; by using the vol_file as an indicator of how far along it was. (This needs testing)



## Installation
Prerequisites:
```
$ sudo dnf -y install tar git bash
```

Tarsplit:
```
git clone TARSPLIT_REPONAME
```



## Usage
Standard invokation pattern:
```
$ tarsplit-single.sh -s "$SRC_PATH" -d "$DEST_PATH" -v "$VOL_FILE" -k "$KB_LIMIT"
```

Example invokation:
```
$ tarsplit-single.sh -s "${HOME}/some_dir_of_files" -d "/media/somehdd/my-split-archive.tar" -v "volume_number.txt" -k "10485760"
```


## Suggested user tweaks
* Changing the value of "--checkpoint=" to alter the frequency of progress messages. (It can take a small amount of time to print each message to the console, slowing program execution.)

* Alterting padding fo very large splitting jobs.


## Links / further reading
### Tar
* https://man7.org/linux/man-pages/man1/tar.1.html
* https://linux.die.net/man/1/tar
* https://www.gnu.org/software/tar/manual/

### BASH - general
* https://devhints.io/bash
* http://redsymbol.net/articles/unofficial-bash-strict-mode/

## License
This software is licensed under the GPL 3.0
