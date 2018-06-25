From: michelemartone@users.sourceforge.net (Michele Martone)
Date: Mon, 25 Jun 2018 17:44:02 +0200
Subject: [Cocci] coccinelle computes patch very slowly
Message-ID: <20180625154402.GC7044@localhost>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dear Coccinelle Team,

While patching source files of a few thousand lines long, I 
noticed prohibitively long patch compute times (seemed hanged).

This effectively prevented spatch from being usable.

I attach a minimalistic program and patch replicating the problem.

It seems like presence of uninitialized variables  and/or
a loops body might slow down spatch computation extremely.

I will be grateful of any support!
Michele
-------------- next part --------------
/*
// A semantic patch introducing casting on function return:
@@
type T;
identifier I;
symbol f;
@@

T I;
...

-I = 
+I = (T) 
 f(...);
*/
// Unfortunately, the above semantic patch takes 44s to run `spatch --sp-file <patch above> <snippet below>` !
// By using initializing declarators, or deleting the loop, it takes a fraction of a second.
// Tested with a coccinelle version 04d390a4414e626a0ca83f65f1ec08390c378cd1 (Sat May 26 07:43:36 2018 +0200).
// spatch version 1.0.6-00440-ga4532f08 compiled with OCaml version 4.08.0+dev0-2018-04-09
void * f(){return 0;}
void g(void)
{
  int v1=0, v2=0;
  int *a1, *a2;
  int presence, of, these, slows, down, patch, computing, extremely, y1, y2, y3, y4, y5;//each new uninitialized variable can cost seconds!
  //int presence=0, of=0, these=0, slows=0, down=0, patch=0, computing=0, extremely=0, y1=0, y2=0, y3=0, y4=0, y5=0;//inizialized ones are fine
  //undefined_t status;// presence of this (if uncommented) slows down a lot
  a1 = f();
  for(v1 = 0; v1 < v2; v1++) { } // presence of this loop here, too! delete it to have a huge speedup ?!
  a2 = f();
}
