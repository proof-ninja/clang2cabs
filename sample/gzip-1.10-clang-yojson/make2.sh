FBclang="/home/kmr/Dropbox/Work/Research/Project/infer/facebook-clang-plugins/clang/install/bin/clang"
FBclangPlugin="/home/kmr/Dropbox/Work/Research/Project/infer/facebook-clang-plugins/libtooling/build/FacebookClangPlugin.dylib"
FBclangOptions="-fsyntax-only -Xpreprocessor -detailed-preprocessing-record -Xclang -load -Xclang /home/kmr/Dropbox/Work/Research/Project/infer/facebook-clang-plugins/libtooling/build/FacebookClangPlugin.dylib -Xclang -plugin -Xclang YojsonASTExporter -Xclang -plugin-arg-YojsonASTExporter"
make  all-recursive
cd '/home/kmr/Documents/ninjaInputFiles/gzip-1.10-clang-yojson'
fail=; \
if (target_option=k; case ${target_option-} in ?) ;; *) echo "am__make_running_with_option: internal error: invalid" "target option '${target_option-}' specified" >&2; exit 1;; esac; has_opt=no; sane_makeflags=$MAKEFLAGS; if { if test -z '1'; then false; elif test -n 'x86_64-pc-linux-gnu'; then true; elif test -n '4.2.1' && test -n '/home/kmr/Documents/ninjaInputFiles/gzip-1.10-clang-yojson'; then true; else false; fi; }; then sane_makeflags=$MFLAGS; else case $MAKEFLAGS in *\\[\ \	]*) bs=\\; sane_makeflags=`printf '%s\n' "$MAKEFLAGS" | sed "s/$bs$bs[$bs $bs	]*//g"`;; esac; fi; skip_next=no; strip_trailopt () { flg=`printf '%s\n' "$flg" | sed "s/$1.*$//"`; }; for flg in $sane_makeflags; do test $skip_next = yes && { skip_next=no; continue; }; case $flg in *=*|--*) continue;; -*I) strip_trailopt 'I'; skip_next=yes;; -*I?*) strip_trailopt 'I';; -*O) strip_trailopt 'O'; skip_next=yes;; -*O?*) strip_trailopt 'O';; -*l) strip_trailopt 'l'; skip_next=yes;; -*l?*) strip_trailopt 'l';; -[dEDm]) skip_next=yes;; -[JT]) skip_next=yes;; esac; case $flg in *$target_option*) has_opt=yes; break;; esac; done; test $has_opt = yes); then \
  failcom='fail=yes'; \
else \
  failcom='exit 1'; \
fi; \
dot_seen=no; \
target=`echo all-recursive | sed s/-recursive//`; \
case "all-recursive" in \
  distclean-* | maintainer-clean-*) list='lib doc . tests' ;; \
  *) list='lib doc . tests' ;; \
esac; \
for subdir in $list; do \
  echo "Making $target in $subdir"; \
  if test "$subdir" = "."; then \
    dot_seen=yes; \
    local_target="$target-am"; \
  else \
    local_target="$target"; \
  fi; \
  (CDPATH="${ZSH_VERSION+.}:" && cd $subdir && make  $local_target) \
  || eval $failcom; \
done; \
if test "$dot_seen" = "no"; then \
  make  "$target-am" || exit 1; \
fi; test -z "$fail"

