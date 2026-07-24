Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA21C531FC
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/cbDgo598TG5qpJ+4KpyIoA1nOSul4eORvYLw5ziO6o=;
  b=dthulzwLp/L24f/Se/54iOTjR1Xt1nBQ8fjFu2jz8M+TUb2mDwWZUpbk
   BU8tEU2QI6O6o1ox4PkHkWIvlqo0gIt/7KwSvs7AiGa56fl1i0kJ1T6NW
   JjiCE1x6Md5SmxCHU/TXtdvF9mZZTngyCGYhOLq8v57nZSrtmalanD1td
   M=;
X-CSE-ConnectionGUID: RUy2ejedQn2qAJ3b8cLD6Q==
X-CSE-MsgGUID: tmQUcCH+SIygiKHmacx/Zg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287734711"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:55:02 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id C8570804CC; Fri, 24 Jul 2026 10:55:01 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id C64A28003A
	for <cocci@sympa.inria.fr>; Fri, 24 Jul 2026 02:37:42 +0200 (CEST)
X-CSE-ConnectionGUID: nIl9TEF2S2S1OvbSTT3whA==
X-CSE-MsgGUID: KmFMDsoMRA6o1rOAoAdTUg==
IronPort-SDR: 6a62b3d6_e4LSiFWQI0efjwDgE23j7RaRPRAKsixV1PLo/bScqyUE0dY
 PQtDqStYngPOHE3rqo2+fgdpaZ1tbVGuanS7tMw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EpAAB+smJqeUh+S9NaHQEBAQEJARIBBQUBgX0HAQsBg?=
 =?us-ascii?q?W1TgWkzBAtJHY01iHyLZIYzii+BVYF8Ag8BAwELAQFRBAEBAQIEhH4CjWEfB?=
 =?us-ascii?q?wEEMQgOAQIEAwIDAQEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBQ?=
 =?us-ascii?q?g47hk8NgmIBgSSBJgEBAQEBAQEBAQEBAR0CQSoBAR0BAQEBAzoGAQE3AQ8CA?=
 =?us-ascii?q?QgYHhAgESUCBAENBQiFHQcRAzcCAsJreIE0gQGCDAEBBtsyDYJbCRWBOAGIO?=
 =?us-ascii?q?yABhXc7g0d6QoINhEA+gh+IaYImgQySLiwmeBwDWSwBDxE1ExcLBwWBIxAzA?=
 =?us-ascii?q?yAKLy0CFA0iDxoFLR1wDCcSDx0XFh5YGwcFEiAqQUUjAxQtJhA4C0MFgVYCg?=
 =?us-ascii?q?Xg/Ix8DOX+BL3VKdy1pAQIQF0o4JINJAoE3AwsHZj03Bg4ZBAIBgTWNZiOCQ?=
 =?us-ascii?q?YIJgS3GQ3GEJ5tfhgQuF6psmQgjkXCXBQIEAgQFAhiBaQE4gVxNIxWDIlADF?=
 =?us-ascii?q?wIPjiGEAspBRDU+AQcCBw8CgXOQNC6BHgEB?=
IronPort-PHdr: A9a23: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
 1Tqc9RrYmUFU+YnobRh8UZvYoy9
IronPort-Data: A9a23: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
 b8biodDD616GpDehEfxh+8UvA==
IronPort-HdrOrdr: A9a23:V+qEnq5TdbU4e7XAaQPXwKnXdLJyesId70hD6qkRc3Fom6Oj5q
 OTdZgguyMc6wx8ZJhfo7C90cC7KBu2n6KdirN/AV7NZmjbhFc=
X-Talos-CUID: =?us-ascii?q?9a23=3Az1A1LmoqFOeBIZ1KPrUvh7TmUcYEdizh4VmKGBW?=
 =?us-ascii?q?DUEF3QoapdQSP+Ioxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AQztfLg/ayEJp6dNzVeHDnhuQf+RtzYGCE0coq7x?=
 =?us-ascii?q?YvJCeEgV3EjuhsTviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="152827587"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFm2whx/VrNCKrKf1b2oJxL6q70iPJxjr4I+K?=
 =?us-ascii?q?8clmYBxTEEPYMmCWY7nTXoY0yntXgrI/pYEcYObd+4PKG0v971t1mapM?=
 =?us-ascii?q?XcyZjVW74fGJvpaZ/rB1nupRcZvJm6j+1aYM9HNMEiiGM30nneKQZFdV?=
 =?us-ascii?q?UkrRKUH5pedB5b2udKgtmKkA=3D=3D?=
Received: from rtits2.realtek.com (HELO rtits2.realtek.com.tw) ([211.75.126.72])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 02:37:40 +0200
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66O0bT9S1826679, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66O0bT9S1826679
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 Jul 2026 08:37:29 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 24 Jul 2026 08:37:29 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Fri, 24 Jul 2026 08:37:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>, "Julia.Lawall@inria.fr"
	<Julia.Lawall@inria.fr>, Miri Korenblit <miriam.rachel.korenblit@intel.com>
CC: "cocci@inria.fr" <cocci@inria.fr>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Thread-Topic: [PATCH 10/36] wifi: remove conditional return with no effect
Thread-Index: AQHdGtORMhfc1QA3FUeQ8RJ/kmVgbrZ70qMQ
Date: Fri, 24 Jul 2026 00:37:29 +0000
Message-ID: <3c36ea4acf0545a28f8c64dd49539cc6@realtek.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <20260723184538.3888637-11-ekffu200098@gmail.com>
In-Reply-To: <20260723184538.3888637-11-ekffu200098@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.6.42]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Validation-by: victor.gambier@inria.fr
Subject: RE: [cocci] [PATCH 10/36] wifi: remove conditional return with no
 effect
Reply-To: Ping-Ke Shih <pkshih@realtek.com>
X-Loop: cocci@inria.fr
X-Sequence: 3641
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/Mf_sBPmyCsmxqwUQNuXiPg>

Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
> Both branches of the check return the same value, so the check has
> no effect. Remove it and return the value directly.
>=20
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
>=20
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  drivers/net/wireless/ath/ath6kl/init.c              | 6 +-----
>  drivers/net/wireless/intel/iwlwifi/mvm/link.c       | 6 +-----
>  drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c | 7 +------
>  drivers/net/wireless/realtek/rtw89/mac.c            | 6 +-----
>  drivers/net/wireless/realtek/rtw89/mac_be.c         | 6 +-----

Can you split into four patches for ath6k, iwlwifi, rtlwifi and rtw89?
Then we can apply the patch to individual tree.=20

Ping-Ke

