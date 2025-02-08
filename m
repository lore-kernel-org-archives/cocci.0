Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3F2C02198
	for <cocci@archiver.kernel.org>; Sat,  8 Feb 2025 12:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=jvgaFKe+5L+Qnvf+K4YVE+QX45AM9c5p4DW1NdzxltE=;
  b=L75Wcr+dl05In/kjAWU8ZVDwx2gLJNgc6HEPKbZDmNNDreQ1AB0IdOHV
   KnHa0jYux1GbTeFm921OqbTx0c77jxcB7lX34PJVFZfkETuIMbhaa2s4b
   xUnzJlW03DW3fdwMOOwai+9UKSl9+ZWQoovu5C6OvFhbYq1S/7yngQIqd
   o=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,270,1732575600"; 
   d="scan'208";a="207286287"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Feb 2025 13:51:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 46EA1E0261; Sat,  8 Feb 2025 13:51:29 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B89DEE0260
	for <cocci@sympa.inria.fr>; Sat,  8 Feb 2025 13:51:27 +0100 (CET)
IronPort-SDR: 67a7534f_ZnxvK48r+GIkWpkwqydUi3xeJ7xVBI19gPLvMxq+yaWuCzW
 CwdjvfgMZZFLqqtuObYWdUiltLkt3ivy/JsbbPw==
X-IPAS-Result: =?us-ascii?q?A0E2BAADUqdng07ASNlaHgEBCxIMQIFIC4JEYhtaMwQLS?=
 =?us-ascii?q?AiETo9PgXQwhDuPDoh1gVaBfg8BAwENOwYBAgQBAQMEhQACiwQCHgcBBDIHD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBOgcOO4V7DYJiA?=
 =?us-ascii?q?YEkgSYBAQEBAQEBAQEBAQEdAg06RAEBAQIBIx0BAREmAQQLCxoCJgICVgYBF?=
 =?us-ascii?q?AEBgn4Bgi8BAw4jBw0GsCWBMoEBggwBAQbaXB8sIleBZQMGgRouhWyCYwGGJ?=
 =?us-ascii?q?oNCeicPgVVEgTyDAz6BD4FSBIFeg1uCaYIzhEhniWqIbIgAiTBSexwDWSwBV?=
 =?us-ascii?q?RMXCwcFgSlIAyo2MSOBIwU1QTqCDWlJOgINAjWCHiRYgitqBAWBLYI5hEOET?=
 =?us-ascii?q?YVagTpYgWADAxYQAYIxcHgcg1V5HUACAQttPTcJCxsGPZ58PYQVgRUsyFc0B?=
 =?us-ascii?q?4I4gWaBYwyKKZUzBhMvg3ABk1IOBpJ7mHwijWKbKoFuAzCBXDMaJIM2TwMZD?=
 =?us-ascii?q?44hGYNhM8VAQjUCAQE4AgcBCgEBAwmFRgEBiniBSwEB?=
IronPort-PHdr: A9a23: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
 NwRR7UdWFFnTpvy5Wx6EdZELJolB1sZ
IronPort-Data: A9a23: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
 lTZiYyJrI9XhKIx/Qtdl6ZpJSwk
IronPort-HdrOrdr: A9a23:sFPzK6r1M3aT/zfiov4vctAaV5qIeYIsimQD101hICG9vPb4qy
 nIpoV86faUskd3ZJhEo7q90ca7LE80maQY3WBVB8bAYOEJ0FHYUL2KrrGSvgEJIkXFh5FgPN
 5bAtZD4YTLfClHZKTBgDVQYuxQpOVvq5rY/Ns2pk0FJWpXguNbnmVE42CgfXGeLzM2YKbReq
 Dz2iNvnUvRRV0nKuq6G1gYVKz5q9XQkpWOW299OzcXrCePkBK14/rAHxKZxxcTVC4n+8ZYzU
 H11yL4+4S+uLWBxhXdzm/e6IkTsNbt0ddYHqW3+7ooAwSppAa0RZhrH4ePuz04u4iUmS4Xud
 TBuQohOMxv63XXZAiO0GjQ5zU=
