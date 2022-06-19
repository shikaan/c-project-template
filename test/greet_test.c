#include "utils.c"

void greet_test()
{
  suite("greet.c");
  context("with test example");
  assertf(1 == 1, "states the obvious");
}