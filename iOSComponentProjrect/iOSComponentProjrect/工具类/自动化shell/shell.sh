#使用方法

if [ ! -d ./IPADir ];
then
mkdir -p IPADir;
fi

#计时
SECONDS=0

#工程绝对路径
project_path=$(cd `dirname $0`; pwd)

#工程名 将XXX替换成自己的工程名
project_name=XXX

#scheme名 将XXX替换成自己的sheme名
scheme_name=XXX

#打包模式 Debug/Release
development_mode=Debug

#build文件夹路径
build_path=${project_path}/build

#plist文件所在路径
exportOptionsPlistPath=${project_path}/exportTest.plist

#导出.ipa文件所在路径
exportIpaPath=${project_path}/IPADir/${development_mode}


echo "Place enter the number you want to export ? [ 1:app-store 2:ad-hoc-fir 3:ad-hoc-pgyer] "

##
read number
while([[ $number != 1 ]] && [[ $number != 2 ]] && [[ $number != 3 ]])
do
echo "Error! Should enter 1 or 2 or 3"
echo "Place enter the number you want to export ? [ 1:app-store 2:ad-hoc 3:ad-hoc-pgyer] "
read number
done

if [ $number == 1 ];then
development_mode=Release
exportOptionsPlistPath=${project_path}/exportAppstore.plist
else
development_mode=Debug
exportOptionsPlistPath=${project_path}/exportTest.plist
fi

echo '///-------------------------------------'
echo '///------------ 正在清理工程 -----------'
echo '///-------------------------------------'
xcodebuild \
clean -configuration ${development_mode} -quiet  || exit

echo "\n"
echo '///----------------------------------'
echo '///------------ 清理完成 -----------'
echo '///----------------------------------'
echo ''

echo "\n"
echo '///----------------------------------------'
echo '///------------- 正在编译工程:'${development_mode}
echo '///----------------------------------------'
xcodebuild \
archive -workspace ${project_path}/${project_name}.xcworkspace \
-scheme ${scheme_name} \
-configuration ${development_mode} \
-archivePath ${build_path}/${project_name}.xcarchive  -quiet  || exit

echo "\n"
echo '///----------------------------------'
echo '///------------- 编译完成 ------------'
echo '///----------------------------------'
echo ''

echo "\n"
echo '///------------------------------------'
echo '///------------- 开始ipa打包 ----------'
echo '///------------------------------------'
xcodebuild -exportArchive -archivePath ${build_path}/${project_name}.xcarchive \
-configuration ${development_mode} \
-exportPath ${exportIpaPath} \
-exportOptionsPlist ${exportOptionsPlistPath} \
-quiet || exit

if [ -e $exportIpaPath/$scheme_name.ipa ]; then
echo "\n"
echo '///------------------------------------'
echo '///------------- ipa包已导出 ----------'
echo '///------------------------------------'
open $exportIpaPath
else
echo "\n"
echo '///---------------------------------------'
echo '///------------- ipa包导出失败 -----------'
echo '///---------------------------------------'
fi
echo "\n"
echo '///--------------------------------------'
echo '///-------------  打包ipa完成 -----------'
echo '///--------------------------------------'
echo ''

echo "\n"
echo '///---------------------------------------'
echo '///------------- 开始发布ipa包 ----------- '
echo '///---------------------------------------'

if [ $number == 1 ];then
echo "\n"
echo "+++++++++++++++++++++++"
echo "+++++上传到App Store+++"
echo "+++++++++++++++++++++++"
#验证并上传到App Store -u 账户 -p app密码，不是Apple ID密码，获取方法https://www.cnblogs.com/gxspring/p/10750598.html
altoolPath="/Applications/Xcode.app/Contents/Applications/Application Loader.app/Contents/Frameworks/ITunesSoftwareService.framework/Versions/A/Support/altool"
"$altoolPath" --validate-app -f $exportIpaPath/$scheme_name.ipa -u zzxyh_ios@sina.com -p gvag-gnll-ezaa-ouec -t ios --output-format xml
"$altoolPath" --upload-app -f $exportIpaPath/$scheme_name.ipa -u  zzxyh_ios@sina.com -p gvag-gnll-ezaa-ouec -t ios --output-format xml

elif [ $number == 2 ];then
#上传到Fir
echo "\n"
echo "+++++++++++++++++++++++"
echo "++++++上传到Fir.im+++++"
echo "+++++++++++++++++++++++"
#T后是自己的Fir平台的token
fir login -T b604e02364f7385c2c0414df92f84cf6
fir publish $exportIpaPath/$scheme_name.ipa

else
#上传到蒲公英
#用户密钥
uKey="c4931a68b515963874bb05c9325b3676"
#API密钥
apiKry="23bb96bfdbe65bcacb929077aa46fa4b"
#上传
echo "\n"
echo "+++++++++++++++++++++++"
echo "++++++上传到蒲公英++++++"
echo "+++++++++++++++++++++++"
curl -F "file=@${exportIpaPath}/${scheme_name}.ipa" -F "uKey=${uKey}" -F "_api_key=${apiKry}" https://qiniu-storage.pgyer.com/apiv1/app/upload

fi

echo "\n"
echo "======================================="
echo "=======Finished. Total time:${SECONDS}s"
echo "======================================="

exit 0
