#!/bin/bash

#Nginxインストール
sudo dnf install -y nginx

# サンプルHTML作成
echo '<!DOCTYPE html>
<html>
<head>
<title>DemoPage</title>
</head>
<body>
<h1>This is a demo page</h1>
</body>
</html>' | sudo tee /usr/share/nginx/html/demo.html

#ポート8080用に設定ファイル編集（/etc/nginx/nginx.conf）
sudo sed -i 's/listen       80;/listen       8080;/' /etc/nginx/nginx.conf

#デフォルトでindexにdemo.htmlが含まれるよう編集
sudo sed -i 's/index  index.html index.htm;/index  demo.html index.html index.htm;/' /etc/nginx/nginx.conf

# nginx自動起動＆起動
sudo systemctl enable nginx
sudo systemctl restart nginx

# firewalldを開放
sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --reload
