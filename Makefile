dir_build:=./module
dir_meta_inf:=$(dir_build)/META-INF/com/google/android
dir_system_etc:=$(dir_build)/system/etc
dir_system_fonts:=$(dir_build)/system/fonts
proxy:=http://127.0.0.1:7890
fonts:=NotoColorEmoji.ttf\
NotoSansCJK-VF.otf.ttc\
NotoSansMono-VF.ttf\
NotoSerifCJK-VF.otf.ttc\
NotoSerif-Italic-VF.ttf\
NotoSerif-VF.ttf\
Roboto-VF.ttf
VPATH:=src:$(dir_build):$(dir_meta_inf):$(dir_system_fonts)
CFLAGS:=-std=c17

.PHONY:clean

# 打包文件
fonts.zip:update-binary updater-script module.prop customize.sh mod\
	NotoSansMono-VF.ttf NotoSerif-VF.ttf NotoSerif-Italic-VF.ttf NotoColorEmoji.ttf\
	NotoSansCJK-VF.otf.ttc NotoSerifCJK-VF.otf.ttc Roboto-VF.ttf
	cd $(dir_build) && zip -r -b .. fonts.zip *\
	&& mv fonts.zip ../ \
	&& cd ..;
# 从 Magisk 仓库下载脚本
update-binary:
	curl -L -x $(proxy) -o $(dir_meta_inf)/update-binary "https://github.com/topjohnwu/Magisk/raw/master/scripts/module_installer.sh";
# 生成默认脚本
updater-script:
	echo "#MAGISK" > $(dir_meta_inf)/updater-script
# 生成默认信息文件
module.prop:
	echo "id=<string>\nname=<string>\nversion=<string>\nversionCode=<int>\nauthor=<string>\ndescription=<string>\nupdateJson=<url> (optional)" > $(dir_build)/module.prop
# 生成空自定义脚本
customize.sh:
	touch $(dir_build)/customize.sh
# 从 googlefonts 下载字体文件(使用代理)
NotoSansMono-VF.ttf:
	curl -L -x $(proxy) --output-dir '$(dir_system_fonts)' -O -R "https://github.com/googlefonts/noto-fonts/raw/main/unhinted/variable-ttf/NotoSansMono-VF.ttf";
NotoSerif-VF.ttf:
	curl -L -x $(proxy) --output-dir '$(dir_system_fonts)' -O -R "https://github.com/googlefonts/noto-fonts/raw/main/unhinted/variable-ttf/NotoSerif-VF.ttf";
NotoSerif-Italic-VF.ttf:
	curl -L -x $(proxy) --output-dir '$(dir_system_fonts)' -O -R "https://github.com/googlefonts/noto-fonts/raw/main/unhinted/variable-ttf/NotoSerif-Italic-VF.ttf";
NotoColorEmoji.ttf:
	curl -L -x $(proxy) --output-dir '$(dir_system_fonts)' -O -R "https://raw.githubusercontent.com/googlefonts/noto-emoji/main/fonts/NotoColorEmoji.ttf";
NotoSansCJK-VF.otf.ttc:
	curl -L -x $(proxy) --output-dir '$(dir_system_fonts)' -O -R "https://raw.githubusercontent.com/googlefonts/noto-cjk/main/Sans/Variable/OTC/NotoSansCJK-VF.otf.ttc";
NotoSerifCJK-VF.otf.ttc:
	curl -L -x $(proxy) --output-dir '$(dir_system_fonts)' -O -R "https://raw.githubusercontent.com/googlefonts/noto-cjk/main/Serif/Variable/OTC/NotoSerifCJK-VF.otf.ttc";
Roboto-VF.ttf:
	curl -L -x $(proxy) -o '$(dir_system_fonts)/roboto.zip' -R "https://github.com/googlefonts/Roboto-Classic/releases/download/v3.004/Roboto_v3.004.zip";
	unzip $(dir_system_fonts)/roboto.zip -d $(dir_system_fonts)/roboto;
	mv '$(dir_system_fonts)/roboto/android/Roboto[ital,wdth,wght].ttf' '$(dir_system_fonts)/Roboto-VF.ttf';
	rm -rf $(dir_system_fonts)/roboto;
	rm $(dir_system_fonts)/roboto.zip;
# 修改 fonts.xml 的二进制可执行文件
mod:main.o font.o
	$(CC) $(CFLAGS) -o $(dir_build)/$@ $^
main.o:font.h
font.o:font.h
# 清理
clean:
	-rm -rf $(dir_build);
	-rm font.o main.o fonts.zip;
	mkdir -p $(dir_meta_inf);
	mkdir -p $(dir_system_etc);
	mkdir -p $(dir_system_fonts);
