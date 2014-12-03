From: francois.berenger@inria.fr (Francois Berenger)
Date: Wed, 03 Dec 2014 18:29:54 +0100
Subject: [Cocci] What is the spatch file for this change and the
 corresponding spatch command line invocation
Message-ID: <547F4892.6080405@inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I give up trying to write the spatch myself:

Before file:
---
int i;

for ( ; ; ++i ) {
   if (1) {
     continue;
   }
}
---

After file:
---
int i;

for ( ; ; ) {
   if (1) {
     ++i;
     continue;
   }
   ++i;
}
---

All my trials don't work, not any change in the file appears
if I try --in-place and -o fails because
"-o can not be applied because there are no modified files"

Thanks a lot,
Francois.
