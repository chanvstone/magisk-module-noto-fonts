#!/bin/bash

if [ -e /system/etc/fonts.xml ] then
    ui_print "fonts.xml found"
    sed -f mod.sed /system/etc/fonts.xml > ${MODPATH}/system/etc/fonts.xml
    ui_print "fonts.xml modified"
elif [ -e /system/system/etc/fonts.xml ] then
    ui_print "fonts.xml found"
    sed -f mod.sed /system/system/etc/fonts.xml > ${MODPATH}/system/etc/fonts.xml
    ui_print "fonts.xml modified"
else
    abort "fonts.xml not found"
fi

if [ -e /system/etc/fonts_slate.xml ] then
    ui_print "fonts_slate.xml found"
    sed -f mod_oos.sed /system/etc/fonts_slate.xml > ${MODPATH}/system/etc/fonts_slate.xml
    ui_print "fonts_slate.xml modified"
elif [ -e /system/system/etc/fonts_slate.xml ] then
    ui_print "fonts_slate.xml found"
    sed -f mod_oos.sed /system/system/etc/fonts_slate.xml > ${MODPATH}/system/etc/fonts_slate.xml
    ui_print "fonts_slate.xml modified"
else
    abort "fonts_slate.xml not found"
fi

ui_print "All modification has been done"