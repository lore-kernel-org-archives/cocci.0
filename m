From: fabf@skynet.be (Fabian Frederick)
Date: Thu,  9 Apr 2015 22:58:04 +0200
Subject: [Cocci] [PATCH V2 linux-next] scripts/coccinelle/misc/bugon.cocci:
	update bug_on conversion warning
Message-ID: <1428613084-2861-1-git-send-email-fabf@skynet.be>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

if()/BUG conversion to BUG_ON must be avoided when there's side effect
in condition. The reason being BUG_ON won't execute the condition when CONFIG_BUG
is not defined.

Inspired-by: J. Bruce Fields <bfields@fieldses.org>
Suggested-by: Julia Lawall <Julia.Lawall@lip6.fr>
Acked-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
V2: s/condition/the condition/

 scripts/coccinelle/misc/bugon.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/misc/bugon.cocci b/scripts/coccinelle/misc/bugon.cocci
index 3b7eec2..27c97f1 100644
--- a/scripts/coccinelle/misc/bugon.cocci
+++ b/scripts/coccinelle/misc/bugon.cocci
@@ -57,6 +57,6 @@ coccilib.org.print_todo(p[0], "WARNING use BUG_ON")
 p << r.p;
 @@
 
-msg="WARNING: Use BUG_ON"
+msg="WARNING: Use BUG_ON instead of if condition followed by BUG.\nPlease make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)"
 coccilib.report.print_report(p[0], msg)
 
-- 
1.9.1
