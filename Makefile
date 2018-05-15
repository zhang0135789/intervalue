VERSION=`cut -d '"' -f2 $BUILDDIR/../version.js`

cordova-base:
	grunt dist-mobile

wp8-prod:
	cordova/build.sh WP8 --clear
	cordova/wp/fix-svg.sh
	echo -e "\a"

wp8-debug:
	cordova/build.sh WP8 --dbgjs
	cordova/wp/fix-svg.sh
	echo -e "\a"

ios:
	cordova/build.sh IOS --dbgjs
	cd ../miaochainbuilds/project-IOS && cordova build ios
	open ../miaochainbuilds/project-IOS/platforms/ios/MiaoChain.xcodeproj

ios-prod:
	cordova/build.sh IOS --clear
	cd ../miaochainbuilds/project-IOS && cordova build ios

ios-debug:
	cordova/build.sh IOS --dbgjs
	cd ../miaochainbuilds/project-IOS && cordova build ios
	open ../miaochainbuilds/project-IOS/platforms/ios/MiaoChain.xcodeproj

android:
	test -d "../miaochainbuilds" || mkdir ../miaochainbuilds
	cordova/build.sh ANDROID --clear
	cd ../miaochainbuilds/project-ANDROID && cordova build android 2>&1 >/dev/null
	mv ../miaochainbuilds/project-ANDROID/platforms/android/build/outputs/apk/android-debug.apk ../miaochainbuilds/MiaoChain.apk

android-prod:
	cordova/build.sh ANDROID --clear
	cd ../miaochainbuilds/project-ANDROID && cordova build android 2>&1 >/dev/null
	mv ../miaochainbuilds/project-ANDROID/platforms/android/build/outputs/apk/android-debug.apk ../miaochainbuilds/MiaoChain.apk

android-prod-fast:
	cordova/build.sh ANDROID
#	cd ../miaochainbuilds/project-ANDROID && cordova run android --device
	cd ../miaochainbuilds/project-ANDROID && cordova build android 2>&1 >/dev/null
	mv ../miaochainbuilds/project-ANDROID/platforms/android/build/outputs/apk/android-debug.apk ../miaochainbuilds/MiaoChain.apk

android-debug:
	cordova/build.sh ANDROID --dbgjs --clear
	cd ../miaochainbuilds/project-ANDROID && cordova build android 2>&1 >/dev/null
	mv ../miaochainbuilds/project-ANDROID/platforms/android/build/outputs/apk/android-debug.apk ../miaochainbuilds/MiaoChain.apk

android-debug-fast:
	cordova/build.sh ANDROID --dbgjs
	cd ../miaochainbuilds/project-ANDROID && cordova run android --device

win32:
	grunt.cmd desktop
	cp -rf node_modules ../miaochainbuilds/MiaoChain/win32/
	grunt.cmd inno32

win64:
	grunt.cmd inno64

linux64:
	grunt desktop
	cp -rf node_modules ../miaochainbuilds/MiaoChain/linux64/
	grunt linux64

osx64:
	grunt desktop
	cp -rf node_modules ../miaochainbuilds/MiaoChain/osx64/MiaoChain.app/Contents/Resources/app.nw/
	grunt dmg