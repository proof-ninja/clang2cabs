make  all-recursive
make[1]: Entering directory '/home/kmr/Documents/ninjaInputFiles/gzip-1.10-clang-yojson'
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
Making all in lib
make[2]: Entering directory '/home/kmr/Documents/ninjaInputFiles/gzip-1.10-clang-yojson/lib'
test -f config.h || rm -f stamp-h1
test -f config.h || make  stamp-h1
make  all-am
make[3]: Entering directory '/home/kmr/Documents/ninjaInputFiles/gzip-1.10-clang-yojson/lib'
test -f config.h || rm -f stamp-h1
test -f config.h || make  stamp-h1
echo "  CC      " cloexec.o;depbase=`echo cloexec.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT cloexec.o -MD -MP -MF $depbase.Tpo -c -o cloexec.o cloexec.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " opendir-safer.o;depbase=`echo opendir-safer.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT opendir-safer.o -MD -MP -MF $depbase.Tpo -c -o opendir-safer.o opendir-safer.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " dirname-lgpl.o;depbase=`echo dirname-lgpl.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT dirname-lgpl.o -MD -MP -MF $depbase.Tpo -c -o dirname-lgpl.o dirname-lgpl.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " basename-lgpl.o;depbase=`echo basename-lgpl.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT basename-lgpl.o -MD -MP -MF $depbase.Tpo -c -o basename-lgpl.o basename-lgpl.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " stripslash.o;depbase=`echo stripslash.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT stripslash.o -MD -MP -MF $depbase.Tpo -c -o stripslash.o stripslash.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " exitfail.o;depbase=`echo exitfail.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT exitfail.o -MD -MP -MF $depbase.Tpo -c -o exitfail.o exitfail.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " creat-safer.o;depbase=`echo creat-safer.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT creat-safer.o -MD -MP -MF $depbase.Tpo -c -o creat-safer.o creat-safer.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " open-safer.o;depbase=`echo open-safer.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT open-safer.o -MD -MP -MF $depbase.Tpo -c -o open-safer.o open-safer.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " fd-hook.o;depbase=`echo fd-hook.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT fd-hook.o -MD -MP -MF $depbase.Tpo -c -o fd-hook.o fd-hook.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " fd-safer-flag.o;depbase=`echo fd-safer-flag.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT fd-safer-flag.o -MD -MP -MF $depbase.Tpo -c -o fd-safer-flag.o fd-safer-flag.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " dup-safer-flag.o;depbase=`echo dup-safer-flag.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT dup-safer-flag.o -MD -MP -MF $depbase.Tpo -c -o dup-safer-flag.o dup-safer-flag.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " filenamecat-lgpl.o;depbase=`echo filenamecat-lgpl.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT filenamecat-lgpl.o -MD -MP -MF $depbase.Tpo -c -o filenamecat-lgpl.o filenamecat-lgpl.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " freading.o;depbase=`echo freading.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT freading.o -MD -MP -MF $depbase.Tpo -c -o freading.o freading.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " getprogname.o;depbase=`echo getprogname.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT getprogname.o -MD -MP -MF $depbase.Tpo -c -o getprogname.o getprogname.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " gettime.o;depbase=`echo gettime.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT gettime.o -MD -MP -MF $depbase.Tpo -c -o gettime.o gettime.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " malloca.o;depbase=`echo malloca.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT malloca.o -MD -MP -MF $depbase.Tpo -c -o malloca.o malloca.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " math.o;depbase=`echo math.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT math.o -MD -MP -MF $depbase.Tpo -c -o math.o math.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " openat-die.o;depbase=`echo openat-die.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT openat-die.o -MD -MP -MF $depbase.Tpo -c -o openat-die.o openat-die.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " openat-safer.o;depbase=`echo openat-safer.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT openat-safer.o -MD -MP -MF $depbase.Tpo -c -o openat-safer.o openat-safer.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " printf-frexp.o;depbase=`echo printf-frexp.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT printf-frexp.o -MD -MP -MF $depbase.Tpo -c -o printf-frexp.o printf-frexp.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " printf-frexpl.o;depbase=`echo printf-frexpl.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT printf-frexpl.o -MD -MP -MF $depbase.Tpo -c -o printf-frexpl.o printf-frexpl.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " save-cwd.o;depbase=`echo save-cwd.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT save-cwd.o -MD -MP -MF $depbase.Tpo -c -o save-cwd.o save-cwd.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " savedir.o;depbase=`echo savedir.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT savedir.o -MD -MP -MF $depbase.Tpo -c -o savedir.o savedir.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " sig-handler.o;depbase=`echo sig-handler.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT sig-handler.o -MD -MP -MF $depbase.Tpo -c -o sig-handler.o sig-handler.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " stat-time.o;depbase=`echo stat-time.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT stat-time.o -MD -MP -MF $depbase.Tpo -c -o stat-time.o stat-time.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " statat.o;depbase=`echo statat.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT statat.o -MD -MP -MF $depbase.Tpo -c -o statat.o statat.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " timespec.o;depbase=`echo timespec.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT timespec.o -MD -MP -MF $depbase.Tpo -c -o timespec.o timespec.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " unistd.o;depbase=`echo unistd.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT unistd.o -MD -MP -MF $depbase.Tpo -c -o unistd.o unistd.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " dup-safer.o;depbase=`echo dup-safer.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT dup-safer.o -MD -MP -MF $depbase.Tpo -c -o dup-safer.o dup-safer.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " fd-safer.o;depbase=`echo fd-safer.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT fd-safer.o -MD -MP -MF $depbase.Tpo -c -o fd-safer.o fd-safer.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " pipe-safer.o;depbase=`echo pipe-safer.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT pipe-safer.o -MD -MP -MF $depbase.Tpo -c -o pipe-safer.o pipe-safer.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " utimens.o;depbase=`echo utimens.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT utimens.o -MD -MP -MF $depbase.Tpo -c -o utimens.o utimens.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " xmalloc.o;depbase=`echo xmalloc.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT xmalloc.o -MD -MP -MF $depbase.Tpo -c -o xmalloc.o xmalloc.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " xalloc-die.o;depbase=`echo xalloc-die.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT xalloc-die.o -MD -MP -MF $depbase.Tpo -c -o xalloc-die.o xalloc-die.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " xsize.o;depbase=`echo xsize.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT xsize.o -MD -MP -MF $depbase.Tpo -c -o xsize.o xsize.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " yesno.o;depbase=`echo yesno.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT yesno.o -MD -MP -MF $depbase.Tpo -c -o yesno.o yesno.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " asnprintf.o;depbase=`echo asnprintf.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT asnprintf.o -MD -MP -MF $depbase.Tpo -c -o asnprintf.o asnprintf.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " calloc.o;depbase=`echo calloc.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT calloc.o -MD -MP -MF $depbase.Tpo -c -o calloc.o calloc.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " chdir-long.o;depbase=`echo chdir-long.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT chdir-long.o -MD -MP -MF $depbase.Tpo -c -o chdir-long.o chdir-long.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " fclose.o;depbase=`echo fclose.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT fclose.o -MD -MP -MF $depbase.Tpo -c -o fclose.o fclose.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " fcntl.o;depbase=`echo fcntl.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT fcntl.o -MD -MP -MF $depbase.Tpo -c -o fcntl.o fcntl.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " fflush.o;depbase=`echo fflush.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT fflush.o -MD -MP -MF $depbase.Tpo -c -o fflush.o fflush.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " fpurge.o;depbase=`echo fpurge.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT fpurge.o -MD -MP -MF $depbase.Tpo -c -o fpurge.o fpurge.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " fseek.o;depbase=`echo fseek.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT fseek.o -MD -MP -MF $depbase.Tpo -c -o fseek.o fseek.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " fseeko.o;depbase=`echo fseeko.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT fseeko.o -MD -MP -MF $depbase.Tpo -c -o fseeko.o fseeko.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " fseterr.o;depbase=`echo fseterr.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT fseterr.o -MD -MP -MF $depbase.Tpo -c -o fseterr.o fseterr.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " isnanf.o;depbase=`echo isnanf.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT isnanf.o -MD -MP -MF $depbase.Tpo -c -o isnanf.o isnanf.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " isnanl.o;depbase=`echo isnanl.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT isnanl.o -MD -MP -MF $depbase.Tpo -c -o isnanl.o isnanl.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " localtime-buffer.o;depbase=`echo localtime-buffer.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT localtime-buffer.o -MD -MP -MF $depbase.Tpo -c -o localtime-buffer.o localtime-buffer.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " openat-proc.o;depbase=`echo openat-proc.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT openat-proc.o -MD -MP -MF $depbase.Tpo -c -o openat-proc.o openat-proc.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " printf-args.o;depbase=`echo printf-args.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT printf-args.o -MD -MP -MF $depbase.Tpo -c -o printf-args.o printf-args.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " printf-parse.o;depbase=`echo printf-parse.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT printf-parse.o -MD -MP -MF $depbase.Tpo -c -o printf-parse.o printf-parse.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " strerror_r.o;depbase=`echo strerror_r.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT strerror_r.o -MD -MP -MF $depbase.Tpo -c -o strerror_r.o strerror_r.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " vasnprintf.o;depbase=`echo vasnprintf.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT vasnprintf.o -MD -MP -MF $depbase.Tpo -c -o vasnprintf.o vasnprintf.c &&\
mv -f $depbase.Tpo $depbase.Po
rm -f libgzip.a
echo "  AR      " libgzip.a;ar cr libgzip.a cloexec.o opendir-safer.o dirname-lgpl.o basename-lgpl.o stripslash.o exitfail.o creat-safer.o open-safer.o fd-hook.o fd-safer-flag.o dup-safer-flag.o filenamecat-lgpl.o freading.o getprogname.o gettime.o glthread/lock.o malloca.o math.o openat-die.o openat-safer.o printf-frexp.o printf-frexpl.o save-cwd.o savedir.o sig-handler.o stat-time.o statat.o glthread/threadlib.o timespec.o unistd.o dup-safer.o fd-safer.o pipe-safer.o utimens.o xmalloc.o xalloc-die.o xsize.o yesno.o asnprintf.o calloc.o chdir-long.o fclose.o fcntl.o fflush.o fpurge.o fseek.o fseeko.o fseterr.o isnanf.o isnanl.o localtime-buffer.o openat-proc.o printf-args.o printf-parse.o strerror_r.o vasnprintf.o 
ranlib libgzip.a
make[3]: Leaving directory '/home/kmr/Documents/ninjaInputFiles/gzip-1.10-clang-yojson/lib'
make[2]: Leaving directory '/home/kmr/Documents/ninjaInputFiles/gzip-1.10-clang-yojson/lib'
Making all in doc
make[2]: Entering directory '/home/kmr/Documents/ninjaInputFiles/gzip-1.10-clang-yojson/doc'
make[2]: Nothing to be done for 'all'.
make[2]: Leaving directory '/home/kmr/Documents/ninjaInputFiles/gzip-1.10-clang-yojson/doc'
Making all in .
make[2]: Entering directory '/home/kmr/Documents/ninjaInputFiles/gzip-1.10-clang-yojson'
make[2]: Nothing to be done for 'all-am'.
make[2]: Leaving directory '/home/kmr/Documents/ninjaInputFiles/gzip-1.10-clang-yojson'
Making all in tests
make[2]: Entering directory '/home/kmr/Documents/ninjaInputFiles/gzip-1.10-clang-yojson/tests'
make[2]: Nothing to be done for 'all'.
make[2]: Leaving directory '/home/kmr/Documents/ninjaInputFiles/gzip-1.10-clang-yojson/tests'
make[1]: Leaving directory '/home/kmr/Documents/ninjaInputFiles/gzip-1.10-clang-yojson'
