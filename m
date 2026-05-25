Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAEECD5BCF
	for <cocci@archiver.kernel.org>; Mon, 25 May 2026 08:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=w48BIIBDDT/mXNPawOL9Emo56IfNbTwmRbdNO1n+X7k=;
  b=eJLARapo8E9BvnyqNW0YDg36MH44VAKMWvx5C+dKI5+5k87nlx2Z1AWm
   vu5shohuy2AuAM2+JjoCVBvRR54hl/DrYA/9w4AkmM5D4c+ZJ+TqXWHT7
   lDKeD0aSQ1TZFoiJ9Ul97/2iFW0HgCgPLYmgUmzS/kUMRCKWO1O5aSQ1+
   I=;
X-CSE-ConnectionGUID: ZPh7ovnMTReKGOOnlAdhwg==
X-CSE-MsgGUID: uBlrszStRq6RZmz1/neMvg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.24,167,1774306800"; 
   d="scan'208";a="278067230"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 May 2026 10:54:56 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 51DA580E64; Mon, 25 May 2026 10:54:56 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 479288014B
	for <cocci@sympa.inria.fr>; Mon, 25 May 2026 10:54:51 +0200 (CEST)
X-CSE-ConnectionGUID: jmHWjus9SUyMoN4UVwnnPA==
X-CSE-MsgGUID: mq5XbG3rQvuCj1n7T4t5IQ==
X-IronPort-AV: E=Sophos;i="6.24,167,1774306800"; 
   d="scan'208";a="278067219"
Received: from unknown (HELO hadrien.home) ([88.188.149.159])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 10:54:51 +0200
Date: Mon, 25 May 2026 10:54:47 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, vulab@iscas.ac.cn
In-Reply-To: <0d2d8fa3-ff1c-4c49-aecc-f599a9193ccf@web.de>
Message-ID: <c68ba8b0-9be8-2531-8473-b88030aba527@inria.fr>
References: <47a6aeca-6c58-4be6-9a4e-a1d6726b5a0a@web.de> <8397220-4b66-acd4-32e2-cfa72ee7ac66@inria.fr> <25fb88dd-4573-4897-98ae-f5904a2324cd@web.de> <85a837b7-8a6-5fb8-eeb-1e70c5f77b2e@inria.fr> <1da11354-3d73-4158-aa0b-98a143471a3b@web.de>
 <dac0391-4aa-f02-f8fc-2168c118e3ef@inria.fr> <dd4fa876-fe40-43ec-8184-05da70579973@web.de> <7cd8b09f-eb9a-c4f7-81a-6a2968c1c02@inria.fr> <c9941a16-38e8-ccb5-c07c-54ac1718a398@inria.fr> <f68596ce-db2c-40a7-9e79-e9448ad460e5@web.de> <84111447-1b1b-98e4-afb2-fae89bc79d5b@inria.fr>
 <eb4b825e-b849-40fd-ab79-dce3852ccfce@web.de> <4222b953-360-6e52-9952-14b4ce9e613@inria.fr> <4d68182d-dd59-46b2-9254-30c8a16cfc0b@web.de> <8ca35446-f68b-4664-dddf-b6de2b2c811@inria.fr> <0e6c3048-5bd7-411e-9151-1280050293de@web.de> <d06c1fd-8672-7d2d-6841-1954904ca4bc@inria.fr>
 <0d2d8fa3-ff1c-4c49-aecc-f599a9193ccf@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1076314585-1779699291=:33802"
Subject: Re: [cocci] Checking evaluation of another SmPL script
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3515
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/vl2WJRhSzgSy-FdE1YdtvA>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1076314585-1779699291=:33802
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 25 May 2026, Markus Elfring wrote:

> >> We are trying to clarify different expectations for SmPL data processing
> >> with goto statements.
> > Please actually clarify your expectations. …
> Would you find the following test result “reasonable”?
>
> https://elixir.bootlin.com/linux/v7.1-rc4/source/fs/nfs/pnfs.c#L2128-L2385
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch --show-ctl-text --no-gotos …/Projekte/Coccinelle/janitor/show_UAF_1.cocci fs/nfs/pnfs.c
> …
> @display@
> identifier i;
> expression e;
> @@
>
> *pnfs_put_layout_hdr*(*i*)*;
> ...   WHEN != i = e
>
> *trace_pnfs_update_layout*(*...*, *i*, *...*)
>
>
> CTL =
>
> (!EX(EX(EX(Exit))) &,
>  (Ex_ i .
>   ((Ex _v . pnfs_put_layout_hdr(i);) &,
>    EX(E[(!After &
>          (!(pnfs_put_layout_hdr(i); v
>             InnerAnd(trace_pnfs_update_layout(..., i, ...)))
>           & !(After v InnerAnd((Ex_ e . i = e)))))
>       U InnerAnd((Ex _v . trace_pnfs_update_layout(..., i, ...)))]))))
>
> diff =
> …
> @@ -2216,7 +2216,6 @@ lookup_again:
>                                            TASK_KILLABLE));
>                 if (IS_ERR(lseg))
>                         goto out_put_layout_hdr;
> -               pnfs_put_layout_hdr(lo);
>                 goto lookup_again;
>         }
>
> @@ -2229,22 +2228,14 @@ lookup_again:
>                 dprintk("%s wait for layoutreturn\n", __func__);
>                 lseg = ERR_PTR(pnfs_prepare_to_retry_layoutget(lo));
>                 if (!IS_ERR(lseg)) {
> -                       pnfs_put_layout_hdr(lo);
>                         dprintk("%s retrying\n", __func__);
> -                       trace_pnfs_update_layout(ino, pos, count, iomode, lo,
> -                                                lseg,
> -                                                PNFS_UPDATE_LAYOUT_RETRY);
>                         goto lookup_again;
>                 }
> -               trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
> -                                        PNFS_UPDATE_LAYOUT_RETURN);

