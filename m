Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B09CD5BB1
	for <cocci@archiver.kernel.org>; Sun, 24 May 2026 13:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Y7XWCSAliwzGcEfrKNE3xtpU3r2VgPUCyIYv0l4ltMU=;
  b=reGIXvOrNBf4PZWCSASYMURJTSNml2uPj+3sAlcRfCemrdvYGcfB+1O1
   /F4tyr6RSt9WBM3qvWK07JQFFNEQWZ2ExBdrz5yZ3nbF/6o0gYahz8D+q
   qDiwowHar82gYKMx/MYAxIv1mA92k67Lpm73w4r+cqYqrgAcsiybPT7Ul
   Y=;
X-CSE-ConnectionGUID: LAiBiL2ZRHq1Em74n/1ANQ==
X-CSE-MsgGUID: G+hmhXPrQyO/tcH5GaVKLg==
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
X-IronPort-AV: E=Sophos;i="6.24,166,1774306800"; 
   d="scan'208";a="278015696"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 May 2026 15:20:22 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 4F0DB8129E; Sun, 24 May 2026 15:20:22 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 9B665812A7
	for <cocci@sympa.inria.fr>; Sun, 24 May 2026 15:20:15 +0200 (CEST)
X-CSE-ConnectionGUID: eN4fRb3zRCevGhRapAkGrg==
X-CSE-MsgGUID: oDpQS8IhSgKSY0TDDkX9hw==
X-IronPort-AV: E=Sophos;i="6.24,166,1774306800"; 
   d="scan'208";a="147446370"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 15:20:16 +0200
Date: Sun, 24 May 2026 15:20:15 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, vulab@iscas.ac.cn
In-Reply-To: <45c2a194-b0fa-495a-8c54-3b77c3d43c71@web.de>
Message-ID: <f6c4ecec-4f33-502c-126-a3d8d24f1e@inria.fr>
References: <47a6aeca-6c58-4be6-9a4e-a1d6726b5a0a@web.de> <8397220-4b66-acd4-32e2-cfa72ee7ac66@inria.fr> <25fb88dd-4573-4897-98ae-f5904a2324cd@web.de> <85a837b7-8a6-5fb8-eeb-1e70c5f77b2e@inria.fr> <1da11354-3d73-4158-aa0b-98a143471a3b@web.de>
 <dac0391-4aa-f02-f8fc-2168c118e3ef@inria.fr> <dd4fa876-fe40-43ec-8184-05da70579973@web.de> <7cd8b09f-eb9a-c4f7-81a-6a2968c1c02@inria.fr> <c9941a16-38e8-ccb5-c07c-54ac1718a398@inria.fr> <f68596ce-db2c-40a7-9e79-e9448ad460e5@web.de> <84111447-1b1b-98e4-afb2-fae89bc79d5b@inria.fr>
 <45c2a194-b0fa-495a-8c54-3b77c3d43c71@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-25811687-1779628815=:33802"
Subject: Re: [cocci] Checking evaluation of another SmPL script
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3513
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/hAJHNPHuFaEayWmrkNbiCg>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-25811687-1779628815=:33802
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 24 May 2026, Markus Elfring wrote:

> > Loops require the use of the CTL operator AW, not AU.
>
> Further development considerations might become more interesting
> for desirable clarifications according to computation tree logic variants.
>
>
> @display@
> identifier i;
> expression e;
> @@
> *i = malloc(...);
>  ... when != i = e
> *free(i);
> *i->x = e
>
>
> Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Coccinelle/janitor> /usr/bin/spatch --show-ctl-text --no-loops show_UAF_3.cocci ../Probe/demo-UAF2.c
> …
> CTL =
>
> (!EX(EX(EX(Exit))) &,
>  (Ex_ i .
>   ((Ex _v . i = malloc(...);) &,
>    EX((Ex_ e .
>       E[(!After &
>          (!(i = malloc(...); v free(i);) & !(After v InnerAnd(i = e))))
>        U
>        ((Ex _v . free(i);) &,
>         EX(InnerAnd(((Ex_ _pos . (Ex _v . i->x = e)) v
>                     (Ex_ _pos .
>                      ((Ex_ _E2_0 . (Ex _v . i[_E2_0].x = e)) &
>                       !Uncheck(i->x = e)))))))])))))
>
> diff =
> …
> @@ -19,12 +19,9 @@ void my_test(void)
>   struct my_point * mp;
>
>  allocation:
> - mp = malloc(sizeof(*mp));
>   if (mp)
>   {
> -  free(mp);
>    // Demonstration of a programming mistake
> -  mp->x = 2;
>
>    // Trigger a repetition eventually
>    if (++s < 5)
>
>
> Where is the mentioned CTL operator applied here?

Nowhere.  Loops are only an issue for the forall case, because we need to
ignore the path that goes around the loop infinitely.  You semantic patch
doesn't use any forall path operators, only exists.

julia
--8323329-25811687-1779628815=:33802--
