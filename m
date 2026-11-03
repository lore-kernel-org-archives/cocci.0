Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98589606D805
	for <cocci@archiver.kernel.org>; Tue,  3 Nov 2026 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=KDHiWtXk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:content-id:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=HY4Dd0Zbou7obxIpf8q47+lTpf0BW1FP4z2nkWOCkl8=;
  b=KDHiWtXkJr1XLVmGGKh3Q1pYHdpXUckuknzBI0QjnKlSAHMC3LYgEiBD
   CrbTc/EwqZXckRlja7oi2SdEaXOJgNZQGwJaHfnS50YDaFb6/WbSN5zuT
   9BjYyNfc2biaaGkF7LKpMcIp6+PPykLNyNGNem7OlK1OWCUP0Ly6XYn41
   o=;
X-CSE-ConnectionGUID: z3KVjL0sSrGSwO4y1/nG0Q==
X-CSE-MsgGUID: w0wqEmMZQFusfWEzEXfq3w==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,193,1787004000"; 
   d="scan'208";a="303627173"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Nov 2026 17:38:24 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 8869B80ED6; Tue,  3 Nov 2026 17:38:25 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 012538051F
	for <cocci@sympa.inria.fr>; Tue,  3 Nov 2026 17:38:21 +0100 (CET)
X-CSE-ConnectionGUID: +EappCgOQEWmrcq4ShxV2A==
X-CSE-MsgGUID: z9Yaetg/SMCm4g20GmXW3w==
X-IronPort-AV: E=Sophos;i="6.27,193,1787004000"; 
   d="scan'208";a="161648430"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 17:38:22 +0100
Date: Tue, 3 Nov 2026 17:38:20 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, tools@kernel.org, kernel-janitors@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <52418f50-b3ff-461d-8e66-c10f70e35b2a@web.de>
Message-ID: <161f567a-f33-7865-8787-844a299ef9c1@inria.fr>
References: <52418f50-b3ff-461d-8e66-c10f70e35b2a@web.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-489044682-1793723734=:3641"
Content-ID: <791c737b-3292-d1ac-a25-2578cac8bd7@inria.fr>
Subject: Re: [cocci] [RFC] Replacing special goto statements by direct
 returns?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3763
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/KY4tkd9cvgh2wFVDXR-R0A>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-489044682-1793723734=:3641
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <d52ad096-714-ddd1-6ad5-f1ea219fc09a@inria.fr>



On Tue, 3 Nov 2026, Markus Elfring wrote:

> Hello,
>
> The documentation for the Linux coding style contains the following information.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v7.4-rc1#n526
>
> “…
> The goto statement comes in handy when a function exits from multiple
> locations and some common work such as cleanup has to be done.  If there is no
> cleanup needed then just return directly.
> …”
>
>
> Thus it seems that the following script for the semantic patch language
> can work to some degree.
>
>
> @replacement exists@
> identifier label, var;
> @@
> -goto label;
> +return var;
>  ...
> -label:
>  return var;
>
>
>
> Unfortunately, patches would be generated then by such a simple SmPL code
> which would still preserve return statements that became unreachable.
>
> Test result example:
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time spatch --allow-inconsistent-paths fs/xfs/libxfs/xfs_btree.c …/Projekte/Coccinelle/janitor/replace_goto_by_return2.cocci
> …
> @@ -1735,7 +1735,7 @@ xfs_btree_increment(
>                 --lev;
>                 error = xfs_btree_read_buf_block(cur, ptrp, 0, &block, &bp);
>                 if (error)
> -                       goto error0;
> +                       return error;
>
>                 xfs_btree_setbuf(cur, lev, bp);
>                 cur->bc_levels[lev].ptr = 1;
> @@ -1747,8 +1747,6 @@ out1:
>  out0:
>         *stat = 0;
>         return 0;
> -
> -error0:
>         return error;
>  }

I think you can do:

@useful@
statement S;
expression error;
identifier error0;
position p;
@@

S
error0:@p
  return error;

@useless@
position p1 != useful.p;
expression error;
identifier error0;
@@

f(...) {
(
<...
- goto error0;
+ return error;
...>
&
...
error0:@p1
  return error;
)
}

I have not tested this.  It might not work, or it might be very slow.

julia


> …
> real    0m1,074s
> user    0m0,995s
> sys     0m0,071s
>
>
>
> How should such a source code transformation approach be improved accordingly?
>
> Regards,
> Markus
>
>
--8323329-489044682-1793723734=:3641--
