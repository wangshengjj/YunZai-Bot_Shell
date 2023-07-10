#! /bin/bash

echo "==============================================================================================="
echo 'Welcome to YunZai-Bot one-click installation script, this script is made by WangShengJJ'
echo '欢迎使用YunZai-Bot一键安装脚本,本脚本由网笙久久制作'
echo -e "注意:本脚本仅支持\e[31mCentos7! \e[0m"
echo '访问网笙久久的博客,查看更多信息! 链接 https://www.wsjj.top/'
echo "==============================================================================================="
echo "The Yum source is being configured, please wait patiently for a long time"
echo -e "正在配置国内Yum源 \e[31m时间较长请耐心等待\e[0m"
echo "==============================================================================================="
yum install -y wget &> /dev/null && yum install -y curl &> /dev/null
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo  && wget -O /etc/yum.repos.d/epel.repo https://mirrors.aliyun.com/repo/epel-7.repo
echo "==============================================================================================="
echo -e "正在建立Yum缓存 \e[31m时间较长请耐心等待\e[0m"
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
# 检测git环境，并且安装
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
fi
# 升级libstdc++.so.6
if !( strings /usr/lib64/libstdc++.so.6 | grep CXXABI_1.3.8 ); then
    echo "==============================================================================================="
    echo "正在升级libstdc++.so.6库"
    cd / && git clone https://gitee.com/wangshengjj/go-cqhttp.git && mv /usr/lib64/libstdc++.so.6 /usr/lib64/libstdc++.so.6.bak && cp -r ./go-cqhttp/libstdc++.so.6 /usr/lib64/
fi
# 检测redis数据库，并且安装
echo "==============================================================================================="
echo "正在检测Redis环境"
echo "==============================================================================================="
if redis-server --version &> /dev/null; then
    echo "Redis环境已经安装"
    redis-server --version
    echo "==============================================================================================="
else
    echo "正在安装Redis"
    yum -y install redis &> /dev/null && redis-server --daemonize yes &> /dev/null
    # 把redis加入开机启动项
    systemctl enable redis &> /dev/null
    echo "==============================================================================================="
    echo "正在测试Redis环境"
    redis-server --version
    echo "==============================================================================================="
fi
# 检测Nodejs，并且安装
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
# 检测Chromeium，并且安装
echo "正在检测Chromium环境"
echo "==============================================================================================="
if rpm -q chromium &> /dev/null; then
    echo "Chromium环境已经安装"
    rpm -q chromium
    echo "==============================================================================================="
else
    echo -e "正在安装Chromium \e[31m时间较长请耐心等待\e[0m"
    yum -y install chromium &> /dev/null
    echo "==============================================================================================="
    echo "正在测试Chromium环境"
    rpm -q chromium
    echo "==============================================================================================="
