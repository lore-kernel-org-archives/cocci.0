Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28557C83F1A
	for <cocci@archiver.kernel.org>; Mon, 14 Jul 2025 11:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=0kM/yftVl2JQcWpsNkhU4wNNNHSe9O4dIrUshRelmII=;
  b=q79xgkkvVDmElAtcPhCqYk2SGHwkzY0UHpwk/L/5L0XVNeJ5N/YixORd
   o3ZcWjbHTQbsKU5AVfFdVhq9r0fIq40Coc/xrgeIqvRUEjH2IQLEZvQ2/
   52S5kykpbRGBZ0OrJgtUalv5lOZYhKqv4PNZDJocbYIpI0v0sfmJakycP
   o=;
X-CSE-ConnectionGUID: WUuNdb4mS1K6lbKrzGnsMg==
X-CSE-MsgGUID: UmuZfuZATsiFS0FscYDFoQ==
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
X-IronPort-AV: E=Sophos;i="6.16,310,1744063200"; 
   d="scan'208";a="231561688"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Jul 2025 13:28:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A2A47E0CCF; Mon, 14 Jul 2025 13:28:31 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CE1D5E007A
	for <cocci@sympa.inria.fr>; Mon, 14 Jul 2025 13:28:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0kM/yftVl2JQcWpsNkhU4wNNNHSe9O4dIrUshRelmII=;
  b=U7KXf78QgWfASQy8gwgN1agAKgfaMcTNm95Gqeo5YbLCjq+c0j/RFxr0
   gKlWLPgsIOW+s4nb26S2Hf/AVUThiNiS4AFa5MDzklkUBtpnoAx9uvkxW
   2vFJulsrcMpRSw0kHpKk6Ik3JUsXG9N8ekzPbRs36ZcIIIlkbO2Bw1G1N
   8=;
X-CSE-ConnectionGUID: rCPkcDVjQ5+n8FLJMfUvJA==
X-CSE-MsgGUID: fANp4GvwSie/ZLzEDL2ZdQ==
X-IronPort-AV: E=Sophos;i="6.16,310,1744063200"; 
   d="scan'208";a="121336319"
Received: from unknown (HELO hadrien.lan) ([172.59.115.247])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 13:28:29 +0200
Date: Mon, 14 Jul 2025 07:28:26 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Yue Haibing <yuehaibing@huawei.com>, 
    Kuniyuki Iwashima <kuniyu@google.com>
In-Reply-To: <9305a7cb-f54f-4655-8802-be7475b6b3ee@web.de>
Message-ID: <9aaaaa9f-51d-7476-3032-3f76f9e7cc9@inria.fr>
References: <8b094c79-c6e5-4398-a2a9-37e9d46a46e8@web.de> <BBB485D5-F5B1-493D-BDD1-FF8A1FD38BF7@inria.fr> <9305a7cb-f54f-4655-8802-be7475b6b3ee@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-268322471-1752492509=:3306"
Subject: Re: [cocci] Deleting duplicate condition checks (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2870
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/9aaaaa9f-51d-7476-3032-3f76f9e7cc9%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-268322471-1752492509=:3306
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 14 Jul 2025, Markus Elfring wrote:

> >> // https://elixir.bootlin.com/linux/v6.16-rc5/source/net/ipv6/mcast.c#L786-L813
> >> @adjustment disable braces0@
> >> expression e;
> >> identifier i;
> >> @@
> >> void i(...)
> >> {
> >> ... when any
> >> if (
> >> +    !
> >>     e
> >>    )
> >> +   return;
> >> -   {
> >>    ... when any
> >
> > I have no idea what is the question here,
>
> Would you find any details improvable in the generated diff output?
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch …/Projekte/Coccinelle/janitor/delete_duplicate_condition_checks4.cocci net/ipv6/mcast.c
> …
> @@ -789,34 +789,31 @@ static void mld_del_delrec(struct inet6_
> …
>
>
> Examples:
> * Coding style preferences?
> …
> +       if (!pmc)
> +               return;
> +       if (pmc_prev)
> …
>
> * Indentation?
> …
> +               for_each_psf_mclock(im, psf)
> +                       psf->sf_crcount = idev->mc_qrv;
> +} else {
> +               im->mca_crcount = idev->mc_qrv;
>         }
> …
>

I still have no idea what the question is.  Please provide a single email
with both the semantic patch and a small C program thta illustrates
whatever you are concerned about.  This is the rule for all issues that
you want to raise.  Everything should be in one email and easily
reproducible,

julia


>
> > but the above when any is useless. Braces always match up properly.
>
> Will such information become relevant for a better software documentation?
>
> Regards,
> Markus
>
--8323329-268322471-1752492509=:3306--
