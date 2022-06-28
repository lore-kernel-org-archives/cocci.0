Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A21CC433EF
	for <cocci@archiver.kernel.org>; Tue, 28 Jun 2022 16:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=cgd9e3TXVZjibE6LQXsLiEwXR89RSuzmjty1X+92qCs=;
  b=ed/6DJOJ0zQtejo7xdUi5vK8aEkdMDW3p+UhVII/KOu/6NLvlZHGMU9J
   BiEkkCiqbXEh2OcFZzjDn5XXL2hlcehImm/zLuxtHXD9o3/0K4eiL4RIT
   aBNz4+WpLZDqFDig37PUIknHqOlGq/HHs0zxrDPjilFYn/ht8pgBTR5AX
   o=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.92,229,1650924000"; 
   d="scan'208";a="43286489"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jun 2022 18:47:33 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 514DEE00F5; Tue, 28 Jun 2022 18:47:32 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4A67DE00BE
	for <cocci@sympa.inria.fr>; Tue, 28 Jun 2022 18:47:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cgd9e3TXVZjibE6LQXsLiEwXR89RSuzmjty1X+92qCs=;
  b=uILWXC060MoXM5NbDDJLvP/MXEZY2gd2nz+i732o/8sgLn9RV7Rn8sVV
   MXhNiTtTwJ1upbQDJWa6wq7qSb0f4iianp4shl1LK1NmtUPv/moP0cde0
   qnAlIJH+jOX33gOCpueL/bRuMIhaD2Odf3AWDkxFnjw/WhaZgSR6ZF4rd
   s=;
X-IronPort-AV: E=Sophos;i="5.92,229,1650924000"; 
   d="scan'208";a="18001796"
Received: from unknown (HELO hadrien) ([65.216.237.4])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 18:47:26 +0200
Date: Tue, 28 Jun 2022 12:47:14 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: =?ISO-8859-15?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
cc: Nicolas Palix <nicolas.palix@imag.fr>, 
    Markus Elfring <Markus.Elfring@web.de>, "cocci@inria.fr" <cocci@inria.fr>
In-Reply-To: <AS8PR03MB76032BE6B27D43AD020D810D93B89@AS8PR03MB7603.eurprd03.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2206281246160.2182@hadrien>
References: <AS8PR03MB76039ED18663E85F7E8234CF93B59@AS8PR03MB7603.eurprd03.prod.outlook.com> <AS8PR03MB76032BE6B27D43AD020D810D93B89@AS8PR03MB7603.eurprd03.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-878603046-1656434846=:2182"
Subject: Re: [cocci] [PATCH v4] coccinelle: Extend address test from ifaddr
 semantic patch to test expressions
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 462
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/alpine.DEB.2.22.394.2206281246160.2182%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-878603046-1656434846=:2182
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Tue, 28 Jun 2022, Jérémy LEFAURE wrote:

> > -*if@p (&x)
> > - S1 else S2
> > +*&x@p || ...
>
> I did additional tests and this version does not match explicit check
> for NULL in if conditions such as `if (&my_var == NULL)`. But it matches
> explicit check for non-NULL such as `if (&my_var != NULL)`. I don't know
> why the `==` and `!=` cases are different. Do you have any idea Julia?
>
> This limitation could be avoided with an explicit test to NULL in the
> semantic patch:
> *\(&x@p || ... \| &x == NULL@p || ... \)

No.  Just put the == NULL case.  The &x case will already be covered by an
isomorphism.  You can see this with spatch --parse-cocci file.cocci

julia

>
> Would it be the best solution?
>
> Thank you,
> Jérémy
>
> ________________________________________
> From: Jérémy LEFAURE
> Sent: Thursday, June 23, 2022 18:42
> To: Julia Lawall; Nicolas Palix
> Cc: Markus Elfring; cocci@inria.fr
> Subject: [PATCH v4] coccinelle: Extend address test from ifaddr semantic patch to test expressions
>
> The test of an expression's address does not necessarily represent the
> whole condition, it may only be a part of it. Also, an expression's
> address is likely to be non-zero in every test expression, not only in
> if statements.
>
> This change aims at detecting an address test in more complex conditions
> for every test expression.
>
> Signed-off-by: Jérémy Lefaure <jeremy.lefaure@netatmo.com>
> ---
> v3 -> v4: Improve patch subject
> v2 -> v3: Apply Julia's suggestion to have a more generic solution + adapt
> commit message and file name to this new solution.
> v1 -> v2: Moved disjunction on the condition itself instead of being on the
> if statements.
>
>  scripts/coccinelle/misc/{ifaddr.cocci => test_addr.cocci} | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>  rename scripts/coccinelle/misc/{ifaddr.cocci => test_addr.cocci} (94%)
>
> diff --git a/scripts/coccinelle/misc/ifaddr.cocci b/scripts/coccinelle/misc/test_addr.cocci
> similarity index 94%
> rename from scripts/coccinelle/misc/ifaddr.cocci
> rename to scripts/coccinelle/misc/test_addr.cocci
> index fc92e8fcbfcb..2d0ec86d1701 100644
> --- a/scripts/coccinelle/misc/ifaddr.cocci
> +++ b/scripts/coccinelle/misc/test_addr.cocci
> @@ -14,12 +14,10 @@ virtual context
>
>  @r@
>  expression x;
> -statement S1,S2;
>  position p;
>  @@
>
> -*if@p (&x)
> - S1 else S2
> +*&x@p || ...
>
>  @script:python depends on org@
>  p << r.p;
> --
> 2.25.1
>
--8323329-878603046-1656434846=:2182--
