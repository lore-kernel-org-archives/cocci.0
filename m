Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E0DC433FE
	for <cocci@archiver.kernel.org>; Tue,  8 Nov 2022 05:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=lsrFGeuHZ9wh8asjvxV7/MIVVp+g7KTY9yxrdvD0P6c=;
  b=FtxbA5fBdzZIKS3n7uIa+LeuzXRBpUkGUWfZxvpx7syrU1t6MVozcZ+f
   G59Rdhi6Oo+ZodgjUOp2su+IOVA/dcDIjv+gkv1sDhN6Gh5ljXum9hm0k
   bDP+UGpxvudKJq9ClYvT4t33WXe47Ssbdnvzcg6x18EMM++1xLU0DdnlO
   Q=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.96,145,1665439200"; 
   d="scan'208";a="77134486"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Nov 2022 06:51:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3E13AE0236; Tue,  8 Nov 2022 06:51:55 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 66897E0076
	for <cocci@sympa.inria.fr>; Tue,  8 Nov 2022 06:51:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   subject:mime-version:content-transfer-encoding;
  bh=lsrFGeuHZ9wh8asjvxV7/MIVVp+g7KTY9yxrdvD0P6c=;
  b=UWLpBxlDy/VnAHHLh1j7OGv93INeQFb4X2fth/yxf6QW/qB4xy02eUmw
   qHlEzYkmm9meSFlp7ymIezuH6ykcq4B6zaQ5ZNSz3oMF0X/EmzjCUcFOt
   ECOJwaH7JXu2Mr3mvs9oQLZhiRyF442P/iiESZjTcsj2hvRtz7+ZUlQyn
   M=;
X-IronPort-AV: E=Sophos;i="5.96,145,1665439200"; 
   d="scan'208";a="77134485"
X-MGA-submission: =?us-ascii?q?MDEs0A+XODSBwig36FY8W1LHf9eQB1swn5ImB2?=
 =?us-ascii?q?RJVGBYwaOpOX5VeMpKjrHc00AoyGbu3XqmnQSTYBPYnZrEn/sj4nrnsV?=
 =?us-ascii?q?OS4cDKK44TcnrkpMcOfEy0MDS92UrHy8Z3joTvvnC8mrytnfaRRWEz41?=
 =?us-ascii?q?rvLlpTwYsyE/jUq56bqOVtow=3D=3D?=
Received: from zcs-store9.inria.fr ([128.93.142.36])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Nov 2022 06:51:53 +0100
Date: Tue, 8 Nov 2022 06:51:53 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr, 
	kernel-janitors <kernel-janitors@vger.kernel.org>, 
	nicolas palix <nicolas.palix@imag.fr>, 
	linux-kernel <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
Message-ID: <257596884.6156222.1667886713273.JavaMail.zimbra@inria.fr>
In-Reply-To: <20221107200815.u7hcwejileeabnct@pengutronix.de>
References: <20221107114702.15706-1-u.kleine-koenig@pengutronix.de> <bd13da2d-6d18-4f33-0987-a193e3c9b761@web.de> <20221107200815.u7hcwejileeabnct@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [122.11.248.245]
X-Mailer: Zimbra 8.8.15_GA_4464 (ZimbraWebClient - FF106 (Linux)/8.8.15_GA_4468)
Thread-Topic: coccinelle: api: Don't use devm_platform_get_and_ioremap_resource with res==NULL
Thread-Index: SY9eA2PxzCVONI9yuvNaH3ovzzKcCw==
Subject: Re: [cocci] [PATCH] coccinelle: api: Don't use
 devm_platform_get_and_ioremap_resource with res==NULL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 721
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/257596884.6156222.1667886713273.JavaMail.zimbra%40inria.fr>


> After uninstalling python2 this ends in:
> 
>	Cannot find Python library
>	coccicheck failed
>	make: *** [Makefile:2076: coccicheck] Error 255
> 
> Didn't try to debug that any further. Is that worth a bug report against
> coccinelle (which is shipped by my distribution)?
> 
> I tried to adapt the org and report modes from other patches in the same
> directory. So a critical glimpse by someone more knowledgable than me is
> recommended. However I don't know how to react to "I doubt ... is
> appropriate", I'd need a more constructive feedback to act on.

I'm not a python expert, so I'm not sure what to do about this python2 vs python3 problem.  Is there some strategy for printing that works in both of them?

julia
