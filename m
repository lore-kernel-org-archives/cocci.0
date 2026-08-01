Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9D3C55174
	for <cocci@archiver.kernel.org>; Sat,  1 Aug 2026 08:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=qdqsv5AkPRtsvfQw7ries6OHtAwQs1BekKY/HE6SBI4=;
  b=MqUg6L5GYcEXIg1SCFXfvZDDwwXiSrh/V/GX+NMbG3Vt1p64xDEJhdjE
   PIHVsc81QOk6xKUHJ+V3J8TiqMDcSQOU2HDxhafP+irc9GQwyUuPT2uhx
   OCc1xWWPcDABh0utwQldsYIViHoId5UMe2tgDW9WQYS8O8Smb2RnEqCxx
   U=;
X-CSE-ConnectionGUID: MLDTSK24QxGbY1uN81HUgA==
X-CSE-MsgGUID: AOv4TdHtQ7S0Ec2510HLSQ==
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
X-IronPort-AV: E=Sophos;i="6.25,198,1779141600"; 
   d="scan'208";a="288736128"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Aug 2026 10:18:42 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 7244F81B16; Sat,  1 Aug 2026 10:18:42 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id BFC9D805C3
	for <cocci@sympa.inria.fr>; Sat,  1 Aug 2026 10:18:39 +0200 (CEST)
X-CSE-ConnectionGUID: vHgSfTYMSeehxUGE6sV49Q==
X-CSE-MsgGUID: hd0LxffORvSmeTwj/cj4kQ==
X-IronPort-AV: E=Sophos;i="6.25,198,1779141600"; 
   d="scan'208";a="153419013"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2026 10:18:39 +0200
Date: Sat, 1 Aug 2026 10:18:39 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>, 
    kernel-janitors@vger.kernel.org
In-Reply-To: <9f8ce18d-67bc-4c01-b3fa-8605c9856b82@web.de>
Message-ID: <9e187875-e472-911-c280-59dff6b7c80@inria.fr>
References: <202dfb21-f5a2-4550-8a1f-aa07d84db345@web.de> <be2727e1-907e-487f-8522-e5aa694b1c38@web.de> <9f8ce18d-67bc-4c01-b3fa-8605c9856b82@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Improving output for single characters (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3665
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/nhQuX-6SpRps7kmA-bJN3A>



On Sat, 1 Aug 2026, Markus Elfring wrote:

> >> Which implementation details should be reconsidered here for an affected macro?
> >> https://elixir.bootlin.com/linux/v7.2-rc4/source/tools/bpf/bpftool/netlink_dumper.h#L25
> >
> > The shown source code transformation approach can be repeated on demand
> > for selected areas.
>
> I would like to add that only a single diff hunk is generated for the following script variant
> of the semantic patch language (as it would usually be expected for the mentioned software component).
>
> @replacement@
> @@
> -fprintf
> +putchar
>  (
> -stdout, "\n"
> +'\n'
>  )
>
>
> > Now I wonder about the following information.
> >
> > Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Linux/next-analyses> grep 'diff -u -p a/netlink_dumper.h b/netlink_dumper.h' /home/altes_Heim2/elfring/Projekte/Bau/Linux/scripts/Coccinelle/tuning1/next/20260721/use_fputc-bpftool-2.diff | wc -l
> > 2
>
> How can the generation of duplicate difference output be avoided here
> for other SmPL script variations?

I don't know the details o what you are doing, but if you have duplicated
output about herder files, it would be because the header file is included
in other files.  If there is no need to process the header file
specifically based on a given .c file (which would be the case for the rul
shown above), then you can use the option --no-includes.  If you want some
type information from header files but you don't want to transform them in
a way that is specific to the .c file in which they are included then you
can also use --include-headers-for-types.

julia


>
> Regards,
> Markus
>
>
