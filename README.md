

# YunZai-Bot V3 一键部署脚本

## 这是一个还在测试的脚本，目前仅支持`Centos7`系统

- 用到的环境：
  - [Nodejs](https://nodejs.org/en)
  - [Git](https://git-scm.com/)
  - [Redis](https://redis.io/)
  - [Miao-YunZai-Bot V3](https://github.com/yoimiya-kokomi/Miao-Yunzai)
  - [TRSS-YunZai-Bot](https://gitee.com/TimeRainStarSky/TRSS_Yunzai)
  - [go-cqhttp](https://github.com/Mrs4s/go-cqhttp)

## 如果您懂得其他，发行版`Linux`系统的使用，可以根据您的使用习惯`修改`命令

## 使用教程：

### 一、使用Git clone 本仓库

```
git clone https://github.com/wangshengjj/YunZai-Bot_Shell.git
```

### 二、赋予执行权限

```
chmod 777 ./YunZai-Bot_Shell/yunzai-bot.sh
```

### 三、执行

```
./YunZai-Bot_Shell/yunzai-bot.sh
```

**或**

```
bash ./YunZai-Bot_Shell/yunzai-bot.sh
```
### 四、报错解决

如果go-cqhttp提示如下字样，请修改`Yunzai/go-cqhttp/device.json`文件

> 把`"protocol":6,"imei"` 里面的6改成3即可

```
[2023-04-19 23:30:11] [WARNING]: 登录失败: 登录失败，建议升级最新版本后重试，或通过问题反馈与我们联系。 Code: 45 
[2023-04-19 23:30:11] [WARNING]: 你的账号涉嫌违规被限制在非常用设备登录, 请在手机QQ登录并根据提示完成认证 
[2023-04-19 23:30:11] [WARNING]: 或使用 -update-protocol 升级到最新协议后重试
```

## 欢迎访问我的博客https://www.wangshengjj.work

![logo](https://www.wangshengjj.work/upload/2022/10/logo3.png)
