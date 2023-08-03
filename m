Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2149AC0015E
	for <cocci@archiver.kernel.org>; Thu,  3 Aug 2023 10:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=+rG4latJwMELrj7ZGEAtLWr6iCvb4MZc7mGfZ4XCHfk=;
  b=FSH03rx9aZvS7zM1wXkI6Oj5E67xVP0+DP87KmDCf5tFDxhFry2Y3dD9
   uQKXqocTCExIa+fSA2vVQccWB3Q6jiL86WLoBLU/4BoMQ05vnSfdEmZEY
   beaRGfw9SMkTIcdIBqeEEZZA+bJx5BCXaNaxOUjw6VPj4ctqexudzWJI+
   Y=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.01,251,1684792800"; 
   d="scan'208";a="120060533"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Aug 2023 12:12:50 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 533ABE0133; Thu,  3 Aug 2023 12:12:50 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4891EE0133
	for <cocci@sympa.inria.fr>; Thu,  3 Aug 2023 12:12:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+rG4latJwMELrj7ZGEAtLWr6iCvb4MZc7mGfZ4XCHfk=;
  b=gyKeA7un0LABCfqqUnTrm5xvPJ8+mULzv//YBpCtsjSdXzl5YM7pWMmR
   etJWLzJnermRZx+aKxBXSwS5oG591US0oePs/JunNWw376RdBG+FJwVYp
   TF3wvHs0wtEv4SFGeJJtVcHSQy9S9XVdJ5mraJU7HTkVAwDVsM+GiB/Et
   o=;
X-IronPort-AV: E=Sophos;i="6.01,251,1684792800"; 
   d="scan'208";a="120060530"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 12:12:49 +0200
Date: Thu, 3 Aug 2023 12:12:49 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Li Zetao <lizetao1@huawei.com>, cocci@inria.fr, 
    Nicolas Palix <nicolas.palix@imag.fr>
In-Reply-To: <81b8eea8-95be-4d22-9600-a24c12ceac4e@web.de>
Message-ID: <b21cb419-678e-b67d-23f2-c922b4a4f7a@inria.fr>
References: <44d5062c-f525-4994-a11c-57687c6597fe@web.de> <20230803094241.733300-1-lizetao1@huawei.com> <81b8eea8-95be-4d22-9600-a24c12ceac4e@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2082718788-1691057569=:3578"
Subject: Re: [cocci] [PATCH -next v2] coccinelle: platform_get_irq: Add
 dev_err_probe() check
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1226
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-08/b21cb419-678e-b67d-23f2-c922b4a4f7a%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2082718788-1691057569=:3578
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 3 Aug 2023, Markus Elfring wrote:

> …
> > ---
> > v1 -> v2: Modify the return statement for the adjusted SmPL
> > disjunctions in the patch operation mode
>
> Thanks that you would like to pick a part of my adjustment idea up.
>
>
> …
> > +++ b/scripts/coccinelle/api/platform_get_irq.cocci
> …
> > @@ -60,6 +70,17 @@ if ( \( ret < 0 \| ret <= 0 \) )
> …
> > +if ( \( ret < 0 \| ret <= 0 \) )
> > +(
> > +-dev_err_probe(...);
> > ++return ret;
> > +|
> > +return
> > +-	dev_err_probe(...);
> > ++	ret;
> > +)
>
> I tend to prefer a different SmPL coding style.
>
> * Thus I imagine that unneeded deletion and addition of code
>   (which affects also semicolons) should be avoided here.
>
> * Space characters should be preserved in the first text column.
>
>  if ( \( ret < 0 \| ret <= 0 \) )
> (
> -dev_err_probe(...)
> +return ret
>  ;
> |
>  return
> -       dev_err_probe(...)
> +       ret
>  ;
> )

I see no purpose to any of this.

julia
--8323329-2082718788-1691057569=:3578--