X-Talos-CUID: 9a23:56BsUW4JWFLFIZxfbdss5mwURvE9V0bmx1D0GE6jImpiSrmyVgrF
X-Talos-MUID: 9a23:IotqCwgaKO/PlizpivHJcMMpF+0v256WURg2yrINmfHdaw12PhGcg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,270,1732575600"; 
   d="scan'208";a="207286285"
X-MGA-submission: =?us-ascii?q?MDHMk60UWJCRxypht/noJo+wo9MVe6OIPIeiDN?=
 =?us-ascii?q?bXcMnq6uYl73J4IIEKBzFV3aLZGbMQICp7BniIduTF8g94d2h+lm+rTq?=
 =?us-ascii?q?GEN/Fq5DE3j8kQDn2TuSJvhpw9MsrX7vLeejQznM6xF2hmxKHZnfNQBs?=
 =?us-ascii?q?jj6ElMT4jsEx8EpEuSswMjLw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2025 13:51:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739019085; x=1739623885; i=markus.elfring@web.de;
	bh=jvgaFKe+5L+Qnvf+K4YVE+QX45AM9c5p4DW1NdzxltE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UmHbuqdG6acu+OfhnrYboJ046H+4Yci4pn5q20kYMmkRVjrElQSen/AHtWT6PRsG
	 ko0cK3N0MdbplhaZsfYOySRTtVBDNJMm0TfuvwgmXm0SjQ0l+/EUyBWVYFDN/PMcp
	 0QJxU2QB6jjlBtmWeQYFXfkOdeshCfvs/YD2C7EoiqM9Mc+pCOkHfvURfmj/OC0+E
	 qEKE8A6YyjaPWu3JBIxDwfeOnYkutwKEB279QEm88mkVjCNW0xxKUtrl7ScUZ2RSK
	 Bha4bpgL8kNWBAyAWQOwx/+oVYZEkx/JtvuPFOvRuoUWPHJ4bjCB+Spu2HuFn5l9j
	 aQMVUWY+QKYRyXMC7A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.11]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJFhJ-1tzejO0BTP-00T3i4; Sat, 08
 Feb 2025 13:51:25 +0100
Message-ID: <f5e79928-d377-4b6a-adf3-6b79aa9d5ffe@web.de>
Date: Sat, 8 Feb 2025 13:51:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Johannes Berg <johannes@sipsolutions.net>
References: <381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net>
 <061f1b6b50d305671c02742382a3df0ff95f9c6b.camel@sipsolutions.net>
 <ca7c1a14-522a-9c2c-4f85-2fda289b83e8@inria.fr>
 <9063a6e6c83f9169456bc009cc35426889cc46e1.camel@sipsolutions.net>
 <6bbdaca7-2fa0-4bdf-bdc7-ba76a5a1d171@web.de>
 <alpine.DEB.2.22.394.2502081257090.15422@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2502081257090.15422@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nESlipVbkXrc4uI8S+7/irOHFgonkUWDYEc4PJ1y03CFTrI5AVf
 /mleH/5TFC5ppluwMVqzwmZ9qvSuEIiVuysvZZEPm7q8vLzlYEyDws1fHRarWzPhwjScGAc
 C7CvFjdgE4VoJ7p/yC04fW4BHWngrx0k3Q0ylVAIF9r8o381Doia6Gpflvcm1lA4GEnMxC4
 A/kEwSaUwvNbE2MOUjunA==
