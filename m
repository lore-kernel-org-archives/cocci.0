Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8251D29C43
	for <cocci@archiver.kernel.org>; Mon, 19 Jan 2026 16:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Ms8mauACcTB7A6cn29PrvKlay8j0NoZWDlX19Ww0AHQ=;
  b=pHhuF4lbjoOB1+thpMUyQvKUVouPBK/bpl/JMURjbg0Zvn25Z4Z9NbJr
   1G9hWxPz4FM/uF7PlAAD+ZSSShhAzXhle252MtYTuV61Pw3OCvuH6zWHl
   mdNyyGYNPyELQi0j2XZ+aI6w4vfNcOaQwxxdALlNk4SwN+Mqgri/9V8Mo
   A=;
X-CSE-ConnectionGUID: LucaGd2XQQun/N7I62mSGQ==
X-CSE-MsgGUID: b8qifQjeQeud3OtCiAfv0w==
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
   d="scan'208";a="259318042"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Jan 2026 17:27:28 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 5AD8C83875; Mon, 19 Jan 2026 17:27:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 8761A81611
	for <cocci@sympa.inria.fr>; Mon, 19 Jan 2026 17:27:22 +0100 (CET)
X-CSE-ConnectionGUID: SN5sRxIFRka/S9N6lTTxag==
X-CSE-MsgGUID: AuxQotYPRu2/5c90IBMQXg==
X-IronPort-AV: E=Sophos;i="6.21,238,1763420400"; 
   d="scan'208";a="259318019"
Received: from unknown (HELO hadrien) ([4.26.64.170])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 17:27:22 +0100
Date: Mon, 19 Jan 2026 11:27:21 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <78df0ed3-2bb4-438a-bba5-c858dd20c1f1@web.de>
Message-ID: <176fb6de-f5c5-de7c-db91-ab5b81661f77@inria.fr>
References: <e12b2a95-f1e6-4f8b-ab62-151c9789e798@web.de> <3857229-a98-854f-225f-5a63ca19cb7d@inria.fr> <15bca19e-5a87-4efd-8da7-c6ea2cad27f1@web.de> <ca324487-4858-9054-14e8-dbeabae9728a@inria.fr> <78df0ed3-2bb4-438a-bba5-c858dd20c1f1@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1942765150-1768840042=:3249"
Subject: Re: [cocci] Checking data structure member accesses after function
 return value assignments?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3275
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/RSo1QUIywZPiUBD9ZQ1PLg>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1942765150-1768840042=:3249
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 19 Jan 2026, Markus Elfring wrote:

> >> Another SmPL script example:
> …
> >> @display@
> >> expression action, pointer;
> >> identifier member;
> >> @@
> >> *pointer = action(...);
> >> *<+... (pointer)->member ...+>
> >>  ;
> >>
> >>
> >> Questionable test result:
> >> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch --no-loops …/Projekte/Coccinelle/janitor/show_questionable_statement_combination3.cocci drivers/regulator/fp9931.c
> >> [no diff output]
> >
> > OK, then I don't know.  It seems like it was possible to parse trhe
> > semantic patch.
> …
>
> Under which circumstances will corresponding software improvements become more likely?

If a semantic patch doesn't match when you expect it to, the most likely
issue is that the C code you expected to match doesn't parse.  Did you try
spatch --parse-c on that file.  You have to see if there is BUG or bug at
the beginning of the relevant lines.

julia
--8323329-1942765150-1768840042=:3249--
