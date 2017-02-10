From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 10 Feb 2017 13:50:26 +0100
Subject: [Cocci] Replacing combination of kcalloc() and copy_from_user() by
 memdup_user() with SmPL?
Message-ID: <d5f46773-2137-d1d7-97d0-fb97721d4982@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I came along another function implementation where I got the impression that
the function ?memdup_user? could also be used there in a way which is similar
to an existing source code transformation approach by a small script for
the semantic patch language.

SmPL script:
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/scripts/coccinelle/api/memdup_user.cocci?id=632571b1bee00494aef749512d9f3290dfba0ead#n1

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
                || ...) {
-   code = -ENOMEM;
-   goto label;
-}
-code = copy_from_user(to, from, (size) * (count));
-if (code) {
    ...
    log(...,
-       code
+       PTR_ERR(to)
        , ...);
    code = -ENOMEM;
    goto label;
 }


Source file:
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/drivers/infiniband/hw/hfi1/user_sdma.c?id=632571b1bee00494aef749512d9f3290dfba0ead#n718

int hfi1_user_sdma_process_request(struct file *fp, struct iovec *iovec,
				   unsigned long dim, unsigned long *count)
{
	/*
	 * ...
	 */
	if (req_opcode(req->info.ctrl) == EXPECTED) {
		u16 ntids = iovec[idx].iov_len / sizeof(*req->tids);

		if (!ntids || ntids > MAX_TID_PAIR_ENTRIES) {
			ret = -EINVAL;
			goto free_req;
		}
		req->tids = kcalloc(ntids, sizeof(*req->tids), GFP_KERNEL);
		if (!req->tids) {
			ret = -ENOMEM;
			goto free_req;
		}
		/*
		 * ...
		 */
		ret = copy_from_user(req->tids, iovec[idx].iov_base,
				     ntids * sizeof(*req->tids));
		if (ret) {
			SDMA_DBG(req, "Failed to copy %d TIDs (%d)",
				 ntids, ret);
			ret = -EFAULT;
			goto free_req;
		}
		req->n_tids = ntids;
		idx++;
	}
	/*
	 * ...
	 */
	return 0;
free_req:
	user_sdma_free_request(req, true);
	if (req_queued)
		pq_update(pq);
	set_comp_state(pq, cq, info.comp_idx, ERROR, req->status);
	return ret;
}


elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt replace_kcalloc_by_memdup_user-draft1.cocci ../Probe/user_sdma-excerpt1.c
?
refactoring: position variables or mixed modifs interfere with comm_assoc iso
bool (bool !to
  >>> IS_ERR(to)
 || ...)
?


The software combination ?Coccinelle 1.0.6-00093-ge1776d7b (OCaml 4.03.0)?
does not like this change attempt so far.
Which details should I reconsider next?

Regards,
Markus
