#!/bin/bash

#Nginxインストール
sudo dnf install -y nginx

# サンプルHTML作成
sudo mkdir -p /usr/share/nginx/html
echo '<!DOCTYPE html>
<html lang="ja">
<head>
<title>DemoPage</title>
</head>
<body>
<h1>デモ用のページです。</h1>
<p>OCI上にTerraformで作成したインスタンスに接続できました。</p>
</body>
</html>' | sudo tee /usr/share/nginx/html/index.html

#ポート8080用に設定ファイル編集（/etc/nginx/nginx.conf）
sudo sed -i 's/listen       80;/listen       8080;/' /etc/nginx/nginx.conf

# nginx自動起動＆起動
sudo systemctl enable nginx
sudo systemctl restart nginx

# firewalldを開放
sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --reload
