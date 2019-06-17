一、前置

使用的OS 

http://cdimage.ubuntu.com/releases/18.04/release/

SD卡格式化: SD Card Formatter

SD卡燒入: balenaEtcher


二、網路

網路設置要用到netplan

ubuntu18有線網路:

vim /etc/netplan/50-cloud-init.yaml

    ethernets:
	
        eth0:
		
            addresses: [xxx.xxx.xxx.xxx/24]  
			
            gateway4: xxx.xxx.xxx.xxx           
			
nameservers:

           		 addresses: [8.8.8.8] //DNS
				 
            dhcp4: no
			
            optional: no

無線網路:

先用有線安裝

sudo lshw -numeric -class network

sudo ifconfig -a

sudo apt-get install wpasupplicant

sudo apt-get install network-manager

vim /etc/netplan/50-cloud-init.yaml

renderer: NetworkManager

    wifis:
	
        wlan0:
		
            addresses: []  
			
            gateway4:          
			
nameservers:

            		addresses: [] 
					
dhcp4: true

access-points:

“ssid”:  //ex: “ICCSL”

passwd:”  ”  //密碼

            optional: no
			

三、依賴安裝

sudo passwd //設置root的密碼

su - //進root，之後的操作都在root進行

用到依賴的安裝:

sudo apt-get update && sudo apt-get upgrade -y 

sudo apt-get install git curl gcc libc6-dev libltdl3-dev python-setuptools –y

後續操作會有記憶體不足的問題，先使用swapon來避免

sudo fallocate -l 1G /swapfile

sudo dd if=/dev/zero of=/swapfile bs=1024 count=1048576

sudo chmod 600 /swapfile

sudo mkswap /swapfile

sudo swapon /swapfile

sudo echo '/swapfile swap swap defaults 0 0' >> /etc/fstab

四、pip

apt-get install python-pip 

python-dev build-essential 

pip install –upgrade pip 

pip –V

如果pip –V發生錯誤

到/usr/bin/pip

from pip import main

if __name__ == ‘__main__’:

sys.exit(main())

改成

from pip import __main__

if __name__ == ‘__main__’:

sys.exit(__main__._main())


五、docker

curl -sSL https://get.docker.com/ | sh


使用docker run hello-world測試是否成功

接下來是docker-compose，版本和下載源的選擇建議如下

pip install docker-compose==1.23.2 -i http://pypi.douban.com/simple/ --trusted-host pypi.douban.com

五、golang

apt install golang

添加環境:

vim ~/.bashrc  

export GOPATH=/

生效:

source ~/.bashrc 

測試是否成功:

go version

六、鏡像

這是非官方的，官方不支持arm

docker pull pesicsasa/fabric-ca:latest

docker pull pesicsasa/fabric-orderer:latest

docker pull pesicsasa/fabric-peer:latest

docker pull pesicsasa/fabric-tools:latest

docker pull pesicsasa/fabric-ccenv:latest

docker pull pesicsasa/fabric-baseos:latest

docker pull pesicsasa/fabric-zookeeper:latest

docker pull pesicsasa/fabric-kafka:latest

docker pull pesicsasa/fabric-couchdb:latest

docker tag pesicsasa/fabric-ca:latest hyperledger/fabric-ca:latest

拉完鏡像後，將tag取代掉

docker tag pesicsasa/fabric-orderer:latest hyperledger/fabric-orderer:latest

docker tag pesicsasa/fabric-peer:latest hyperledger/fabric-peer:latest

docker tag pesicsasa/fabric-tools:latest hyperledger/fabric-tools:latest

docker tag pesicsasa/fabric-ccenv:latest hyperledger/fabric-ccenv:latest

docker tag pesicsasa/fabric-baseos:latest hyperledger/fabric-baseos:arm64-latest

docker tag pesicsasa/fabric-zookeeper:latest hyperledger/fabric-zookeeper:latest

docker tag pesicsasa/fabric-kafka:latest hyperledger/fabric-kafka:latest

docker tag pesicsasa/fabric-couchdb:latest hyperledger/fabric-couchdb:latest

docker rmi pesicsasa/fabric-ca:latest

docker rmi pesicsasa/fabric-orderer:latest

docker rmi pesicsasa/fabric-peer:latest

docker rmi pesicsasa/fabric-tools:latest

docker rmi pesicsasa/fabric-ccenv:latest

docker rmi pesicsasa/fabric-baseos:latest

docker rmi pesicsasa/fabric-zookeeper:latest

docker rmi pesicsasa/fabric-kafka:latest

docker rmi pesicsasa/fabric-couchdb:latest


七、fabric和sample

sudo mkdir -p $GOPATH/src/github.com/hyperledger/ 

cd $GOPATH/src/github.com/hyperledger/ 

git clone https://github.com/hyperledger/fabric.git 

cd fabric 

git branch -a 

git checkout release-1.2  //使用1.2版



sample:

cd $GOPATH/src/github.com/hyperledger/ 

git clone https://github.com/hyperledger/fabric-samples.git 

cd fabric-samples 

git branch -a 

git checkout release-1.2



八、Makefile

因為不支持arm64，要新增一些配置

10x行: RELEASE_PLATFORMS 最後面添加linux-arm64

35x行:依照上面linux-s390x格式，改成linux-arm64的版本

release/linux-arm64: GOARCH=arm64 

release/linux-arm64: $(patsubst %,release/linux-arm64/bin/%, $(RELEASE_PKGS)) release/linux-arm64/install



make release 

ls release/linux-arm64/bin //確認是否有8個檔案

並將整個bin複製到fabric-samples下



九、測試

在fabric-samples有first-network這個範例

./byfn.sh up 測試是否成功


參考資料:

https://github.com/Tunstad/Hyperprov   

https://qiita.com/shibata_wk/items/a1025dd8562d0528a267

https://bcgh.wordpress.com/2018/11/04/hyperledger-fabric-1-2-on-raspberry-pi-3b/

https://blog.51cto.com/wutengfei/2395919

