##使用

 
####1.通过shell脚本实现从archive->生成ipa->上传到第三方平台（Fir.im 、蒲公英）或 App store。流程：
 
 1.将文件夹中的几文件拖入工程的根目录
 
 2.根据自己需求选择好描述文件
 
 3.根据自己的项目修改一下shell.sh (修改哪里下面会指出)
 
 4.cd到工程根目录，通过./shell.sh 执行脚本即可

####2.准备工作：发布到‘fir’需要安装fir-cli ## gem install fir-cli

####3.根据实际情况修改shell脚本里面的配置

####4.cd到工程文件内， 执行./shell.sh
####5.平台选择：1-AppStore 2-Fir 3-蒲公英