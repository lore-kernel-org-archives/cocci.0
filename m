Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D65CD5BAC
	for <cocci@archiver.kernel.org>; Sat, 23 May 2026 14:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=0KcUrP3ttv9V704jMBZFWGHrPGg2Z4+fqylhXxaMbwI=;
  b=UFD/8ZnnVGjWZcB1hgLm1slHnjuwpkM5Ks5GwMe1x6h4lKP8DEX9dt5v
   Jeah4IhMQFfc6b8ZZX7SeRS133kbcyXjGdJ1g132e016yIy+HgKCAUeKT
   v/2R353Scoh4DAqrfp/LPmMlTslpD088125RBFFh3Vj9/AVV62XDfRsHc
   4=;
X-CSE-ConnectionGUID: tu0HOo3fSjy/esnehG+LdA==
X-CSE-MsgGUID: Jtn3egDtRwaTM3gE3x2iww==
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
X-IronPort-AV: E=Sophos;i="6.24,164,1774306800"; 
   d="scan'208";a="277964582"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 May 2026 16:27:45 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 7FF8E83190; Sat, 23 May 2026 16:27:45 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id B61F081EC9
	for <cocci@sympa.inria.fr>; Sat, 23 May 2026 16:27:42 +0200 (CEST)
X-CSE-ConnectionGUID: YbceLd6uR4anQbUIEEaEyw==
X-CSE-MsgGUID: uLSCjub1QSqQUvo4CXMOAw==
X-IronPort-AV: E=Sophos;i="6.24,164,1774306800"; 
   d="scan'208";a="147404778"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2026 16:27:42 +0200
Date: Sat, 23 May 2026 16:27:42 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, vulab@iscas.ac.cn
In-Reply-To: <47a6aeca-6c58-4be6-9a4e-a1d6726b5a0a@web.de>
Message-ID: <8397220-4b66-acd4-32e2-cfa72ee7ac66@inria.fr>
References: <47a6aeca-6c58-4be6-9a4e-a1d6726b5a0a@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2059719691-1779546462=:33802"
Subject: Re: [cocci] Checking evaluation of another SmPL script
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3503
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/i1tpZwf4N2FBMehNbLoDaQ>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2059719691-1779546462=:33802
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 23 May 2026, Markus Elfring wrote:

> Hello,
>
> I would like to try another small SmPL script out.
>
>
> Example:
> // See also:
> // [PATCH] pNFS: Fix use-after-free in pnfs_update_layout()
> // https://lore.kernel.org/linux-nfs/20260518131036.1337001-1-vulab@iscas.ac.cn/
>
> // https://elixir.bootlin.com/linux/v7.1-rc4/source/fs/nfs/pnfs.c#L2128-L2385
> @display@
> identifier i;
> expression e;
> @@
> *pnfs_put_layout_hdr(i);
>  ... when != i = e
> *trace_pnfs_update_layout(..., i, ...)
>
>
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/janitor> /usr/bin/spatch --version
> spatch version 1.3.1 compiled with OCaml version 4.14.3
> …
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> /usr/bin/spatch --no-loops …/Projekte/Coccinelle/janitor/show_UAF_1.cocci fs/nfs/pnfs.c
> …
> @@ -2169,9 +2169,6 @@ pnfs_update_layout(struct inode *ino,
>
>  lookup_again:
>         if (!nfs4_valid_open_stateid(ctx->state)) {
> -               trace_pnfs_update_layout(ino, pos, count,
> -                                        iomode, lo, lseg,
> -                                        PNFS_UPDATE_LAYOUT_INVALID_OPEN);
>                 lseg = ERR_PTR(-EIO);
>                 goto out;
>         }
> @@ -2216,7 +2213,6 @@ lookup_again:
>                                            TASK_KILLABLE));
>                 if (IS_ERR(lseg))
>                         goto out_put_layout_hdr;
> -               pnfs_put_layout_hdr(lo);
>                 goto lookup_again;
>         }
>
> @@ -2229,11 +2225,7 @@ lookup_again:
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
>                 trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
> @@ -2268,7 +2260,6 @@ lookup_again:
>                                                 TASK_KILLABLE));
>                         if (IS_ERR(lseg))
>                                 goto out_put_layout_hdr;
> -                       pnfs_put_layout_hdr(lo);
>                         dprintk("%s retrying\n", __func__);
>                         goto lookup_again;
>                 }
> @@ -2285,7 +2276,6 @@ lookup_again:
>                                         PNFS_UPDATE_LAYOUT_INVALID_OPEN);
>                         nfs4_schedule_stateid_recovery(server, ctx->state);
>                         pnfs_clear_first_layoutget(lo);
> -                       pnfs_put_layout_hdr(lo);
>                         goto lookup_again;
>                 }
>                 spin_lock(&ino->i_lock);
> @@ -2356,7 +2346,6 @@ lookup_again:
>                                 pnfs_clear_first_layoutget(lo);
>                         trace_pnfs_update_layout(ino, pos, count,
>                                 iomode, lo, lseg, PNFS_UPDATE_LAYOUT_RETRY);
> -                       pnfs_put_layout_hdr(lo);
>                         goto lookup_again;
>                 }
>         } else {
>
>
> I find some generated diff hunks inappropriate for the mentioned source code
> search pattern.
> How can such questionable data be avoided here?

Due to the goto, they all look fine to me.  What did you intend?

If you consider that some output is unsuitable, it would help a lot if you
would indicate which output you are concerned about, and not just dump
the whole thing and hopw taht the reader will figure it out in the same
way you did.

julia

>
> Regards,
> Markus
>
--8323329-2059719691-1779546462=:33802--
