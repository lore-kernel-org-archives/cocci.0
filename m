Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06744CD8C88
	for <cocci@archiver.kernel.org>; Sun,  7 Jun 2026 11:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=O3HMBXIsjdjYcoPDo4+772IlfONALqDRlnb3z/Ttq/c=;
  b=Ik+H0/CBRpuxlLVaZRkHMotcXfU4uBSmNKEVsdxHGXhtTXTOeZElsVAO
   BmGkGgI5bRn/G8gXi7c8qegflFTR//W41ZceICy/dzX2fO/oyCawJlyHw
   4mLAQ958g9+z08wSUrWLU9lX/T+3tpJRTqo7WKIDwznRQnmJ7rBQvjJWH
   g=;
X-CSE-ConnectionGUID: bhsR2en5QPqvSPrqPpQu8Q==
X-CSE-MsgGUID: h5haJBiUQLuES5NHMzcxIA==
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
X-IronPort-AV: E=Sophos;i="6.24,192,1774306800"; 
   d="scan'208";a="280168102"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jun 2026 13:25:50 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 0ECEA804E5; Sun,  7 Jun 2026 13:25:50 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id C69EB804E5
	for <cocci@sympa.inria.fr>; Sun,  7 Jun 2026 13:25:41 +0200 (CEST)
X-CSE-ConnectionGUID: bSVPAmwGRmS1tcYKV61zPw==
X-CSE-MsgGUID: VCNxsJVLTLaNrR4z6orwjQ==
X-IronPort-AV: E=Sophos;i="6.24,192,1774306800"; 
   d="scan'208";a="148643961"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 13:25:42 +0200
Date: Sun, 7 Jun 2026 13:25:41 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <06c1a8ed-1619-470b-b92c-974955a415a4@web.de>
Message-ID: <1b6ff36-9b2-2b3d-6d46-9acbcec3216@inria.fr>
References: <b90fe034-4d51-41cb-b011-d98565044a53@web.de> <876f76fe-c234-498c-9381-02697370dc18@web.de> <06c1a8ed-1619-470b-b92c-974955a415a4@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1297926780-1780831541=:39302"
Subject: Re: [cocci] Adding a string literal after a string literal with
 SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3557
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/tXOt0EbJlEN36ANn_fD1zw>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1297926780-1780831541=:39302
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 7 Jun 2026, Markus Elfring wrote:

> > Under which circumstances will the following data processing approach become supported?
> >
> > Another SmPL script variant:
>
> @addition@
> identifier action;
> @@
>  action("My test"
> +       " case!\n"
>        )


There is no plan to support this.

julia

>
>
> Questionable test result (in combination with the software “Coccinelle 1.3.1”):
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> /usr/bin/spatch --parse-cocci add_literal_after_literal.cocci
> …
> plus: parse error:
>   File "add_literal_after_literal.cocci", line 5, column 17, charpos = 68
>   around = '"',
>   whole content = +       " case!\n"
>
>
> Would any more software users like to achieve that such a simple source code transformation
> can work also with this evolving development tool?
> https://en.cppreference.com/c/language/string_literal#Explanation
>
> Regards,
> Markus
>
--8323329-1297926780-1780831541=:39302--
