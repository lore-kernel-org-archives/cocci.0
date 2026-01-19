Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAAAD29C2E
	for <cocci@archiver.kernel.org>; Mon, 19 Jan 2026 16:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=g1VnfCiPNQC5ZVk4shY9xaYZpgTCEgA+3/UTcbcojR0=;
  b=l0NyZvYhn/2TJ264CtcQ8kT++limbn+2T8ugK6NYyY0Ml7TXllX4MtkZ
   wxwykVf7+g7EWVh0fCmEj9ZocJrVxw/P46s8MRm2hf1KqBwzPB80Va8Sg
   1bb2FBMISg+WCEVGA5Q+emuyxXNIKxAciJYpyzbLRK4bwY3mnLeLYr7dJ
   M=;
X-CSE-ConnectionGUID: pj9iX6WuRcec9qpeipG4Ag==
X-CSE-MsgGUID: Ou2K1BPySaSF9MsTRLKoCw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
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
X-IronPort-AV: E=Sophos;i="6.21,238,1763420400"; 
   d="scan'208";a="259315559"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Jan 2026 17:16:31 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 11DCE81614; Mon, 19 Jan 2026 17:16:31 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 91F9181614
	for <cocci@sympa.inria.fr>; Mon, 19 Jan 2026 17:16:27 +0100 (CET)
X-CSE-ConnectionGUID: +r4bK2LQQcKnS+GEzdOF8w==
X-CSE-MsgGUID: tLJzcuwZRuSWMlKyn+3dug==
X-IronPort-AV: E=Sophos;i="6.21,238,1763420400"; 
   d="scan'208";a="136425724"
Received: from unknown (HELO hadrien) ([4.26.64.170])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 17:16:28 +0100
Date: Mon, 19 Jan 2026 11:16:25 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <15bca19e-5a87-4efd-8da7-c6ea2cad27f1@web.de>
Message-ID: <ca324487-4858-9054-14e8-dbeabae9728a@inria.fr>
References: <e12b2a95-f1e6-4f8b-ab62-151c9789e798@web.de> <3857229-a98-854f-225f-5a63ca19cb7d@inria.fr> <15bca19e-5a87-4efd-8da7-c6ea2cad27f1@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1117795549-1768839387=:3249"
Subject: Re: [cocci] Checking data structure member accesses after function
 return value assignments?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3273
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/0pck1AYa1eVEg45_lO4ysA>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1117795549-1768839387=:3249
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 19 Jan 2026, Markus Elfring wrote:

> …
> >> May I expect that the same data processing result can be achieved together with
> >> the application of an SmPL nest construct?
> …
> > Since you haven't told me what happens when you run this, I don't know
> > what the issue is.
>
> I assume that you can try to reproduce a questionable test result also with
> your current development software version.
>
>
> > But it may work better with () around the <+... ...+>, to avoid a parsing conflict.
>
> Why are you looking for extra parentheses there?

As I already said it is to avoid a parser conflict.  Both statements and
expressions can start with <+... ...+>.  But if there is a (), it can only
be an expression.

>
> Another SmPL script example:
> // See also:
> // [PATCH] regulator: fp9931: Add missing memory allocation check
> // https://lore.kernel.org/lkml/tencent_5FCF2108621C51007E5526A7C60A5CC1F306@qq.com/
> // https://lkml.org/lkml/2026/1/18/129
> @display@
> expression action, pointer;
> identifier member;
> @@
> *pointer = action(...);
> *<+... (pointer)->member ...+>
>  ;
>
>
> Questionable test result:
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch --no-loops /home/altes_Heim2/elfring/Projekte/Coccinelle/janitor/show_questionable_statement_combination3.cocci drivers/regulator/fp9931.c
> [no diff output]

OK, then I don't know.  It seems like it was possible to parse trhe
semantic patch.

julia

>
> real    0m0,108s
> user    0m0,086s
> sys     0m0,015s
>
>
> Regards,
> Markus
>
--8323329-1117795549-1768839387=:3249--
