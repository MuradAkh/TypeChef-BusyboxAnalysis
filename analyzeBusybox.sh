#!/bin/bash -e
#!/bin/bash -vxe

filesToProcess() {
  local listFile=busybox/busybox_files
  cat $listFile
  #awk -F: '$1 ~ /.c$/ {print gensub(/\.c$/, "", "", $1)}' < linux_2.6.33.3_pcs.txt
}


flags="-U HAVE_LIBDMALLOC -DCONFIG_FIND -U CONFIG_FEATURE_WGET_LONG_OPTIONS -U ENABLE_NC_110_COMPAT -U CONFIG_EXTRA_COMPAT -D_GNU_SOURCE"
srcPath="busybox-1.18.5"
export partialPreprocFlags="-x CONFIG_ --bdd -I /usr/local/include --include busybox/config.h -I $srcPath/include --featureModelFExpr busybox/featureModel \
  --output=/home/murad/typechefdump/d
  --writePI    --serializeAST      --simplifyPresenceConditions   --recordTiming --parserstatistics --lexdebug \
   --dumpcfg -t --interface --debugInterface --errorXML"



## Reset output
filesToProcess|while read i; do
  if [ ! -f $srcPath/$i.dbg ]; then
    file_name=`echo "$i" | tr '/' '_'`
    touch $srcPath/$i.dbg
    ./jcpp.sh $srcPath/$i.c $flags
    cp /home/murad/typechefdump/d.cfg /home/murad/typechefdump/busybox/$file_name.cfg 
  else
    echo "Skipping $srcPath/$i.c"
  fi
done

