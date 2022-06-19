#include <stdlib.h>
#include <stdio.h>

#include "../lib/str.h"

void greet(char *name)
{
  str s = str_null;
  str_join(&s, str_lit("Hello "), str_lit(name));

  puts(s);
  str_free(s);
}