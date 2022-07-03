Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D08AC43334
	for <cocci@archiver.kernel.org>; Sun,  3 Jul 2022 21:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=TcQYXqLRtrLGWsmwB2+oZA+Wve4mD+Rv6vnB3ABd6zA=;
  b=jdm0MMrT+8f2Wwx/y2sGXYcmZyFIp0u0utX6ikufVbX6MUTBjaNyx0Cx
   iZ4++PvxB7ck9FNSZE4E3f57HuTVZHlzAdSByyWujODGhe1VDlMTJEAqe
   846o4Hqizb4xHtzJCocDfo9wzbDke/R5YI9wHIee9hScjOoj7U/z9q3xa
   U=;
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
X-IronPort-AV: E=Sophos;i="5.92,241,1650924000"; 
   d="scan'208";a="44008716"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Jul 2022 23:45:44 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 55E70E034D; Sun,  3 Jul 2022 23:45:44 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4667DE0092
	for <cocci@sympa.inria.fr>; Sun,  3 Jul 2022 23:45:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TcQYXqLRtrLGWsmwB2+oZA+Wve4mD+Rv6vnB3ABd6zA=;
  b=hZm8w2dqXVviiRVSs1OvL+fkgWptFGXspN0lxAfgB9zgLE1d7VRE4eaj
   ONUT3n8iIiFevNTLm0j2hDlwIB/bI3sZ+GFZsEKB7vQe4GVg1qDeWcSXk
   rrCeZeX15CuV//VJ640qOnw0AkeIySnCnVFzNpVqCS7v99FPblrbMe+sI
   A=;
X-IronPort-AV: E=Sophos;i="5.92,241,1650924000"; 
   d="scan'208";a="44008711"
Received: from 252.75.68.85.rev.sfr.net (HELO hadrien) ([85.68.75.252])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 23:45:42 +0200
Date: Sun, 3 Jul 2022 23:45:41 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-15?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
cc: Nicolas Palix <nicolas.palix@imag.fr>, "cocci@inria.fr" <cocci@inria.fr>
In-Reply-To: <AS8PR03MB7603EE9F885BA2573CD56CF993BD9@AS8PR03MB7603.eurprd03.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2207032345230.23263@hadrien>
References: <AS8PR03MB7603EE9F885BA2573CD56CF993BD9@AS8PR03MB7603.eurprd03.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1643175310-1656884742=:23263"
Subject: Re: [cocci] [PATCH v5] coccinelle: Extend address test from ifaddr
 semantic patch to test expressions
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 481
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/alpine.DEB.2.22.394.2207032345230.23263%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1643175310-1656884742=:23263
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Fri, 1 Jul 2022, Jérémy LEFAURE wrote:

> The test of an expression's address does not necessarily represent the
> whole condition, it may only be a part of it. Also, an expression's
> address is likely to be non-zero in every test expression, not only in
> if statements.
>
> This change aims at detecting an address test in more complex conditions
> and not only in if statements.
>
> Signed-off-by: Jérémy Lefaure <jeremy.lefaure@netatmo.com>
> ---
> v4 -> v5: Change semantic patch to match explicit tests to NULL +
> improve commit message
> v3 -> v4: Improve patch subject
> v2 -> v3: Apply Julia's suggestion to have a more generic solution + adapt
> commit message and file name to this new solution.
> v1 -> v2: Moved disjunction on the condition itself instead of being on the
> if statements.

Applied, thanks.

julia

>
>  scripts/coccinelle/misc/{ifaddr.cocci => test_addr.cocci} | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>  rename scripts/coccinelle/misc/{ifaddr.cocci => test_addr.cocci} (94%)
>
> diff --git a/scripts/coccinelle/misc/ifaddr.cocci b/scripts/coccinelle/misc/test_addr.cocci
> similarity index 94%
> rename from scripts/coccinelle/misc/ifaddr.cocci
> rename to scripts/coccinelle/misc/test_addr.cocci
> index fc92e8fcbfcb..029db9069c44 100644
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
> +*\(&x@p == NULL \| &x@p != NULL\)
>
>  @script:python depends on org@
>  p << r.p;
> --
> 2.25.1
>
--8323329-1643175310-1656884742=:23263--