UI-OutboundReport: notjunk:1;M01:P0:e4+2RHbe2NY=;7iBBY9jTFZ0yFcDpJrqCQDucwox
 3RPU/G6+az2trAFj5Ww9FIW+y/FZ7blz7SV8D0S/wFPmRrGTXHb7jg6gLReRkBQDFMYn/WHuZ
 7gd+mbi4RqlsTt3ksjYwYo20bBJZ29J/SGxONy6koJ0QuVRxifXYXhcFQzRGOlzdx0kohRLmq
 oNGUBaqTdzFbCxEh0PHQNYJua1icK+Q2NURSrsdzIzNjuBXKdnsABXODEPVZbMJ7b4tgY5nGa
 0n3LGVEGdsRd9Kgp3uxJ8qcs485isyyfWieSKyyWjwzceDowhbFRGibpOkNbtPV3w89OmltTL
 YAmHijsZtZPsTiqS3mO6B8WkIPQvgUwoK6v4sf/V4yjwcgIzTB9korfrJO4pxTxL/WtZNLdxr
 ONYjCdvlcQ8Hbda293XDrKc6bIF9SImjoH4+TF7IcW7olgJR4I62E1NLPEuVZOK25It47hpOV
 GXwSTTkaMmYBcX8dgZVv62rErtMWnPHJND6X4qfJwryQWXbkUSfkx1k6YHS5I/GpFf4oUbA1h
 0H38rkPIJ9mFQj6kbJPoFsnIiJSOxsfoOPZGFEraZEZyko0I3HrEdh61E66QOHyO4hb3797/r
 esrwP1BGvuV8sG5rhvh0QELxpBhzVy9t5imwKFO4QQsmKUK2yBxwDcM7muRGRxfiqd3GHA9q0
 Mh4Qo/ip1++4LolwOA27aiJpvzH5+CJjFk+GwCUHvmqiu3JI6GY1ROGOF8MjnDFe/Okxk//CQ
 xPCxELKtB0UhFHI8SnTkFEeN6g4emDGbyCmaiorgwYqvAmxPD66+w16QfifouNiPiw3XStiuN
 pcv0aK6yDUOTov5tk1bnZ2pTOUszsWouUS97i/gFWIfaHNw+vkUlpuTmk06IqD2Hp1ylKbml3
 oUc2fLr8K3xY4sjRc7glhFiFVDt+NKK5AVl8NQGOztKGzOnASXWTwvbh+KOJKbHdC3cBpX5ww
 5R6OCZ8FJ0cCqJalkP9EwElIHL44I4Mqv+l7xuhgsibZIr6LnR0qSvqjxH4RUx0maUD2Ub1Ll
 aIkI1VGG2HO5odrVBOIN7e82B2Z4R/uZICyAACgIs3rtcqgoeFdIlEmYoaM11ZXyqfPAs38cP
 35lUV+0IDmKwawb/XaQoCxARkpyTg7dBA1aD0iNdFZYKRd/VV0vnICmvszQKY97f5YUjzcZVr
 U3Wlqv4QdWYeOYqhCoBLbn5UjoY8bu69Y/E/StxjmPWAysgxn/oby/y4QqyUCw7CffhtKzoR1
 iBYHTQLEvWhjCvkRAjDL6K0R0M37n6744oYp5FeiAeKqk5Iv9fxe5v7/aDOHxLUdsXYwxCX+4
 A9f75IND4qlnLV/KYG2Irg3JteCKZ+bNMvymrUEBODWsyhIa54Am3CpSLg6wp3TAkCZLiyvm4
 CGk8vtZOG6BNBuhFsqCMy5ZmTLAe/CtwBQDL4hdjab9hpW3FV6bJFV0Bkn62A+DRKNcN61mfr
 pkVyNLO6oWBV5DSW0q9xe3s+TZdQ=
Subject: Re: [cocci] Checking SmPL test cases?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2373
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/f5e79928-d377-4b6a-adf3-6b79aa9d5ffe%40web.de>

> The matched if doesn't occur on every control-flow path.
Is this also the case according to the source file/header example =E2=80=
=9Cextract-ieee80211_get_mbssid_beacon_len-20250206.h=E2=80=9D
(despite of the discussed difference output)?
https://elixir.bootlin.com/linux/v6.13.1/source/net/mac80211/ieee80211_i.h=
#L1210-L1240

Regards,
Markus
