Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10ECC433F5
	for <cocci@archiver.kernel.org>; Sat, 19 Mar 2022 17:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=6WMpW/skSCjhHLa4JlmBnKzq6GSUeeIM48mLoyiknUk=;
  b=nm2QvujtZkVE3VbEzO3Aw9FGMJO8sKob3al2nwlFVEpfU9OiCKaV8bxo
   y4Bus4t0hZGoAsOdXgHnAoiQMNgLzmfrRmTalFuG2kWF3jFjTSmbpn9Yc
   /avbd0kFWVS5NSZv6wNFw2xXcaR45OJ1VwpBpjefu+e8HljlbqkXeKKjE
   4=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="27014977"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2022 18:03:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CB8BBE020F; Sat, 19 Mar 2022 18:03:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 12DF1E0069
	for <cocci@sympa.inria.fr>; Sat, 19 Mar 2022 18:03:23 +0100 (CET)
IronPort-SDR: xa5qSO26wcgScKcm11mETuU/RgSUTwoyxTF2pdL66esP+86DjNziU1z5wJhh4TJ4WKQ1LqKLSL
 zHeK3b2DfFAvLv8SpOl7mDbtXLoHnko9it/s7ZAvaVYl134wYmdxbkA4evHgyNFmyJt/H+gik/
 kfS6DHnbv6aI0uBF6TscLgoev/Bo9T4ICKO1FhYVqVeuagljk/TucXkkLu/7uZx3n/u0I0Rhyi
 X7mEz4DeYiGZDGoNdmXbJEoGgoLrQ9NhEs/v1ZCFDTFR3ZFpGBcAusxbz5Rc96n0B7uG/tGOie
 NSEzIdJhSgQ5W0ZhYBSZnUsA
X-IPAS-Result: =?us-ascii?q?A0ByAwD0CzZi/0Xcza1agmOCKAd3VgEBASkEC0SEVI5zg?=
 =?us-ascii?q?XcxnGOBfAsBAwENNwoEAQGCEoJ1AoQ0Ah0GBjAJDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEDAQEFAQEBAgEBAgQEAYEILAFjAWcBgU4BgXkGBDANgjUpAYNjAQEBAQIBI?=
 =?us-ascii?q?1YQCxgqAgJXBoMXAYJ1IQ+sc3qBMYEBg08BhiuBPIoUhDUnHECBTYE8DIJHM?=
 =?us-ascii?q?D6CTBcBAQKEeIJlBJlJCRlvgSqhflSeFoNTiw+UTwYULpZJkXWWW40VmW01g?=
 =?us-ascii?q?QoiPIFZHxQaCCYKgyQJRQECAQIBDAECAgECAQIBAgEIAQECAZIOhRSFaiEBA?=
 =?us-ascii?q?QExCy0CBgEKAQEDCQGBVo13AQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:HxhOk63HV1M0IlhydfbD5fB3kn2cJEfYwER7XKvMYLTBsI5bp2MDz
 TdJDz/XbPyPYWukfdlyPouw/BlTvMLSzd9lTQs93Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOH9IQMcacUsxLbVYMpBwJ1FQyw4bVvqYy2YLjW1jU6
 IuoyyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt8xIk
 dMXnMXqdQcGMJTywuosdUJxCQgraMWq+JefSZS+mcmDiUDZc3bhx/h0Skc7IeX0+M4uXjoIr
 6RFbmpXNlbd1opaw5rjIgVors8kJ8LqFIceoW17izzGDfsrRZ3ZBaPH+be02R9q2ZgXQaeBP
 qL1bxJuUT/QeAVsH24JCasdxryBqmn1Qjdx/Qf9Sa0fuDSNl10ugNABKuH9cduBTsR9hVedv
 muA/mLjAxhcOsb39Nae2ne8wOLQnS72XI8IUru16paGnWF/2EQPMUQQD3Li+8W5pUCHZYhRG
 mpP0zAH+P1aGFOQcvHxWBixoXihtxEaWsZNH+BS1Dxh2pY48C7CWTdZFm8phMgO8Z5pFWZzh
 zdlivuwXWQ32IB5X05x4Vt9kN9fES0Fa2IdZSIJSQYfpd/uvOnfby4jrP44QMZZbfWvRVkcJ
 gxmSgBk393/auZSic2GEajv2W7Em3QwZlddC8W+djvNAvlFTICkfZe0zlPQ8OxNKo2UJnHY4
 iRbxpbGvbFVXcrc/MBofAnrNOr1jxpiGGaD6WOD4rF7qmrFF4CLIui8Hw2S1G8ybphfKGC5C
 KMikQ5O5JJeOHawbKl8JtroY/nGPoC7fekIl5n8MLJzX3SGXFTerX80OhLIgTyFfYpFufhXB
 Kp3uP2EVR4yYZmLBhLvLwvE+bN0lC04203JQpX3k0au3baEPS7HTbYeLEDIY/854a6ArR+T9
 dtDbpPYxxJaWez4Qy/W7Y9KdwxRdyBmXMyvppwFbPOHLypnBHolVa3bz4QhTJM5za5boeHFo
 yOmUUhCxVui23CecVeWampuYa/EVIpkqS5pJjQlOFulgiBxYYum4KoFWYEweL0rqL5qwfJuF
 qlXf8SbHu8JRyvH9jkZYIO7qoF+LUz5iQWLNiujQT4+Y585HVCSoIe5J1e2+XBXXCSttMY4r
 7mx7S/hQMIOF1Z4EcLbSPOz1Ffv73ITr+JFQBeaKNdkfkixopNhLDb8j6JpLphUewnD3DaTy
 y2fHQwc+bvWu4Yw/dTE2fKEooOuH7csF0ZWBTCGv7OmcyTF/meuxYJaFuCFYWmFBm/z/ayjY
 8RTzu39aadbxwwS7tMgSrs7n7gj49bPpqNBylo2Fnv8b2O0VuFqLE6A0JQdraZK3LJY5FW7A
 xrd5tlANLyVE8r5C1pNdhE9Z+GO2K1GgDXU9vhpckz26DUuoeiCQQNfIBmBhShQNv1zPZ98m
 bUtv8sf6gqejBs2M4/c0nsOrznVciUNA/c9q5UXII73kQ51mFtMVpzrFXOk6p+4bdgRYFIhJ
 SWZhfeciu0ElFbCaXc6CVPEwfFZ2cYVoBlPwVIPT7hTdgEpWhPjMNxtHTULosB9ywUB3v1zN
 2VvOlczI6iSl9utaA6vQEj0czytxjXAkqAy97fNvGnYVFWzEGHSLGAwPeuXukYU7wqwu9SdE
 K6wkA7YvPWDQC019i8zQlJ+7fH8TdF88gDY3saqA6xp2nX8jSXN2seTWIbDl/cr7Q7dSqEKS
 SmGMducsZHGCBM=