cd '/home/kmr/Documents/ninjaInputFiles/gzip-1.10-clang-yojson/lib'
test -f config.h || rm -f stamp-h1
test -f config.h || make  stamp-h1
make  all-am
cd '/home/kmr/Documents/ninjaInputFiles/gzip-1.10-clang-yojson/lib'
test -f config.h || rm -f stamp-h1
test -f config.h || make  stamp-h1
echo "  CC      " cloexec.o;depbase=`echo cloexec.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> cloexec.c ->  cloexec.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  cloexec.c.yojson -c  cloexec.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " opendir-safer.o;depbase=`echo opendir-safer.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> opendir-safer.c ->  opendir-safer.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  opendir-safer.c.yojson -c  opendir-safer.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " dirname-lgpl.o;depbase=`echo dirname-lgpl.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> dirname-lgpl.c ->  dirname-lgpl.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  dirname-lgpl.c.yojson -c  dirname-lgpl.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " basename-lgpl.o;depbase=`echo basename-lgpl.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> basename-lgpl.c ->  basename-lgpl.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  basename-lgpl.c.yojson -c  basename-lgpl.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " stripslash.o;depbase=`echo stripslash.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> stripslash.c ->  stripslash.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  stripslash.c.yojson -c  stripslash.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " exitfail.o;depbase=`echo exitfail.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> exitfail.c ->  exitfail.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  exitfail.c.yojson -c  exitfail.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " creat-safer.o;depbase=`echo creat-safer.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> creat-safer.c ->  creat-safer.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  creat-safer.c.yojson -c  creat-safer.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " open-safer.o;depbase=`echo open-safer.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> open-safer.c ->  open-safer.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  open-safer.c.yojson -c  open-safer.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " fd-hook.o;depbase=`echo fd-hook.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> fd-hook.c ->  fd-hook.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  fd-hook.c.yojson -c  fd-hook.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " fd-safer-flag.o;depbase=`echo fd-safer-flag.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> fd-safer-flag.c ->  fd-safer-flag.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  fd-safer-flag.c.yojson -c  fd-safer-flag.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " dup-safer-flag.o;depbase=`echo dup-safer-flag.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> dup-safer-flag.c ->  dup-safer-flag.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  dup-safer-flag.c.yojson -c  dup-safer-flag.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " filenamecat-lgpl.o;depbase=`echo filenamecat-lgpl.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> filenamecat-lgpl.c ->  filenamecat-lgpl.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  filenamecat-lgpl.c.yojson -c  filenamecat-lgpl.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " freading.o;depbase=`echo freading.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> freading.c ->  freading.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  freading.c.yojson -c  freading.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " getprogname.o;depbase=`echo getprogname.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> getprogname.c ->  getprogname.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  getprogname.c.yojson -c  getprogname.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " gettime.o;depbase=`echo gettime.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> gettime.c ->  gettime.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  gettime.c.yojson -c  gettime.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " malloca.o;depbase=`echo malloca.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> malloca.c ->  malloca.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  malloca.c.yojson -c  malloca.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " math.o;depbase=`echo math.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> math.c ->  math.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  math.c.yojson -c  math.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " openat-die.o;depbase=`echo openat-die.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> openat-die.c ->  openat-die.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  openat-die.c.yojson -c  openat-die.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " openat-safer.o;depbase=`echo openat-safer.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> openat-safer.c ->  openat-safer.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  openat-safer.c.yojson -c  openat-safer.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " printf-frexp.o;depbase=`echo printf-frexp.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> printf-frexp.c ->  printf-frexp.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  printf-frexp.c.yojson -c  printf-frexp.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " printf-frexpl.o;depbase=`echo printf-frexpl.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> printf-frexpl.c ->  printf-frexpl.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  printf-frexpl.c.yojson -c  printf-frexpl.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " save-cwd.o;depbase=`echo save-cwd.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> save-cwd.c ->  save-cwd.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  save-cwd.c.yojson -c  save-cwd.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " savedir.o;depbase=`echo savedir.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> savedir.c ->  savedir.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  savedir.c.yojson -c  savedir.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " sig-handler.o;depbase=`echo sig-handler.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> sig-handler.c ->  sig-handler.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  sig-handler.c.yojson -c  sig-handler.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " stat-time.o;depbase=`echo stat-time.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> stat-time.c ->  stat-time.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  stat-time.c.yojson -c  stat-time.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " statat.o;depbase=`echo statat.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> statat.c ->  statat.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  statat.c.yojson -c  statat.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " timespec.o;depbase=`echo timespec.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> timespec.c ->  timespec.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  timespec.c.yojson -c  timespec.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " unistd.o;depbase=`echo unistd.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> unistd.c ->  unistd.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  unistd.c.yojson -c  unistd.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " dup-safer.o;depbase=`echo dup-safer.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> dup-safer.c ->  dup-safer.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  dup-safer.c.yojson -c  dup-safer.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " fd-safer.o;depbase=`echo fd-safer.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> fd-safer.c ->  fd-safer.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  fd-safer.c.yojson -c  fd-safer.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " pipe-safer.o;depbase=`echo pipe-safer.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> pipe-safer.c ->  pipe-safer.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  pipe-safer.c.yojson -c  pipe-safer.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " utimens.o;depbase=`echo utimens.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> utimens.c ->  utimens.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  utimens.c.yojson -c  utimens.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " xmalloc.o;depbase=`echo xmalloc.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> xmalloc.c ->  xmalloc.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  xmalloc.c.yojson -c  xmalloc.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " xalloc-die.o;depbase=`echo xalloc-die.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> xalloc-die.c ->  xalloc-die.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  xalloc-die.c.yojson -c  xalloc-die.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " xsize.o;depbase=`echo xsize.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> xsize.c ->  xsize.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  xsize.c.yojson -c  xsize.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " yesno.o;depbase=`echo yesno.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> yesno.c ->  yesno.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  yesno.c.yojson -c  yesno.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " asnprintf.o;depbase=`echo asnprintf.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> asnprintf.c ->  asnprintf.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  asnprintf.c.yojson -c  asnprintf.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " calloc.o;depbase=`echo calloc.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> calloc.c ->  calloc.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  calloc.c.yojson -c  calloc.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " chdir-long.o;depbase=`echo chdir-long.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> chdir-long.c ->  chdir-long.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  chdir-long.c.yojson -c  chdir-long.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " fclose.o;depbase=`echo fclose.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> fclose.c ->  fclose.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  fclose.c.yojson -c  fclose.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " fcntl.o;depbase=`echo fcntl.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> fcntl.c ->  fcntl.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  fcntl.c.yojson -c  fcntl.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " fflush.o;depbase=`echo fflush.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> fflush.c ->  fflush.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  fflush.c.yojson -c  fflush.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " fpurge.o;depbase=`echo fpurge.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> fpurge.c ->  fpurge.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  fpurge.c.yojson -c  fpurge.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " fseek.o;depbase=`echo fseek.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> fseek.c ->  fseek.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  fseek.c.yojson -c  fseek.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " fseeko.o;depbase=`echo fseeko.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> fseeko.c ->  fseeko.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  fseeko.c.yojson -c  fseeko.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " fseterr.o;depbase=`echo fseterr.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> fseterr.c ->  fseterr.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  fseterr.c.yojson -c  fseterr.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " isnanf.o;depbase=`echo isnanf.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> isnanf.c ->  isnanf.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  isnanf.c.yojson -c  isnanf.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " isnanl.o;depbase=`echo isnanl.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> isnanl.c ->  isnanl.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  isnanl.c.yojson -c  isnanl.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " localtime-buffer.o;depbase=`echo localtime-buffer.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> localtime-buffer.c ->  localtime-buffer.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  localtime-buffer.c.yojson -c  localtime-buffer.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " openat-proc.o;depbase=`echo openat-proc.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> openat-proc.c ->  openat-proc.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  openat-proc.c.yojson -c  openat-proc.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " printf-args.o;depbase=`echo printf-args.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> printf-args.c ->  printf-args.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  printf-args.c.yojson -c  printf-args.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " printf-parse.o;depbase=`echo printf-parse.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> printf-parse.c ->  printf-parse.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  printf-parse.c.yojson -c  printf-parse.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " strerror_r.o;depbase=`echo strerror_r.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> strerror_r.c ->  strerror_r.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  strerror_r.c.yojson -c  strerror_r.c  &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " vasnprintf.o;depbase=`echo vasnprintf.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
echo "MSG>> vasnprintf.c ->  vasnprintf.c.yojson"
${FBclang} -DHAVE_CONFIG_H -I.      -g -O2  -MD -MP -MF $depbase.Tpo ${FBclangOptions} -Xclang  vasnprintf.c.yojson -c  vasnprintf.c  &&\
mv -f $depbase.Tpo $depbase.Po
rm -f libgzip.a
echo "  AR      " libgzip.a;ar cr libgzip.a cloexec.o opendir-safer.o dirname-lgpl.o basename-lgpl.o stripslash.o exitfail.o creat-safer.o open-safer.o fd-hook.o fd-safer-flag.o dup-safer-flag.o filenamecat-lgpl.o freading.o getprogname.o gettime.o glthread/lock.o malloca.o math.o openat-die.o openat-safer.o printf-frexp.o printf-frexpl.o save-cwd.o savedir.o sig-handler.o stat-time.o statat.o glthread/threadlib.o timespec.o unistd.o dup-safer.o fd-safer.o pipe-safer.o utimens.o xmalloc.o xalloc-die.o xsize.o yesno.o asnprintf.o calloc.o chdir-long.o fclose.o fcntl.o fflush.o fpurge.o fseek.o fseeko.o fseterr.o isnanf.o isnanl.o localtime-buffer.o openat-proc.o printf-args.o printf-parse.o strerror_r.o vasnprintf.o 
ranlib libgzip.a
cd ..
cd ..

cd '/home/kmr/Documents/ninjaInputFiles/gzip-1.10-clang-yojson/doc'

cd ..

cd '/home/kmr/Documents/ninjaInputFiles/gzip-1.10-clang-yojson'

cd ..

cd '/home/kmr/Documents/ninjaInputFiles/gzip-1.10-clang-yojson/tests'

cd ..
cd ..
