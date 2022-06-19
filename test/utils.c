#ifndef test_utils
#define test_utils

#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>

#define clean_errno() (errno == 0 ? "None" : strerror(errno))
#define log_error(M, ...) fprintf(stderr, "\x1b[31m\n[FAIL] (%s:%d: errno: %s) " M "\n\033[0m", __FILE__, __LINE__, clean_errno(), ##__VA_ARGS__)
#define suite(M) printf("\x1b[1mSuite: %s\033[0m\n", M)
#define context(M) printf("  \x1b[3m%s\033[0m\n", M)
#define assertf(A, M, ...)                       \
  if (!(A))                                      \
  {                                              \
    log_error(M, ##__VA_ARGS__);                 \
    assert(A);                                   \
  }                                              \
  else                                           \
  {                                              \
    printf("    \x1b[32m[ OK ] %s\033[0m\n", M); \
  }
#define xassertf(A, M, ...) printf("    \x1b[36m[SKIP] %s\033[0m\n", M)

#endif