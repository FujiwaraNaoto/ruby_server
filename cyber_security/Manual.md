
```
sudo apt-get update
sudo apt-install apache2
apache2 -v
sudo service apache2 restart
sudo service apache2 stop
```
## memo

`apache2 -v`コマンドでapacheのバージョンが確認できる.筆者の環境では
```
Server version: Apache/2.4.41 (Ubuntu)
Server built:   2022-06-14T13:30:55
```
となった.

` service apache2 status`で
apache2が動いているかどうかが確認できる.
```
apache2 is not running/ apache2 is running
```


windows側からのアクセスは
WSLのプライベートIPアドレス(`ifconfig`で出てくる 172...から始まるIPアドレス)
を打ち込む.

## IPアドレス

クラスB 172.16.0.0 ~ 172.31.255.255

## Vscodeを管理者権限下で使う
https://qiita.com/ntrlmt/items/6dc79105a7be76c38f5d

無理みたいなので,apacheの公開ディレクトリを
`/var/www/html`から変更を行うことにする.

https://i-think-it.net/apache-documentroot-other-publishing/