When you use * there s no way to go what matches with what.  But this line
looks questionable because there isn't an obvious path from the
pnfs_put_layout_hdr above to the trace_pnfs_update_layout here.  You get
this because of the no-gotos flag not taking the goto lookup_again;

julia


>                 goto out_put_layout_hdr;
>         }
>
>         lseg = pnfs_find_lseg(lo, &arg, strict_iomode);
>         if (lseg) {
> -               trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
> -                               PNFS_UPDATE_LAYOUT_FOUND_CACHED);
>                 goto out_unlock;
>         }
>
> @@ -2268,7 +2259,6 @@ lookup_again:
>                                                 TASK_KILLABLE));
>                         if (IS_ERR(lseg))
>                                 goto out_put_layout_hdr;
> -                       pnfs_put_layout_hdr(lo);
>                         dprintk("%s retrying\n", __func__);
>                         goto lookup_again;
>                 }
> @@ -2280,12 +2270,8 @@ lookup_again:
>                                         NULL, &stateid, NULL);
>                 if (status != 0) {
>                         lseg = ERR_PTR(status);
> -                       trace_pnfs_update_layout(ino, pos, count,
> -                                       iomode, lo, lseg,
> -                                       PNFS_UPDATE_LAYOUT_INVALID_OPEN);
>                         nfs4_schedule_stateid_recovery(server, ctx->state);
>                         pnfs_clear_first_layoutget(lo);
> -                       pnfs_put_layout_hdr(lo);
>                         goto lookup_again;
>                 }
>                 spin_lock(&ino->i_lock);
> @@ -2294,8 +2280,6 @@ lookup_again:
>         }
>
>         if (pnfs_layoutgets_blocked(lo)) {
> -               trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
> -                               PNFS_UPDATE_LAYOUT_BLOCKED);
>                 goto out_unlock;
>         }
>         nfs_layoutget_begin(lo);
> @@ -2314,8 +2298,6 @@ lookup_again:
>         lgp = pnfs_alloc_init_layoutget_args(ino, ctx, &stateid, &arg, gfp_flags);
>         if (!lgp) {
>                 lseg = ERR_PTR(-ENOMEM);
> -               trace_pnfs_update_layout(ino, pos, count, iomode, lo, NULL,
> -                                        PNFS_UPDATE_LAYOUT_NOMEM);
>                 nfs_layoutget_end(lo);
>                 goto out_put_layout_hdr;
>         }
> @@ -2324,8 +2306,6 @@ lookup_again:
>         pnfs_get_layout_hdr(lo);
>
>         lseg = nfs4_proc_layoutget(lgp, &exception);
> -       trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
> -                                PNFS_UPDATE_LAYOUT_SEND_LAYOUTGET);
>         nfs_layoutget_end(lo);
>         if (IS_ERR(lseg)) {
>                 switch(PTR_ERR(lseg)) {
> @@ -2356,7 +2336,6 @@ lookup_again:
>                                 pnfs_clear_first_layoutget(lo);
>                         trace_pnfs_update_layout(ino, pos, count,
>                                 iomode, lo, lseg, PNFS_UPDATE_LAYOUT_RETRY);
> -                       pnfs_put_layout_hdr(lo);
>                         goto lookup_again;
>                 }
>         } else {
> @@ -2366,8 +2345,6 @@ lookup_again:
>  out_put_layout_hdr:
>         if (first)
>                 pnfs_clear_first_layoutget(lo);
> -       trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
> -                                PNFS_UPDATE_LAYOUT_EXIT);
>         pnfs_put_layout_hdr(lo);
>  out:
>         dprintk("%s: inode %s/%llu pNFS layout segment %s for "
>
> real    0m1,038s
> user    0m0,997s
> sys     0m0,036s
>
>
>
> Are such technical details still questionable?
>
> Regards,
> Markus
>
--8323329-1076314585-1779699291=:33802--
