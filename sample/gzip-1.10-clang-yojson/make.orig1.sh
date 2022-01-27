echo "  GEN     " version.c;rm -f version.c
printf '#include <config.h>\n' > version.ct
printf 'char const *Version = "1.10";\n' >> version.ct
chmod a-w version.ct
mv version.ct version.c
echo "  GEN     " version.h;rm -f version.h
printf 'extern char const *Version;\n' > version.ht
chmod a-w version.ht
mv version.ht version.h
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
echo "  GEN     " alloca.h;rm -f alloca.h-t alloca.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */'; \
  cat ./alloca.in.h; \
} > alloca.h-t && \
mv -f alloca.h-t alloca.h
echo "  GEN     " dirent.h;rm -f dirent.h-t dirent.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */'; \
  sed -e 's|@''GUARD_PREFIX''@|GL|g' \
      -e 's|@''HAVE_DIRENT_H''@|1|g' \
      -e 's|@''INCLUDE_NEXT''@|include_next|g' \
      -e 's|@''PRAGMA_SYSTEM_HEADER''@|#pragma GCC system_header|g' \
      -e 's|@''PRAGMA_COLUMNS''@||g' \
      -e 's|@''NEXT_DIRENT_H''@|<dirent.h>|g' \
      -e 's/@''GNULIB_OPENDIR''@/1/g' \
      -e 's/@''GNULIB_READDIR''@/1/g' \
      -e 's/@''GNULIB_REWINDDIR''@/0/g' \
      -e 's/@''GNULIB_CLOSEDIR''@/1/g' \
      -e 's/@''GNULIB_DIRFD''@/1/g' \
      -e 's/@''GNULIB_FDOPENDIR''@/1/g' \
      -e 's/@''GNULIB_SCANDIR''@/0/g' \
      -e 's/@''GNULIB_ALPHASORT''@/0/g' \
      -e 's/@''HAVE_OPENDIR''@/1/g' \
      -e 's/@''HAVE_READDIR''@/1/g' \
      -e 's/@''HAVE_REWINDDIR''@/1/g' \
      -e 's/@''HAVE_CLOSEDIR''@/1/g' \
      -e 's|@''HAVE_DECL_DIRFD''@|1|g' \
      -e 's|@''HAVE_DECL_FDOPENDIR''@|1|g' \
      -e 's|@''HAVE_FDOPENDIR''@|1|g' \
      -e 's|@''HAVE_SCANDIR''@|1|g' \
      -e 's|@''HAVE_ALPHASORT''@|1|g' \
      -e 's|@''REPLACE_OPENDIR''@|0|g' \
      -e 's|@''REPLACE_CLOSEDIR''@|0|g' \
      -e 's|@''REPLACE_DIRFD''@|0|g' \
      -e 's|@''REPLACE_FDOPENDIR''@|0|g' \
      -e '/definitions of _GL_FUNCDECL_RPL/r ./c++defs.h' \
      -e '/definition of _GL_ARG_NONNULL/r ./arg-nonnull.h' \
      -e '/definition of _GL_WARN_ON_USE/r ./warn-on-use.h' \
      < ./dirent.in.h; \
} > dirent.h-t && \
mv dirent.h-t dirent.h
echo "  GEN     " fcntl.h;rm -f fcntl.h-t fcntl.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */'; \
  sed -e 's|@''GUARD_PREFIX''@|GL|g' \
      -e 's|@''INCLUDE_NEXT''@|include_next|g' \
      -e 's|@''PRAGMA_SYSTEM_HEADER''@|#pragma GCC system_header|g' \
      -e 's|@''PRAGMA_COLUMNS''@||g' \
      -e 's|@''NEXT_FCNTL_H''@|<fcntl.h>|g' \
      -e 's/@''GNULIB_FCNTL''@/1/g' \
      -e 's/@''GNULIB_NONBLOCKING''@/0/g' \
      -e 's/@''GNULIB_OPEN''@/1/g' \
      -e 's/@''GNULIB_OPENAT''@/1/g' \
      -e 's|@''HAVE_FCNTL''@|1|g' \
      -e 's|@''HAVE_OPENAT''@|1|g' \
      -e 's|@''REPLACE_FCNTL''@|1|g' \
      -e 's|@''REPLACE_OPEN''@|0|g' \
      -e 's|@''REPLACE_OPENAT''@|0|g' \
      -e '/definitions of _GL_FUNCDECL_RPL/r ./c++defs.h' \
      -e '/definition of _GL_ARG_NONNULL/r ./arg-nonnull.h' \
      -e '/definition of _GL_WARN_ON_USE/r ./warn-on-use.h' \
      < ./fcntl.in.h; \
} > fcntl.h-t && \
mv fcntl.h-t fcntl.h
echo "  GEN     " limits.h;rm -f limits.h-t limits.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */' && \
  sed -e 's|@''GUARD_PREFIX''@|GL|g' \
      -e 's|@''INCLUDE_NEXT''@|include_next|g' \
      -e 's|@''PRAGMA_SYSTEM_HEADER''@|#pragma GCC system_header|g' \
      -e 's|@''PRAGMA_COLUMNS''@||g' \
      -e 's|@''NEXT_LIMITS_H''@|<limits.h>|g' \
      < ./limits.in.h; \
} > limits.h-t && \
mv limits.h-t limits.h
echo "  GEN     " math.h;rm -f math.h-t math.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */' && \
  sed -e 's|@''GUARD_PREFIX''@|GL|g' \
      -e 's|@''INCLUDE_NEXT_AS_FIRST_DIRECTIVE''@|include_next|g' \
      -e 's|@''PRAGMA_SYSTEM_HEADER''@|#pragma GCC system_header|g' \
      -e 's|@''PRAGMA_COLUMNS''@||g' \
      -e 's|@''NEXT_AS_FIRST_DIRECTIVE_MATH_H''@|<math.h>|g' \
      -e 's/@''GNULIB_ACOSF''@/0/g' \
      -e 's/@''GNULIB_ACOSL''@/0/g' \
      -e 's/@''GNULIB_ASINF''@/0/g' \
      -e 's/@''GNULIB_ASINL''@/0/g' \
      -e 's/@''GNULIB_ATANF''@/0/g' \
      -e 's/@''GNULIB_ATANL''@/0/g' \
      -e 's/@''GNULIB_ATAN2F''@/0/g' \
      -e 's/@''GNULIB_CBRT''@/0/g' \
      -e 's/@''GNULIB_CBRTF''@/0/g' \
      -e 's/@''GNULIB_CBRTL''@/0/g' \
      -e 's/@''GNULIB_CEIL''@/0/g' \
      -e 's/@''GNULIB_CEILF''@/0/g' \
      -e 's/@''GNULIB_CEILL''@/0/g' \
      -e 's/@''GNULIB_COPYSIGN''@/0/g' \
      -e 's/@''GNULIB_COPYSIGNF''@/0/g' \
      -e 's/@''GNULIB_COPYSIGNL''@/0/g' \
      -e 's/@''GNULIB_COSF''@/0/g' \
      -e 's/@''GNULIB_COSL''@/0/g' \
      -e 's/@''GNULIB_COSHF''@/0/g' \
      -e 's/@''GNULIB_EXPF''@/0/g' \
      -e 's/@''GNULIB_EXPL''@/0/g' \
      -e 's/@''GNULIB_EXP2''@/0/g' \
      -e 's/@''GNULIB_EXP2F''@/0/g' \
      -e 's/@''GNULIB_EXP2L''@/0/g' \
      -e 's/@''GNULIB_EXPM1''@/0/g' \
      -e 's/@''GNULIB_EXPM1F''@/0/g' \
      -e 's/@''GNULIB_EXPM1L''@/0/g' \
      -e 's/@''GNULIB_FABSF''@/0/g' \
      -e 's/@''GNULIB_FABSL''@/0/g' \
      -e 's/@''GNULIB_FLOOR''@/0/g' \
      -e 's/@''GNULIB_FLOORF''@/0/g' \
      -e 's/@''GNULIB_FLOORL''@/0/g' \
      -e 's/@''GNULIB_FMA''@/0/g' \
      -e 's/@''GNULIB_FMAF''@/0/g' \
      -e 's/@''GNULIB_FMAL''@/0/g' \
      -e 's/@''GNULIB_FMOD''@/0/g' \
      -e 's/@''GNULIB_FMODF''@/0/g' \
      -e 's/@''GNULIB_FMODL''@/0/g' \
      -e 's/@''GNULIB_FREXPF''@/0/g' \
      -e 's/@''GNULIB_FREXP''@/1/g' \
      -e 's/@''GNULIB_FREXPL''@/1/g' \
      -e 's/@''GNULIB_HYPOT''@/0/g' \
      -e 's/@''GNULIB_HYPOTF''@/0/g' \
      -e 's/@''GNULIB_HYPOTL''@/0/g' \
      < ./math.in.h | \
  sed -e 's/@''GNULIB_ILOGB''@/0/g' \
      -e 's/@''GNULIB_ILOGBF''@/0/g' \
      -e 's/@''GNULIB_ILOGBL''@/0/g' \
      -e 's/@''GNULIB_ISFINITE''@/0/g' \
      -e 's/@''GNULIB_ISINF''@/0/g' \
      -e 's/@''GNULIB_ISNAN''@/0/g' \
      -e 's/@''GNULIB_ISNANF''@/0/g' \
      -e 's/@''GNULIB_ISNAND''@/0/g' \
      -e 's/@''GNULIB_ISNANL''@/0/g' \
      -e 's/@''GNULIB_LDEXPF''@/0/g' \
      -e 's/@''GNULIB_LDEXPL''@/0/g' \
      -e 's/@''GNULIB_LOG''@/0/g' \
      -e 's/@''GNULIB_LOGF''@/0/g' \
      -e 's/@''GNULIB_LOGL''@/0/g' \
      -e 's/@''GNULIB_LOG10''@/0/g' \
      -e 's/@''GNULIB_LOG10F''@/0/g' \
      -e 's/@''GNULIB_LOG10L''@/0/g' \
      -e 's/@''GNULIB_LOG1P''@/0/g' \
      -e 's/@''GNULIB_LOG1PF''@/0/g' \
      -e 's/@''GNULIB_LOG1PL''@/0/g' \
      -e 's/@''GNULIB_LOG2''@/0/g' \
      -e 's/@''GNULIB_LOG2F''@/0/g' \
      -e 's/@''GNULIB_LOG2L''@/0/g' \
      -e 's/@''GNULIB_LOGB''@/0/g' \
      -e 's/@''GNULIB_LOGBF''@/0/g' \
      -e 's/@''GNULIB_LOGBL''@/0/g' \
      -e 's/@''GNULIB_MODF''@/0/g' \
      -e 's/@''GNULIB_MODFF''@/0/g' \
      -e 's/@''GNULIB_MODFL''@/0/g' \
      -e 's/@''GNULIB_POWF''@/0/g' \
      -e 's/@''GNULIB_REMAINDER''@/0/g' \
      -e 's/@''GNULIB_REMAINDERF''@/0/g' \
      -e 's/@''GNULIB_REMAINDERL''@/0/g' \
      -e 's/@''GNULIB_RINT''@/0/g' \
      -e 's/@''GNULIB_RINTF''@/0/g' \
      -e 's/@''GNULIB_RINTL''@/0/g' \
      -e 's/@''GNULIB_ROUND''@/0/g' \
      -e 's/@''GNULIB_ROUNDF''@/0/g' \
      -e 's/@''GNULIB_ROUNDL''@/0/g' \
      -e 's/@''GNULIB_SIGNBIT''@/1/g' \
      -e 's/@''GNULIB_SINF''@/0/g' \
      -e 's/@''GNULIB_SINL''@/0/g' \
      -e 's/@''GNULIB_SINHF''@/0/g' \
      -e 's/@''GNULIB_SQRTF''@/0/g' \
      -e 's/@''GNULIB_SQRTL''@/0/g' \
      -e 's/@''GNULIB_TANF''@/0/g' \
      -e 's/@''GNULIB_TANL''@/0/g' \
      -e 's/@''GNULIB_TANHF''@/0/g' \
      -e 's/@''GNULIB_TRUNC''@/0/g' \
      -e 's/@''GNULIB_TRUNCF''@/0/g' \
      -e 's/@''GNULIB_TRUNCL''@/0/g' \
  | \
  sed -e 's|@''HAVE_ACOSF''@|1|g' \
      -e 's|@''HAVE_ACOSL''@|1|g' \
      -e 's|@''HAVE_ASINF''@|1|g' \
      -e 's|@''HAVE_ASINL''@|1|g' \
      -e 's|@''HAVE_ATANF''@|1|g' \
      -e 's|@''HAVE_ATANL''@|1|g' \
      -e 's|@''HAVE_ATAN2F''@|1|g' \
      -e 's|@''HAVE_CBRT''@|1|g' \
      -e 's|@''HAVE_CBRTF''@|1|g' \
      -e 's|@''HAVE_CBRTL''@|1|g' \
      -e 's|@''HAVE_COPYSIGN''@|1|g' \
      -e 's|@''HAVE_COPYSIGNL''@|1|g' \
      -e 's|@''HAVE_COSF''@|1|g' \
      -e 's|@''HAVE_COSL''@|1|g' \
      -e 's|@''HAVE_COSHF''@|1|g' \
      -e 's|@''HAVE_EXPF''@|1|g' \
      -e 's|@''HAVE_EXPL''@|1|g' \
      -e 's|@''HAVE_EXPM1''@|1|g' \
      -e 's|@''HAVE_EXPM1F''@|1|g' \
      -e 's|@''HAVE_FABSF''@|1|g' \
      -e 's|@''HAVE_FABSL''@|1|g' \
      -e 's|@''HAVE_FMA''@|1|g' \
      -e 's|@''HAVE_FMAF''@|1|g' \
      -e 's|@''HAVE_FMAL''@|1|g' \
      -e 's|@''HAVE_FMODF''@|1|g' \
      -e 's|@''HAVE_FMODL''@|1|g' \
      -e 's|@''HAVE_FREXPF''@|1|g' \
      -e 's|@''HAVE_HYPOTF''@|1|g' \
      -e 's|@''HAVE_HYPOTL''@|1|g' \
      -e 's|@''HAVE_ILOGB''@|1|g' \
      -e 's|@''HAVE_ILOGBF''@|1|g' \
      -e 's|@''HAVE_ILOGBL''@|1|g' \
      -e 's|@''HAVE_ISNANF''@|1|g' \
      -e 's|@''HAVE_ISNAND''@|1|g' \
      -e 's|@''HAVE_ISNANL''@|1|g' \
      -e 's|@''HAVE_LDEXPF''@|1|g' \
      -e 's|@''HAVE_LOGF''@|1|g' \
      -e 's|@''HAVE_LOGL''@|1|g' \
      -e 's|@''HAVE_LOG10F''@|1|g' \
      -e 's|@''HAVE_LOG10L''@|1|g' \
      -e 's|@''HAVE_LOG1P''@|1|g' \
      -e 's|@''HAVE_LOG1PF''@|1|g' \
      -e 's|@''HAVE_LOG1PL''@|1|g' \
      -e 's|@''HAVE_LOGBF''@|1|g' \
      -e 's|@''HAVE_LOGBL''@|1|g' \
      -e 's|@''HAVE_MODFF''@|1|g' \
      -e 's|@''HAVE_MODFL''@|1|g' \
      -e 's|@''HAVE_POWF''@|1|g' \
      -e 's|@''HAVE_REMAINDER''@|1|g' \
      -e 's|@''HAVE_REMAINDERF''@|1|g' \
      -e 's|@''HAVE_RINT''@|1|g' \
      -e 's|@''HAVE_RINTL''@|1|g' \
      -e 's|@''HAVE_SINF''@|1|g' \
      -e 's|@''HAVE_SINL''@|1|g' \
      -e 's|@''HAVE_SINHF''@|1|g' \
      -e 's|@''HAVE_SQRTF''@|1|g' \
      -e 's|@''HAVE_SQRTL''@|1|g' \
      -e 's|@''HAVE_TANF''@|1|g' \
      -e 's|@''HAVE_TANL''@|1|g' \
      -e 's|@''HAVE_TANHF''@|1|g' \
      -e 's|@''HAVE_DECL_ACOSL''@|1|g' \
      -e 's|@''HAVE_DECL_ASINL''@|1|g' \
      -e 's|@''HAVE_DECL_ATANL''@|1|g' \
      -e 's|@''HAVE_DECL_CBRTF''@|1|g' \
      -e 's|@''HAVE_DECL_CBRTL''@|1|g' \
      -e 's|@''HAVE_DECL_CEILF''@|1|g' \
      -e 's|@''HAVE_DECL_CEILL''@|1|g' \
      -e 's|@''HAVE_DECL_COPYSIGNF''@|1|g' \
      -e 's|@''HAVE_DECL_COSL''@|1|g' \
      -e 's|@''HAVE_DECL_EXPL''@|1|g' \
      -e 's|@''HAVE_DECL_EXP2''@|1|g' \
      -e 's|@''HAVE_DECL_EXP2F''@|1|g' \
      -e 's|@''HAVE_DECL_EXP2L''@|1|g' \
      -e 's|@''HAVE_DECL_EXPM1L''@|1|g' \
      -e 's|@''HAVE_DECL_FLOORF''@|1|g' \
      -e 's|@''HAVE_DECL_FLOORL''@|1|g' \
      -e 's|@''HAVE_DECL_FREXPL''@|1|g' \
      -e 's|@''HAVE_DECL_LDEXPL''@|1|g' \
      -e 's|@''HAVE_DECL_LOGL''@|1|g' \
      -e 's|@''HAVE_DECL_LOG10L''@|1|g' \
      -e 's|@''HAVE_DECL_LOG2''@|1|g' \
      -e 's|@''HAVE_DECL_LOG2F''@|1|g' \
      -e 's|@''HAVE_DECL_LOG2L''@|1|g' \
      -e 's|@''HAVE_DECL_LOGB''@|1|g' \
      -e 's|@''HAVE_DECL_REMAINDER''@|1|g' \
      -e 's|@''HAVE_DECL_REMAINDERL''@|1|g' \
      -e 's|@''HAVE_DECL_RINTF''@|1|g' \
      -e 's|@''HAVE_DECL_ROUND''@|1|g' \
      -e 's|@''HAVE_DECL_ROUNDF''@|1|g' \
      -e 's|@''HAVE_DECL_ROUNDL''@|1|g' \
      -e 's|@''HAVE_DECL_SINL''@|1|g' \
      -e 's|@''HAVE_DECL_SQRTL''@|1|g' \
      -e 's|@''HAVE_DECL_TANL''@|1|g' \
      -e 's|@''HAVE_DECL_TRUNC''@|1|g' \
      -e 's|@''HAVE_DECL_TRUNCF''@|1|g' \
      -e 's|@''HAVE_DECL_TRUNCL''@|1|g' \
  | \
  sed -e 's|@''REPLACE_ACOSF''@|0|g' \
      -e 's|@''REPLACE_ASINF''@|0|g' \
      -e 's|@''REPLACE_ATANF''@|0|g' \
      -e 's|@''REPLACE_ATAN2F''@|0|g' \
      -e 's|@''REPLACE_CBRTF''@|0|g' \
      -e 's|@''REPLACE_CBRTL''@|0|g' \
      -e 's|@''REPLACE_CEIL''@|0|g' \
      -e 's|@''REPLACE_CEILF''@|0|g' \
      -e 's|@''REPLACE_CEILL''@|0|g' \
      -e 's|@''REPLACE_COSF''@|0|g' \
      -e 's|@''REPLACE_COSHF''@|0|g' \
      -e 's|@''REPLACE_EXPF''@|0|g' \
      -e 's|@''REPLACE_EXPM1''@|0|g' \
      -e 's|@''REPLACE_EXPM1F''@|0|g' \
      -e 's|@''REPLACE_EXP2''@|0|g' \
      -e 's|@''REPLACE_EXP2L''@|0|g' \
      -e 's|@''REPLACE_FABSL''@|0|g' \
      -e 's|@''REPLACE_FLOOR''@|0|g' \
      -e 's|@''REPLACE_FLOORF''@|0|g' \
      -e 's|@''REPLACE_FLOORL''@|0|g' \
      -e 's|@''REPLACE_FMA''@|0|g' \
      -e 's|@''REPLACE_FMAF''@|0|g' \
      -e 's|@''REPLACE_FMAL''@|0|g' \
      -e 's|@''REPLACE_FMOD''@|0|g' \
      -e 's|@''REPLACE_FMODF''@|0|g' \
      -e 's|@''REPLACE_FMODL''@|0|g' \
      -e 's|@''REPLACE_FREXPF''@|0|g' \
      -e 's|@''REPLACE_FREXP''@|0|g' \
      -e 's|@''REPLACE_FREXPL''@|0|g' \
      -e 's|@''REPLACE_HUGE_VAL''@|0|g' \
      -e 's|@''REPLACE_HYPOT''@|0|g' \
      -e 's|@''REPLACE_HYPOTF''@|0|g' \
      -e 's|@''REPLACE_HYPOTL''@|0|g' \
      -e 's|@''REPLACE_ILOGB''@|0|g' \
      -e 's|@''REPLACE_ILOGBF''@|0|g' \
      -e 's|@''REPLACE_ILOGBL''@|0|g' \
      -e 's|@''REPLACE_ISFINITE''@|0|g' \
      -e 's|@''REPLACE_ISINF''@|0|g' \
      -e 's|@''REPLACE_ISNAN''@|0|g' \
      -e 's|@''REPLACE_ITOLD''@|0|g' \
      -e 's|@''REPLACE_LDEXPL''@|0|g' \
      -e 's|@''REPLACE_LOG''@|0|g' \
      -e 's|@''REPLACE_LOGF''@|0|g' \
      -e 's|@''REPLACE_LOGL''@|0|g' \
      -e 's|@''REPLACE_LOG10''@|0|g' \
      -e 's|@''REPLACE_LOG10F''@|0|g' \
      -e 's|@''REPLACE_LOG10L''@|0|g' \
      -e 's|@''REPLACE_LOG1P''@|0|g' \
      -e 's|@''REPLACE_LOG1PF''@|0|g' \
      -e 's|@''REPLACE_LOG1PL''@|0|g' \
      -e 's|@''REPLACE_LOG2''@|0|g' \
      -e 's|@''REPLACE_LOG2F''@|0|g' \
      -e 's|@''REPLACE_LOG2L''@|0|g' \
      -e 's|@''REPLACE_LOGB''@|0|g' \
      -e 's|@''REPLACE_LOGBF''@|0|g' \
      -e 's|@''REPLACE_LOGBL''@|0|g' \
      -e 's|@''REPLACE_MODF''@|0|g' \
      -e 's|@''REPLACE_MODFF''@|0|g' \
      -e 's|@''REPLACE_MODFL''@|0|g' \
      -e 's|@''REPLACE_NAN''@|0|g' \
      -e 's|@''REPLACE_REMAINDER''@|0|g' \
      -e 's|@''REPLACE_REMAINDERF''@|0|g' \
      -e 's|@''REPLACE_REMAINDERL''@|0|g' \
      -e 's|@''REPLACE_ROUND''@|0|g' \
      -e 's|@''REPLACE_ROUNDF''@|0|g' \
      -e 's|@''REPLACE_ROUNDL''@|0|g' \
      -e 's|@''REPLACE_SIGNBIT''@|0|g' \
      -e 's|@''REPLACE_SIGNBIT_USING_GCC''@|1|g' \
      -e 's|@''REPLACE_SINF''@|0|g' \
      -e 's|@''REPLACE_SINHF''@|0|g' \
      -e 's|@''REPLACE_SQRTF''@|0|g' \
      -e 's|@''REPLACE_SQRTL''@|0|g' \
      -e 's|@''REPLACE_TANF''@|0|g' \
      -e 's|@''REPLACE_TANHF''@|0|g' \
      -e 's|@''REPLACE_TRUNC''@|0|g' \
      -e 's|@''REPLACE_TRUNCF''@|0|g' \
      -e 's|@''REPLACE_TRUNCL''@|0|g' \
      -e '/definitions of _GL_FUNCDECL_RPL/r ./c++defs.h' \
      -e '/definition of _GL_ARG_NONNULL/r ./arg-nonnull.h' \
      -e '/definition of _GL_WARN_ON_USE/r ./warn-on-use.h'; \
} > math.h-t && \
mv math.h-t math.h
echo "  GEN     " signal.h;rm -f signal.h-t signal.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */' && \
  sed -e 's|@''GUARD_PREFIX''@|GL|g' \
      -e 's|@''INCLUDE_NEXT''@|include_next|g' \
      -e 's|@''PRAGMA_SYSTEM_HEADER''@|#pragma GCC system_header|g' \
      -e 's|@''PRAGMA_COLUMNS''@||g' \
      -e 's|@''NEXT_SIGNAL_H''@|<signal.h>|g' \
      -e 's/@''GNULIB_PTHREAD_SIGMASK''@/0/g' \
      -e 's/@''GNULIB_RAISE''@/1/g' \
      -e 's/@''GNULIB_SIGNAL_H_SIGPIPE''@/0/g' \
      -e 's/@''GNULIB_SIGPROCMASK''@/1/g' \
      -e 's/@''GNULIB_SIGACTION''@/1/g' \
      -e 's|@''HAVE_POSIX_SIGNALBLOCKING''@|1|g' \
      -e 's|@''HAVE_PTHREAD_SIGMASK''@|1|g' \
      -e 's|@''HAVE_RAISE''@|1|g' \
      -e 's|@''HAVE_SIGSET_T''@|1|g' \
      -e 's|@''HAVE_SIGINFO_T''@|1|g' \
      -e 's|@''HAVE_SIGACTION''@|1|g' \
      -e 's|@''HAVE_STRUCT_SIGACTION_SA_SIGACTION''@|1|g' \
      -e 's|@''HAVE_TYPE_VOLATILE_SIG_ATOMIC_T''@|1|g' \
      -e 's|@''HAVE_SIGHANDLER_T''@|1|g' \
      -e 's|@''REPLACE_PTHREAD_SIGMASK''@|0|g' \
      -e 's|@''REPLACE_RAISE''@|0|g' \
      -e '/definitions of _GL_FUNCDECL_RPL/r ./c++defs.h' \
      -e '/definition of _GL_ARG_NONNULL/r ./arg-nonnull.h' \
      -e '/definition of _GL_WARN_ON_USE/r ./warn-on-use.h' \
      < ./signal.in.h; \
} > signal.h-t && \
mv signal.h-t signal.h
echo "  GEN     " stdio.h;rm -f stdio.h-t stdio.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */' && \
  sed -e 's|@''GUARD_PREFIX''@|GL|g' \
      -e 's|@''INCLUDE_NEXT''@|include_next|g' \
      -e 's|@''PRAGMA_SYSTEM_HEADER''@|#pragma GCC system_header|g' \
      -e 's|@''PRAGMA_COLUMNS''@||g' \
      -e 's|@''NEXT_STDIO_H''@|<stdio.h>|g' \
      -e 's/@''GNULIB_DPRINTF''@/0/g' \
      -e 's/@''GNULIB_FCLOSE''@/1/g' \
      -e 's/@''GNULIB_FDOPEN''@/0/g' \
      -e 's/@''GNULIB_FFLUSH''@/1/g' \
      -e 's/@''GNULIB_FGETC''@/1/g' \
      -e 's/@''GNULIB_FGETS''@/1/g' \
      -e 's/@''GNULIB_FOPEN''@/0/g' \
      -e 's/@''GNULIB_FPRINTF''@/1/g' \
      -e 's/@''GNULIB_FPRINTF_POSIX''@/1/g' \
      -e 's/@''GNULIB_FPURGE''@/1/g' \
      -e 's/@''GNULIB_FPUTC''@/1/g' \
      -e 's/@''GNULIB_FPUTS''@/1/g' \
      -e 's/@''GNULIB_FREAD''@/1/g' \
      -e 's/@''GNULIB_FREOPEN''@/0/g' \
      -e 's/@''GNULIB_FSCANF''@/1/g' \
      -e 's/@''GNULIB_FSEEK''@/1/g' \
      -e 's/@''GNULIB_FSEEKO''@/1/g' \
      -e 's/@''GNULIB_FTELL''@/1/g' \
      -e 's/@''GNULIB_FTELLO''@/1/g' \
      -e 's/@''GNULIB_FWRITE''@/1/g' \
      -e 's/@''GNULIB_GETC''@/1/g' \
      -e 's/@''GNULIB_GETCHAR''@/1/g' \
      -e 's/@''GNULIB_GETDELIM''@/0/g' \
      -e 's/@''GNULIB_GETLINE''@/0/g' \
      -e 's/@''GNULIB_OBSTACK_PRINTF''@/0/g' \
      -e 's/@''GNULIB_OBSTACK_PRINTF_POSIX''@/0/g' \
      -e 's/@''GNULIB_PCLOSE''@/0/g' \
      -e 's/@''GNULIB_PERROR''@/1/g' \
      -e 's/@''GNULIB_POPEN''@/0/g' \
      -e 's/@''GNULIB_PRINTF''@/1/g' \
      -e 's/@''GNULIB_PRINTF_POSIX''@/1/g' \
      -e 's/@''GNULIB_PUTC''@/1/g' \
      -e 's/@''GNULIB_PUTCHAR''@/1/g' \
      -e 's/@''GNULIB_PUTS''@/1/g' \
      -e 's/@''GNULIB_REMOVE''@/0/g' \
      -e 's/@''GNULIB_RENAME''@/0/g' \
      -e 's/@''GNULIB_RENAMEAT''@/0/g' \
      -e 's/@''GNULIB_SCANF''@/1/g' \
      -e 's/@''GNULIB_SNPRINTF''@/0/g' \
      -e 's/@''GNULIB_SPRINTF_POSIX''@/0/g' \
      -e 's/@''GNULIB_STDIO_H_NONBLOCKING''@/0/g' \
      -e 's/@''GNULIB_STDIO_H_SIGPIPE''@/0/g' \
      -e 's/@''GNULIB_TMPFILE''@/0/g' \
      -e 's/@''GNULIB_VASPRINTF''@/0/g' \
      -e 's/@''GNULIB_VDPRINTF''@/0/g' \
      -e 's/@''GNULIB_VFPRINTF''@/1/g' \
      -e 's/@''GNULIB_VFPRINTF_POSIX''@/1/g' \
      -e 's/@''GNULIB_VFSCANF''@/0/g' \
      -e 's/@''GNULIB_VSCANF''@/0/g' \
      -e 's/@''GNULIB_VPRINTF''@/1/g' \
      -e 's/@''GNULIB_VPRINTF_POSIX''@/0/g' \
      -e 's/@''GNULIB_VSNPRINTF''@/0/g' \
      -e 's/@''GNULIB_VSPRINTF_POSIX''@/0/g' \
      < ./stdio.in.h | \
  sed -e 's|@''HAVE_DECL_FPURGE''@|0|g' \
      -e 's|@''HAVE_DECL_FSEEKO''@|1|g' \
      -e 's|@''HAVE_DECL_FTELLO''@|1|g' \
      -e 's|@''HAVE_DECL_GETDELIM''@|1|g' \
      -e 's|@''HAVE_DECL_GETLINE''@|1|g' \
      -e 's|@''HAVE_DECL_OBSTACK_PRINTF''@|1|g' \
      -e 's|@''HAVE_DECL_SNPRINTF''@|1|g' \
      -e 's|@''HAVE_DECL_VSNPRINTF''@|1|g' \
      -e 's|@''HAVE_DPRINTF''@|1|g' \
      -e 's|@''HAVE_FSEEKO''@|1|g' \
      -e 's|@''HAVE_FTELLO''@|1|g' \
      -e 's|@''HAVE_PCLOSE''@|1|g' \
      -e 's|@''HAVE_POPEN''@|1|g' \
      -e 's|@''HAVE_RENAMEAT''@|1|g' \
      -e 's|@''HAVE_VASPRINTF''@|1|g' \
      -e 's|@''HAVE_VDPRINTF''@|1|g' \
      -e 's|@''REPLACE_DPRINTF''@|0|g' \
      -e 's|@''REPLACE_FCLOSE''@|1|g' \
      -e 's|@''REPLACE_FDOPEN''@|0|g' \
      -e 's|@''REPLACE_FFLUSH''@|1|g' \
      -e 's|@''REPLACE_FOPEN''@|0|g' \
      -e 's|@''REPLACE_FPRINTF''@|0|g' \
      -e 's|@''REPLACE_FPURGE''@|0|g' \
      -e 's|@''REPLACE_FREOPEN''@|0|g' \
      -e 's|@''REPLACE_FSEEK''@|1|g' \
      -e 's|@''REPLACE_FSEEKO''@|1|g' \
      -e 's|@''REPLACE_FTELL''@|0|g' \
      -e 's|@''REPLACE_FTELLO''@|0|g' \
      -e 's|@''REPLACE_GETDELIM''@|0|g' \
      -e 's|@''REPLACE_GETLINE''@|0|g' \
      -e 's|@''REPLACE_OBSTACK_PRINTF''@|0|g' \
      -e 's|@''REPLACE_PERROR''@|0|g' \
      -e 's|@''REPLACE_POPEN''@|0|g' \
      -e 's|@''REPLACE_PRINTF''@|0|g' \
      -e 's|@''REPLACE_REMOVE''@|0|g' \
      -e 's|@''REPLACE_RENAME''@|0|g' \
      -e 's|@''REPLACE_RENAMEAT''@|0|g' \
      -e 's|@''REPLACE_SNPRINTF''@|0|g' \
      -e 's|@''REPLACE_SPRINTF''@|0|g' \
      -e 's|@''REPLACE_STDIO_READ_FUNCS''@|0|g' \
      -e 's|@''REPLACE_STDIO_WRITE_FUNCS''@|0|g' \
      -e 's|@''REPLACE_TMPFILE''@|0|g' \
      -e 's|@''REPLACE_VASPRINTF''@|0|g' \
      -e 's|@''REPLACE_VDPRINTF''@|0|g' \
      -e 's|@''REPLACE_VFPRINTF''@|0|g' \
      -e 's|@''REPLACE_VPRINTF''@|0|g' \
      -e 's|@''REPLACE_VSNPRINTF''@|0|g' \
      -e 's|@''REPLACE_VSPRINTF''@|0|g' \
      -e 's|@''ASM_SYMBOL_PREFIX''@|""|g' \
      -e '/definitions of _GL_FUNCDECL_RPL/r ./c++defs.h' \
      -e '/definition of _GL_ARG_NONNULL/r ./arg-nonnull.h' \
      -e '/definition of _GL_WARN_ON_USE/r ./warn-on-use.h'; \
} > stdio.h-t && \
mv stdio.h-t stdio.h
echo "  GEN     " stdlib.h;rm -f stdlib.h-t stdlib.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */' && \
  sed -e 's|@''GUARD_PREFIX''@|GL|g' \
      -e 's|@''INCLUDE_NEXT''@|include_next|g' \
      -e 's|@''PRAGMA_SYSTEM_HEADER''@|#pragma GCC system_header|g' \
      -e 's|@''PRAGMA_COLUMNS''@||g' \
      -e 's|@''NEXT_STDLIB_H''@|<stdlib.h>|g' \
      -e 's/@''GNULIB__EXIT''@/0/g' \
      -e 's/@''GNULIB_ATOLL''@/0/g' \
      -e 's/@''GNULIB_CALLOC_POSIX''@/1/g' \
      -e 's/@''GNULIB_CANONICALIZE_FILE_NAME''@/0/g' \
      -e 's/@''GNULIB_GETLOADAVG''@/0/g' \
      -e 's/@''GNULIB_GETSUBOPT''@/0/g' \
      -e 's/@''GNULIB_GRANTPT''@/0/g' \
      -e 's/@''GNULIB_MALLOC_POSIX''@/1/g' \
      -e 's/@''GNULIB_MBTOWC''@/0/g' \
      -e 's/@''GNULIB_MKDTEMP''@/0/g' \
      -e 's/@''GNULIB_MKOSTEMP''@/0/g' \
      -e 's/@''GNULIB_MKOSTEMPS''@/0/g' \
      -e 's/@''GNULIB_MKSTEMP''@/0/g' \
      -e 's/@''GNULIB_MKSTEMPS''@/0/g' \
      -e 's/@''GNULIB_POSIX_OPENPT''@/0/g' \
      -e 's/@''GNULIB_PTSNAME''@/0/g' \
      -e 's/@''GNULIB_PTSNAME_R''@/0/g' \
      -e 's/@''GNULIB_PUTENV''@/0/g' \
      -e 's/@''GNULIB_QSORT_R''@/0/g' \
      -e 's/@''GNULIB_RANDOM''@/0/g' \
      -e 's/@''GNULIB_RANDOM_R''@/0/g' \
      -e 's/@''GNULIB_REALLOC_POSIX''@/1/g' \
      -e 's/@''GNULIB_REALLOCARRAY''@/0/g' \
      -e 's/@''GNULIB_REALPATH''@/0/g' \
      -e 's/@''GNULIB_RPMATCH''@/0/g' \
      -e 's/@''GNULIB_SECURE_GETENV''@/0/g' \
      -e 's/@''GNULIB_SETENV''@/0/g' \
      -e 's/@''GNULIB_STRTOD''@/0/g' \
      -e 's/@''GNULIB_STRTOLL''@/0/g' \
      -e 's/@''GNULIB_STRTOULL''@/0/g' \
      -e 's/@''GNULIB_SYSTEM_POSIX''@/0/g' \
      -e 's/@''GNULIB_UNLOCKPT''@/0/g' \
      -e 's/@''GNULIB_UNSETENV''@/0/g' \
      -e 's/@''GNULIB_WCTOMB''@/0/g' \
      < ./stdlib.in.h | \
  sed -e 's|@''HAVE__EXIT''@|1|g' \
      -e 's|@''HAVE_ATOLL''@|1|g' \
      -e 's|@''HAVE_CANONICALIZE_FILE_NAME''@|1|g' \
      -e 's|@''HAVE_DECL_GETLOADAVG''@|1|g' \
      -e 's|@''HAVE_GETSUBOPT''@|1|g' \
      -e 's|@''HAVE_GRANTPT''@|1|g' \
      -e 's|@''HAVE_DECL_INITSTATE''@|1|g' \
      -e 's|@''HAVE_MKDTEMP''@|1|g' \
      -e 's|@''HAVE_MKOSTEMP''@|1|g' \
      -e 's|@''HAVE_MKOSTEMPS''@|1|g' \
      -e 's|@''HAVE_MKSTEMP''@|1|g' \
      -e 's|@''HAVE_MKSTEMPS''@|1|g' \
      -e 's|@''HAVE_POSIX_OPENPT''@|1|g' \
      -e 's|@''HAVE_PTSNAME''@|1|g' \
      -e 's|@''HAVE_PTSNAME_R''@|1|g' \
      -e 's|@''HAVE_QSORT_R''@|1|g' \
      -e 's|@''HAVE_RANDOM''@|1|g' \
      -e 's|@''HAVE_RANDOM_H''@|1|g' \
      -e 's|@''HAVE_RANDOM_R''@|1|g' \
      -e 's|@''HAVE_REALLOCARRAY''@|1|g' \
      -e 's|@''HAVE_REALPATH''@|1|g' \
      -e 's|@''HAVE_RPMATCH''@|1|g' \
      -e 's|@''HAVE_SECURE_GETENV''@|1|g' \
      -e 's|@''HAVE_DECL_SETENV''@|1|g' \
      -e 's|@''HAVE_DECL_SETSTATE''@|1|g' \
      -e 's|@''HAVE_STRTOD''@|1|g' \
      -e 's|@''HAVE_STRTOLL''@|1|g' \
      -e 's|@''HAVE_STRTOULL''@|1|g' \
      -e 's|@''HAVE_STRUCT_RANDOM_DATA''@|1|g' \
      -e 's|@''HAVE_SYS_LOADAVG_H''@|0|g' \
      -e 's|@''HAVE_UNLOCKPT''@|1|g' \
      -e 's|@''HAVE_DECL_UNSETENV''@|1|g' \
      -e 's|@''REPLACE_CALLOC''@|1|g' \
      -e 's|@''REPLACE_CANONICALIZE_FILE_NAME''@|0|g' \
      -e 's|@''REPLACE_MALLOC''@|0|g' \
      -e 's|@''REPLACE_MBTOWC''@|0|g' \
      -e 's|@''REPLACE_MKSTEMP''@|0|g' \
      -e 's|@''REPLACE_PTSNAME''@|0|g' \
      -e 's|@''REPLACE_PTSNAME_R''@|0|g' \
      -e 's|@''REPLACE_PUTENV''@|0|g' \
      -e 's|@''REPLACE_QSORT_R''@|0|g' \
      -e 's|@''REPLACE_RANDOM_R''@|0|g' \
      -e 's|@''REPLACE_REALLOC''@|0|g' \
      -e 's|@''REPLACE_REALPATH''@|0|g' \
      -e 's|@''REPLACE_SETENV''@|0|g' \
      -e 's|@''REPLACE_STRTOD''@|0|g' \
      -e 's|@''REPLACE_UNSETENV''@|0|g' \
      -e 's|@''REPLACE_WCTOMB''@|0|g' \
      -e '/definitions of _GL_FUNCDECL_RPL/r ./c++defs.h' \
      -e '/definition of _Noreturn/r ./_Noreturn.h' \
      -e '/definition of _GL_ARG_NONNULL/r ./arg-nonnull.h' \
      -e '/definition of _GL_WARN_ON_USE/r ./warn-on-use.h'; \
} > stdlib.h-t && \
mv stdlib.h-t stdlib.h
echo "  GEN     " string.h;rm -f string.h-t string.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */' && \
  sed -e 's|@''GUARD_PREFIX''@|GL|g' \
      -e 's|@''INCLUDE_NEXT''@|include_next|g' \
      -e 's|@''PRAGMA_SYSTEM_HEADER''@|#pragma GCC system_header|g' \
      -e 's|@''PRAGMA_COLUMNS''@||g' \
      -e 's|@''NEXT_STRING_H''@|<string.h>|g' \
      -e 's/@''GNULIB_EXPLICIT_BZERO''@/0/g' \
      -e 's/@''GNULIB_FFSL''@/0/g' \
      -e 's/@''GNULIB_FFSLL''@/0/g' \
      -e 's/@''GNULIB_MBSLEN''@/0/g' \
      -e 's/@''GNULIB_MBSNLEN''@/0/g' \
      -e 's/@''GNULIB_MBSCHR''@/0/g' \
      -e 's/@''GNULIB_MBSRCHR''@/0/g' \
      -e 's/@''GNULIB_MBSSTR''@/0/g' \
      -e 's/@''GNULIB_MBSCASECMP''@/0/g' \
      -e 's/@''GNULIB_MBSNCASECMP''@/0/g' \
      -e 's/@''GNULIB_MBSPCASECMP''@/0/g' \
      -e 's/@''GNULIB_MBSCASESTR''@/0/g' \
      -e 's/@''GNULIB_MBSCSPN''@/0/g' \
      -e 's/@''GNULIB_MBSPBRK''@/0/g' \
      -e 's/@''GNULIB_MBSSPN''@/0/g' \
      -e 's/@''GNULIB_MBSSEP''@/0/g' \
      -e 's/@''GNULIB_MBSTOK_R''@/0/g' \
      -e 's/@''GNULIB_MEMCHR''@/1/g' \
      -e 's/@''GNULIB_MEMMEM''@/0/g' \
      -e 's/@''GNULIB_MEMPCPY''@/1/g' \
      -e 's/@''GNULIB_MEMRCHR''@/1/g' \
      -e 's/@''GNULIB_RAWMEMCHR''@/0/g' \
      -e 's/@''GNULIB_STPCPY''@/1/g' \
      -e 's/@''GNULIB_STPNCPY''@/0/g' \
      -e 's/@''GNULIB_STRCHRNUL''@/0/g' \
      -e 's/@''GNULIB_STRDUP''@/1/g' \
      -e 's/@''GNULIB_STRNCAT''@/0/g' \
      -e 's/@''GNULIB_STRNDUP''@/0/g' \
      -e 's/@''GNULIB_STRNLEN''@/0/g' \
      -e 's/@''GNULIB_STRPBRK''@/0/g' \
      -e 's/@''GNULIB_STRSEP''@/0/g' \
      -e 's/@''GNULIB_STRSTR''@/0/g' \
      -e 's/@''GNULIB_STRCASESTR''@/0/g' \
      -e 's/@''GNULIB_STRTOK_R''@/0/g' \
      -e 's/@''GNULIB_STRERROR''@/1/g' \
      -e 's/@''GNULIB_STRERROR_R''@/1/g' \
      -e 's/@''GNULIB_STRSIGNAL''@/0/g' \
      -e 's/@''GNULIB_STRVERSCMP''@/0/g' \
      < ./string.in.h | \
  sed -e 's|@''HAVE_EXPLICIT_BZERO''@|1|g' \
      -e 's|@''HAVE_FFSL''@|1|g' \
      -e 's|@''HAVE_FFSLL''@|1|g' \
      -e 's|@''HAVE_MBSLEN''@|0|g' \
      -e 's|@''HAVE_MEMCHR''@|1|g' \
      -e 's|@''HAVE_DECL_MEMMEM''@|1|g' \
      -e 's|@''HAVE_MEMPCPY''@|1|g' \
      -e 's|@''HAVE_DECL_MEMRCHR''@|1|g' \
      -e 's|@''HAVE_RAWMEMCHR''@|1|g' \
      -e 's|@''HAVE_STPCPY''@|1|g' \
      -e 's|@''HAVE_STPNCPY''@|1|g' \
      -e 's|@''HAVE_STRCHRNUL''@|1|g' \
      -e 's|@''HAVE_DECL_STRDUP''@|1|g' \
      -e 's|@''HAVE_DECL_STRNDUP''@|1|g' \
      -e 's|@''HAVE_DECL_STRNLEN''@|1|g' \
      -e 's|@''HAVE_STRPBRK''@|1|g' \
      -e 's|@''HAVE_STRSEP''@|1|g' \
      -e 's|@''HAVE_STRCASESTR''@|1|g' \
      -e 's|@''HAVE_DECL_STRTOK_R''@|1|g' \
      -e 's|@''HAVE_DECL_STRERROR_R''@|1|g' \
      -e 's|@''HAVE_DECL_STRSIGNAL''@|1|g' \
      -e 's|@''HAVE_STRVERSCMP''@|1|g' \
      -e 's|@''REPLACE_MEMCHR''@|0|g' \
      -e 's|@''REPLACE_MEMMEM''@|0|g' \
      -e 's|@''REPLACE_STPNCPY''@|0|g' \
      -e 's|@''REPLACE_STRCHRNUL''@|0|g' \
      -e 's|@''REPLACE_STRDUP''@|0|g' \
      -e 's|@''REPLACE_STRNCAT''@|0|g' \
      -e 's|@''REPLACE_STRNDUP''@|0|g' \
      -e 's|@''REPLACE_STRNLEN''@|0|g' \
      -e 's|@''REPLACE_STRSTR''@|0|g' \
      -e 's|@''REPLACE_STRCASESTR''@|0|g' \
      -e 's|@''REPLACE_STRTOK_R''@|0|g' \
      -e 's|@''REPLACE_STRERROR''@|0|g' \
      -e 's|@''REPLACE_STRERROR_R''@|1|g' \
      -e 's|@''REPLACE_STRSIGNAL''@|0|g' \
      -e 's|@''UNDEFINE_STRTOK_R''@|0|g' \
      -e '/definitions of _GL_FUNCDECL_RPL/r ./c++defs.h' \
      -e '/definition of _GL_ARG_NONNULL/r ./arg-nonnull.h' \
      -e '/definition of _GL_WARN_ON_USE/r ./warn-on-use.h'; \
      < ./string.in.h; \
} > string.h-t && \
mv string.h-t string.h
/bin/mkdir -p sys
echo "  GEN     " sys/stat.h;rm -f sys/stat.h-t sys/stat.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */'; \
  sed -e 's|@''GUARD_PREFIX''@|GL|g' \
      -e 's|@''INCLUDE_NEXT''@|include_next|g' \
      -e 's|@''PRAGMA_SYSTEM_HEADER''@|#pragma GCC system_header|g' \
      -e 's|@''PRAGMA_COLUMNS''@||g' \
      -e 's|@''NEXT_SYS_STAT_H''@|<sys/stat.h>|g' \
      -e 's|@''WINDOWS_64_BIT_ST_SIZE''@|0|g' \
      -e 's|@''WINDOWS_STAT_TIMESPEC''@|0|g' \
      -e 's/@''GNULIB_FCHMODAT''@/0/g' \
      -e 's/@''GNULIB_FSTAT''@/1/g' \
      -e 's/@''GNULIB_FSTATAT''@/1/g' \
      -e 's/@''GNULIB_FUTIMENS''@/0/g' \
      -e 's/@''GNULIB_LCHMOD''@/0/g' \
      -e 's/@''GNULIB_LSTAT''@/1/g' \
      -e 's/@''GNULIB_MKDIRAT''@/0/g' \
      -e 's/@''GNULIB_MKFIFO''@/0/g' \
      -e 's/@''GNULIB_MKFIFOAT''@/0/g' \
      -e 's/@''GNULIB_MKNOD''@/0/g' \
      -e 's/@''GNULIB_MKNODAT''@/0/g' \
      -e 's/@''GNULIB_STAT''@/1/g' \
      -e 's/@''GNULIB_UTIMENSAT''@/0/g' \
      -e 's/@''GNULIB_OVERRIDES_STRUCT_STAT''@/0/g' \
      -e 's|@''HAVE_FCHMODAT''@|1|g' \
      -e 's|@''HAVE_FSTATAT''@|1|g' \
      -e 's|@''HAVE_FUTIMENS''@|1|g' \
      -e 's|@''HAVE_LCHMOD''@|1|g' \
      -e 's|@''HAVE_LSTAT''@|1|g' \
      -e 's|@''HAVE_MKDIRAT''@|1|g' \
      -e 's|@''HAVE_MKFIFO''@|1|g' \
      -e 's|@''HAVE_MKFIFOAT''@|1|g' \
      -e 's|@''HAVE_MKNOD''@|1|g' \
      -e 's|@''HAVE_MKNODAT''@|1|g' \
      -e 's|@''HAVE_UTIMENSAT''@|1|g' \
      -e 's|@''REPLACE_FSTAT''@|0|g' \
      -e 's|@''REPLACE_FSTATAT''@|0|g' \
      -e 's|@''REPLACE_FUTIMENS''@|0|g' \
      -e 's|@''REPLACE_LSTAT''@|0|g' \
      -e 's|@''REPLACE_MKDIR''@|0|g' \
      -e 's|@''REPLACE_MKFIFO''@|0|g' \
      -e 's|@''REPLACE_MKNOD''@|0|g' \
      -e 's|@''REPLACE_STAT''@|0|g' \
      -e 's|@''REPLACE_UTIMENSAT''@|0|g' \
      -e '/definitions of _GL_FUNCDECL_RPL/r ./c++defs.h' \
      -e '/definition of _GL_ARG_NONNULL/r ./arg-nonnull.h' \
      -e '/definition of _GL_WARN_ON_USE/r ./warn-on-use.h' \
      < ./sys_stat.in.h; \
} > sys/stat.h-t && \
mv sys/stat.h-t sys/stat.h
/bin/mkdir -p sys
echo "  GEN     " sys/time.h;rm -f sys/time.h-t sys/time.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */'; \
  sed -e 's|@''GUARD_PREFIX''@|GL|g' \
      -e 's/@''HAVE_SYS_TIME_H''@/1/g' \
      -e 's|@''INCLUDE_NEXT''@|include_next|g' \
      -e 's|@''PRAGMA_SYSTEM_HEADER''@|#pragma GCC system_header|g' \
      -e 's|@''PRAGMA_COLUMNS''@||g' \
      -e 's|@''NEXT_SYS_TIME_H''@|<sys/time.h>|g' \
      -e 's/@''GNULIB_GETTIMEOFDAY''@/1/g' \
      -e 's|@''HAVE_WINSOCK2_H''@|0|g' \
      -e 's/@''HAVE_GETTIMEOFDAY''@/1/g' \
      -e 's/@''HAVE_STRUCT_TIMEVAL''@/1/g' \
      -e 's/@''REPLACE_GETTIMEOFDAY''@/0/g' \
      -e 's/@''REPLACE_STRUCT_TIMEVAL''@/0/g' \
      -e '/definitions of _GL_FUNCDECL_RPL/r ./c++defs.h' \
      -e '/definition of _GL_ARG_NONNULL/r ./arg-nonnull.h' \
      -e '/definition of _GL_WARN_ON_USE/r ./warn-on-use.h' \
      < ./sys_time.in.h; \
} > sys/time.h-t && \
mv sys/time.h-t sys/time.h
/bin/mkdir -p sys
echo "  GEN     " sys/types.h;rm -f sys/types.h-t sys/types.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */'; \
  sed -e 's|@''GUARD_PREFIX''@|GL|g' \
      -e 's|@''INCLUDE_NEXT''@|include_next|g' \
      -e 's|@''PRAGMA_SYSTEM_HEADER''@|#pragma GCC system_header|g' \
      -e 's|@''PRAGMA_COLUMNS''@||g' \
      -e 's|@''NEXT_SYS_TYPES_H''@|<sys/types.h>|g' \
      -e 's|@''WINDOWS_64_BIT_OFF_T''@|0|g' \
      -e 's|@''WINDOWS_STAT_INODES''@|0|g' \
      < ./sys_types.in.h; \
} > sys/types.h-t && \
mv sys/types.h-t sys/types.h
echo "  GEN     " time.h;rm -f time.h-t time.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */' && \
  sed -e 's|@''GUARD_PREFIX''@|GL|g' \
      -e 's|@''INCLUDE_NEXT''@|include_next|g' \
      -e 's|@''PRAGMA_SYSTEM_HEADER''@|#pragma GCC system_header|g' \
      -e 's|@''PRAGMA_COLUMNS''@||g' \
      -e 's|@''NEXT_TIME_H''@|<time.h>|g' \
      -e 's/@''GNULIB_CTIME''@/0/g' \
      -e 's/@''GNULIB_LOCALTIME''@/0/g' \
      -e 's/@''GNULIB_MKTIME''@/0/g' \
      -e 's/@''GNULIB_NANOSLEEP''@/0/g' \
      -e 's/@''GNULIB_STRFTIME''@/0/g' \
      -e 's/@''GNULIB_STRPTIME''@/0/g' \
      -e 's/@''GNULIB_TIMEGM''@/0/g' \
      -e 's/@''GNULIB_TIME_R''@/0/g' \
      -e 's/@''GNULIB_TIME_RZ''@/0/g' \
      -e 's/@''GNULIB_TZSET''@/0/g' \
      -e 's|@''HAVE_DECL_LOCALTIME_R''@|1|g' \
      -e 's|@''HAVE_NANOSLEEP''@|1|g' \
      -e 's|@''HAVE_STRPTIME''@|1|g' \
      -e 's|@''HAVE_TIMEGM''@|1|g' \
      -e 's|@''HAVE_TIMEZONE_T''@|0|g' \
      -e 's|@''HAVE_TZSET''@|1|g' \
      -e 's|@''REPLACE_CTIME''@|GNULIB_PORTCHECK|g' \
      -e 's|@''REPLACE_GMTIME''@|0|g' \
      -e 's|@''REPLACE_LOCALTIME''@|0|g' \
      -e 's|@''REPLACE_LOCALTIME_R''@|GNULIB_PORTCHECK|g' \
      -e 's|@''REPLACE_MKTIME''@|GNULIB_PORTCHECK|g' \
      -e 's|@''REPLACE_NANOSLEEP''@|GNULIB_PORTCHECK|g' \
      -e 's|@''REPLACE_STRFTIME''@|GNULIB_PORTCHECK|g' \
      -e 's|@''REPLACE_TIMEGM''@|GNULIB_PORTCHECK|g' \
      -e 's|@''REPLACE_TZSET''@|GNULIB_PORTCHECK|g' \
      -e 's|@''PTHREAD_H_DEFINES_STRUCT_TIMESPEC''@|0|g' \
      -e 's|@''SYS_TIME_H_DEFINES_STRUCT_TIMESPEC''@|0|g' \
      -e 's|@''TIME_H_DEFINES_STRUCT_TIMESPEC''@|1|g' \
      -e 's|@''UNISTD_H_DEFINES_STRUCT_TIMESPEC''@|0|g' \
      -e '/definitions of _GL_FUNCDECL_RPL/r ./c++defs.h' \
      -e '/definition of _GL_ARG_NONNULL/r ./arg-nonnull.h' \
      -e '/definition of _GL_WARN_ON_USE/r ./warn-on-use.h' \
      < ./time.in.h; \
} > time.h-t && \
mv time.h-t time.h
echo "  GEN     " unistd.h;rm -f unistd.h-t unistd.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */'; \
  sed -e 's|@''GUARD_PREFIX''@|GL|g' \
      -e 's|@''HAVE_UNISTD_H''@|1|g' \
      -e 's|@''INCLUDE_NEXT''@|include_next|g' \
      -e 's|@''PRAGMA_SYSTEM_HEADER''@|#pragma GCC system_header|g' \
      -e 's|@''PRAGMA_COLUMNS''@||g' \
      -e 's|@''NEXT_UNISTD_H''@|<unistd.h>|g' \
      -e 's|@''WINDOWS_64_BIT_OFF_T''@|0|g' \
      -e 's/@''GNULIB_CHDIR''@/1/g' \
      -e 's/@''GNULIB_CHOWN''@/0/g' \
      -e 's/@''GNULIB_CLOSE''@/1/g' \
      -e 's/@''GNULIB_DUP''@/1/g' \
      -e 's/@''GNULIB_DUP2''@/1/g' \
      -e 's/@''GNULIB_DUP3''@/0/g' \
      -e 's/@''GNULIB_ENVIRON''@/0/g' \
      -e 's/@''GNULIB_EUIDACCESS''@/0/g' \
      -e 's/@''GNULIB_FACCESSAT''@/0/g' \
      -e 's/@''GNULIB_FCHDIR''@/1/g' \
      -e 's/@''GNULIB_FCHOWNAT''@/0/g' \
      -e 's/@''GNULIB_FDATASYNC''@/1/g' \
      -e 's/@''GNULIB_FSYNC''@/1/g' \
      -e 's/@''GNULIB_FTRUNCATE''@/0/g' \
      -e 's/@''GNULIB_GETCWD''@/1/g' \
      -e 's/@''GNULIB_GETDOMAINNAME''@/0/g' \
      -e 's/@''GNULIB_GETDTABLESIZE''@/1/g' \
      -e 's/@''GNULIB_GETGROUPS''@/0/g' \
      -e 's/@''GNULIB_GETHOSTNAME''@/0/g' \
      -e 's/@''GNULIB_GETLOGIN''@/0/g' \
      -e 's/@''GNULIB_GETLOGIN_R''@/0/g' \
      -e 's/@''GNULIB_GETPAGESIZE''@/0/g' \
      -e 's/@''GNULIB_GETPASS''@/0/g' \
      -e 's/@''GNULIB_GETUSERSHELL''@/0/g' \
      -e 's/@''GNULIB_GROUP_MEMBER''@/0/g' \
      -e 's/@''GNULIB_ISATTY''@/0/g' \
      -e 's/@''GNULIB_LCHOWN''@/0/g' \
      -e 's/@''GNULIB_LINK''@/0/g' \
      -e 's/@''GNULIB_LINKAT''@/0/g' \
      -e 's/@''GNULIB_LSEEK''@/1/g' \
      -e 's/@''GNULIB_PIPE''@/0/g' \
      -e 's/@''GNULIB_PIPE2''@/0/g' \
      -e 's/@''GNULIB_PREAD''@/0/g' \
      -e 's/@''GNULIB_PWRITE''@/0/g' \
      -e 's/@''GNULIB_READ''@/0/g' \
      -e 's/@''GNULIB_READLINK''@/0/g' \
      -e 's/@''GNULIB_READLINKAT''@/0/g' \
      -e 's/@''GNULIB_RMDIR''@/1/g' \
      -e 's/@''GNULIB_SETHOSTNAME''@/0/g' \
      -e 's/@''GNULIB_SLEEP''@/0/g' \
      -e 's/@''GNULIB_SYMLINK''@/0/g' \
      -e 's/@''GNULIB_SYMLINKAT''@/0/g' \
      -e 's/@''GNULIB_TRUNCATE''@/0/g' \
      -e 's/@''GNULIB_TTYNAME_R''@/0/g' \
      -e 's/@''GNULIB_UNISTD_H_GETOPT''@/0/g' \
      -e 's/@''GNULIB_UNISTD_H_NONBLOCKING''@/0/g' \
      -e 's/@''GNULIB_UNISTD_H_SIGPIPE''@/0/g' \
      -e 's/@''GNULIB_UNLINK''@/1/g' \
      -e 's/@''GNULIB_UNLINKAT''@/1/g' \
      -e 's/@''GNULIB_USLEEP''@/0/g' \
      -e 's/@''GNULIB_WRITE''@/0/g' \
      < ./unistd.in.h | \
  sed -e 's|@''HAVE_CHOWN''@|1|g' \
      -e 's|@''HAVE_DUP2''@|1|g' \
      -e 's|@''HAVE_DUP3''@|1|g' \
      -e 's|@''HAVE_EUIDACCESS''@|1|g' \
      -e 's|@''HAVE_FACCESSAT''@|1|g' \
      -e 's|@''HAVE_FCHDIR''@|1|g' \
      -e 's|@''HAVE_FCHOWNAT''@|1|g' \
      -e 's|@''HAVE_FDATASYNC''@|1|g' \
      -e 's|@''HAVE_FSYNC''@|1|g' \
      -e 's|@''HAVE_FTRUNCATE''@|1|g' \
      -e 's|@''HAVE_GETDTABLESIZE''@|1|g' \
      -e 's|@''HAVE_GETGROUPS''@|1|g' \
      -e 's|@''HAVE_GETHOSTNAME''@|1|g' \
      -e 's|@''HAVE_GETPAGESIZE''@|1|g' \
      -e 's|@''HAVE_GETPASS''@|1|g' \
      -e 's|@''HAVE_GROUP_MEMBER''@|1|g' \
      -e 's|@''HAVE_LCHOWN''@|1|g' \
      -e 's|@''HAVE_LINK''@|1|g' \
      -e 's|@''HAVE_LINKAT''@|1|g' \
      -e 's|@''HAVE_PIPE''@|1|g' \
      -e 's|@''HAVE_PIPE2''@|1|g' \
      -e 's|@''HAVE_PREAD''@|1|g' \
      -e 's|@''HAVE_PWRITE''@|1|g' \
      -e 's|@''HAVE_READLINK''@|1|g' \
      -e 's|@''HAVE_READLINKAT''@|1|g' \
      -e 's|@''HAVE_SETHOSTNAME''@|1|g' \
      -e 's|@''HAVE_SLEEP''@|1|g' \
      -e 's|@''HAVE_SYMLINK''@|1|g' \
      -e 's|@''HAVE_SYMLINKAT''@|1|g' \
      -e 's|@''HAVE_UNLINKAT''@|1|g' \
      -e 's|@''HAVE_USLEEP''@|1|g' \
      -e 's|@''HAVE_DECL_ENVIRON''@|1|g' \
      -e 's|@''HAVE_DECL_FCHDIR''@|1|g' \
      -e 's|@''HAVE_DECL_FDATASYNC''@|1|g' \
      -e 's|@''HAVE_DECL_GETDOMAINNAME''@|1|g' \
      -e 's|@''HAVE_DECL_GETLOGIN''@|1|g' \
      -e 's|@''HAVE_DECL_GETLOGIN_R''@|1|g' \
      -e 's|@''HAVE_DECL_GETPAGESIZE''@|1|g' \
      -e 's|@''HAVE_DECL_GETUSERSHELL''@|1|g' \
      -e 's|@''HAVE_DECL_SETHOSTNAME''@|1|g' \
      -e 's|@''HAVE_DECL_TRUNCATE''@|1|g' \
      -e 's|@''HAVE_DECL_TTYNAME_R''@|1|g' \
      -e 's|@''HAVE_OS_H''@|0|g' \
      -e 's|@''HAVE_SYS_PARAM_H''@|0|g' \
  | \
  sed -e 's|@''REPLACE_CHOWN''@|0|g' \
      -e 's|@''REPLACE_CLOSE''@|0|g' \
      -e 's|@''REPLACE_DUP''@|0|g' \
      -e 's|@''REPLACE_DUP2''@|0|g' \
      -e 's|@''REPLACE_FACCESSAT''@|0|g' \
      -e 's|@''REPLACE_FCHOWNAT''@|0|g' \
      -e 's|@''REPLACE_FTRUNCATE''@|0|g' \
      -e 's|@''REPLACE_GETCWD''@|0|g' \
      -e 's|@''REPLACE_GETDOMAINNAME''@|0|g' \
      -e 's|@''REPLACE_GETDTABLESIZE''@|0|g' \
      -e 's|@''REPLACE_GETLOGIN_R''@|0|g' \
      -e 's|@''REPLACE_GETGROUPS''@|0|g' \
      -e 's|@''REPLACE_GETPAGESIZE''@|0|g' \
      -e 's|@''REPLACE_GETPASS''@|0|g' \
      -e 's|@''REPLACE_ISATTY''@|0|g' \
      -e 's|@''REPLACE_LCHOWN''@|0|g' \
      -e 's|@''REPLACE_LINK''@|0|g' \
      -e 's|@''REPLACE_LINKAT''@|0|g' \
      -e 's|@''REPLACE_LSEEK''@|0|g' \
      -e 's|@''REPLACE_PREAD''@|0|g' \
      -e 's|@''REPLACE_PWRITE''@|0|g' \
      -e 's|@''REPLACE_READ''@|0|g' \
      -e 's|@''REPLACE_READLINK''@|0|g' \
      -e 's|@''REPLACE_READLINKAT''@|0|g' \
      -e 's|@''REPLACE_RMDIR''@|0|g' \
      -e 's|@''REPLACE_SLEEP''@|0|g' \
      -e 's|@''REPLACE_SYMLINK''@|0|g' \
      -e 's|@''REPLACE_SYMLINKAT''@|0|g' \
      -e 's|@''REPLACE_TRUNCATE''@|0|g' \
      -e 's|@''REPLACE_TTYNAME_R''@|0|g' \
      -e 's|@''REPLACE_UNLINK''@|0|g' \
      -e 's|@''REPLACE_UNLINKAT''@|0|g' \
      -e 's|@''REPLACE_USLEEP''@|0|g' \
      -e 's|@''REPLACE_WRITE''@|0|g' \
      -e 's|@''UNISTD_H_HAVE_WINSOCK2_H''@|0|g' \
      -e 's|@''UNISTD_H_HAVE_WINSOCK2_H_AND_USE_SOCKETS''@|0|g' \
      -e '/definitions of _GL_FUNCDECL_RPL/r ./c++defs.h' \
      -e '/definition of _GL_ARG_NONNULL/r ./arg-nonnull.h' \
      -e '/definition of _GL_WARN_ON_USE/r ./warn-on-use.h'; \
} > unistd.h-t && \
mv unistd.h-t unistd.h
echo "  GEN     " wchar.h;rm -f wchar.h-t wchar.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */'; \
  sed -e 's|@''GUARD_PREFIX''@|GL|g' \
      -e 's|@''INCLUDE_NEXT''@|include_next|g' \
      -e 's|@''PRAGMA_SYSTEM_HEADER''@|#pragma GCC system_header|g' \
      -e 's|@''PRAGMA_COLUMNS''@||g' \
      -e 's|@''HAVE_FEATURES_H''@|1|g' \
      -e 's|@''NEXT_WCHAR_H''@|<wchar.h>|g' \
      -e 's|@''HAVE_WCHAR_H''@|1|g' \
      -e 's/@''HAVE_CRTDEFS_H''@/0/g' \
      -e 's/@''GNULIB_OVERRIDES_WINT_T''@/0/g' \
      -e 's/@''GNULIB_BTOWC''@/0/g' \
      -e 's/@''GNULIB_WCTOB''@/0/g' \
      -e 's/@''GNULIB_MBSINIT''@/0/g' \
      -e 's/@''GNULIB_MBRTOWC''@/0/g' \
      -e 's/@''GNULIB_MBRLEN''@/0/g' \
      -e 's/@''GNULIB_MBSRTOWCS''@/0/g' \
      -e 's/@''GNULIB_MBSNRTOWCS''@/0/g' \
      -e 's/@''GNULIB_WCRTOMB''@/0/g' \
      -e 's/@''GNULIB_WCSRTOMBS''@/0/g' \
      -e 's/@''GNULIB_WCSNRTOMBS''@/0/g' \
      -e 's/@''GNULIB_WCWIDTH''@/0/g' \
      -e 's/@''GNULIB_WMEMCHR''@/0/g' \
      -e 's/@''GNULIB_WMEMCMP''@/0/g' \
      -e 's/@''GNULIB_WMEMCPY''@/0/g' \
      -e 's/@''GNULIB_WMEMMOVE''@/0/g' \
      -e 's/@''GNULIB_WMEMSET''@/0/g' \
      -e 's/@''GNULIB_WCSLEN''@/0/g' \
      -e 's/@''GNULIB_WCSNLEN''@/0/g' \
      -e 's/@''GNULIB_WCSCPY''@/0/g' \
      -e 's/@''GNULIB_WCPCPY''@/0/g' \
      -e 's/@''GNULIB_WCSNCPY''@/0/g' \
      -e 's/@''GNULIB_WCPNCPY''@/0/g' \
      -e 's/@''GNULIB_WCSCAT''@/0/g' \
      -e 's/@''GNULIB_WCSNCAT''@/0/g' \
      -e 's/@''GNULIB_WCSCMP''@/0/g' \
      -e 's/@''GNULIB_WCSNCMP''@/0/g' \
      -e 's/@''GNULIB_WCSCASECMP''@/0/g' \
      -e 's/@''GNULIB_WCSNCASECMP''@/0/g' \
      -e 's/@''GNULIB_WCSCOLL''@/0/g' \
      -e 's/@''GNULIB_WCSXFRM''@/0/g' \
      -e 's/@''GNULIB_WCSDUP''@/0/g' \
      -e 's/@''GNULIB_WCSCHR''@/0/g' \
      -e 's/@''GNULIB_WCSRCHR''@/0/g' \
      -e 's/@''GNULIB_WCSCSPN''@/0/g' \
      -e 's/@''GNULIB_WCSSPN''@/0/g' \
      -e 's/@''GNULIB_WCSPBRK''@/0/g' \
      -e 's/@''GNULIB_WCSSTR''@/0/g' \
      -e 's/@''GNULIB_WCSTOK''@/0/g' \
      -e 's/@''GNULIB_WCSWIDTH''@/0/g' \
      -e 's/@''GNULIB_WCSFTIME''@/0/g' \
      < ./wchar.in.h | \
  sed -e 's|@''HAVE_WINT_T''@|1|g' \
      -e 's|@''HAVE_BTOWC''@|1|g' \
      -e 's|@''HAVE_MBSINIT''@|1|g' \
      -e 's|@''HAVE_MBRTOWC''@|1|g' \
      -e 's|@''HAVE_MBRLEN''@|1|g' \
      -e 's|@''HAVE_MBSRTOWCS''@|1|g' \
      -e 's|@''HAVE_MBSNRTOWCS''@|1|g' \
      -e 's|@''HAVE_WCRTOMB''@|1|g' \
      -e 's|@''HAVE_WCSRTOMBS''@|1|g' \
      -e 's|@''HAVE_WCSNRTOMBS''@|1|g' \
      -e 's|@''HAVE_WMEMCHR''@|1|g' \
      -e 's|@''HAVE_WMEMCMP''@|1|g' \
      -e 's|@''HAVE_WMEMCPY''@|1|g' \
      -e 's|@''HAVE_WMEMMOVE''@|1|g' \
      -e 's|@''HAVE_WMEMSET''@|1|g' \
      -e 's|@''HAVE_WCSLEN''@|1|g' \
      -e 's|@''HAVE_WCSNLEN''@|1|g' \
      -e 's|@''HAVE_WCSCPY''@|1|g' \
      -e 's|@''HAVE_WCPCPY''@|1|g' \
      -e 's|@''HAVE_WCSNCPY''@|1|g' \
      -e 's|@''HAVE_WCPNCPY''@|1|g' \
      -e 's|@''HAVE_WCSCAT''@|1|g' \
      -e 's|@''HAVE_WCSNCAT''@|1|g' \
      -e 's|@''HAVE_WCSCMP''@|1|g' \
      -e 's|@''HAVE_WCSNCMP''@|1|g' \
      -e 's|@''HAVE_WCSCASECMP''@|1|g' \
      -e 's|@''HAVE_WCSNCASECMP''@|1|g' \
      -e 's|@''HAVE_WCSCOLL''@|1|g' \
      -e 's|@''HAVE_WCSXFRM''@|1|g' \
      -e 's|@''HAVE_WCSDUP''@|1|g' \
      -e 's|@''HAVE_WCSCHR''@|1|g' \
      -e 's|@''HAVE_WCSRCHR''@|1|g' \
      -e 's|@''HAVE_WCSCSPN''@|1|g' \
      -e 's|@''HAVE_WCSSPN''@|1|g' \
      -e 's|@''HAVE_WCSPBRK''@|1|g' \
      -e 's|@''HAVE_WCSSTR''@|1|g' \
      -e 's|@''HAVE_WCSTOK''@|1|g' \
      -e 's|@''HAVE_WCSWIDTH''@|1|g' \
      -e 's|@''HAVE_WCSFTIME''@|1|g' \
      -e 's|@''HAVE_DECL_WCTOB''@|1|g' \
      -e 's|@''HAVE_DECL_WCWIDTH''@|1|g' \
  | \
  sed -e 's|@''REPLACE_MBSTATE_T''@|0|g' \
      -e 's|@''REPLACE_BTOWC''@|0|g' \
      -e 's|@''REPLACE_WCTOB''@|0|g' \
      -e 's|@''REPLACE_MBSINIT''@|0|g' \
      -e 's|@''REPLACE_MBRTOWC''@|0|g' \
      -e 's|@''REPLACE_MBRLEN''@|0|g' \
      -e 's|@''REPLACE_MBSRTOWCS''@|0|g' \
      -e 's|@''REPLACE_MBSNRTOWCS''@|0|g' \
      -e 's|@''REPLACE_WCRTOMB''@|0|g' \
      -e 's|@''REPLACE_WCSRTOMBS''@|0|g' \
      -e 's|@''REPLACE_WCSNRTOMBS''@|0|g' \
      -e 's|@''REPLACE_WCWIDTH''@|0|g' \
      -e 's|@''REPLACE_WCSWIDTH''@|0|g' \
      -e 's|@''REPLACE_WCSFTIME''@|0|g' \
      -e '/definitions of _GL_FUNCDECL_RPL/r ./c++defs.h' \
      -e '/definition of _GL_ARG_NONNULL/r ./arg-nonnull.h' \
      -e '/definition of _GL_WARN_ON_USE/r ./warn-on-use.h'; \
} > wchar.h-t && \
mv wchar.h-t wchar.h
test -f config.h || rm -f stamp-h1
test -f config.h || make  stamp-h1
make  all-am
make[3]: Entering directory '/home/kmr/Documents/ninjaInputFiles/gzip-1.10-clang-yojson/lib'
test -f config.h || rm -f stamp-h1
test -f config.h || make  stamp-h1
echo "  GEN     " fcntl.h;rm -f fcntl.h-t fcntl.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */'; \
  sed -e 's|@''GUARD_PREFIX''@|GL|g' \
      -e 's|@''INCLUDE_NEXT''@|include_next|g' \
      -e 's|@''PRAGMA_SYSTEM_HEADER''@|#pragma GCC system_header|g' \
      -e 's|@''PRAGMA_COLUMNS''@||g' \
      -e 's|@''NEXT_FCNTL_H''@|<fcntl.h>|g' \
      -e 's/@''GNULIB_FCNTL''@/1/g' \
      -e 's/@''GNULIB_NONBLOCKING''@/0/g' \
      -e 's/@''GNULIB_OPEN''@/1/g' \
      -e 's/@''GNULIB_OPENAT''@/1/g' \
      -e 's|@''HAVE_FCNTL''@|1|g' \
      -e 's|@''HAVE_OPENAT''@|1|g' \
      -e 's|@''REPLACE_FCNTL''@|1|g' \
      -e 's|@''REPLACE_OPEN''@|0|g' \
      -e 's|@''REPLACE_OPENAT''@|0|g' \
      -e '/definitions of _GL_FUNCDECL_RPL/r ./c++defs.h' \
      -e '/definition of _GL_ARG_NONNULL/r ./arg-nonnull.h' \
      -e '/definition of _GL_WARN_ON_USE/r ./warn-on-use.h' \
      < ./fcntl.in.h; \
} > fcntl.h-t && \
mv fcntl.h-t fcntl.h
/bin/mkdir -p sys
echo "  GEN     " sys/types.h;rm -f sys/types.h-t sys/types.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */'; \
  sed -e 's|@''GUARD_PREFIX''@|GL|g' \
      -e 's|@''INCLUDE_NEXT''@|include_next|g' \
      -e 's|@''PRAGMA_SYSTEM_HEADER''@|#pragma GCC system_header|g' \
      -e 's|@''PRAGMA_COLUMNS''@||g' \
      -e 's|@''NEXT_SYS_TYPES_H''@|<sys/types.h>|g' \
      -e 's|@''WINDOWS_64_BIT_OFF_T''@|0|g' \
      -e 's|@''WINDOWS_STAT_INODES''@|0|g' \
      < ./sys_types.in.h; \
} > sys/types.h-t && \
mv sys/types.h-t sys/types.h
echo "  GEN     " unistd.h;rm -f unistd.h-t unistd.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */'; \
  sed -e 's|@''GUARD_PREFIX''@|GL|g' \
      -e 's|@''HAVE_UNISTD_H''@|1|g' \
      -e 's|@''INCLUDE_NEXT''@|include_next|g' \
      -e 's|@''PRAGMA_SYSTEM_HEADER''@|#pragma GCC system_header|g' \
      -e 's|@''PRAGMA_COLUMNS''@||g' \
      -e 's|@''NEXT_UNISTD_H''@|<unistd.h>|g' \
      -e 's|@''WINDOWS_64_BIT_OFF_T''@|0|g' \
      -e 's/@''GNULIB_CHDIR''@/1/g' \
      -e 's/@''GNULIB_CHOWN''@/0/g' \
      -e 's/@''GNULIB_CLOSE''@/1/g' \
      -e 's/@''GNULIB_DUP''@/1/g' \
      -e 's/@''GNULIB_DUP2''@/1/g' \
      -e 's/@''GNULIB_DUP3''@/0/g' \
      -e 's/@''GNULIB_ENVIRON''@/0/g' \
      -e 's/@''GNULIB_EUIDACCESS''@/0/g' \
      -e 's/@''GNULIB_FACCESSAT''@/0/g' \
      -e 's/@''GNULIB_FCHDIR''@/1/g' \
      -e 's/@''GNULIB_FCHOWNAT''@/0/g' \
      -e 's/@''GNULIB_FDATASYNC''@/1/g' \
      -e 's/@''GNULIB_FSYNC''@/1/g' \
      -e 's/@''GNULIB_FTRUNCATE''@/0/g' \
      -e 's/@''GNULIB_GETCWD''@/1/g' \
      -e 's/@''GNULIB_GETDOMAINNAME''@/0/g' \
      -e 's/@''GNULIB_GETDTABLESIZE''@/1/g' \
      -e 's/@''GNULIB_GETGROUPS''@/0/g' \
      -e 's/@''GNULIB_GETHOSTNAME''@/0/g' \
      -e 's/@''GNULIB_GETLOGIN''@/0/g' \
      -e 's/@''GNULIB_GETLOGIN_R''@/0/g' \
      -e 's/@''GNULIB_GETPAGESIZE''@/0/g' \
      -e 's/@''GNULIB_GETPASS''@/0/g' \
      -e 's/@''GNULIB_GETUSERSHELL''@/0/g' \
      -e 's/@''GNULIB_GROUP_MEMBER''@/0/g' \
      -e 's/@''GNULIB_ISATTY''@/0/g' \
      -e 's/@''GNULIB_LCHOWN''@/0/g' \
      -e 's/@''GNULIB_LINK''@/0/g' \
      -e 's/@''GNULIB_LINKAT''@/0/g' \
      -e 's/@''GNULIB_LSEEK''@/1/g' \
      -e 's/@''GNULIB_PIPE''@/0/g' \
      -e 's/@''GNULIB_PIPE2''@/0/g' \
      -e 's/@''GNULIB_PREAD''@/0/g' \
      -e 's/@''GNULIB_PWRITE''@/0/g' \
      -e 's/@''GNULIB_READ''@/0/g' \
      -e 's/@''GNULIB_READLINK''@/0/g' \
      -e 's/@''GNULIB_READLINKAT''@/0/g' \
      -e 's/@''GNULIB_RMDIR''@/1/g' \
      -e 's/@''GNULIB_SETHOSTNAME''@/0/g' \
      -e 's/@''GNULIB_SLEEP''@/0/g' \
      -e 's/@''GNULIB_SYMLINK''@/0/g' \
      -e 's/@''GNULIB_SYMLINKAT''@/0/g' \
      -e 's/@''GNULIB_TRUNCATE''@/0/g' \
      -e 's/@''GNULIB_TTYNAME_R''@/0/g' \
      -e 's/@''GNULIB_UNISTD_H_GETOPT''@/0/g' \
      -e 's/@''GNULIB_UNISTD_H_NONBLOCKING''@/0/g' \
      -e 's/@''GNULIB_UNISTD_H_SIGPIPE''@/0/g' \
      -e 's/@''GNULIB_UNLINK''@/1/g' \
      -e 's/@''GNULIB_UNLINKAT''@/1/g' \
      -e 's/@''GNULIB_USLEEP''@/0/g' \
      -e 's/@''GNULIB_WRITE''@/0/g' \
      < ./unistd.in.h | \
  sed -e 's|@''HAVE_CHOWN''@|1|g' \
      -e 's|@''HAVE_DUP2''@|1|g' \
      -e 's|@''HAVE_DUP3''@|1|g' \
      -e 's|@''HAVE_EUIDACCESS''@|1|g' \
      -e 's|@''HAVE_FACCESSAT''@|1|g' \
      -e 's|@''HAVE_FCHDIR''@|1|g' \
      -e 's|@''HAVE_FCHOWNAT''@|1|g' \
      -e 's|@''HAVE_FDATASYNC''@|1|g' \
      -e 's|@''HAVE_FSYNC''@|1|g' \
      -e 's|@''HAVE_FTRUNCATE''@|1|g' \
      -e 's|@''HAVE_GETDTABLESIZE''@|1|g' \
      -e 's|@''HAVE_GETGROUPS''@|1|g' \
      -e 's|@''HAVE_GETHOSTNAME''@|1|g' \
      -e 's|@''HAVE_GETPAGESIZE''@|1|g' \
      -e 's|@''HAVE_GETPASS''@|1|g' \
      -e 's|@''HAVE_GROUP_MEMBER''@|1|g' \
      -e 's|@''HAVE_LCHOWN''@|1|g' \
      -e 's|@''HAVE_LINK''@|1|g' \
      -e 's|@''HAVE_LINKAT''@|1|g' \
      -e 's|@''HAVE_PIPE''@|1|g' \
      -e 's|@''HAVE_PIPE2''@|1|g' \
      -e 's|@''HAVE_PREAD''@|1|g' \
      -e 's|@''HAVE_PWRITE''@|1|g' \
      -e 's|@''HAVE_READLINK''@|1|g' \
      -e 's|@''HAVE_READLINKAT''@|1|g' \
      -e 's|@''HAVE_SETHOSTNAME''@|1|g' \
      -e 's|@''HAVE_SLEEP''@|1|g' \
      -e 's|@''HAVE_SYMLINK''@|1|g' \
      -e 's|@''HAVE_SYMLINKAT''@|1|g' \
      -e 's|@''HAVE_UNLINKAT''@|1|g' \
      -e 's|@''HAVE_USLEEP''@|1|g' \
      -e 's|@''HAVE_DECL_ENVIRON''@|1|g' \
      -e 's|@''HAVE_DECL_FCHDIR''@|1|g' \
      -e 's|@''HAVE_DECL_FDATASYNC''@|1|g' \
      -e 's|@''HAVE_DECL_GETDOMAINNAME''@|1|g' \
      -e 's|@''HAVE_DECL_GETLOGIN''@|1|g' \
      -e 's|@''HAVE_DECL_GETLOGIN_R''@|1|g' \
      -e 's|@''HAVE_DECL_GETPAGESIZE''@|1|g' \
      -e 's|@''HAVE_DECL_GETUSERSHELL''@|1|g' \
      -e 's|@''HAVE_DECL_SETHOSTNAME''@|1|g' \
      -e 's|@''HAVE_DECL_TRUNCATE''@|1|g' \
      -e 's|@''HAVE_DECL_TTYNAME_R''@|1|g' \
      -e 's|@''HAVE_OS_H''@|0|g' \
      -e 's|@''HAVE_SYS_PARAM_H''@|0|g' \
  | \
  sed -e 's|@''REPLACE_CHOWN''@|0|g' \
      -e 's|@''REPLACE_CLOSE''@|0|g' \
      -e 's|@''REPLACE_DUP''@|0|g' \
      -e 's|@''REPLACE_DUP2''@|0|g' \
      -e 's|@''REPLACE_FACCESSAT''@|0|g' \
      -e 's|@''REPLACE_FCHOWNAT''@|0|g' \
      -e 's|@''REPLACE_FTRUNCATE''@|0|g' \
      -e 's|@''REPLACE_GETCWD''@|0|g' \
      -e 's|@''REPLACE_GETDOMAINNAME''@|0|g' \
      -e 's|@''REPLACE_GETDTABLESIZE''@|0|g' \
      -e 's|@''REPLACE_GETLOGIN_R''@|0|g' \
      -e 's|@''REPLACE_GETGROUPS''@|0|g' \
      -e 's|@''REPLACE_GETPAGESIZE''@|0|g' \
      -e 's|@''REPLACE_GETPASS''@|0|g' \
      -e 's|@''REPLACE_ISATTY''@|0|g' \
      -e 's|@''REPLACE_LCHOWN''@|0|g' \
      -e 's|@''REPLACE_LINK''@|0|g' \
      -e 's|@''REPLACE_LINKAT''@|0|g' \
      -e 's|@''REPLACE_LSEEK''@|0|g' \
      -e 's|@''REPLACE_PREAD''@|0|g' \
      -e 's|@''REPLACE_PWRITE''@|0|g' \
      -e 's|@''REPLACE_READ''@|0|g' \
      -e 's|@''REPLACE_READLINK''@|0|g' \
      -e 's|@''REPLACE_READLINKAT''@|0|g' \
      -e 's|@''REPLACE_RMDIR''@|0|g' \
      -e 's|@''REPLACE_SLEEP''@|0|g' \
      -e 's|@''REPLACE_SYMLINK''@|0|g' \
      -e 's|@''REPLACE_SYMLINKAT''@|0|g' \
      -e 's|@''REPLACE_TRUNCATE''@|0|g' \
      -e 's|@''REPLACE_TTYNAME_R''@|0|g' \
      -e 's|@''REPLACE_UNLINK''@|0|g' \
      -e 's|@''REPLACE_UNLINKAT''@|0|g' \
      -e 's|@''REPLACE_USLEEP''@|0|g' \
      -e 's|@''REPLACE_WRITE''@|0|g' \
      -e 's|@''UNISTD_H_HAVE_WINSOCK2_H''@|0|g' \
      -e 's|@''UNISTD_H_HAVE_WINSOCK2_H_AND_USE_SOCKETS''@|0|g' \
      -e '/definitions of _GL_FUNCDECL_RPL/r ./c++defs.h' \
      -e '/definition of _GL_ARG_NONNULL/r ./arg-nonnull.h' \
      -e '/definition of _GL_WARN_ON_USE/r ./warn-on-use.h'; \
} > unistd.h-t && \
mv unistd.h-t unistd.h
echo "  CC      " cloexec.o;depbase=`echo cloexec.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT cloexec.o -MD -MP -MF $depbase.Tpo -c -o cloexec.o cloexec.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  GEN     " dirent.h;rm -f dirent.h-t dirent.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */'; \
  sed -e 's|@''GUARD_PREFIX''@|GL|g' \
      -e 's|@''HAVE_DIRENT_H''@|1|g' \
      -e 's|@''INCLUDE_NEXT''@|include_next|g' \
      -e 's|@''PRAGMA_SYSTEM_HEADER''@|#pragma GCC system_header|g' \
      -e 's|@''PRAGMA_COLUMNS''@||g' \
      -e 's|@''NEXT_DIRENT_H''@|<dirent.h>|g' \
      -e 's/@''GNULIB_OPENDIR''@/1/g' \
      -e 's/@''GNULIB_READDIR''@/1/g' \
      -e 's/@''GNULIB_REWINDDIR''@/0/g' \
      -e 's/@''GNULIB_CLOSEDIR''@/1/g' \
      -e 's/@''GNULIB_DIRFD''@/1/g' \
      -e 's/@''GNULIB_FDOPENDIR''@/1/g' \
      -e 's/@''GNULIB_SCANDIR''@/0/g' \
      -e 's/@''GNULIB_ALPHASORT''@/0/g' \
      -e 's/@''HAVE_OPENDIR''@/1/g' \
      -e 's/@''HAVE_READDIR''@/1/g' \
      -e 's/@''HAVE_REWINDDIR''@/1/g' \
      -e 's/@''HAVE_CLOSEDIR''@/1/g' \
      -e 's|@''HAVE_DECL_DIRFD''@|1|g' \
      -e 's|@''HAVE_DECL_FDOPENDIR''@|1|g' \
      -e 's|@''HAVE_FDOPENDIR''@|1|g' \
      -e 's|@''HAVE_SCANDIR''@|1|g' \
      -e 's|@''HAVE_ALPHASORT''@|1|g' \
      -e 's|@''REPLACE_OPENDIR''@|0|g' \
      -e 's|@''REPLACE_CLOSEDIR''@|0|g' \
      -e 's|@''REPLACE_DIRFD''@|0|g' \
      -e 's|@''REPLACE_FDOPENDIR''@|0|g' \
      -e '/definitions of _GL_FUNCDECL_RPL/r ./c++defs.h' \
      -e '/definition of _GL_ARG_NONNULL/r ./arg-nonnull.h' \
      -e '/definition of _GL_WARN_ON_USE/r ./warn-on-use.h' \
      < ./dirent.in.h; \
} > dirent.h-t && \
mv dirent.h-t dirent.h
echo "  CC      " opendir-safer.o;depbase=`echo opendir-safer.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT opendir-safer.o -MD -MP -MF $depbase.Tpo -c -o opendir-safer.o opendir-safer.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  GEN     " stdlib.h;rm -f stdlib.h-t stdlib.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */' && \
  sed -e 's|@''GUARD_PREFIX''@|GL|g' \
      -e 's|@''INCLUDE_NEXT''@|include_next|g' \
      -e 's|@''PRAGMA_SYSTEM_HEADER''@|#pragma GCC system_header|g' \
      -e 's|@''PRAGMA_COLUMNS''@||g' \
      -e 's|@''NEXT_STDLIB_H''@|<stdlib.h>|g' \
      -e 's/@''GNULIB__EXIT''@/0/g' \
      -e 's/@''GNULIB_ATOLL''@/0/g' \
      -e 's/@''GNULIB_CALLOC_POSIX''@/1/g' \
      -e 's/@''GNULIB_CANONICALIZE_FILE_NAME''@/0/g' \
      -e 's/@''GNULIB_GETLOADAVG''@/0/g' \
      -e 's/@''GNULIB_GETSUBOPT''@/0/g' \
      -e 's/@''GNULIB_GRANTPT''@/0/g' \
      -e 's/@''GNULIB_MALLOC_POSIX''@/1/g' \
      -e 's/@''GNULIB_MBTOWC''@/0/g' \
      -e 's/@''GNULIB_MKDTEMP''@/0/g' \
      -e 's/@''GNULIB_MKOSTEMP''@/0/g' \
      -e 's/@''GNULIB_MKOSTEMPS''@/0/g' \
      -e 's/@''GNULIB_MKSTEMP''@/0/g' \
      -e 's/@''GNULIB_MKSTEMPS''@/0/g' \
      -e 's/@''GNULIB_POSIX_OPENPT''@/0/g' \
      -e 's/@''GNULIB_PTSNAME''@/0/g' \
      -e 's/@''GNULIB_PTSNAME_R''@/0/g' \
      -e 's/@''GNULIB_PUTENV''@/0/g' \
      -e 's/@''GNULIB_QSORT_R''@/0/g' \
      -e 's/@''GNULIB_RANDOM''@/0/g' \
      -e 's/@''GNULIB_RANDOM_R''@/0/g' \
      -e 's/@''GNULIB_REALLOC_POSIX''@/1/g' \
      -e 's/@''GNULIB_REALLOCARRAY''@/0/g' \
      -e 's/@''GNULIB_REALPATH''@/0/g' \
      -e 's/@''GNULIB_RPMATCH''@/0/g' \
      -e 's/@''GNULIB_SECURE_GETENV''@/0/g' \
      -e 's/@''GNULIB_SETENV''@/0/g' \
      -e 's/@''GNULIB_STRTOD''@/0/g' \
      -e 's/@''GNULIB_STRTOLL''@/0/g' \
      -e 's/@''GNULIB_STRTOULL''@/0/g' \
      -e 's/@''GNULIB_SYSTEM_POSIX''@/0/g' \
      -e 's/@''GNULIB_UNLOCKPT''@/0/g' \
      -e 's/@''GNULIB_UNSETENV''@/0/g' \
      -e 's/@''GNULIB_WCTOMB''@/0/g' \
      < ./stdlib.in.h | \
  sed -e 's|@''HAVE__EXIT''@|1|g' \
      -e 's|@''HAVE_ATOLL''@|1|g' \
      -e 's|@''HAVE_CANONICALIZE_FILE_NAME''@|1|g' \
      -e 's|@''HAVE_DECL_GETLOADAVG''@|1|g' \
      -e 's|@''HAVE_GETSUBOPT''@|1|g' \
      -e 's|@''HAVE_GRANTPT''@|1|g' \
      -e 's|@''HAVE_DECL_INITSTATE''@|1|g' \
      -e 's|@''HAVE_MKDTEMP''@|1|g' \
      -e 's|@''HAVE_MKOSTEMP''@|1|g' \
      -e 's|@''HAVE_MKOSTEMPS''@|1|g' \
      -e 's|@''HAVE_MKSTEMP''@|1|g' \
      -e 's|@''HAVE_MKSTEMPS''@|1|g' \
      -e 's|@''HAVE_POSIX_OPENPT''@|1|g' \
      -e 's|@''HAVE_PTSNAME''@|1|g' \
      -e 's|@''HAVE_PTSNAME_R''@|1|g' \
      -e 's|@''HAVE_QSORT_R''@|1|g' \
      -e 's|@''HAVE_RANDOM''@|1|g' \
      -e 's|@''HAVE_RANDOM_H''@|1|g' \
      -e 's|@''HAVE_RANDOM_R''@|1|g' \
      -e 's|@''HAVE_REALLOCARRAY''@|1|g' \
      -e 's|@''HAVE_REALPATH''@|1|g' \
      -e 's|@''HAVE_RPMATCH''@|1|g' \
      -e 's|@''HAVE_SECURE_GETENV''@|1|g' \
      -e 's|@''HAVE_DECL_SETENV''@|1|g' \
      -e 's|@''HAVE_DECL_SETSTATE''@|1|g' \
      -e 's|@''HAVE_STRTOD''@|1|g' \
      -e 's|@''HAVE_STRTOLL''@|1|g' \
      -e 's|@''HAVE_STRTOULL''@|1|g' \
      -e 's|@''HAVE_STRUCT_RANDOM_DATA''@|1|g' \
      -e 's|@''HAVE_SYS_LOADAVG_H''@|0|g' \
      -e 's|@''HAVE_UNLOCKPT''@|1|g' \
      -e 's|@''HAVE_DECL_UNSETENV''@|1|g' \
      -e 's|@''REPLACE_CALLOC''@|1|g' \
      -e 's|@''REPLACE_CANONICALIZE_FILE_NAME''@|0|g' \
      -e 's|@''REPLACE_MALLOC''@|0|g' \
      -e 's|@''REPLACE_MBTOWC''@|0|g' \
      -e 's|@''REPLACE_MKSTEMP''@|0|g' \
      -e 's|@''REPLACE_PTSNAME''@|0|g' \
      -e 's|@''REPLACE_PTSNAME_R''@|0|g' \
      -e 's|@''REPLACE_PUTENV''@|0|g' \
      -e 's|@''REPLACE_QSORT_R''@|0|g' \
      -e 's|@''REPLACE_RANDOM_R''@|0|g' \
      -e 's|@''REPLACE_REALLOC''@|0|g' \
      -e 's|@''REPLACE_REALPATH''@|0|g' \
      -e 's|@''REPLACE_SETENV''@|0|g' \
      -e 's|@''REPLACE_STRTOD''@|0|g' \
      -e 's|@''REPLACE_UNSETENV''@|0|g' \
      -e 's|@''REPLACE_WCTOMB''@|0|g' \
      -e '/definitions of _GL_FUNCDECL_RPL/r ./c++defs.h' \
      -e '/definition of _Noreturn/r ./_Noreturn.h' \
      -e '/definition of _GL_ARG_NONNULL/r ./arg-nonnull.h' \
      -e '/definition of _GL_WARN_ON_USE/r ./warn-on-use.h'; \
} > stdlib.h-t && \
mv stdlib.h-t stdlib.h
echo "  GEN     " alloca.h;rm -f alloca.h-t alloca.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */'; \
  cat ./alloca.in.h; \
} > alloca.h-t && \
mv -f alloca.h-t alloca.h
echo "  GEN     " string.h;rm -f string.h-t string.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */' && \
  sed -e 's|@''GUARD_PREFIX''@|GL|g' \
      -e 's|@''INCLUDE_NEXT''@|include_next|g' \
      -e 's|@''PRAGMA_SYSTEM_HEADER''@|#pragma GCC system_header|g' \
      -e 's|@''PRAGMA_COLUMNS''@||g' \
      -e 's|@''NEXT_STRING_H''@|<string.h>|g' \
      -e 's/@''GNULIB_EXPLICIT_BZERO''@/0/g' \
      -e 's/@''GNULIB_FFSL''@/0/g' \
      -e 's/@''GNULIB_FFSLL''@/0/g' \
      -e 's/@''GNULIB_MBSLEN''@/0/g' \
      -e 's/@''GNULIB_MBSNLEN''@/0/g' \
      -e 's/@''GNULIB_MBSCHR''@/0/g' \
      -e 's/@''GNULIB_MBSRCHR''@/0/g' \
      -e 's/@''GNULIB_MBSSTR''@/0/g' \
      -e 's/@''GNULIB_MBSCASECMP''@/0/g' \
      -e 's/@''GNULIB_MBSNCASECMP''@/0/g' \
      -e 's/@''GNULIB_MBSPCASECMP''@/0/g' \
      -e 's/@''GNULIB_MBSCASESTR''@/0/g' \
      -e 's/@''GNULIB_MBSCSPN''@/0/g' \
      -e 's/@''GNULIB_MBSPBRK''@/0/g' \
      -e 's/@''GNULIB_MBSSPN''@/0/g' \
      -e 's/@''GNULIB_MBSSEP''@/0/g' \
      -e 's/@''GNULIB_MBSTOK_R''@/0/g' \
      -e 's/@''GNULIB_MEMCHR''@/1/g' \
      -e 's/@''GNULIB_MEMMEM''@/0/g' \
      -e 's/@''GNULIB_MEMPCPY''@/1/g' \
      -e 's/@''GNULIB_MEMRCHR''@/1/g' \
      -e 's/@''GNULIB_RAWMEMCHR''@/0/g' \
      -e 's/@''GNULIB_STPCPY''@/1/g' \
      -e 's/@''GNULIB_STPNCPY''@/0/g' \
      -e 's/@''GNULIB_STRCHRNUL''@/0/g' \
      -e 's/@''GNULIB_STRDUP''@/1/g' \
      -e 's/@''GNULIB_STRNCAT''@/0/g' \
      -e 's/@''GNULIB_STRNDUP''@/0/g' \
      -e 's/@''GNULIB_STRNLEN''@/0/g' \
      -e 's/@''GNULIB_STRPBRK''@/0/g' \
      -e 's/@''GNULIB_STRSEP''@/0/g' \
      -e 's/@''GNULIB_STRSTR''@/0/g' \
      -e 's/@''GNULIB_STRCASESTR''@/0/g' \
      -e 's/@''GNULIB_STRTOK_R''@/0/g' \
      -e 's/@''GNULIB_STRERROR''@/1/g' \
      -e 's/@''GNULIB_STRERROR_R''@/1/g' \
      -e 's/@''GNULIB_STRSIGNAL''@/0/g' \
      -e 's/@''GNULIB_STRVERSCMP''@/0/g' \
      < ./string.in.h | \
  sed -e 's|@''HAVE_EXPLICIT_BZERO''@|1|g' \
      -e 's|@''HAVE_FFSL''@|1|g' \
      -e 's|@''HAVE_FFSLL''@|1|g' \
      -e 's|@''HAVE_MBSLEN''@|0|g' \
      -e 's|@''HAVE_MEMCHR''@|1|g' \
      -e 's|@''HAVE_DECL_MEMMEM''@|1|g' \
      -e 's|@''HAVE_MEMPCPY''@|1|g' \
      -e 's|@''HAVE_DECL_MEMRCHR''@|1|g' \
      -e 's|@''HAVE_RAWMEMCHR''@|1|g' \
      -e 's|@''HAVE_STPCPY''@|1|g' \
      -e 's|@''HAVE_STPNCPY''@|1|g' \
      -e 's|@''HAVE_STRCHRNUL''@|1|g' \
      -e 's|@''HAVE_DECL_STRDUP''@|1|g' \
      -e 's|@''HAVE_DECL_STRNDUP''@|1|g' \
      -e 's|@''HAVE_DECL_STRNLEN''@|1|g' \
      -e 's|@''HAVE_STRPBRK''@|1|g' \
      -e 's|@''HAVE_STRSEP''@|1|g' \
      -e 's|@''HAVE_STRCASESTR''@|1|g' \
      -e 's|@''HAVE_DECL_STRTOK_R''@|1|g' \
      -e 's|@''HAVE_DECL_STRERROR_R''@|1|g' \
      -e 's|@''HAVE_DECL_STRSIGNAL''@|1|g' \
      -e 's|@''HAVE_STRVERSCMP''@|1|g' \
      -e 's|@''REPLACE_MEMCHR''@|0|g' \
      -e 's|@''REPLACE_MEMMEM''@|0|g' \
      -e 's|@''REPLACE_STPNCPY''@|0|g' \
      -e 's|@''REPLACE_STRCHRNUL''@|0|g' \
      -e 's|@''REPLACE_STRDUP''@|0|g' \
      -e 's|@''REPLACE_STRNCAT''@|0|g' \
      -e 's|@''REPLACE_STRNDUP''@|0|g' \
      -e 's|@''REPLACE_STRNLEN''@|0|g' \
      -e 's|@''REPLACE_STRSTR''@|0|g' \
      -e 's|@''REPLACE_STRCASESTR''@|0|g' \
      -e 's|@''REPLACE_STRTOK_R''@|0|g' \
      -e 's|@''REPLACE_STRERROR''@|0|g' \
      -e 's|@''REPLACE_STRERROR_R''@|1|g' \
      -e 's|@''REPLACE_STRSIGNAL''@|0|g' \
      -e 's|@''UNDEFINE_STRTOK_R''@|0|g' \
      -e '/definitions of _GL_FUNCDECL_RPL/r ./c++defs.h' \
      -e '/definition of _GL_ARG_NONNULL/r ./arg-nonnull.h' \
      -e '/definition of _GL_WARN_ON_USE/r ./warn-on-use.h'; \
      < ./string.in.h; \
} > string.h-t && \
mv string.h-t string.h
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
echo "  GEN     " stdio.h;rm -f stdio.h-t stdio.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */' && \
  sed -e 's|@''GUARD_PREFIX''@|GL|g' \
      -e 's|@''INCLUDE_NEXT''@|include_next|g' \
      -e 's|@''PRAGMA_SYSTEM_HEADER''@|#pragma GCC system_header|g' \
      -e 's|@''PRAGMA_COLUMNS''@||g' \
      -e 's|@''NEXT_STDIO_H''@|<stdio.h>|g' \
      -e 's/@''GNULIB_DPRINTF''@/0/g' \
      -e 's/@''GNULIB_FCLOSE''@/1/g' \
      -e 's/@''GNULIB_FDOPEN''@/0/g' \
      -e 's/@''GNULIB_FFLUSH''@/1/g' \
      -e 's/@''GNULIB_FGETC''@/1/g' \
      -e 's/@''GNULIB_FGETS''@/1/g' \
      -e 's/@''GNULIB_FOPEN''@/0/g' \
      -e 's/@''GNULIB_FPRINTF''@/1/g' \
      -e 's/@''GNULIB_FPRINTF_POSIX''@/1/g' \
      -e 's/@''GNULIB_FPURGE''@/1/g' \
      -e 's/@''GNULIB_FPUTC''@/1/g' \
      -e 's/@''GNULIB_FPUTS''@/1/g' \
      -e 's/@''GNULIB_FREAD''@/1/g' \
      -e 's/@''GNULIB_FREOPEN''@/0/g' \
      -e 's/@''GNULIB_FSCANF''@/1/g' \
      -e 's/@''GNULIB_FSEEK''@/1/g' \
      -e 's/@''GNULIB_FSEEKO''@/1/g' \
      -e 's/@''GNULIB_FTELL''@/1/g' \
      -e 's/@''GNULIB_FTELLO''@/1/g' \
      -e 's/@''GNULIB_FWRITE''@/1/g' \
      -e 's/@''GNULIB_GETC''@/1/g' \
      -e 's/@''GNULIB_GETCHAR''@/1/g' \
      -e 's/@''GNULIB_GETDELIM''@/0/g' \
      -e 's/@''GNULIB_GETLINE''@/0/g' \
      -e 's/@''GNULIB_OBSTACK_PRINTF''@/0/g' \
      -e 's/@''GNULIB_OBSTACK_PRINTF_POSIX''@/0/g' \
      -e 's/@''GNULIB_PCLOSE''@/0/g' \
      -e 's/@''GNULIB_PERROR''@/1/g' \
      -e 's/@''GNULIB_POPEN''@/0/g' \
      -e 's/@''GNULIB_PRINTF''@/1/g' \
      -e 's/@''GNULIB_PRINTF_POSIX''@/1/g' \
      -e 's/@''GNULIB_PUTC''@/1/g' \
      -e 's/@''GNULIB_PUTCHAR''@/1/g' \
      -e 's/@''GNULIB_PUTS''@/1/g' \
      -e 's/@''GNULIB_REMOVE''@/0/g' \
      -e 's/@''GNULIB_RENAME''@/0/g' \
      -e 's/@''GNULIB_RENAMEAT''@/0/g' \
      -e 's/@''GNULIB_SCANF''@/1/g' \
      -e 's/@''GNULIB_SNPRINTF''@/0/g' \
      -e 's/@''GNULIB_SPRINTF_POSIX''@/0/g' \
      -e 's/@''GNULIB_STDIO_H_NONBLOCKING''@/0/g' \
      -e 's/@''GNULIB_STDIO_H_SIGPIPE''@/0/g' \
      -e 's/@''GNULIB_TMPFILE''@/0/g' \
      -e 's/@''GNULIB_VASPRINTF''@/0/g' \
      -e 's/@''GNULIB_VDPRINTF''@/0/g' \
      -e 's/@''GNULIB_VFPRINTF''@/1/g' \
      -e 's/@''GNULIB_VFPRINTF_POSIX''@/1/g' \
      -e 's/@''GNULIB_VFSCANF''@/0/g' \
      -e 's/@''GNULIB_VSCANF''@/0/g' \
      -e 's/@''GNULIB_VPRINTF''@/1/g' \
      -e 's/@''GNULIB_VPRINTF_POSIX''@/0/g' \
      -e 's/@''GNULIB_VSNPRINTF''@/0/g' \
      -e 's/@''GNULIB_VSPRINTF_POSIX''@/0/g' \
      < ./stdio.in.h | \
  sed -e 's|@''HAVE_DECL_FPURGE''@|0|g' \
      -e 's|@''HAVE_DECL_FSEEKO''@|1|g' \
      -e 's|@''HAVE_DECL_FTELLO''@|1|g' \
      -e 's|@''HAVE_DECL_GETDELIM''@|1|g' \
      -e 's|@''HAVE_DECL_GETLINE''@|1|g' \
      -e 's|@''HAVE_DECL_OBSTACK_PRINTF''@|1|g' \
      -e 's|@''HAVE_DECL_SNPRINTF''@|1|g' \
      -e 's|@''HAVE_DECL_VSNPRINTF''@|1|g' \
      -e 's|@''HAVE_DPRINTF''@|1|g' \
      -e 's|@''HAVE_FSEEKO''@|1|g' \
      -e 's|@''HAVE_FTELLO''@|1|g' \
      -e 's|@''HAVE_PCLOSE''@|1|g' \
      -e 's|@''HAVE_POPEN''@|1|g' \
      -e 's|@''HAVE_RENAMEAT''@|1|g' \
      -e 's|@''HAVE_VASPRINTF''@|1|g' \
      -e 's|@''HAVE_VDPRINTF''@|1|g' \
      -e 's|@''REPLACE_DPRINTF''@|0|g' \
      -e 's|@''REPLACE_FCLOSE''@|1|g' \
      -e 's|@''REPLACE_FDOPEN''@|0|g' \
      -e 's|@''REPLACE_FFLUSH''@|1|g' \
      -e 's|@''REPLACE_FOPEN''@|0|g' \
      -e 's|@''REPLACE_FPRINTF''@|0|g' \
      -e 's|@''REPLACE_FPURGE''@|0|g' \
      -e 's|@''REPLACE_FREOPEN''@|0|g' \
      -e 's|@''REPLACE_FSEEK''@|1|g' \
      -e 's|@''REPLACE_FSEEKO''@|1|g' \
      -e 's|@''REPLACE_FTELL''@|0|g' \
      -e 's|@''REPLACE_FTELLO''@|0|g' \
      -e 's|@''REPLACE_GETDELIM''@|0|g' \
      -e 's|@''REPLACE_GETLINE''@|0|g' \
      -e 's|@''REPLACE_OBSTACK_PRINTF''@|0|g' \
      -e 's|@''REPLACE_PERROR''@|0|g' \
      -e 's|@''REPLACE_POPEN''@|0|g' \
      -e 's|@''REPLACE_PRINTF''@|0|g' \
      -e 's|@''REPLACE_REMOVE''@|0|g' \
      -e 's|@''REPLACE_RENAME''@|0|g' \
      -e 's|@''REPLACE_RENAMEAT''@|0|g' \
      -e 's|@''REPLACE_SNPRINTF''@|0|g' \
      -e 's|@''REPLACE_SPRINTF''@|0|g' \
      -e 's|@''REPLACE_STDIO_READ_FUNCS''@|0|g' \
      -e 's|@''REPLACE_STDIO_WRITE_FUNCS''@|0|g' \
      -e 's|@''REPLACE_TMPFILE''@|0|g' \
      -e 's|@''REPLACE_VASPRINTF''@|0|g' \
      -e 's|@''REPLACE_VDPRINTF''@|0|g' \
      -e 's|@''REPLACE_VFPRINTF''@|0|g' \
      -e 's|@''REPLACE_VPRINTF''@|0|g' \
      -e 's|@''REPLACE_VSNPRINTF''@|0|g' \
      -e 's|@''REPLACE_VSPRINTF''@|0|g' \
      -e 's|@''ASM_SYMBOL_PREFIX''@|""|g' \
      -e '/definitions of _GL_FUNCDECL_RPL/r ./c++defs.h' \
      -e '/definition of _GL_ARG_NONNULL/r ./arg-nonnull.h' \
      -e '/definition of _GL_WARN_ON_USE/r ./warn-on-use.h'; \
} > stdio.h-t && \
mv stdio.h-t stdio.h
echo "  CC      " freading.o;depbase=`echo freading.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT freading.o -MD -MP -MF $depbase.Tpo -c -o freading.o freading.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " getprogname.o;depbase=`echo getprogname.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT getprogname.o -MD -MP -MF $depbase.Tpo -c -o getprogname.o getprogname.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  GEN     " time.h;rm -f time.h-t time.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */' && \
  sed -e 's|@''GUARD_PREFIX''@|GL|g' \
      -e 's|@''INCLUDE_NEXT''@|include_next|g' \
      -e 's|@''PRAGMA_SYSTEM_HEADER''@|#pragma GCC system_header|g' \
      -e 's|@''PRAGMA_COLUMNS''@||g' \
      -e 's|@''NEXT_TIME_H''@|<time.h>|g' \
      -e 's/@''GNULIB_CTIME''@/0/g' \
      -e 's/@''GNULIB_LOCALTIME''@/0/g' \
      -e 's/@''GNULIB_MKTIME''@/0/g' \
      -e 's/@''GNULIB_NANOSLEEP''@/0/g' \
      -e 's/@''GNULIB_STRFTIME''@/0/g' \
      -e 's/@''GNULIB_STRPTIME''@/0/g' \
      -e 's/@''GNULIB_TIMEGM''@/0/g' \
      -e 's/@''GNULIB_TIME_R''@/0/g' \
      -e 's/@''GNULIB_TIME_RZ''@/0/g' \
      -e 's/@''GNULIB_TZSET''@/0/g' \
      -e 's|@''HAVE_DECL_LOCALTIME_R''@|1|g' \
      -e 's|@''HAVE_NANOSLEEP''@|1|g' \
      -e 's|@''HAVE_STRPTIME''@|1|g' \
      -e 's|@''HAVE_TIMEGM''@|1|g' \
      -e 's|@''HAVE_TIMEZONE_T''@|0|g' \
      -e 's|@''HAVE_TZSET''@|1|g' \
      -e 's|@''REPLACE_CTIME''@|GNULIB_PORTCHECK|g' \
      -e 's|@''REPLACE_GMTIME''@|0|g' \
      -e 's|@''REPLACE_LOCALTIME''@|0|g' \
      -e 's|@''REPLACE_LOCALTIME_R''@|GNULIB_PORTCHECK|g' \
      -e 's|@''REPLACE_MKTIME''@|GNULIB_PORTCHECK|g' \
      -e 's|@''REPLACE_NANOSLEEP''@|GNULIB_PORTCHECK|g' \
      -e 's|@''REPLACE_STRFTIME''@|GNULIB_PORTCHECK|g' \
      -e 's|@''REPLACE_TIMEGM''@|GNULIB_PORTCHECK|g' \
      -e 's|@''REPLACE_TZSET''@|GNULIB_PORTCHECK|g' \
      -e 's|@''PTHREAD_H_DEFINES_STRUCT_TIMESPEC''@|0|g' \
      -e 's|@''SYS_TIME_H_DEFINES_STRUCT_TIMESPEC''@|0|g' \
      -e 's|@''TIME_H_DEFINES_STRUCT_TIMESPEC''@|1|g' \
      -e 's|@''UNISTD_H_DEFINES_STRUCT_TIMESPEC''@|0|g' \
      -e '/definitions of _GL_FUNCDECL_RPL/r ./c++defs.h' \
      -e '/definition of _GL_ARG_NONNULL/r ./arg-nonnull.h' \
      -e '/definition of _GL_WARN_ON_USE/r ./warn-on-use.h' \
      < ./time.in.h; \
} > time.h-t && \
mv time.h-t time.h
/bin/mkdir -p sys
echo "  GEN     " sys/time.h;rm -f sys/time.h-t sys/time.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */'; \
  sed -e 's|@''GUARD_PREFIX''@|GL|g' \
      -e 's/@''HAVE_SYS_TIME_H''@/1/g' \
      -e 's|@''INCLUDE_NEXT''@|include_next|g' \
      -e 's|@''PRAGMA_SYSTEM_HEADER''@|#pragma GCC system_header|g' \
      -e 's|@''PRAGMA_COLUMNS''@||g' \
      -e 's|@''NEXT_SYS_TIME_H''@|<sys/time.h>|g' \
      -e 's/@''GNULIB_GETTIMEOFDAY''@/1/g' \
      -e 's|@''HAVE_WINSOCK2_H''@|0|g' \
      -e 's/@''HAVE_GETTIMEOFDAY''@/1/g' \
      -e 's/@''HAVE_STRUCT_TIMEVAL''@/1/g' \
      -e 's/@''REPLACE_GETTIMEOFDAY''@/0/g' \
      -e 's/@''REPLACE_STRUCT_TIMEVAL''@/0/g' \
      -e '/definitions of _GL_FUNCDECL_RPL/r ./c++defs.h' \
      -e '/definition of _GL_ARG_NONNULL/r ./arg-nonnull.h' \
      -e '/definition of _GL_WARN_ON_USE/r ./warn-on-use.h' \
      < ./sys_time.in.h; \
} > sys/time.h-t && \
mv sys/time.h-t sys/time.h
echo "  CC      " gettime.o;depbase=`echo gettime.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT gettime.o -MD -MP -MF $depbase.Tpo -c -o gettime.o gettime.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " glthread/lock.o;depbase=`echo glthread/lock.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT glthread/lock.o -MD -MP -MF $depbase.Tpo -c -o glthread/lock.o glthread/lock.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " malloca.o;depbase=`echo malloca.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT malloca.o -MD -MP -MF $depbase.Tpo -c -o malloca.o malloca.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  GEN     " math.h;rm -f math.h-t math.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */' && \
  sed -e 's|@''GUARD_PREFIX''@|GL|g' \
      -e 's|@''INCLUDE_NEXT_AS_FIRST_DIRECTIVE''@|include_next|g' \
      -e 's|@''PRAGMA_SYSTEM_HEADER''@|#pragma GCC system_header|g' \
      -e 's|@''PRAGMA_COLUMNS''@||g' \
      -e 's|@''NEXT_AS_FIRST_DIRECTIVE_MATH_H''@|<math.h>|g' \
      -e 's/@''GNULIB_ACOSF''@/0/g' \
      -e 's/@''GNULIB_ACOSL''@/0/g' \
      -e 's/@''GNULIB_ASINF''@/0/g' \
      -e 's/@''GNULIB_ASINL''@/0/g' \
      -e 's/@''GNULIB_ATANF''@/0/g' \
      -e 's/@''GNULIB_ATANL''@/0/g' \
      -e 's/@''GNULIB_ATAN2F''@/0/g' \
      -e 's/@''GNULIB_CBRT''@/0/g' \
      -e 's/@''GNULIB_CBRTF''@/0/g' \
      -e 's/@''GNULIB_CBRTL''@/0/g' \
      -e 's/@''GNULIB_CEIL''@/0/g' \
      -e 's/@''GNULIB_CEILF''@/0/g' \
      -e 's/@''GNULIB_CEILL''@/0/g' \
      -e 's/@''GNULIB_COPYSIGN''@/0/g' \
      -e 's/@''GNULIB_COPYSIGNF''@/0/g' \
      -e 's/@''GNULIB_COPYSIGNL''@/0/g' \
      -e 's/@''GNULIB_COSF''@/0/g' \
      -e 's/@''GNULIB_COSL''@/0/g' \
      -e 's/@''GNULIB_COSHF''@/0/g' \
      -e 's/@''GNULIB_EXPF''@/0/g' \
      -e 's/@''GNULIB_EXPL''@/0/g' \
      -e 's/@''GNULIB_EXP2''@/0/g' \
      -e 's/@''GNULIB_EXP2F''@/0/g' \
      -e 's/@''GNULIB_EXP2L''@/0/g' \
      -e 's/@''GNULIB_EXPM1''@/0/g' \
      -e 's/@''GNULIB_EXPM1F''@/0/g' \
      -e 's/@''GNULIB_EXPM1L''@/0/g' \
      -e 's/@''GNULIB_FABSF''@/0/g' \
      -e 's/@''GNULIB_FABSL''@/0/g' \
      -e 's/@''GNULIB_FLOOR''@/0/g' \
      -e 's/@''GNULIB_FLOORF''@/0/g' \
      -e 's/@''GNULIB_FLOORL''@/0/g' \
      -e 's/@''GNULIB_FMA''@/0/g' \
      -e 's/@''GNULIB_FMAF''@/0/g' \
      -e 's/@''GNULIB_FMAL''@/0/g' \
      -e 's/@''GNULIB_FMOD''@/0/g' \
      -e 's/@''GNULIB_FMODF''@/0/g' \
      -e 's/@''GNULIB_FMODL''@/0/g' \
      -e 's/@''GNULIB_FREXPF''@/0/g' \
      -e 's/@''GNULIB_FREXP''@/1/g' \
      -e 's/@''GNULIB_FREXPL''@/1/g' \
      -e 's/@''GNULIB_HYPOT''@/0/g' \
      -e 's/@''GNULIB_HYPOTF''@/0/g' \
      -e 's/@''GNULIB_HYPOTL''@/0/g' \
      < ./math.in.h | \
  sed -e 's/@''GNULIB_ILOGB''@/0/g' \
      -e 's/@''GNULIB_ILOGBF''@/0/g' \
      -e 's/@''GNULIB_ILOGBL''@/0/g' \
      -e 's/@''GNULIB_ISFINITE''@/0/g' \
      -e 's/@''GNULIB_ISINF''@/0/g' \
      -e 's/@''GNULIB_ISNAN''@/0/g' \
      -e 's/@''GNULIB_ISNANF''@/0/g' \
      -e 's/@''GNULIB_ISNAND''@/0/g' \
      -e 's/@''GNULIB_ISNANL''@/0/g' \
      -e 's/@''GNULIB_LDEXPF''@/0/g' \
      -e 's/@''GNULIB_LDEXPL''@/0/g' \
      -e 's/@''GNULIB_LOG''@/0/g' \
      -e 's/@''GNULIB_LOGF''@/0/g' \
      -e 's/@''GNULIB_LOGL''@/0/g' \
      -e 's/@''GNULIB_LOG10''@/0/g' \
      -e 's/@''GNULIB_LOG10F''@/0/g' \
      -e 's/@''GNULIB_LOG10L''@/0/g' \
      -e 's/@''GNULIB_LOG1P''@/0/g' \
      -e 's/@''GNULIB_LOG1PF''@/0/g' \
      -e 's/@''GNULIB_LOG1PL''@/0/g' \
      -e 's/@''GNULIB_LOG2''@/0/g' \
      -e 's/@''GNULIB_LOG2F''@/0/g' \
      -e 's/@''GNULIB_LOG2L''@/0/g' \
      -e 's/@''GNULIB_LOGB''@/0/g' \
      -e 's/@''GNULIB_LOGBF''@/0/g' \
      -e 's/@''GNULIB_LOGBL''@/0/g' \
      -e 's/@''GNULIB_MODF''@/0/g' \
      -e 's/@''GNULIB_MODFF''@/0/g' \
      -e 's/@''GNULIB_MODFL''@/0/g' \
      -e 's/@''GNULIB_POWF''@/0/g' \
      -e 's/@''GNULIB_REMAINDER''@/0/g' \
      -e 's/@''GNULIB_REMAINDERF''@/0/g' \
      -e 's/@''GNULIB_REMAINDERL''@/0/g' \
      -e 's/@''GNULIB_RINT''@/0/g' \
      -e 's/@''GNULIB_RINTF''@/0/g' \
      -e 's/@''GNULIB_RINTL''@/0/g' \
      -e 's/@''GNULIB_ROUND''@/0/g' \
      -e 's/@''GNULIB_ROUNDF''@/0/g' \
      -e 's/@''GNULIB_ROUNDL''@/0/g' \
      -e 's/@''GNULIB_SIGNBIT''@/1/g' \
      -e 's/@''GNULIB_SINF''@/0/g' \
      -e 's/@''GNULIB_SINL''@/0/g' \
      -e 's/@''GNULIB_SINHF''@/0/g' \
      -e 's/@''GNULIB_SQRTF''@/0/g' \
      -e 's/@''GNULIB_SQRTL''@/0/g' \
      -e 's/@''GNULIB_TANF''@/0/g' \
      -e 's/@''GNULIB_TANL''@/0/g' \
      -e 's/@''GNULIB_TANHF''@/0/g' \
      -e 's/@''GNULIB_TRUNC''@/0/g' \
      -e 's/@''GNULIB_TRUNCF''@/0/g' \
      -e 's/@''GNULIB_TRUNCL''@/0/g' \
  | \
  sed -e 's|@''HAVE_ACOSF''@|1|g' \
      -e 's|@''HAVE_ACOSL''@|1|g' \
      -e 's|@''HAVE_ASINF''@|1|g' \
      -e 's|@''HAVE_ASINL''@|1|g' \
      -e 's|@''HAVE_ATANF''@|1|g' \
      -e 's|@''HAVE_ATANL''@|1|g' \
      -e 's|@''HAVE_ATAN2F''@|1|g' \
      -e 's|@''HAVE_CBRT''@|1|g' \
      -e 's|@''HAVE_CBRTF''@|1|g' \
      -e 's|@''HAVE_CBRTL''@|1|g' \
      -e 's|@''HAVE_COPYSIGN''@|1|g' \
      -e 's|@''HAVE_COPYSIGNL''@|1|g' \
      -e 's|@''HAVE_COSF''@|1|g' \
      -e 's|@''HAVE_COSL''@|1|g' \
      -e 's|@''HAVE_COSHF''@|1|g' \
      -e 's|@''HAVE_EXPF''@|1|g' \
      -e 's|@''HAVE_EXPL''@|1|g' \
      -e 's|@''HAVE_EXPM1''@|1|g' \
      -e 's|@''HAVE_EXPM1F''@|1|g' \
      -e 's|@''HAVE_FABSF''@|1|g' \
      -e 's|@''HAVE_FABSL''@|1|g' \
      -e 's|@''HAVE_FMA''@|1|g' \
      -e 's|@''HAVE_FMAF''@|1|g' \
      -e 's|@''HAVE_FMAL''@|1|g' \
      -e 's|@''HAVE_FMODF''@|1|g' \
      -e 's|@''HAVE_FMODL''@|1|g' \
      -e 's|@''HAVE_FREXPF''@|1|g' \
      -e 's|@''HAVE_HYPOTF''@|1|g' \
      -e 's|@''HAVE_HYPOTL''@|1|g' \
      -e 's|@''HAVE_ILOGB''@|1|g' \
      -e 's|@''HAVE_ILOGBF''@|1|g' \
      -e 's|@''HAVE_ILOGBL''@|1|g' \
      -e 's|@''HAVE_ISNANF''@|1|g' \
      -e 's|@''HAVE_ISNAND''@|1|g' \
      -e 's|@''HAVE_ISNANL''@|1|g' \
      -e 's|@''HAVE_LDEXPF''@|1|g' \
      -e 's|@''HAVE_LOGF''@|1|g' \
      -e 's|@''HAVE_LOGL''@|1|g' \
      -e 's|@''HAVE_LOG10F''@|1|g' \
      -e 's|@''HAVE_LOG10L''@|1|g' \
      -e 's|@''HAVE_LOG1P''@|1|g' \
      -e 's|@''HAVE_LOG1PF''@|1|g' \
      -e 's|@''HAVE_LOG1PL''@|1|g' \
      -e 's|@''HAVE_LOGBF''@|1|g' \
      -e 's|@''HAVE_LOGBL''@|1|g' \
      -e 's|@''HAVE_MODFF''@|1|g' \
      -e 's|@''HAVE_MODFL''@|1|g' \
      -e 's|@''HAVE_POWF''@|1|g' \
      -e 's|@''HAVE_REMAINDER''@|1|g' \
      -e 's|@''HAVE_REMAINDERF''@|1|g' \
      -e 's|@''HAVE_RINT''@|1|g' \
      -e 's|@''HAVE_RINTL''@|1|g' \
      -e 's|@''HAVE_SINF''@|1|g' \
      -e 's|@''HAVE_SINL''@|1|g' \
      -e 's|@''HAVE_SINHF''@|1|g' \
      -e 's|@''HAVE_SQRTF''@|1|g' \
      -e 's|@''HAVE_SQRTL''@|1|g' \
      -e 's|@''HAVE_TANF''@|1|g' \
      -e 's|@''HAVE_TANL''@|1|g' \
      -e 's|@''HAVE_TANHF''@|1|g' \
      -e 's|@''HAVE_DECL_ACOSL''@|1|g' \
      -e 's|@''HAVE_DECL_ASINL''@|1|g' \
      -e 's|@''HAVE_DECL_ATANL''@|1|g' \
      -e 's|@''HAVE_DECL_CBRTF''@|1|g' \
      -e 's|@''HAVE_DECL_CBRTL''@|1|g' \
      -e 's|@''HAVE_DECL_CEILF''@|1|g' \
      -e 's|@''HAVE_DECL_CEILL''@|1|g' \
      -e 's|@''HAVE_DECL_COPYSIGNF''@|1|g' \
      -e 's|@''HAVE_DECL_COSL''@|1|g' \
      -e 's|@''HAVE_DECL_EXPL''@|1|g' \
      -e 's|@''HAVE_DECL_EXP2''@|1|g' \
      -e 's|@''HAVE_DECL_EXP2F''@|1|g' \
      -e 's|@''HAVE_DECL_EXP2L''@|1|g' \
      -e 's|@''HAVE_DECL_EXPM1L''@|1|g' \
      -e 's|@''HAVE_DECL_FLOORF''@|1|g' \
      -e 's|@''HAVE_DECL_FLOORL''@|1|g' \
      -e 's|@''HAVE_DECL_FREXPL''@|1|g' \
      -e 's|@''HAVE_DECL_LDEXPL''@|1|g' \
      -e 's|@''HAVE_DECL_LOGL''@|1|g' \
      -e 's|@''HAVE_DECL_LOG10L''@|1|g' \
      -e 's|@''HAVE_DECL_LOG2''@|1|g' \
      -e 's|@''HAVE_DECL_LOG2F''@|1|g' \
      -e 's|@''HAVE_DECL_LOG2L''@|1|g' \
      -e 's|@''HAVE_DECL_LOGB''@|1|g' \
      -e 's|@''HAVE_DECL_REMAINDER''@|1|g' \
      -e 's|@''HAVE_DECL_REMAINDERL''@|1|g' \
      -e 's|@''HAVE_DECL_RINTF''@|1|g' \
      -e 's|@''HAVE_DECL_ROUND''@|1|g' \
      -e 's|@''HAVE_DECL_ROUNDF''@|1|g' \
      -e 's|@''HAVE_DECL_ROUNDL''@|1|g' \
      -e 's|@''HAVE_DECL_SINL''@|1|g' \
      -e 's|@''HAVE_DECL_SQRTL''@|1|g' \
      -e 's|@''HAVE_DECL_TANL''@|1|g' \
      -e 's|@''HAVE_DECL_TRUNC''@|1|g' \
      -e 's|@''HAVE_DECL_TRUNCF''@|1|g' \
      -e 's|@''HAVE_DECL_TRUNCL''@|1|g' \
  | \
  sed -e 's|@''REPLACE_ACOSF''@|0|g' \
      -e 's|@''REPLACE_ASINF''@|0|g' \
      -e 's|@''REPLACE_ATANF''@|0|g' \
      -e 's|@''REPLACE_ATAN2F''@|0|g' \
      -e 's|@''REPLACE_CBRTF''@|0|g' \
      -e 's|@''REPLACE_CBRTL''@|0|g' \
      -e 's|@''REPLACE_CEIL''@|0|g' \
      -e 's|@''REPLACE_CEILF''@|0|g' \
      -e 's|@''REPLACE_CEILL''@|0|g' \
      -e 's|@''REPLACE_COSF''@|0|g' \
      -e 's|@''REPLACE_COSHF''@|0|g' \
      -e 's|@''REPLACE_EXPF''@|0|g' \
      -e 's|@''REPLACE_EXPM1''@|0|g' \
      -e 's|@''REPLACE_EXPM1F''@|0|g' \
      -e 's|@''REPLACE_EXP2''@|0|g' \
      -e 's|@''REPLACE_EXP2L''@|0|g' \
      -e 's|@''REPLACE_FABSL''@|0|g' \
      -e 's|@''REPLACE_FLOOR''@|0|g' \
      -e 's|@''REPLACE_FLOORF''@|0|g' \
      -e 's|@''REPLACE_FLOORL''@|0|g' \
      -e 's|@''REPLACE_FMA''@|0|g' \
      -e 's|@''REPLACE_FMAF''@|0|g' \
      -e 's|@''REPLACE_FMAL''@|0|g' \
      -e 's|@''REPLACE_FMOD''@|0|g' \
      -e 's|@''REPLACE_FMODF''@|0|g' \
      -e 's|@''REPLACE_FMODL''@|0|g' \
      -e 's|@''REPLACE_FREXPF''@|0|g' \
      -e 's|@''REPLACE_FREXP''@|0|g' \
      -e 's|@''REPLACE_FREXPL''@|0|g' \
      -e 's|@''REPLACE_HUGE_VAL''@|0|g' \
      -e 's|@''REPLACE_HYPOT''@|0|g' \
      -e 's|@''REPLACE_HYPOTF''@|0|g' \
      -e 's|@''REPLACE_HYPOTL''@|0|g' \
      -e 's|@''REPLACE_ILOGB''@|0|g' \
      -e 's|@''REPLACE_ILOGBF''@|0|g' \
      -e 's|@''REPLACE_ILOGBL''@|0|g' \
      -e 's|@''REPLACE_ISFINITE''@|0|g' \
      -e 's|@''REPLACE_ISINF''@|0|g' \
      -e 's|@''REPLACE_ISNAN''@|0|g' \
      -e 's|@''REPLACE_ITOLD''@|0|g' \
      -e 's|@''REPLACE_LDEXPL''@|0|g' \
      -e 's|@''REPLACE_LOG''@|0|g' \
      -e 's|@''REPLACE_LOGF''@|0|g' \
      -e 's|@''REPLACE_LOGL''@|0|g' \
      -e 's|@''REPLACE_LOG10''@|0|g' \
      -e 's|@''REPLACE_LOG10F''@|0|g' \
      -e 's|@''REPLACE_LOG10L''@|0|g' \
      -e 's|@''REPLACE_LOG1P''@|0|g' \
      -e 's|@''REPLACE_LOG1PF''@|0|g' \
      -e 's|@''REPLACE_LOG1PL''@|0|g' \
      -e 's|@''REPLACE_LOG2''@|0|g' \
      -e 's|@''REPLACE_LOG2F''@|0|g' \
      -e 's|@''REPLACE_LOG2L''@|0|g' \
      -e 's|@''REPLACE_LOGB''@|0|g' \
      -e 's|@''REPLACE_LOGBF''@|0|g' \
      -e 's|@''REPLACE_LOGBL''@|0|g' \
      -e 's|@''REPLACE_MODF''@|0|g' \
      -e 's|@''REPLACE_MODFF''@|0|g' \
      -e 's|@''REPLACE_MODFL''@|0|g' \
      -e 's|@''REPLACE_NAN''@|0|g' \
      -e 's|@''REPLACE_REMAINDER''@|0|g' \
      -e 's|@''REPLACE_REMAINDERF''@|0|g' \
      -e 's|@''REPLACE_REMAINDERL''@|0|g' \
      -e 's|@''REPLACE_ROUND''@|0|g' \
      -e 's|@''REPLACE_ROUNDF''@|0|g' \
      -e 's|@''REPLACE_ROUNDL''@|0|g' \
      -e 's|@''REPLACE_SIGNBIT''@|0|g' \
      -e 's|@''REPLACE_SIGNBIT_USING_GCC''@|1|g' \
      -e 's|@''REPLACE_SINF''@|0|g' \
      -e 's|@''REPLACE_SINHF''@|0|g' \
      -e 's|@''REPLACE_SQRTF''@|0|g' \
      -e 's|@''REPLACE_SQRTL''@|0|g' \
      -e 's|@''REPLACE_TANF''@|0|g' \
      -e 's|@''REPLACE_TANHF''@|0|g' \
      -e 's|@''REPLACE_TRUNC''@|0|g' \
      -e 's|@''REPLACE_TRUNCF''@|0|g' \
      -e 's|@''REPLACE_TRUNCL''@|0|g' \
      -e '/definitions of _GL_FUNCDECL_RPL/r ./c++defs.h' \
      -e '/definition of _GL_ARG_NONNULL/r ./arg-nonnull.h' \
      -e '/definition of _GL_WARN_ON_USE/r ./warn-on-use.h'; \
} > math.h-t && \
mv math.h-t math.h
echo "  CC      " math.o;depbase=`echo math.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT math.o -MD -MP -MF $depbase.Tpo -c -o math.o math.c &&\
mv -f $depbase.Tpo $depbase.Po
/bin/mkdir -p sys
echo "  GEN     " sys/stat.h;rm -f sys/stat.h-t sys/stat.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */'; \
  sed -e 's|@''GUARD_PREFIX''@|GL|g' \
      -e 's|@''INCLUDE_NEXT''@|include_next|g' \
      -e 's|@''PRAGMA_SYSTEM_HEADER''@|#pragma GCC system_header|g' \
      -e 's|@''PRAGMA_COLUMNS''@||g' \
      -e 's|@''NEXT_SYS_STAT_H''@|<sys/stat.h>|g' \
      -e 's|@''WINDOWS_64_BIT_ST_SIZE''@|0|g' \
      -e 's|@''WINDOWS_STAT_TIMESPEC''@|0|g' \
      -e 's/@''GNULIB_FCHMODAT''@/0/g' \
      -e 's/@''GNULIB_FSTAT''@/1/g' \
      -e 's/@''GNULIB_FSTATAT''@/1/g' \
      -e 's/@''GNULIB_FUTIMENS''@/0/g' \
      -e 's/@''GNULIB_LCHMOD''@/0/g' \
      -e 's/@''GNULIB_LSTAT''@/1/g' \
      -e 's/@''GNULIB_MKDIRAT''@/0/g' \
      -e 's/@''GNULIB_MKFIFO''@/0/g' \
      -e 's/@''GNULIB_MKFIFOAT''@/0/g' \
      -e 's/@''GNULIB_MKNOD''@/0/g' \
      -e 's/@''GNULIB_MKNODAT''@/0/g' \
      -e 's/@''GNULIB_STAT''@/1/g' \
      -e 's/@''GNULIB_UTIMENSAT''@/0/g' \
      -e 's/@''GNULIB_OVERRIDES_STRUCT_STAT''@/0/g' \
      -e 's|@''HAVE_FCHMODAT''@|1|g' \
      -e 's|@''HAVE_FSTATAT''@|1|g' \
      -e 's|@''HAVE_FUTIMENS''@|1|g' \
      -e 's|@''HAVE_LCHMOD''@|1|g' \
      -e 's|@''HAVE_LSTAT''@|1|g' \
      -e 's|@''HAVE_MKDIRAT''@|1|g' \
      -e 's|@''HAVE_MKFIFO''@|1|g' \
      -e 's|@''HAVE_MKFIFOAT''@|1|g' \
      -e 's|@''HAVE_MKNOD''@|1|g' \
      -e 's|@''HAVE_MKNODAT''@|1|g' \
      -e 's|@''HAVE_UTIMENSAT''@|1|g' \
      -e 's|@''REPLACE_FSTAT''@|0|g' \
      -e 's|@''REPLACE_FSTATAT''@|0|g' \
      -e 's|@''REPLACE_FUTIMENS''@|0|g' \
      -e 's|@''REPLACE_LSTAT''@|0|g' \
      -e 's|@''REPLACE_MKDIR''@|0|g' \
      -e 's|@''REPLACE_MKFIFO''@|0|g' \
      -e 's|@''REPLACE_MKNOD''@|0|g' \
      -e 's|@''REPLACE_STAT''@|0|g' \
      -e 's|@''REPLACE_UTIMENSAT''@|0|g' \
      -e '/definitions of _GL_FUNCDECL_RPL/r ./c++defs.h' \
      -e '/definition of _GL_ARG_NONNULL/r ./arg-nonnull.h' \
      -e '/definition of _GL_WARN_ON_USE/r ./warn-on-use.h' \
      < ./sys_stat.in.h; \
} > sys/stat.h-t && \
mv sys/stat.h-t sys/stat.h
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
echo "  GEN     " limits.h;rm -f limits.h-t limits.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */' && \
  sed -e 's|@''GUARD_PREFIX''@|GL|g' \
      -e 's|@''INCLUDE_NEXT''@|include_next|g' \
      -e 's|@''PRAGMA_SYSTEM_HEADER''@|#pragma GCC system_header|g' \
      -e 's|@''PRAGMA_COLUMNS''@||g' \
      -e 's|@''NEXT_LIMITS_H''@|<limits.h>|g' \
      < ./limits.in.h; \
} > limits.h-t && \
mv limits.h-t limits.h
echo "  CC      " save-cwd.o;depbase=`echo save-cwd.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT save-cwd.o -MD -MP -MF $depbase.Tpo -c -o save-cwd.o save-cwd.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " savedir.o;depbase=`echo savedir.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT savedir.o -MD -MP -MF $depbase.Tpo -c -o savedir.o savedir.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  GEN     " signal.h;rm -f signal.h-t signal.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */' && \
  sed -e 's|@''GUARD_PREFIX''@|GL|g' \
      -e 's|@''INCLUDE_NEXT''@|include_next|g' \
      -e 's|@''PRAGMA_SYSTEM_HEADER''@|#pragma GCC system_header|g' \
      -e 's|@''PRAGMA_COLUMNS''@||g' \
      -e 's|@''NEXT_SIGNAL_H''@|<signal.h>|g' \
      -e 's/@''GNULIB_PTHREAD_SIGMASK''@/0/g' \
      -e 's/@''GNULIB_RAISE''@/1/g' \
      -e 's/@''GNULIB_SIGNAL_H_SIGPIPE''@/0/g' \
      -e 's/@''GNULIB_SIGPROCMASK''@/1/g' \
      -e 's/@''GNULIB_SIGACTION''@/1/g' \
      -e 's|@''HAVE_POSIX_SIGNALBLOCKING''@|1|g' \
      -e 's|@''HAVE_PTHREAD_SIGMASK''@|1|g' \
      -e 's|@''HAVE_RAISE''@|1|g' \
      -e 's|@''HAVE_SIGSET_T''@|1|g' \
      -e 's|@''HAVE_SIGINFO_T''@|1|g' \
      -e 's|@''HAVE_SIGACTION''@|1|g' \
      -e 's|@''HAVE_STRUCT_SIGACTION_SA_SIGACTION''@|1|g' \
      -e 's|@''HAVE_TYPE_VOLATILE_SIG_ATOMIC_T''@|1|g' \
      -e 's|@''HAVE_SIGHANDLER_T''@|1|g' \
      -e 's|@''REPLACE_PTHREAD_SIGMASK''@|0|g' \
      -e 's|@''REPLACE_RAISE''@|0|g' \
      -e '/definitions of _GL_FUNCDECL_RPL/r ./c++defs.h' \
      -e '/definition of _GL_ARG_NONNULL/r ./arg-nonnull.h' \
      -e '/definition of _GL_WARN_ON_USE/r ./warn-on-use.h' \
      < ./signal.in.h; \
} > signal.h-t && \
mv signal.h-t signal.h
echo "  CC      " sig-handler.o;depbase=`echo sig-handler.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT sig-handler.o -MD -MP -MF $depbase.Tpo -c -o sig-handler.o sig-handler.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " stat-time.o;depbase=`echo stat-time.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT stat-time.o -MD -MP -MF $depbase.Tpo -c -o stat-time.o stat-time.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " statat.o;depbase=`echo statat.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT statat.o -MD -MP -MF $depbase.Tpo -c -o statat.o statat.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " glthread/threadlib.o;depbase=`echo glthread/threadlib.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I.      -g -O2 -MT glthread/threadlib.o -MD -MP -MF $depbase.Tpo -c -o glthread/threadlib.o glthread/threadlib.c &&\
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
echo "  GEN     " wchar.h;rm -f wchar.h-t wchar.h && \
{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */'; \
  sed -e 's|@''GUARD_PREFIX''@|GL|g' \
      -e 's|@''INCLUDE_NEXT''@|include_next|g' \
      -e 's|@''PRAGMA_SYSTEM_HEADER''@|#pragma GCC system_header|g' \
      -e 's|@''PRAGMA_COLUMNS''@||g' \
      -e 's|@''HAVE_FEATURES_H''@|1|g' \
      -e 's|@''NEXT_WCHAR_H''@|<wchar.h>|g' \
      -e 's|@''HAVE_WCHAR_H''@|1|g' \
      -e 's/@''HAVE_CRTDEFS_H''@/0/g' \
      -e 's/@''GNULIB_OVERRIDES_WINT_T''@/0/g' \
      -e 's/@''GNULIB_BTOWC''@/0/g' \
      -e 's/@''GNULIB_WCTOB''@/0/g' \
      -e 's/@''GNULIB_MBSINIT''@/0/g' \
      -e 's/@''GNULIB_MBRTOWC''@/0/g' \
      -e 's/@''GNULIB_MBRLEN''@/0/g' \
      -e 's/@''GNULIB_MBSRTOWCS''@/0/g' \
      -e 's/@''GNULIB_MBSNRTOWCS''@/0/g' \
      -e 's/@''GNULIB_WCRTOMB''@/0/g' \
      -e 's/@''GNULIB_WCSRTOMBS''@/0/g' \
      -e 's/@''GNULIB_WCSNRTOMBS''@/0/g' \
      -e 's/@''GNULIB_WCWIDTH''@/0/g' \
      -e 's/@''GNULIB_WMEMCHR''@/0/g' \
      -e 's/@''GNULIB_WMEMCMP''@/0/g' \
      -e 's/@''GNULIB_WMEMCPY''@/0/g' \
      -e 's/@''GNULIB_WMEMMOVE''@/0/g' \
      -e 's/@''GNULIB_WMEMSET''@/0/g' \
      -e 's/@''GNULIB_WCSLEN''@/0/g' \
      -e 's/@''GNULIB_WCSNLEN''@/0/g' \
      -e 's/@''GNULIB_WCSCPY''@/0/g' \
      -e 's/@''GNULIB_WCPCPY''@/0/g' \
      -e 's/@''GNULIB_WCSNCPY''@/0/g' \
      -e 's/@''GNULIB_WCPNCPY''@/0/g' \
      -e 's/@''GNULIB_WCSCAT''@/0/g' \
      -e 's/@''GNULIB_WCSNCAT''@/0/g' \
      -e 's/@''GNULIB_WCSCMP''@/0/g' \
      -e 's/@''GNULIB_WCSNCMP''@/0/g' \
      -e 's/@''GNULIB_WCSCASECMP''@/0/g' \
      -e 's/@''GNULIB_WCSNCASECMP''@/0/g' \
      -e 's/@''GNULIB_WCSCOLL''@/0/g' \
      -e 's/@''GNULIB_WCSXFRM''@/0/g' \
      -e 's/@''GNULIB_WCSDUP''@/0/g' \
      -e 's/@''GNULIB_WCSCHR''@/0/g' \
      -e 's/@''GNULIB_WCSRCHR''@/0/g' \
      -e 's/@''GNULIB_WCSCSPN''@/0/g' \
      -e 's/@''GNULIB_WCSSPN''@/0/g' \
      -e 's/@''GNULIB_WCSPBRK''@/0/g' \
      -e 's/@''GNULIB_WCSSTR''@/0/g' \
      -e 's/@''GNULIB_WCSTOK''@/0/g' \
      -e 's/@''GNULIB_WCSWIDTH''@/0/g' \
      -e 's/@''GNULIB_WCSFTIME''@/0/g' \
      < ./wchar.in.h | \
  sed -e 's|@''HAVE_WINT_T''@|1|g' \
      -e 's|@''HAVE_BTOWC''@|1|g' \
      -e 's|@''HAVE_MBSINIT''@|1|g' \
      -e 's|@''HAVE_MBRTOWC''@|1|g' \
      -e 's|@''HAVE_MBRLEN''@|1|g' \
      -e 's|@''HAVE_MBSRTOWCS''@|1|g' \
      -e 's|@''HAVE_MBSNRTOWCS''@|1|g' \
      -e 's|@''HAVE_WCRTOMB''@|1|g' \
      -e 's|@''HAVE_WCSRTOMBS''@|1|g' \
      -e 's|@''HAVE_WCSNRTOMBS''@|1|g' \
      -e 's|@''HAVE_WMEMCHR''@|1|g' \
      -e 's|@''HAVE_WMEMCMP''@|1|g' \
      -e 's|@''HAVE_WMEMCPY''@|1|g' \
      -e 's|@''HAVE_WMEMMOVE''@|1|g' \
      -e 's|@''HAVE_WMEMSET''@|1|g' \
      -e 's|@''HAVE_WCSLEN''@|1|g' \
      -e 's|@''HAVE_WCSNLEN''@|1|g' \
      -e 's|@''HAVE_WCSCPY''@|1|g' \
      -e 's|@''HAVE_WCPCPY''@|1|g' \
      -e 's|@''HAVE_WCSNCPY''@|1|g' \
      -e 's|@''HAVE_WCPNCPY''@|1|g' \
      -e 's|@''HAVE_WCSCAT''@|1|g' \
      -e 's|@''HAVE_WCSNCAT''@|1|g' \
      -e 's|@''HAVE_WCSCMP''@|1|g' \
      -e 's|@''HAVE_WCSNCMP''@|1|g' \
      -e 's|@''HAVE_WCSCASECMP''@|1|g' \
      -e 's|@''HAVE_WCSNCASECMP''@|1|g' \
      -e 's|@''HAVE_WCSCOLL''@|1|g' \
      -e 's|@''HAVE_WCSXFRM''@|1|g' \
      -e 's|@''HAVE_WCSDUP''@|1|g' \
      -e 's|@''HAVE_WCSCHR''@|1|g' \
      -e 's|@''HAVE_WCSRCHR''@|1|g' \
      -e 's|@''HAVE_WCSCSPN''@|1|g' \
      -e 's|@''HAVE_WCSSPN''@|1|g' \
      -e 's|@''HAVE_WCSPBRK''@|1|g' \
      -e 's|@''HAVE_WCSSTR''@|1|g' \
      -e 's|@''HAVE_WCSTOK''@|1|g' \
      -e 's|@''HAVE_WCSWIDTH''@|1|g' \
      -e 's|@''HAVE_WCSFTIME''@|1|g' \
      -e 's|@''HAVE_DECL_WCTOB''@|1|g' \
      -e 's|@''HAVE_DECL_WCWIDTH''@|1|g' \
  | \
  sed -e 's|@''REPLACE_MBSTATE_T''@|0|g' \
      -e 's|@''REPLACE_BTOWC''@|0|g' \
      -e 's|@''REPLACE_WCTOB''@|0|g' \
      -e 's|@''REPLACE_MBSINIT''@|0|g' \
      -e 's|@''REPLACE_MBRTOWC''@|0|g' \
      -e 's|@''REPLACE_MBRLEN''@|0|g' \
      -e 's|@''REPLACE_MBSRTOWCS''@|0|g' \
      -e 's|@''REPLACE_MBSNRTOWCS''@|0|g' \
      -e 's|@''REPLACE_WCRTOMB''@|0|g' \
      -e 's|@''REPLACE_WCSRTOMBS''@|0|g' \
      -e 's|@''REPLACE_WCSNRTOMBS''@|0|g' \
      -e 's|@''REPLACE_WCWIDTH''@|0|g' \
      -e 's|@''REPLACE_WCSWIDTH''@|0|g' \
      -e 's|@''REPLACE_WCSFTIME''@|0|g' \
      -e '/definitions of _GL_FUNCDECL_RPL/r ./c++defs.h' \
      -e '/definition of _GL_ARG_NONNULL/r ./arg-nonnull.h' \
      -e '/definition of _GL_WARN_ON_USE/r ./warn-on-use.h'; \
} > wchar.h-t && \
mv wchar.h-t wchar.h
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
(dir=.; test -f ./gzip.texi || dir=.; \
set `/bin/bash ../build-aux/mdate-sh $dir/gzip.texi`; \
echo "@set UPDATED $1 $2 $3"; \
echo "@set UPDATED-MONTH $2 $3"; \
echo "@set EDITION 1.10"; \
echo "@set VERSION 1.10") > vti.tmp$$ && \
(cmp -s vti.tmp$$ ./version.texi \
  || (echo "Updating ./version.texi" && \
      cp vti.tmp$$ ./version.texi.tmp$$ && \
      mv ./version.texi.tmp$$ ./version.texi)) && \
rm -f vti.tmp$$ ./version.texi.$$
cp ./version.texi stamp-vti
make[2]: Leaving directory '/home/kmr/Documents/ninjaInputFiles/gzip-1.10-clang-yojson/doc'
Making all in .
make[2]: Entering directory '/home/kmr/Documents/ninjaInputFiles/gzip-1.10-clang-yojson'
echo "  CC      " bits.o;depbase=`echo bits.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I. -I./lib  -I./lib    -g -O2 -MT bits.o -MD -MP -MF $depbase.Tpo -c -o bits.o bits.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " deflate.o;depbase=`echo deflate.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I. -I./lib  -I./lib    -g -O2 -MT deflate.o -MD -MP -MF $depbase.Tpo -c -o deflate.o deflate.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  GEN     " version.h;rm -f version.h
printf 'extern char const *Version;\n' > version.ht
chmod a-w version.ht
mv version.ht version.h
echo "  CC      " gzip.o;depbase=`echo gzip.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I. -I./lib  -I./lib    -g -O2 -MT gzip.o -MD -MP -MF $depbase.Tpo -c -o gzip.o gzip.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " inflate.o;depbase=`echo inflate.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I. -I./lib  -I./lib    -g -O2 -MT inflate.o -MD -MP -MF $depbase.Tpo -c -o inflate.o inflate.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " lzw.o;depbase=`echo lzw.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I. -I./lib  -I./lib    -g -O2 -MT lzw.o -MD -MP -MF $depbase.Tpo -c -o lzw.o lzw.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " trees.o;depbase=`echo trees.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I. -I./lib  -I./lib    -g -O2 -MT trees.o -MD -MP -MF $depbase.Tpo -c -o trees.o trees.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " unlzh.o;depbase=`echo unlzh.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I. -I./lib  -I./lib    -g -O2 -MT unlzh.o -MD -MP -MF $depbase.Tpo -c -o unlzh.o unlzh.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " unlzw.o;depbase=`echo unlzw.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I. -I./lib  -I./lib    -g -O2 -MT unlzw.o -MD -MP -MF $depbase.Tpo -c -o unlzw.o unlzw.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " unpack.o;depbase=`echo unpack.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I. -I./lib  -I./lib    -g -O2 -MT unpack.o -MD -MP -MF $depbase.Tpo -c -o unpack.o unpack.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " unzip.o;depbase=`echo unzip.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I. -I./lib  -I./lib    -g -O2 -MT unzip.o -MD -MP -MF $depbase.Tpo -c -o unzip.o unzip.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " util.o;depbase=`echo util.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I. -I./lib  -I./lib    -g -O2 -MT util.o -MD -MP -MF $depbase.Tpo -c -o util.o util.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  CC      " zip.o;depbase=`echo zip.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I. -I./lib  -I./lib    -g -O2 -MT zip.o -MD -MP -MF $depbase.Tpo -c -o zip.o zip.c &&\
mv -f $depbase.Tpo $depbase.Po
echo "  GEN     " version.c;rm -f version.c
printf '#include <config.h>\n' > version.ct
printf 'char const *Version = "1.10";\n' >> version.ct
chmod a-w version.ct
mv version.ct version.c
echo "  CC      " version.o;depbase=`echo version.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
clang -DHAVE_CONFIG_H -I. -I./lib  -I./lib    -g -O2 -MT version.o -MD -MP -MF $depbase.Tpo -c -o version.o version.c &&\
mv -f $depbase.Tpo $depbase.Po
rm -f libver.a
echo "  AR      " libver.a;ar cr libver.a version.o 
ranlib libver.a
make[2]: Leaving directory '/home/kmr/Documents/ninjaInputFiles/gzip-1.10-clang-yojson'
make[1]: Leaving directory '/home/kmr/Documents/ninjaInputFiles/gzip-1.10-clang-yojson'
