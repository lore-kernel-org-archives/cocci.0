From: dhiru.kholia@gmail.com (Dhiru Kholia)
Date: Fri, 2 Sep 2016 12:42:54 +0530
Subject: [Cocci] Detecting undefined behavior with Coccinelle
Message-ID: <CANO7a6yAgHjcJc2R2fNyn8Pgto=qs-5+kUTZ2Etan0ODhqLSrQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

When the following program is compiled with GCC 6 compiler running on
Fedora 24 with "-O2" flag, the overflow check (rowstride / channels !=
width) gets eliminated presumably due to undefined behavior.

// gcc -c -O2 too-much-optimization.c
//
// objdump -d too-much-optimization.o

#include <stdio.h>
#include <stdlib.h>

void *gdk_pixbuf_new_reduced(int has_alpha, int width, int height)
{
  void *buf = NULL;
  int channels;
  int rowstride;

  if (width < 0)
    return NULL;
  if (height < 0)
    return 0;

  channels = has_alpha ? 4 : 3;
  rowstride = width * channels;
  if (rowstride / channels != width) /* overflow check */
    return NULL;

  buf = calloc(height, rowstride);
  if (!buf)
    return NULL;

  return buf;
}

This code is present in the gdk-pixbuf software package. The
elimination of this overflow check leads to memory corruption problems
later on in the gdk-pixbuf library.

Is it possible to detect such code patterns (multiplication operation
followed by division to check for overflow) which invoke undefined
behavior using Coccinelle?

I have not written Coccinelle scripts before. Any help would be great.

Thanks,
Dhiru
