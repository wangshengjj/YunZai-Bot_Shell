#! /bin/bash
echo "==============================================================================================="
echo 'Welcome to Miao-YunZai-Bot one-click installation script, this script is made by WangShengJJ'
echo '欢迎使用Miao-YunZai-Bot一键安装脚本,本脚本由网笙久久制作'
echo '注意:本脚本仅支持Centos7!'
echo '访问网笙久久的博客,查看更多信息! 链接 https://www.wangshengjj.work/'
echo "==============================================================================================="
echo "The Yum source is being configured, please wait patiently for a long time"
echo -e "正在配置Yum源 \e[31m时间较长请耐心等待\e[0m"
echo "==============================================================================================="
yum install -y wget &> /dev/null && yum install -y curl &> /dev/null
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo &> /dev/null && wget -O /etc/yum.repos.d/epel.repo https://mirrors.aliyun.com/repo/epel-7.repo &> /dev/null
yum clean all &> /dev/null && yum makecache &> /dev/null
echo "Testing the Yum source"
echo "正在测试Yum源"
echo "==============================================================================================="
yum install -y wget
echo "==============================================================================================="
echo "Installing Chinese font dependencies"
echo "正在安装中文字体依赖"
echo "==============================================================================================="
yum groupinstall fonts -y &> /dev/null
echo "Installing Git"
echo "正在安装Git" 
echo "==============================================================================================="
yum install -y git &> /dev/null
echo "Testing the Git environment"
echo "正在测试Git环境"
git version
echo "==============================================================================================="
echo "Installing Redis"
echo "正在安装Redis"
echo "==============================================================================================="
yum -y install redis &> /dev/null && redis-server --daemonize yes &> /dev/null
echo "Installing Nodejs16"
echo "正在安装Nodejs16"
echo "==============================================================================================="
curl -sL https://rpm.nodesource.com/setup_16.x | bash - &> /dev/null && yum -y install nodejs &> /dev/null
echo "Testing the Nodejs environment"
echo "正在测试Nodejs环境"
node -v && npm -v
echo "==============================================================================================="
echo "Installing Chromeium"
echo "正在安装Chromeium"
echo "==============================================================================================="
yum -y install chromium &> /dev/null
echo "Miao-YunZai-Bot is being cloned"
echo "正在克隆Miao-YunZai-Bot"
echo "==============================================================================================="
git clone https://gitee.com/yoimiya-kokomi/Miao-Yunzai.git &> /dev/null
echo "Miao-YunZai-Bot is being installed"
echo "正在安装Miao-YunZai-Bot"
cd Miao-Yunzai && pwd
echo "==============================================================================================="
npm install pnpm -g &> /dev/null && pnpm install -P &> /dev/null
echo "Miao-YunZai-Bot has been installed! Looking forward to your next use! by@WangShengJJ"
echo 'Miao-YunZai-Bot已经安装完成! 期待您的下次使用! by@WangShengJJ'
echo "==============================================================================================="
echo "The bash will automatically start Miao-YunZai-Bot in 5 seconds!"
echo '脚本将于5秒后自动启动Miao-YunZai-Bot!'
echo "==============================================================================================="
sleep 5s
node app











