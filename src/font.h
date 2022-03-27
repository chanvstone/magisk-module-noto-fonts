#ifndef _FONT_H_
#define _FONT_H_ 1

#include <stdio.h>

void robotoSansSerif(FILE *target);
void robotoSansSerifCondensed(FILE *target);
void notoSansSerif(FILE *target);
void notoSansSerifCondensed(FILE *target);
void notoSerif(FILE *target);
void notoSerifCondensed(FILE *target);
void notoSansMonospace(FILE *target);
void notoSansCjkJa(FILE *target);
void notoSansCjkKo(FILE *target);
void notoSansCjkSc(FILE *target);
void notoSansCjkTc(FILE *target);
void mod(FILE *dest,FILE *src);

#endif //_FONT_H_
