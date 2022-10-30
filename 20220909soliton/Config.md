
to install vmware 
https://www.vmware.com/jp/products/workstation-player/workstation-player-evaluation.html

to install iso Debian file
https://www.debian.org/distrib/netinst


- apt
In order to execute commands as a root, you should enter
```
su
``` 
or 
```
sudo [command]
```

In order to configurate, you should input those commands
```
sudo apt-get install gem
sudo apt-get install ruby
sudo gem install sinatra
sudo gem install digest
sudo gem install sinatra-contrib

```

In order to run sinatra framework
main.rb 
```
ruby main.rb -o 0.0.0.0
```


In order to install sqlite3, you should input those commands
```
sudo apt-get install ruby-dev
sudo apt-get install build-essential
sudo apt-get install libsqlite3-dev
sudo apt-get install sqlite3
sudo gem install sqlite3
```


Also, VSCode extension software,such as

- SQLite Viewer
- VSCode remote SSH

are useful.



if you enter 'make', then, you'll encounter a comment like   
```
make: *** ターゲットが指定されておらず, makefile も見つかりません.  中止.
```
it is OK.
If not, please try to install make by using this command
```
sudo apt-get install make
```

if you encounter another trouble, you should type this command
```
which [command or file name you wanna find]
```
In this case,
```
which make
```

symbol 
```
ln -s /usr/bin/make /usr/local/bin/make
```


