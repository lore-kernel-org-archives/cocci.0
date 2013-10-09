From: volanschi@metaware.fr (Nic Volanschi (R&D))
Date: Wed, 09 Oct 2013 11:45:37 +0200
Subject: [Cocci] problem with a (contorted) macro
Message-ID: <1381311937.3213.23.camel@zamolxis.metaware.tm.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I've got a problem in a program using a (well, contorted) macro, whose
real definition is passed via the "--macro-file macros.h" option:

--- macros.h:
#define TEST(X, Y) \
 if((X) >= (Y))

#define TRNIV1 TEST(NIVTRCUSR, NIVTRC1)
--- EOF macros.h

I have a whole lot of uses of this macro and it does work fine in most
programs, it's just that in the following program it prevents some rule
applications:

--- test.c:
#include <stdio.h>
#define NIVTRCUSR 0
extern short lectObjCU();
short calculeEPC() {
  short      sRet = 0;
  short sNBPT   = 0;
  double dMtEnjEngChTmp = 0;

  sRet = lectObjCU();
  if (sRet != 0) {
    printf("GENFMG61: Erreur lectObjCU \n");
  }

  for(sNBPT = 1; sNBPT < 11; sNBPT++) {
    TRNIV1
      printf("dMtEnjEngChTmp: %lf\n", dMtEnjEngChTmp);
  }
  return sRet;
}
--- EOF test.c

The rules I'm trying to apply are:

--- test.cocci:
@@ statement s1; @@
 if(...)
+{mwtrace();/*ifth*/
  s1
+}

@@ statement s1, s2; @@
 if(...)
+{mwtrace();/*ifelth*/
  s1
+}
 else
+{mwtrace();/*ifelel*/
  s2
+}

@@ statement s1, s2; @@
 if(...) s1 else s2
+mwtrace();/*endifel*/

@@ statement s1; @@
 for(...;...;...) 
+{mwtrace();/*for*/
  s1
+}

@@ statement s1; @@
 for(...;...;...) s1
+mwtrace();/*endfor*/

@@ type T; identifier f; @@
 T f(...) {
+mwtrace();/*fun*/
  ...
 }
--- EOF test.cocci

The command I use is:
spatch --macro-file macros.h --ibm -c test.cocci
--allow-inconsistent-paths --out-place test.c

As a result, the rules adding /*fun*/, /*for*/ and /*endfor*/ are not
applied (and replacing the option --macro-file by --macro-file-builtins
changes nothing).
I think this is really a combination of factors, because:
- when I take out the if, or move it after the for, it works
- when I comment out the "TRNIV1", it works

So is it possible to fix or turn around this problem?
Cheers,
Nic.
