Return-Path: <SRS0=hgwh=XT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35786C432C1
	for <cocci@archiver.kernel.org>; Tue, 24 Sep 2019 20:21:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D0120872
	for <cocci@archiver.kernel.org>; Tue, 24 Sep 2019 20:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D0120872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8OKLPug022019;
	Tue, 24 Sep 2019 22:21:25 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1214377AB;
	Tue, 24 Sep 2019 22:21:25 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C8EE6779E
 for <cocci@systeme.lip6.fr>; Tue, 24 Sep 2019 22:21:23 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8OKLNRL024770
 for <cocci@systeme.lip6.fr>; Tue, 24 Sep 2019 22:21:23 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.64,545,1559512800"; d="scan'208";a="403232588"
Received: from ip-215.net-89-2-7.rev.numericable.fr (HELO hadrien)
 ([89.2.7.215])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Sep 2019 22:21:22 +0200
Date: Tue, 24 Sep 2019 22:21:22 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e3e922ef-fab2-ee5c-57f1-0f36ccc682fd@web.de>
Message-ID: <alpine.DEB.2.21.1909242219450.2589@hadrien>
References: <e07ce253-8a13-0f90-3ee0-79c1a0e78b38@web.de>
 <alpine.DEB.2.21.1909231058380.2283@hadrien>
 <e3e922ef-fab2-ee5c-57f1-0f36ccc682fd@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1546414866-1569356483=:2589"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 24 Sep 2019 22:21:25 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Tue, 24 Sep 2019 22:21:23 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Reducing source code around return statements with SmPL?
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1546414866-1569356483=:2589
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 24 Sep 2019, Markus Elfring wrote:

> >> @@
> >> -rc = x;
> >
> > Replace by - lrc@rc = x;
>
> I have constructed further test scripts for the semantic patch language.
>
> @display1@
> expression x;
> identifier rc;
> local idexpression lrc;
> @@
> (
>  if (...)
> *{
> *lrc@rc = x;
> *return lrc;
> *}
> |
> *lrc@rc = x;
> *return lrc;
> )
>
> @display2@
> identifier display1.rc;
> type t;
> @@
> *t rc;
>  ... when != rc
>
>
> The following test result is generated so far for an example.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/kernel/ptrace.c?id=08f103b9a9502974109fab47ea35ca8542c4e57a
>
> elfring@Sonne:~/Projekte/Linux/next-patched> spatch ~/Projekte/Coccinelle/janitor/show_code_for_moving_to_return1.cocci arch/arm64/kernel/ptrace.c
> …
>      (ONCE) already tagged but only removed, so safe
> …
> @@ -290,7 +290,6 @@ static struct perf_event *ptrace_hbp_cre
>  {
>  	struct perf_event *bp;
>  	struct perf_event_attr attr;
> -	int err, type;
>
>  	switch (note_type) {
>  	case NT_ARM_HW_BREAK:
> @@ -329,7 +328,6 @@ static int ptrace_hbp_fill_attr_ctrl(uns
>  				     struct arch_hw_breakpoint_ctrl ctrl,
>  				     struct perf_event_attr *attr)
>  {
> -	int err, len, type, offset, disabled = !ctrl.enabled;
>
>  	attr->disabled = disabled;
>  	if (disabled)
> @@ -434,10 +432,6 @@ static int ptrace_hbp_set_ctrl(unsigned
>  	struct arch_hw_breakpoint_ctrl ctrl;
>
>  	bp = ptrace_hbp_get_initialised_bp(note_type, tsk, idx);
> -	if (IS_ERR(bp)) {
> -		err = PTR_ERR(bp);
> -		return err;
> -	}
>
>  	attr = bp->attr;
>  	decode_ctrl_reg(uctrl, &ctrl);
> @@ -458,15 +452,9 @@ static int ptrace_hbp_set_addr(unsigned
>  	struct perf_event_attr attr;
>
>  	bp = ptrace_hbp_get_initialised_bp(note_type, tsk, idx);
> -	if (IS_ERR(bp)) {
> -		err = PTR_ERR(bp);
> -		return err;
> -	}
>
>  	attr = bp->attr;
>  	attr.bp_addr = addr;
> -	err = modify_user_hw_breakpoint(bp, &attr);
> -	return err;
>  }
>
>  #define PTRACE_HBP_ADDR_SZ	sizeof(u64)
>
>
>
> I suggest to compare this output with the following source code transformation approach.
>
> @replacement@
> expression x;
> identifier rc;
> local idexpression lrc;
> @@
> -lrc@rc = x;
>  return
> -       rc
> +       x
>  ;
>
> @deletion@
> identifier replacement.rc;
> type t;
> @@
> -t rc;
>  ... when != rc
>
>
> elfring@Sonne:~/Projekte/Linux/next-patched> spatch ~/Projekte/Coccinelle/janitor/simplify_return2.cocci arch/arm64/kernel/ptrace.c
> …
> @@ -435,8 +435,7 @@ static int ptrace_hbp_set_ctrl(unsigned
>
>  	bp = ptrace_hbp_get_initialised_bp(note_type, tsk, idx);
>  	if (IS_ERR(bp)) {
> -		err = PTR_ERR(bp);
> -		return err;
> +		return PTR_ERR(bp);
>  	}
>
>  	attr = bp->attr;
> @@ -453,20 +452,17 @@ static int ptrace_hbp_set_addr(unsigned
>  			       unsigned long idx,
>  			       u64 addr)
>  {
> -	int err;
>  	struct perf_event *bp;
>  	struct perf_event_attr attr;
>
>  	bp = ptrace_hbp_get_initialised_bp(note_type, tsk, idx);
>  	if (IS_ERR(bp)) {
> -		err = PTR_ERR(bp);
> -		return err;
> +		return PTR_ERR(bp);
>  	}
>
>  	attr = bp->attr;
>  	attr.bp_addr = addr;
> -	err = modify_user_hw_breakpoint(bp, &attr);
> -	return err;
> +	return modify_user_hw_breakpoint(bp, &attr);
>  }
>
>  #define PTRACE_HBP_ADDR_SZ	sizeof(u64)
>
>
> * Why are the functions “ptrace_hbp_create” and “ptrace_hbp_fill_attr_ctrl”
>   presented here?

What does "here" mean.  You give two semantic patches with two sets of
output.  Which is here?

> * Why is the first variable declaration from the function “ptrace_hbp_set_addr”
>   not marked by the SmPL asterisk functionality in this test example?

I don't know what you ae referring to so I can't answer precisely, but you
should know that the only connection between your first two rules with a *
is the name of an identifier.  There is no guarantee that the two rules
match code in the same function.

julia
--8323329-1546414866-1569356483=:2589
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1546414866-1569356483=:2589--