fi
while true; do
# 选择YunZai版本
cat << eof
=========请选择您要安装的版本===============
1.安装Miao-YunZai(请输入1)
2.安装TRSS-YunZai(请输入2)
3.退出安装(请输入3)
============================================
eof
echo 
read -p "请选择你要安装的版本:" choice
case $choice in
    1)
        Miao_Yunzai_Dir=$(find / -type d -name "Miao-Yunzai" 2>/dev/null)
        if [ -d "${Miao_Yunzai_Dir}" ]; then
            echo "==============================================================================================="
            echo "监测到Miao-Yunzai，正在尝试启动"
            cd "${Miao_Yunzai_Dir}" && node app
            if (($? != 0)); then
                echo "==============================================================================================="
                echo "您的Miao-Yunzai存在问题，请手动删除目录后重新执行此脚本"
                exit 1
            fi
        else
            echo "==============================================================================================="
            echo "正在安装Miao-YunZai"
            echo "==============================================================================================="
            echo "Miao-YunZai-Bot is being cloned"
            echo "正在克隆Miao-YunZai-Bot"
            git clone https://gitee.com/yoimiya-kokomi/Miao-Yunzai.git &> /dev/null
            echo "==============================================================================================="
            echo "当前脚本所在的运行目录"
            cd Miao-Yunzai && pwd
            echo "==============================================================================================="
            echo "正在安装喵喵插件"
            # 安装喵喵插件和
            git clone --depth 1 https://gitee.com/yoimiya-kokomi/miao-plugin plugins/miao-plugin &> /dev/null
            echo "==============================================================================================="
            echo "Miao-YunZai-Bot is being installed"
            echo "正在安装Miao-YunZai-Bot"
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
        fi
        break
        ;;
    2)
        TRSS_Yunzai_Dir=$(find / -type d -name "Yunzai" 2> /dev/null)
        if [ -d "${TRSS_Yunzai_Dir}" ]; then
            echo "==============================================================================================="
            echo "监测到TRSS-Yunzai，正在尝试启动"
            cd "${TRSS_Yunzai_Dir}" && nohup node app &
            if ! ps -aux | grep -v "grep" |grep -i "TRSS Yun" &> /dev/null ; then
                echo -e "您的TRSS-Yunzai启动失败，请手动删除目录后重新执行此脚本"
                exit 1
            fi
        else
            echo "==============================================================================================="
            echo "正在安装TRSS-YunZai"
            echo "==============================================================================================="
            echo "TRSS-YunZai-Bot is being cloned"
            echo "正在克隆TRSS-YunZai-Bot"
            git clone https://gitee.com/TimeRainStarSky/Yunzai
            echo "==============================================================================================="
            echo "当前脚本所在的运行目录"
            cd Yunzai && pwd
            echo "==============================================================================================="
            echo "正在安装喵喵插件 和 Genshin插件 和 锅巴插件"
            # 安装喵喵插件 和 Genshin插件 和 锅巴插件
            git clone --depth 1 https://gitee.com/yoimiya-kokomi/miao-plugin plugins/miao-plugin
            git clone --depth 1 https://gitee.com/TimeRainStarSky/Yunzai-genshin.git plugins/genshin
            git clone --depth 1 https://gitee.com/guoba-yunzai/guoba-plugin.git ./plugins/Guoba-Plugin/
            echo "==============================================================================================="
            echo "TRSS-YunZai-Bot is being installed"
            echo "正在安装TRSS-YunZai-Bot"
            echo "==============================================================================================="
            echo -e "如果遇到 \e[31msqlite3\e[0m 下载失败，请尝试更换网络环境！"
            echo "==============================================================================================="
            npm --registry=https://registry.npmmirror.com install pnpm -g
            pnpm config set registry https://registry.npmmirror.com
            pnpm install -P
            if [ "$?" != 0 ]; then
                for i in $(seq 3); do
                    echo "==============================================================================================="
                    echo -e "\e[31msqlite3\e[0m下载失败，正在重试,第${i}次"
                    pnpm config set registry https://registry.npmmirror.com
                    pnpm install -P
                        if [ "$?" = 0 ]; then
                            break
                        fi
                done
            fi
            echo "==============================================================================================="
            echo "The shell will automatically start TRSS-YunZai-Bot in 5 seconds!"
            echo '脚本将于5秒后自动启动TRSS-YunZai-Bot!'
            echo "==============================================================================================="
            sleep 5s
            nohup node app &
            jobs -l
            if ! ps -aux | grep -v "grep" |grep -i "TRSS Yun" &> /dev/null ; then
                echo -e "TRSS-Yunzai启动失败，请检查\e[31msqlite3\e[0m是否安装成功"
                echo "正在退出安装脚本"
                exit 1
            fi
            echo "==============================================================================================="
            echo "脚本已经将TRSS-YunZai放到后台运行"
            echo -e "您可以使用 \e[31m ps -aux | grep -i TRSS Yun\e[0m 命令，查看是否有后台进程名字为: \e[31mTRSS Yun\e[0m"
            echo -e "当你想关闭YunZai时 可以使用 \e[31mkill + 进程ID\e[0m 即可关掉!"
            echo -e "例:进程ID为114514 执行 \e[31mkill 114514\e[0m 即可"
            echo "==============================================================================================="
        fi
        echo "正在安装go-cqhttp"
        echo "==============================================================================================="
        # 安装自动操作工具expect
        yum install -y expect &> /dev/null
        # 判断文件是否存在
        if [ -e ./config.yml -a -e ./device.json ]; then
            # 修改设备信息 默认使用扫码登录 如果想使用账号密码登录，请取消注释221-232行
            sed -r -i 's|("protocol":)6|\12|' ./device.json
            # echo "==============================================================================================="
            # echo "脚本不会记录您的QQ号,此QQ号仅用于登录YunZai-Bot!"
            # read -p "请输入您的QQ号(建议小号):" qq
            # echo "==============================================================================================="
            # echo "脚本不会记录您的QQ密码,此密码仅用于登录YunZai-Bot!"
            # read -p "请输入您的密码(必须输入密码):" pd
            # echo "==============================================================================================="
            # echo "脚本不会记录您的认证服务器地址"
            # read -p "请输入您的自定义认证服务器地址(为空则使用默认认证服务器):" SIGN_SERVER_URL
            # sed -i '/uin: /s|1233456|'$qq'|' ./config.yml
            # sed -i "s|password: ''|password: \'$pd\'|" ./config.yml
            # sed -i "/sign-server: '-'/s|'-'|'$SIGN_SERVER_URL'|" ./config.yml
            sed -i '/post-format: string/s|string|array|' ./config.yml
            sed -i '/universal: ws:\/\/your_websocket_universal.server/s|ws:\/\/your_websocket_universal.server|ws:\/\/localhost:2536/go-cqhttp|' ./config.yml
            echo "==============================================================================================="
            echo "TRSS-YunZai-Bot has been installed! Looking forward to your next use! by@WangShengJJ"
            echo 'TRSS-YunZai-Bot已经安装完成! 期待您的下次使用! by@WangShengJJ'
            echo "==============================================================================================="
            go-cqhttp
        else
            echo "==============================================================================================="
            echo -e "正在下载go-cqhttp \e[31m时间较长请耐心等待\e[0m"
            echo -e "\e[31m可能会出现下载失败的情况,如遇到请观看教程\e[0m"
            echo -e "教程链接： \e[31m https://www.wsjj.top/archives/trss-yunzai\e[0m"
            echo "==============================================================================================="
            cp -r /go-cqhttp ./
            echo "当前脚本所在目录"
            cd ./go-cqhttp && pwd
            # 判断是否下载成功
            if [ -e ./go-cqhttp_1.1.0_linux_amd64.rpm ]; then
                echo "==============================================================================================="
                echo "正在安装go-cqhttp"
                yum install -y go-cqhttp_1.1.0_linux_amd64.rpm &> /dev/null
            else
                echo "go-cqhttp下载失败,自动退出"
                exit 1
            fi
