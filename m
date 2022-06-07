Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5B0C43334
	for <cocci@archiver.kernel.org>; Tue,  7 Jun 2022 09:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=WPMIF/ZdRxQluuM5wA7vVcLt76yhP2zJUE48Bx4+TXU=;
  b=ovFYqrySGiKFPR7ePSvBomR2QFqNos6+rmq9Dx7HtNE1aEGu4cLPhvf0
   2PCshSMOzk8dR8Oz6uFaZLFb6SlO24ccRLpy6aTWl0Zah+H5JPcF67eNl
   9LIvk2+ldn+DxOMcZt2RAp9fHx846zHzUda2A4bAO/OhGddxg7+dxm/FT
   4=;
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
X-IronPort-AV: E=Sophos;i="5.91,283,1647298800"; 
   d="scan'208";a="39783851"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jun 2022 11:44:04 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 44A65E0346; Tue,  7 Jun 2022 11:44:04 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8ED72E007E
	for <cocci@sympa.inria.fr>; Tue,  7 Jun 2022 11:44:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WPMIF/ZdRxQluuM5wA7vVcLt76yhP2zJUE48Bx4+TXU=;
  b=CFEjkSxqSEtZPhwU/wjPGo2Rwuu6at+vNQr+f81sBWgEjQ0b10H7KhT4
   DrE3M/QY8doV5s9Y6aTp6R9nMbMwAE8fgA7gt26hcTiGuaxhzfoNW2l1M
   SM7Q02bFLwfggSekvQ/Zwqo1R+Ny78tvEYuUvpRCFop62dlLFWvnSuadi
   k=;
X-IronPort-AV: E=Sophos;i="5.91,283,1647298800"; 
   d="scan'208";a="39783838"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 11:44:02 +0200
Date: Tue, 7 Jun 2022 11:44:02 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: =?ISO-8859-15?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
cc: Nicolas Palix <nicolas.palix@imag.fr>, "cocci@inria.fr" <cocci@inria.fr>, 
    Markus Elfring <Markus.Elfring@web.de>, 
    "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
In-Reply-To: <AS8PR03MB760365A0DE3A8522136471BE93A59@AS8PR03MB7603.eurprd03.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2206071143370.11966@hadrien>
References: <AS8PR03MB760365A0DE3A8522136471BE93A59@AS8PR03MB7603.eurprd03.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-699005149-1654595042=:11966"
Subject: Re: [cocci] [PATCH v2] coccinelle: ifaddr: Find address test in
 more complex conditions
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 418
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/alpine.DEB.2.22.394.2206071143370.11966%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-699005149-1654595042=:11966
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Tue, 7 Jun 2022, Jérémy LEFAURE wrote:

> The test of an expression's address does not necessarily represent the
> whole condition, it may only be a part of it.
> This change aims at detecting an address test in more complex conditions.
>
> Signed-off-by: Jérémy Lefaure <jeremy.lefaure@netatmo.com>
> ---
> v1 -> v2: Moved disjunction on the condition itself instead of being on the if statements

Thanks for the change.  It seems to cover all the cases.

julia

>
>  scripts/coccinelle/misc/ifaddr.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccinelle/misc/ifaddr.cocci b/scripts/coccinelle/misc/ifaddr.cocci
> index fc92e8fcbfcb..14dbf3131a3f 100644
> --- a/scripts/coccinelle/misc/ifaddr.cocci
> +++ b/scripts/coccinelle/misc/ifaddr.cocci
> @@ -18,7 +18,7 @@ statement S1,S2;
>  position p;
>  @@
>
> -*if@p (&x)
> +*if@p ( \(&x || ... \| &x && ... \) )
>   S1 else S2
>
>  @script:python depends on org@
> --
> 2.25.1
>
--8323329-699005149-1654595042=:11966--
