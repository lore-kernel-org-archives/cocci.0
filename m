From: himanshujha199640@gmail.com (Himanshu Jha)
Date: Sun, 14 Jan 2018 01:56:58 +0530
Subject: [Cocci] [PATCH v2] Coccinelle: kzalloc-simple: Rename
	kzalloc-simple to zalloc-simple
Message-ID: <1515875218-9707-1-git-send-email-himanshujha199640@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Rename kzalloc-simple to zalloc-simple since now the rule is not
specific to kzalloc function only, but also to many other zero memory
allocating functions specified in the rule.

Suggested-by: SF Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
     v2:
	-generated the patch using -M flag for renaming.
	-Since Markus earlier worked on renaming this patch adding his name too
 .../coccinelle/api/alloc/{kzalloc-simple.cocci => zalloc-simple.cocci}    | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename scripts/coccinelle/api/alloc/{kzalloc-simple.cocci => zalloc-simple.cocci} (100%)

diff --git a/scripts/coccinelle/api/alloc/kzalloc-simple.cocci b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
similarity index 100%
rename from scripts/coccinelle/api/alloc/kzalloc-simple.cocci
rename to scripts/coccinelle/api/alloc/zalloc-simple.cocci
-- 
2.7.4