# 自动操作
/usr/bin/expect << eof
set timeout 5
spawn go-cqhttp
expect "您的选择是:"
send "3\n"
send "\n"
expect eof
eof
            # 故意不配置账号密码，让它提前自动生成设备信息
            echo "==============================================================================================="
            echo "正在修改设备信息"
            # echo "==============================================================================================="
            go-cqhttp &> /dev/null
            # 默认使用扫码登录策略,想使用账号密码登录，请取消注释274-285行代码
            sed -r -i 's|("protocol":)6|\12|' ./device.json
            # echo "==============================================================================================="
            # echo "脚本不会记录您的QQ号,此QQ号仅用于登录YunZai-Bot!"
            # read -p "请输入您的QQ号(建议小号):" qq
            # echo "==============================================================================================="
            # echo "脚本不会记录您的QQ密码,此密码仅用于登录YunZai-Bot!"
            # read -p "请输入您的密码(必须输入密码):" pd
            # echo "==============================================================================================="
            # echo "脚本不会记录您的认证服务器地址"
            # read -p "请输入您的自定义认证服务器地址(为空则使用默认认证服务器):" SIGN_SERVER_URL
            # sed -i '/uin: /s|1233456|'$qq'|' ./config.yml
            # sed -i "s|password: ''|password: \'$pd\'|" ./config.yml
            # sed -i "/sign-server: '-'/s|'-'|'$SIGN_SERVER_URL'|" ./config.yml
            sed -i '/post-format: string/s|string|array|' ./config.yml
            sed -i '/universal: ws:\/\/your_websocket_universal.server/s|ws:\/\/your_websocket_universal.server|ws:\/\/localhost:2536/go-cqhttp|' ./config.yml
            echo "==============================================================================================="
            echo "TRSS-YunZai-Bot has been installed! Looking forward to your next use! by@WangShengJJ"
            echo 'TRSS-YunZai-Bot已经安装完成! 期待您的下次使用! by@WangShengJJ'
            echo "==============================================================================================="
            go-cqhttp
        fi
        break
        ;;
    3)
        echo "用户选择退出安装"
        break 
        ;;
    *)
        echo "============================================"
        echo "选择有误,请重新选择！"
        continue
        ;;
esac
done