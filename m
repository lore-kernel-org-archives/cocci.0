Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DE7C4332F
	for <cocci@archiver.kernel.org>; Tue, 27 Dec 2022 11:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=fbDuEclhbUSpZiJFnhFQKq7fs2reDAEBvERmqyYTs9Q=;
  b=BMOiwCCy4lMhWGzbVsJkCaEPiI+RyCfDRf7voD1y8vgAhPaH1+dvb9S1
   BZHOIZSZ84m5FSTP2WcHjV7Uoqdi0zjtMtthPGuHHl6P54P2gc9/sFLS0
   ZT30drXn4NPBo2m89bx/QT7GjsGo6gh3Ytot7oS6usyaX2rFaUwk40nEZ
   k=;
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
X-IronPort-AV: E=Sophos;i="5.96,278,1665439200"; 
   d="scan'208";a="85148372"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Dec 2022 12:26:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F09B6E0141; Tue, 27 Dec 2022 12:26:53 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A6B99E0128
	for <cocci@sympa.inria.fr>; Tue, 27 Dec 2022 12:26:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fbDuEclhbUSpZiJFnhFQKq7fs2reDAEBvERmqyYTs9Q=;
  b=UnXDBHNRO9vm7N7B0o0Z6X5caoJWsuXZQMOTQJDUv/t0VX+uggG4hjAA
   T9ZBEifuFF6b4qk2W6mN+Ydh0SLijdyFOwnW3JChAJkP/0MqTEj9wWnuc
   WDc2whMT1V/+d5Z/d4oTLou2gwWzMTYKegZ46PKYLR/ofCpIutxk+oc4x
   Y=;
X-IronPort-AV: E=Sophos;i="5.96,278,1665439200"; 
   d="scan'208";a="85148369"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 12:26:51 +0100
Date: Tue, 27 Dec 2022 12:26:50 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
cc: Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org, 
    kernel@pengutronix.de, cocci@inria.fr
In-Reply-To: <20221227095517.mzjmqse5wvaielev@pengutronix.de>
Message-ID: <e39bbae4-7929-b1b0-ea42-11825d98e43e@inria.fr>
References: <20221224115657.kqyocti356cwm7hc@pengutronix.de> <alpine.DEB.2.22.394.2212241326310.2711@hadrien> <20221225212011.6il5egocxtx5zupa@pengutronix.de> <be39f7d-31ab-24c-61c5-6daabdef9267@inria.fr> <20221227095517.mzjmqse5wvaielev@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] coccinelle: How to remove a return at the end of a void
 function?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 800
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/e39bbae4-7929-b1b0-ea42-11825d98e43e%40inria.fr>

> @p2@
> identifier pdev;
> @@
>  void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
>  ...
> -Return();
>  }

You need when any on the ... to allow there to be Returns();s along the
way.

julia
