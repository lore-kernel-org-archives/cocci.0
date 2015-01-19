From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Mon, 19 Jan 2015 13:40:02 +0100
Subject: [Cocci] [PATCH] Coccinelle: catch useless conditions comparing two
	identical constants
Message-ID: <1421671202-9452-1-git-send-email-der.herr@hofr.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

catch useless conditionals like (1 == 1) or (1 != 0) - it seems like some
code generators like this "style"

Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---

After stumbling across this code in drivers/media/dvb-frontends/dib7000p.c

<snip>
        value = 0;
        if (1 != 0)
                value |= (1 << 6);
        if (ch->hierarchy == 1)
                value |= (1 << 4);
        if (1 == 1)                                                                                                                                  
                value |= 1;
        switch ((ch->hierarchy == 0 || 1 == 1) ? ch->code_rate_HP :
ch->code_rate_LP) {
        case FEC_2_3:
<snip>

It might be good to have a test for such conditions. If they can 
not be avoided they at least need to be commented as intentional

This semantic patch only provides report mode as it is not generally
possible to deduce a sound fix for such code.

Tested with spatch version 1.0.0-rc23 on linux-3.19.0-rc4 which 
resulted in 12 findings in 6 files - none of which were false
positives.

 scripts/coccinelle/tests/uselesscondition.cocci |   39 +++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 scripts/coccinelle/tests/uselesscondition.cocci

diff --git a/scripts/coccinelle/tests/uselesscondition.cocci b/scripts/coccinelle/tests/uselesscondition.cocci
new file mode 100644
index 0000000..50cff3a
--- /dev/null
+++ b/scripts/coccinelle/tests/uselesscondition.cocci
@@ -0,0 +1,39 @@
+// Find conditions comparing two identical constants
+// e.g 1 == 1 or 1 != 0
+//
+// Some of these code sequences are due to code generators.
+// Never the less they should be flagged and if not removed
+// atleast commented.
+virtual context
+virtual org
+virtual report
+
+ at condeq@
+constant C;
+position p;
+@@
+
+<+...
+(
+* C at p == C
+|
+* C at p != C
+|
+* C at p <= C
+|
+* C@p < C
+)
+...+>
+
+ at script:python depends on org@
+p << condeq.p;
+@@
+
+cocci.print_main("bad/useless conditional",p)
+
+@script:python depends on report@
+p << condeq.p;
+@@
+
+msg = "bad/useless conditional line %s" % (p[0].line)
+coccilib.report.print_report(p[0],msg)
-- 
1.7.10.4
