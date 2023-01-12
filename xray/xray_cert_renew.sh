echo "Xray Certificates Renewed"

chmod +r /usr/local/etc/xray/xray.key
echo "Read Permission Granted for Private Key"

sudo systemctl restart xray
echo "Xray Restarted"