IronPort-HdrOrdr: A9a23:n38Bm61Nw20lLZChJgBmXwqjBLYkLtp133Aq2lEZdPU1SL3gqy
 jN9M516faaslgssR0b+OxofZPwJE80lqQFh7X5X43SODUO0VHAROoOgbcKgQeQfBEWndQtt5
 uIHZIfNDQuNzJHpMzxiTPIcOod/A==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="27014971"
X-MGA-submission: =?us-ascii?q?MDF6e+JemFrSAHaG69pEUoOxjKn/WoVzdwlouq?=
 =?us-ascii?q?Oe61/TAMXzevRVDwnHi+16XLhn3XK1t6oUAjk0HB77WLfJ6CkTA9is9F?=
 =?us-ascii?q?MNc1urNrtarlLQUarjs0M9Len9GlNwr+HC6MudkN0RiP+/UwI/rYAjf9?=
 =?us-ascii?q?1DXPLVAJQUq49jZOnNlkYSEw=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 18:03:22 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 33A5F81;
	Sat, 19 Mar 2022 10:03:20 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id hidX74sU91vQ; Sat, 19 Mar 2022 10:03:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id CBE1C40;
	Sat, 19 Mar 2022 10:03:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net CBE1C40
Date: Sat, 19 Mar 2022 10:03:13 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <47febea2-a444-5e8d-f1c9-faa973371912@web.de>
Message-ID: <2c672239-1820-fb38-a378-43fd7d11c5ae@ewheeler.net>
References: <a2422ea-5dd9-753-cf9b-97439e7db462@ewheeler.net> <75237f17-66ae-21c3-8796-c656315d99d0@ewheeler.net> <db684d7-8b40-d3be-969f-cb399e39d4c3@ewheeler.net> <47febea2-a444-5e8d-f1c9-faa973371912@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-762498738-1647709395=:28642"
Subject: Re: [cocci] Improving the implementation of the software
 =?UTF-8?Q?=E2=80=9CXnec2c=E2=80=9D?=
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 247
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/2c672239-1820-fb38-a378-43fd7d11c5ae%40ewheeler.net>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-762498738-1647709395=:28642
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 19 Mar 2022, Markus Elfring wrote:
> > We are working to make the xnec2c EM simulator thread safe
> > (www.xnec2c.org) but we need to figure out what is being modified between
> > frequency loops to isolate the data.
> …
> > src/common.h and src/shared.c are in the xnec2c codebase if you're curious:
> > 	https://github.com/KJ7LNW/xnec2c/tree/master/src
> 
> 
> I suggest to increase the usage of advanced static source code analysis and transformation tools
> so that remaining open issues will be improved also for this software.
> 
> Example:
> Would you like to fix signal handling here?
> https://github.com/KJ7LNW/xnec2c/blob/956d33d923849a4f80ec47fb8afb90258e83cf24/src/main.c#L521

I'm sure there are many places that the code could be cleaned up.  I'm 
open to patches and PR's if you'd like to help on the project.


--
Eric Wheeler


> 
> Regards,
> Markus
> 
> 
--8323328-762498738-1647709395=:28642--
