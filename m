From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 15 Feb 2017 12:49:06 +0100
Subject: [Cocci] Replacing combination of kcalloc() and copy_from_user()
 by memdup_user() with SmPL?
In-Reply-To: <d5f46773-2137-d1d7-97d0-fb97721d4982@users.sourceforge.net>
References: <d5f46773-2137-d1d7-97d0-fb97721d4982@users.sourceforge.net>
Message-ID: <32e33451-c8ba-1a01-bc41-a6b8c6fc78bb@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt replace_kcalloc_by_memdup_user-draft1.cocci ../Probe/user_sdma-excerpt1.c
> ?
> refactoring: position variables or mixed modifs interfere with comm_assoc iso
> bool (bool !to
>   >>> IS_ERR(to)
>  || ...)
> ?

Would you like to explain this message a bit more while the following SmPL approach seems to work
as expected?

@refactoring@
expression code, count, from, to, size;
identifier label, log;
@@
 to =
-     kcalloc(count, size, GFP_KERNEL)
+     memdup_user(from, size * count)
 ;
 if (
-    !to
+    IS_ERR(to)
    ) {
-   code = -ENOMEM;
-   goto label;
-}
-code = copy_from_user(to, from, (size) * (count));
-if (code) {
    ...
+   code = PTR_ERR(to);
    log(..., code, ...);
-   code = -EFAULT;
    goto label;
 }


elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt replace_kcalloc_by_memdup_user-draft2.cocci ../Probe/user_sdma-excerpt1.c
init_defs_builtins: /usr/local/lib64/coccinelle/standard.h
HANDLING: ../Probe/user_sdma-excerpt1.c
diff = 
--- ../Probe/user_sdma-excerpt1.c
+++ /tmp/cocci-output-8749-f5da06-user_sdma-excerpt1.c
@@ -11,20 +11,12 @@ int hfi1_user_sdma_process_request(struc
 			ret = -EINVAL;
 			goto free_req;
 		}
-		req->tids = kcalloc(ntids, sizeof(*req->tids), GFP_KERNEL);
-		if (!req->tids) {
-			ret = -ENOMEM;
-			goto free_req;
-		}
-		/*
-		 * ...
-		 */
-		ret = copy_from_user(req->tids, iovec[idx].iov_base,
-				     ntids * sizeof(*req->tids));
-		if (ret) {
+		req->tids = memdup_user(iovec[idx].iov_base,
+					sizeof(*req->tids) * ntids);
+		if (IS_ERR(req->tids)) {
+			ret = PTR_ERR(req->tids);
 			SDMA_DBG(req, "Failed to copy %d TIDs (%d)",
 				 ntids, ret);
-			ret = -EFAULT;
 			goto free_req;
 		}
 		req->n_tids = ntids;


Regards,
Markus
