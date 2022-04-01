dir_build:=./module
dir_meta_inf:=$(dir_build)/META-INF/com/google/android
dir_system_etc:=$(dir_build)/system/etc
dir_system_fonts:=$(dir_build)/system/fonts
dir_xml:=$(dir_build)/xml
proxy:=http://127.0.0.1:7890
vpath update-binary ${dir_meta_inf}
vpath updater-script ${dir_meta_inf}
vpath %.ttf ${dir_system_fonts}
vpath %.ttc ${dir_system_fonts}
vpath %.xml ./src/xml
vpath customize.sh ./src
vpath module.prop ./src
vpath %.sed ./src
VPATH:=$(dir_build):$(dir_meta_inf):$(dir_system_fonts):$(dir_xml)

fonts:=NotoSans-VF.ttf NotoSans-Italic-VF.ttf NotoSansMono-VF.ttf NotoSerif-VF.ttf NotoSerif-Italic-VF.ttf NotoColorEmoji.ttf NotoSansCJK-VF.otf.ttc NotoSerifCJK-VF.otf.ttc Roboto-VF.ttf
xml:=roboto-sans-serif.xml roboto-sans-serif-condensed.xml noto-sans-serif.xml noto-sans-serif-condensed.xml noto-serif.xml noto-serif-condensed.xml noto-sans-monospace.xml noto-cjk-ja.xml noto-cjk-ko.xml noto-cjk-sc.xml noto-cjk-tc.xml fallback.xml

.PHONY:clean create_dirs

# 打包文件
fonts.zip:update-binary updater-script module.prop customize.sh $(fonts) $(xml)
	cd $(dir_build) && zip -r -b .. fonts.zip *\
	&& mv fonts.zip ../ \
	&& cd ..;
# 创建文件夹
create_dirs:
	mkdir -p $(dir_meta_inf);
	mkdir -p $(dir_system_etc);
	mkdir -p $(dir_system_fonts);

# 从 Magisk 仓库下载脚本
update-binary:
	curl -L -x $(proxy) -o $(dir_meta_inf)/update-binary "https://github.com/topjohnwu/Magisk/raw/master/scripts/module_installer.sh";
# 生成默认脚本
updater-script:
	echo "#MAGISK" > $(dir_meta_inf)/updater-script
# 生成默认信息文件
module.prop:
	[ ! -e ./src/module.prop ] && echo "id=<string>\nname=<string>\nversion=<string>\nversionCode=<int>\nauthor=<string>\ndescription=<string>\nupdateJson=<url> (optional)" > $(dir_build)/module.prop
# 生成空自定义脚本
customize.sh:mod_oos.sed mod.sed
	[ ! -e ./src/customize.sh ] && echo touch $(dir_build)/customize.sh
# 从 googlefonts 下载字体文件(使用代理)
NotoSans-VF.ttf:
	curl -L -x $(proxy) --output-dir '$(dir_system_fonts)' -O -R "https://github.com/googlefonts/noto-fonts/raw/main/unhinted/variable-ttf/NotoSans-VF.ttf"
NotoSans-Italic-VF.ttf:
	curl -L -x $(proxy) --output-dir '$(dir_system_fonts)' -O -R "https://github.com/googlefonts/noto-fonts/raw/main/unhinted/variable-ttf/NotoSans-Italic-VF.ttf"
NotoSansMono-VF.ttf:
	curl -L -x $(proxy) --output-dir '$(dir_system_fonts)' -O -R "https://github.com/googlefonts/noto-fonts/raw/main/unhinted/variable-ttf/NotoSansMono-VF.ttf";
NotoSerif-VF.ttf:
	curl -L -x $(proxy) --output-dir '$(dir_system_fonts)' -O -R "https://github.com/googlefonts/noto-fonts/raw/main/unhinted/variable-ttf/NotoSerif-VF.ttf";
NotoSerif-Italic-VF.ttf:
	curl -L -x $(proxy) --output-dir '$(dir_system_fonts)' -O -R "https://github.com/googlefonts/noto-fonts/raw/main/unhinted/variable-ttf/NotoSerif-Italic-VF.ttf";
NotoColorEmoji.ttf:
	curl -L -x $(proxy) --output-dir '$(dir_system_fonts)' -O -R "https://github.com/googlefonts/noto-emoji/raw/main/fonts/NotoColorEmoji.ttf";
NotoSansCJK-VF.otf.ttc:
	curl -L -x $(proxy) --output-dir '$(dir_system_fonts)' -O -R "https://github.com/googlefonts/noto-cjk/raw/main/Sans/Variable/OTC/NotoSansCJK-VF.otf.ttc";
NotoSerifCJK-VF.otf.ttc:
	curl -L -x $(proxy) --output-dir '$(dir_system_fonts)' -O -R "https://github.com/googlefonts/noto-cjk/raw/main/Serif/Variable/OTC/NotoSerifCJK-VF.otf.ttc";
Roboto-VF.ttf:
	curl -L -x $(proxy) -o '$(dir_system_fonts)/roboto.zip' -R "https://github.com/googlefonts/Roboto-Classic/releases/download/v3.004/Roboto_v3.004.zip";
	unzip $(dir_system_fonts)/roboto.zip -d $(dir_system_fonts)/roboto;
	mv '$(dir_system_fonts)/roboto/android/Roboto[ital,wdth,wght].ttf' '$(dir_system_fonts)/Roboto-VF.ttf';
	rm -rf $(dir_system_fonts)/roboto;
	rm $(dir_system_fonts)/roboto.zip;
# 单个字体配置文件
roboto-sans-serif.xml:
	[ -e ./src/xml/$@ ] && cp ./src/$@ $(dir_build)/xml
roboto-sans-serif-condensed.xml:
	[ -e ./src/xml/$@ ] && cp ./src/$@ $(dir_build)/xml
noto-sans-serif.xml:
	[ -e ./src/xml/$@ ] && cp ./src/$@ $(dir_build)/xml
noto-sans-serif-condensed.xml:
	[ -e ./src/xml/$@ ] && cp ./src/$@ $(dir_build)/xml
noto-serif.xml:
	[ -e ./src/xml/$@ ] && cp ./src/$@ $(dir_build)/xml
noto-serif-condensed.xml:
	[ -e ./src/xml/$@ ] && cp ./src/$@ $(dir_build)/xml
noto-sans-monospace.xml:
	[ -e ./src/xml/$@ ] && cp ./src/$@ $(dir_build)/xml
noto-cjk-ja.xml:
	[ -e ./src/xml/$@ ] && cp ./src/$@ $(dir_build)/xml
noto-cjk-ko.xml:
	[ -e ./src/xml/$@ ] && cp ./src/$@ $(dir_build)/xml
noto-cjk-sc.xml:
	[ -e ./src/xml/$@ ] && cp ./src/$@ $(dir_build)/xml
noto-cjk-tc.xml:
	[ -e ./src/xml/$@ ] && cp ./src/$@ $(dir_build)/xml
fallback.xml:
	[ -e ./src/xml/$@ ] && cp ./src/$@ $(dir_build)/xml
# 清理
clean:
	-rm -rf $(dir_build)/META-INF
	-rm -rf $(dir_build)/system
	-rm fonts.zip
