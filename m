Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDEEC001E0
	for <cocci@archiver.kernel.org>; Tue,  1 Aug 2023 15:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=0T1zzFhla6OwY5HQwHM28kuy+/OExNTih16K2tgb4SM=;
  b=No5hkaoYG0BgL45Q0w/WlDf5o75gYaGXLuSxP5vuomozyt54qOJW/0uB
   E61WbyUdkjIpDMaIPlXGKfE40r/BgYSTACIJMBG3LZ4ozMzfw0o8Ytlaq
   SPPlexrgk1Ab+hwok/9CwZ9UtaG9cQb3302Hvn5BPE1Hrd0GhYvrhtkCF
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.01,247,1684792800"; 
   d="scan'208";a="119845739"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Aug 2023 17:32:12 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3FD51E013D; Tue,  1 Aug 2023 17:32:11 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C27D5E004E
	for <cocci@sympa.inria.fr>; Tue,  1 Aug 2023 17:32:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0T1zzFhla6OwY5HQwHM28kuy+/OExNTih16K2tgb4SM=;
  b=dtGdxQWFBXTLjDz1edxJyyjfSrJ4vyL1WXd3Uk2icRHg+L8Z4+kLLHb7
   NNj9cBCl/JPOTlkmOQPaSZNdHEqfAKg4/8Ik1AuOQiFRqdIObc7AHRNwu
   PBPwPnBjHFAH4VM6joNiZj2sDjZlf6M7wVClJz1PqnDU0Tn1CjWYFfp0c
   A=;
X-IronPort-AV: E=Sophos;i="6.01,247,1684792800"; 
   d="scan'208";a="119845711"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 17:32:06 +0200
Date: Tue, 1 Aug 2023 17:32:05 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Li Zetao <lizetao1@huawei.com>, cocci@inria.fr, 
    Nicolas Palix <nicolas.palix@imag.fr>
In-Reply-To: <526c2701-9659-85a4-aa10-4ce2bb499b18@web.de>
Message-ID: <a22f1cd0-9a9c-7ef6-f36d-a04119591d2b@inria.fr>
References: <20230801094337.4145806-1-lizetao1@huawei.com> <526c2701-9659-85a4-aa10-4ce2bb499b18@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2074033586-1690903925=:3628"
Subject: Re: [cocci] [PATCH -next] coccinelle: platform_get_irq: Add
 dev_err_probe() check
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1220
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-08/a22f1cd0-9a9c-7ef6-f36d-a04119591d2b%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2074033586-1690903925=:3628
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 1 Aug 2023, Markus Elfring wrote:

> …
> > +++ b/scripts/coccinelle/api/platform_get_irq.cocci
> …
> > @@ -60,6 +70,16 @@ if ( \( ret < 0 \| ret <= 0 \) )
> …
> > +if ( \( ret < 0 \| ret <= 0 \) )
> > +(
> > +-dev_err_probe(...);
> > ++return ret;
> > +|
> > +-return dev_err_probe(...);
> > ++return ret;
> > +)
> > +)
>
> How do you think about to use the following code variant
> for the adjusted SmPL disjunctions in the patch operation mode?
>
>  if ( \( ret < 0 \| ret <= 0 \) )
> (
> -dev_err_probe(...)
> |
> -return dev_err_probe(...)
> )
> +return ret
>  ;

If this style works here, it doesn't always work, so it is not desirable
to put it in the Linux kernel.

julia
--8323329-2074033586-1690903925=:3628--
