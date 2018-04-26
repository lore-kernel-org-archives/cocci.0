From: michelemartone@users.sourceforge.net (Michele Martone)
Date: Thu, 26 Apr 2018 10:12:09 +0200
Subject: [Cocci] [cocci-bug] coccinelle 1.0.6: OpenMP #pragma directive
 leads to function ignore
Message-ID: <20180426081209.GA7703@localhost>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dear Prof. Lawall and Coccinelle team,

I'm an enthusiastical, however still beginner use of Coccinelle.

While running spatch 1.0.6 on a long OpenMP-enabled listing, I
noticed that the presence of the C line:
 #pragma omp parallel for reduction(+:I) private(I)
seems to prevent restructuring of the function containing it.
If I simplify the pragma to something like
 #pragma omp parallel
the problem disappears.

Is there anything I can do to restructure large codes containing
many of such similar lines ?

In the attachment you find a test case and the output I experience.

Best regards,
Michele
-------------- next part --------------
+ spatch --version
spatch version 1.0.6 compiled with OCaml version 4.05.0
Flags passed to the configure script: --host=i586-suse-linux-gnu --build=i586-suse-linux-gnu --program-prefix= --disable-dependency-tracking --prefix=/usr --exec-prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc --datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib --libexecdir=/usr/lib --localstatedir=/var --sharedstatedir=/var/lib --mandir=/usr/share/man --infodir=/usr/share/info --disable-dependency-tracking
Python scripting support: yes
Syntax of regular expresssions: PCRE
+ sed -i 's/^...pragma/#pragma  /g' pragma_ignored.c
+ cat pragma_ignored.c
void good(void)
{
 A[I]; /* not ignored */
}
void bad(void)
{
 A[I]; /* if pragma uncommented ignored by spatch 1.0.6  */
#pragma   omp parallel for reduction(+:I) private(I)
}
+ spatch --sp-file pragma_ignored.cocci pragma_ignored.c
init_defs_builtins: /usr/lib/coccinelle/standard.h
HANDLING: pragma_ignored.c
diff = 
--- pragma_ignored.c
+++ /tmp/di36pef/cocci-output-200330-4f22e8-pragma_ignored.c
@@ -1,6 +1,6 @@
 void good(void)
 {
- A[I]; /* not ignored */
+ A[J]; /* not ignored */
 }
 void bad(void)
 {
+ sed -i 's/^.pragma  /\/\/#pragma/g' pragma_ignored.c
+ cat pragma_ignored.c
void good(void)
{
 A[I]; /* not ignored */
}
void bad(void)
{
 A[I]; /* if pragma uncommented ignored by spatch 1.0.6  */
//#pragma omp parallel for reduction(+:I) private(I)
}
+ spatch --sp-file pragma_ignored.cocci pragma_ignored.c
init_defs_builtins: /usr/lib/coccinelle/standard.h
HANDLING: pragma_ignored.c
diff = 
--- pragma_ignored.c
+++ /tmp/di36pef/cocci-output-200335-2965e3-pragma_ignored.c
@@ -1,9 +1,9 @@
 void good(void)
 {
- A[I]; /* not ignored */
+ A[J]; /* not ignored */
 }
 void bad(void)
 {
- A[I]; /* if pragma uncommented ignored by spatch 1.0.6  */
+ A[J]; /* if pragma uncommented ignored by spatch 1.0.6  */
 //#pragma omp parallel for reduction(+:I) private(I)
 }
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pragma_ignored.sh
Type: application/x-sh
Size: 345 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20180426/bb9498f0/attachment.sh>
-------------- next part --------------
void good(void)
{
 A[I]; /* not ignored */
}
void bad(void)
{
 A[I]; /* if pragma uncommented ignored by spatch 1.0.6  */
//#pragma omp parallel for reduction(+:I) private(I)
}
-------------- next part --------------
// pragma_ignored.cocci
// 
// $ spatch --version
// spatch version 1.0.6 compiled with OCaml version 4.05.0
// Flags passed to the configure script: --host=i586-suse-linux-gnu --build=i586-suse-linux-gnu --program-prefix= --disable-dependency-tracking --prefix=/usr --exec-prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc --datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib --libexecdir=/usr/lib --localstatedir=/var --sharedstatedir=/var/lib --mandir=/usr/share/man --infodir=/usr/share/info --disable-dependency-tracking
// Python scripting support: yes
// Syntax of regular expresssions: PCRE
// 
// 
// $ spatch --sp-file pragma_ignored.cocci  pragma_i
// 
// @@ -1,9 +1,9 @@
//  void good(void)
//  {
// - A[I]; /* not ignored */
// + A[J]; /* not ignored */
//  }
//  void bad(void)
//  {
// - A[I]; /* if pragma uncommented ignored by spatch 1.0.6  */
// + A[J]; /* if pragma uncommented ignored by spatch 1.0.6  */
//  //#pragma omp parallel for reduction(+:I) private(I)
//  }
// 
@@
symbol A,I,J;
@@

-A[I]
+A[J]
