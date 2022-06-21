Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEE0CCA473
	for <cocci@archiver.kernel.org>; Tue, 21 Jun 2022 19:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=QebF9d7DxCMQwGIsaTCONnqAShxo/8N8hIDpNDCKAa0=;
  b=Pdm5yPSEM/dTi6zlJAb5YMhC9VVHwaXILXu2QLA9Kp/JKbCfB9hj9XqC
   GTbXSJpn8zugJMTLttA+ITMit3TgsszF5hrp617d4119SJtPT9p3IFOOR
   ZaFhuePz1OfFsTevITZgxh1genpy54YURKUZqLjyw0tbFM8Jg1d6Jxm0L
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
X-IronPort-AV: E=Sophos;i="5.92,210,1650924000"; 
   d="scan'208";a="42242723"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jun 2022 21:43:07 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3FDE9E0096; Tue, 21 Jun 2022 21:43:06 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 70C10E0094
	for <cocci@sympa.inria.fr>; Tue, 21 Jun 2022 21:43:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QebF9d7DxCMQwGIsaTCONnqAShxo/8N8hIDpNDCKAa0=;
  b=LMSQ4ISqaQbdcbHGIeeGWEC0FFjyYLPI9Oh+Xsmc23nKkyrcNqrP5/LT
   i60G6pikY+EqiB7aLPULYaqQxM6DbZeXjWJjpCLIGyncasCEiSxjCsAh9
   7uuoxCPIkBIoaCDj863oeciAi328pTRX35n5zQPkouZygUsxqGJh7oFEx
   k=;
X-IronPort-AV: E=Sophos;i="5.92,210,1650924000"; 
   d="scan'208";a="17426576"
Received: from 71-219-62-252.chvl.qwest.net (HELO hadrien.PK5001Z) ([71.219.62.252])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 21:42:59 +0200
Date: Tue, 21 Jun 2022 15:42:56 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: =?ISO-8859-15?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
cc: Markus Elfring <Markus.Elfring@web.de>, "cocci@inria.fr" <cocci@inria.fr>, 
    "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, 
    Nicolas Palix <nicolas.palix@imag.fr>
In-Reply-To: <AS8PR03MB7603675681B64E5F14C1995593B39@AS8PR03MB7603.eurprd03.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2206211542410.2194@hadrien>
References: <AS8PR03MB76033CF2848D03651D6E189093A69@AS8PR03MB7603.eurprd03.prod.outlook.com> <6aef3ee4-d934-daff-7145-73ac563d2fb4@web.de> <AS8PR03MB7603675681B64E5F14C1995593B39@AS8PR03MB7603.eurprd03.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-169498865-1655840580=:2194"
Subject: Re: [cocci] [PATCH v3] coccinelle: Extend address test from ifaddr
 to every test expression
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 449
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/alpine.DEB.2.22.394.2206211542410.2194%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-169498865-1655840580=:2194
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 8BIT



On Tue, 21 Jun 2022, Jérémy LEFAURE wrote:

> > It can be determined that the proposed approach for the detection of
> > questionable source code places is incomplete (also because of the current
> > development status for the Coccinelle software).
> > Thus I suggest to reconsider the usage of the word “every” for the patch message
> > once more.
>
> I'm not against changing the patch's subject. Would you find it better
> if it was "coccinelle: Extend address test from ifaddr to test
> expressions"?
>
> And what about you Julia?

The subject you propose is fine.

julia

>
> > Will further adjustments become helpful for desired source code analyses
> > and corresponding transformations?
>
> Do you mean adjustments in this semantic patch or in the coccinelle software?
>
>
> Thanks,
> Jérémy
--8323329-169498865-1655840580=:2194--
