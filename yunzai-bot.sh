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
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo  && wget -O /etc/yum.repos.d/epel.repo https://mirrors.aliyun.com/repo/epel-7.repo
echo "==============================================================================================="
echo "正在建立Yum缓存"
yum clean all &> /dev/null && yum makecache &> /dev/null
echo "==============================================================================================="
echo "Testing the Yum source"
echo "正在测试Yum源"
echo "==============================================================================================="
yum install -y wget
echo "==============================================================================================="
echo "Installing Chinese font dependencies"
echo "正在安装中文字体依赖"
echo "==============================================================================================="
yum groupinstall fonts -y &> /dev/null
#检测git环境，并且安装
echo "正在检测Git环境"
echo "==============================================================================================="
if git --version &> /dev/null; then
    echo "Git环境已经安装"
    git --version
    echo "==============================================================================================="
else
    echo "正在安装Git"
    yum install -y git &> /dev/null
    echo "==============================================================================================="
    echo "正在测试Git环境"
    git --version
    echo "==============================================================================================="
fi
#检测redis数据库，并且安装
echo "正在检测redis环境"
echo "==============================================================================================="
if redis-server --version &> /dev/null; then
    echo "Redis环境已经安装"
    redis-server --version
    echo "==============================================================================================="
else
    echo "正在安装Redis"
    yum -y install redis &> /dev/null && redis-server --daemonize yes &> /dev/null
    echo "==============================================================================================="
    echo "正在测试Redis环境"
    redis-server --version
    echo "==============================================================================================="
fi
#检测Nodejs，并且安装
echo "正在检测Nodejs环境"
echo "==============================================================================================="
if node -v &> /dev/null; then
    echo "Nodejs环境已经安装"
    node -v && npm -v
    echo "==============================================================================================="
else
    echo "正在安装Nodejs"
    curl -sL https://rpm.nodesource.com/setup_16.x | bash - &> /dev/null && yum -y install nodejs &> /dev/null
    echo "==============================================================================================="
    echo "正在测试Nodejs环境"
    node -v && npm -v
    echo "==============================================================================================="
fi
#检测Chromeium，并且安装
echo "正在检测Chromium环境"
echo "==============================================================================================="
if rpm -q chromium &> /dev/null; then
    echo "Chromium环境已经安装"
    rpm -q chromium
    echo "==============================================================================================="
else
    echo "正在安装Chromium"
    yum -y install chromium &> /dev/null
    echo "==============================================================================================="
    echo "正在测试Chromium环境"
    rpm -q chromium
    echo "==============================================================================================="
fi
#选择YunZai版本
cat << eof
=========请选择您要安装的版本===============
1.安装Miao-YunZai(请输入1)
2.安装TRSS-YunZai(请输入2)
3.退出安装(请输入3)
==========================================
eof
echo 
read -p "请选择你要安装的版本:" choose
case $choose in
    1)
        echo "==============================================================================================="
        echo "正在安装Miao-YunZai"
        echo "==============================================================================================="
        echo "Miao-YunZai-Bot is being cloned"
        echo "正在克隆Miao-YunZai-Bot"
        echo "==============================================================================================="
        git clone https://gitee.com/yoimiya-kokomi/Miao-Yunzai.git &> /dev/null
        git clone --depth 1 https://gitee.com/yoimiya-kokomi/miao-plugin plugins/miao-plugin &> /dev/null
        echo "Miao-YunZai-Bot is being installed"
        echo "正在安装Miao-YunZai-Bot"
        cd Miao-Yunzai && pwd
        echo "==============================================================================================="
        npm --registry=https://registry.npmmirror.com install pnpm -g &> /dev/null && pnpm config set registry https://registry.npmmirror.com &> /dev/null && pnpm install -P &> /dev/null && pnpm add image-size -w &> /dev/null
        echo "Miao-YunZai-Bot has been installed! Looking forward to your next use! by@WangShengJJ"
        echo 'Miao-YunZai-Bot已经安装完成! 期待您的下次使用! by@WangShengJJ'    
        echo "==============================================================================================="
        echo "The shell will automatically start Miao-YunZai-Bot in 5 seconds!"
        echo '脚本将于5秒后自动启动Miao-YunZai-Bot!'
        echo "==============================================================================================="
        sleep 5s
        node app
        ;;
    2)
        echo "==============================================================================================="
        echo "正在安装TRSS-YunZai"
        echo "==============================================================================================="
        echo "TRSS-YunZai-Bot is being cloned"
        echo "正在克隆TRSS-YunZai-Bot"
        echo "==============================================================================================="
        git clone https://gitee.com/TimeRainStarSky/Yunzai &> /dev/null
        git clone --depth 1 https://gitee.com/yoimiya-kokomi/miao-plugin plugins/miao-plugin &> /dev/null
        echo "TRSS-YunZai-Bot is being installed"
        echo "正在安装TRSS-YunZai-Bot"
        cd Yunzai && pwd
        echo "==============================================================================================="
        npm --registry=https://registry.npmmirror.com install pnpm -g &> /dev/null && pnpm config set registry https://registry.npmmirror.com &> /dev/null && pnpm install -P &> /dev/null && pnpm add image-size -w &> /dev/null
        echo "TRSS-YunZai-Bot has been installed! Looking forward to your next use! by@WangShengJJ"
        echo 'TRSS-YunZai-Bot已经安装完成! 期待您的下次使用! by@WangShengJJ'    
        echo "==============================================================================================="
        echo "The shell will automatically start TRSS-YunZai-Bot in 5 seconds!"
        echo '脚本将于5秒后自动启动TRSS-YunZai-Bot!'
        echo "==============================================================================================="
        sleep 5s
        node app
        ;;
    3)
        echo "用户选择退出安装"
        exit 0
        ;;
    *)
        echo "选择错误"
        exit 1
        ;;
esac
