From: wpengfeinudt@gmail.com (Pengfei Wang)
Date: Mon, 2 Jan 2017 23:45:57 +0800
Subject: [Cocci] [PATCH] coccicheck: add a test for repeat copy_from_user
In-Reply-To: <alpine.DEB.2.20.1612271916250.2001@hadrien>
References: <20160426222442.GA8104@www.outflux.net>
 <alpine.DEB.2.20.1612271916250.2001@hadrien>
Message-ID: <CACxtibQLHAd8X3og686DqTWYW-P8rOHpDS=QOg-tChP6hK+_bA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

Thank you for paying attention to this problem as I reported earlier as a
double-fetch bug. My research topic is the detection of the double-fetch
bugs, and I once conducted my work on the basis of the Coccinelle engine.
We totally found 6 previously unknown double-fetch bugs by our approach,
five from Linux kernel-4.5 and one from Android kernel-6.0.1.

We made the Coccinelle script of our approach publicly available (
https://github.com/wpengfei/double_fetch_cocci.git), hoping it can be
useful for the kernel security check. We took into consideration of many
double-fetch cases according to the investigation of the kernel source
code. Even though it is not 100% accurate yet, it can narrow down the scope
from around 40 thousand kernel source files to only 53 candidate files,
which include five true cases for kernel-4.5. We hope our work could
provide some practical help on avoiding the double-fetch bugs.

Please feel free to contact me if you?re interested or would like to give
us any feedback. Thank you!


Kind regards

Pengfei Wang


 ? 2016?12?28????2:21?Julia Lawall <julia.lawall@lip6.fr> ???

I totally dropped the ball on this.  Many thanks to Vaishali for
resurrecting it.

Some changes are suggested below.

On Tue, 26 Apr 2016, Kees Cook wrote:

This is usually a sign of a resized request. This adds a check for
potential races or confusions. The check isn't 100% accurate, so it
needs some manual review.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
scripts/coccinelle/tests/reusercopy.cocci | 36
+++++++++++++++++++++++++++++++
1 file changed, 36 insertions(+)
create mode 100644 scripts/coccinelle/tests/reusercopy.cocci

diff --git a/scripts/coccinelle/tests/reusercopy.cocci
b/scripts/coccinelle/tests/reusercopy.cocci
new file mode 100644
index 000000000000..53645de8ae95
--- /dev/null
+++ b/scripts/coccinelle/tests/reusercopy.cocci
@@ -0,0 +1,36 @@
+/// Recopying from the same user buffer frequently indicates a pattern of
+/// Reading a size header, allocating, and then re-reading an entire
+/// structure. If the structure's size is not re-validated, this can lead
+/// to structure or data size confusions.
+///
+// Confidence: Moderate
+// Copyright: (C) 2016 Kees Cook, Google. License: GPLv2.
+// URL: http://coccinelle.lip6.fr/
+// Comments:
+// Options: -no_includes -include_headers


The options could be: --no-include --include-headers

Actually, Coccinelle supports both, but it only officially supports the
-- versions.

+
+virtual report
+virtual org


Add, the following for the *s:

virtual context

Then add the following rule:

@ok@
position p;
expression src,dest;
@@

copy_from_user at p(&dest, src, sizeof(dest))

+
+ at cfu_twice@
+position p;


Change this to:

position p != ok.p;

+identifier src;
+expression dest1, dest2, size1, size2, offset;
+@@
+
+*copy_from_user(dest1, src, size1)
+ ... when != src = offset
+     when != src += offset


Add the following lines:

    when != if (size2 > e1 || ...) { ... return ...; }
    when != if (size2 > e1 || ...) { ... size2 = e2 ... }

These changes drop cases where the last argument to copy_from_usr is the
size of the first argument, which seems safe enough, and where there is a
test on the size value that can either update it or abort the function.
These changes only eliminate false positives, as far as I could tell.

If it would be more convenient, I could just send the complete revised
patch, or whatever seems convenient.

thanks,
julia

+*copy_from_user at p(dest2, src, size2)
+
+ at script:python depends on org@
+p << cfu_twice.p;
+@@
+
+cocci.print_main("potentially dangerous second copy_from_user()",p)
+
+@script:python depends on report@
+p << cfu_twice.p;
+@@
+
+coccilib.report.print_report(p[0],"potentially dangerous second
copy_from_user()")
--
2.6.3


--
Kees Cook
Chrome OS & Brillo Security
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20170102/7bf49a2b/attachment-0001.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: cocci.zip
Type: application/zip
Size: 86659 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20170102/7bf49a2b/attachment-0001.zip>
