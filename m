Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC16CA101F
	for <cocci@archiver.kernel.org>; Fri, 12 Sep 2025 11:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=RWWxgq5fT4BDOLxyx4iIAqZykyOPJ4yr44lrB1JMsrE=;
  b=knIsA0Gdyx6MiIED6qr6dcEH3CU4gYZXuY6ZfH7tkOFDCieUY3SDLZXY
   M5s1siGHiVg2TASWdLAJPziIdwBBrr3OklABc1LLKHG94iSTWvzc7krdF
   wuIbhZoXOAC0jn7S2cVFsOexZVndQRznIpIUiPzMAnv7TehbbpYwp5v4n
   M=;
X-CSE-ConnectionGUID: cSe+oETZQEqYI+xkLs5K+w==
X-CSE-MsgGUID: 9vMIY2cyRX6+dfUnSsNq+A==
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
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
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.18,259,1751234400"; 
   d="scan'208";a="238781409"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Sep 2025 13:07:38 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9CBA0E0BE9; Fri, 12 Sep 2025 13:07:37 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B7033E0171
	for <cocci@sympa.inria.fr>; Fri, 12 Sep 2025 13:07:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RWWxgq5fT4BDOLxyx4iIAqZykyOPJ4yr44lrB1JMsrE=;
  b=jWg3o/z/EMgeVa7qSYp/c15Z5FNZc8DXCNsjvO1+IGANO1/6JzdVLljc
   ZjdxcUygjSlU2DMJncyTQ0Vyo5ZyeWYY0YgAPKW+yQaVbyMO3WQVki5wR
   eiDljnFNM2U/hHNlub+FI0mfVplMt9q8vzS2rd4Qx5K5r7Psde1ubRrHD
   o=;
X-CSE-ConnectionGUID: tF5HqBh7Traxsy4bQ7Ex2g==
X-CSE-MsgGUID: CFqMR2tmTeKkXBGyNuJy0Q==
X-IronPort-AV: E=Sophos;i="6.18,259,1751234400"; 
   d="scan'208";a="238781398"
Received: from unknown (HELO hadrien.lan) ([172.58.253.152])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 13:07:32 +0200
Date: Fri, 12 Sep 2025 07:07:29 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <504107f9-09eb-47fe-96ea-53e375b17eac@web.de>
Message-ID: <85e2bcd-23aa-cabd-dee7-7ebf2448c83@inria.fr>
References: <6c2e0db1-033f-4f66-9cf7-dc0eae4bcde7@web.de> <1bfe79b9-f7a4-c20-f116-75d9fe1642b2@inria.fr> <504107f9-09eb-47fe-96ea-53e375b17eac@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1494833121-1757675252=:4162"
Subject: Re: [cocci] Searching for missing cleanup function calls (with
 SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3014
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
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/85e2bcd-23aa-cabd-dee7-7ebf2448c83%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1494833121-1757675252=:4162
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 12 Sep 2025, Markus Elfring wrote:

> > But if there are cases where dn really should be freed, that could be
> > something to write a patch for.
>
> I would like to clarify possible software development consequences
> also according to a diff output like the following.
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch …/Projekte/Coccinelle/janitor/show_missing_of_node_put.cocci arch/powerpc/sysdev/fsl_rio.c
> …
> @@ -511,7 +511,6 @@ static int fsl_rio_setup(struct platform
>         }
>
>         /*set up doobell node*/
> -       np = of_find_compatible_node(NULL, NULL, "fsl,srio-dbell-unit");
>         if (!np) {
>                 dev_err(&dev->dev, "No fsl,srio-dbell-unit node\n");
>                 rc = -ENODEV;
> @@ -537,7 +536,6 @@ static int fsl_rio_setup(struct platform
>                                 (u32)range_start);
>
>         /*set up port write node*/
> -       np = of_find_compatible_node(NULL, NULL, "fsl,srio-port-write-unit");
>         if (!np) {
>                 dev_err(&dev->dev, "No fsl,srio-port-write-unit node\n");
>                 rc = -ENODEV;
>
> real    0m0,968s
> user    0m0,547s
> sys     0m0,059s
>
>
> I would expect that the previously mentioned SmPL code “... when != dn”
> should exclude some C source code.
> How does the shown test result fit to this expectation on the behaviour
> of the Coccinelle software (when there are obviously places where the found variable
> is used again after a null pointer check)?


Your semantic patch isn't included and it is not cenvenient for me to hunt
it down.  idn't you have ?dn = e; or something like at at the end?

julia

>
>
> But it seems that the code is still improvable.
> https://elixir.bootlin.com/linux/v6.17-rc5/source/arch/powerpc/sysdev/fsl_rio.c#L439-L731
>
> I guess that of_node_put() should be called before the affected variable
> is reassigned here.
> https://elixir.bootlin.com/linux/v6.17-rc5/source/drivers/of/base.c#L1011-L1022
>
> I would appreciate your advice.
>
> Regards,
> Markus
>
--8323329-1494833121-1757675252=:4162--
