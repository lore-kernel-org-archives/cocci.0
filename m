Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077C3C07E9D
	for <cocci@archiver.kernel.org>; Mon, 26 Sep 2022 07:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:message-id:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=uowubGJhCWa53sse25ojZ4XW90goZPgJXXAJrFpAyY0=;
  b=HkxgkgaGWpftC56a8Ct5Gpt587u/jPlncrVSo9ZnMMqGzWiX542+crUt
   tW24ZM2/3sAcqETiN7N5RdrASz7HELYgi0QhnqNZ6x7MfOHE3RoOqNBcQ
   x4/AZRwIib4BjbuaiBfFnXAURP4wf/B7zVs6xWrXqCkGJWDyKoV0Jjco6
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.93,345,1654552800"; 
   d="scan'208";a="54451301"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Sep 2022 09:36:51 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8B7F0E0090; Mon, 26 Sep 2022 09:36:51 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2ABC1E0090
	for <cocci@sympa.inria.fr>; Mon, 26 Sep 2022 09:36:47 +0200 (CEST)
IronPort-SDR: 6331568e_ScFAbSx4QhUrWOl32j+ngKqoA3pBIPGmW4FnnU5g92vFUgv
 Jimm17hZlD0HsC8CqlieP1KdZwnUN/ou0YQUdCA==
X-IPAS-Result: =?us-ascii?q?A0B3BQDvVTFjhwMP49RagQmDc4FXLgQLRYROkG6LZ4clj?=
 =?us-ascii?q?CsLAQMBDT8BAgQBAYUFAoRsAh0HAQQ0EwECBAEBAQEDAgMBAQEBAQEDAQEFA?=
 =?us-ascii?q?QEBAgEBAgQEARMBAQEZCRcHDgULBSKFaA2CNSkBg2QDAyMdAQERJgEPBQYaA?=
 =?us-ascii?q?iYCAlcqgmyCbQEDMAepToEygQGCCAEBBoROHywiUoFcCYERLIcViBp6JxCBV?=
 =?us-ascii?q?USBSIJHMD6ERE2DCYJmlQGEJDgDRB1BA001GAMUAwUkBwMZDyMNDQQWBwwDA?=
 =?us-ascii?q?wUlAwICGwcCAgMCBhMFAgJNNggECAQrJA8FAgcvBQQvAh4EBQYRCAIWAgYEB?=
 =?us-ascii?q?AQEFQIQCAIIJhcHEzMZAQUyJxAJIRwOGg0FBhMDIG8FRA8oMWsrHRsKgQwqK?=
 =?us-ascii?q?BUDBAQDAgYTAwMiAhAqMRQEKRMSLQcrcwkCAyJnBQMDBCgsAwlABygmPAdYO?=
 =?us-ascii?q?gEEAwIQIj0GAwkDAiSBUTkoBQMNGSYIBSMXHgQIPAIFBlcTAgoSAxOaaINgw?=
 =?us-ascii?q?Xc0B4IYgUSBSQyecjMDg1CTEQaSCZcLp2mBeCOBWzMaJIM2TgMZD445hAyKL?=
 =?us-ascii?q?T80OwIGCwEBAwmFRwEBhQ0BAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:FE9nvqpW0qlKsCZnMDqUD3UaV5rpeYIsimQD101hICG9vPb5qy
 nIpoVl6faUskdyZJhEo7u90ca7MBbhHPJOj7X5HI3SODUO/VHYSr2KjrGP/9SDIULDH4dmvM
 8MT0E9MqyIMbC+5vyKhzVQeOxQo+VvnprIuQ6k9QYXcelwAZsQlTuR5zzrb3FedU17Jd4cGI
 CH7sRK4wexYHh/VLXCOpE9NdKz2+EiH//dCyI7Ow==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,345,1654552800"; 
   d="scan'208";a="24653677"
X-MGA-submission: =?us-ascii?q?MDEBOXiFZZRsy9Y0RPxQRtBus/+LSbwxqbi+Bg?=
 =?us-ascii?q?lPBxRvAK2fUgUsWcMtA6soy7fXc6w/biG5MyHuDC2mZ3DHxaddcljeBC?=
 =?us-ascii?q?7T0asNmusB6PmaPsVqvPzy0Yh+BgiTrWXFI1uzRcn1Ja2UApvpy3tK1+?=
 =?us-ascii?q?UTEpNy1eeUPPbeFNm89HRTsw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 09:36:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1664177792; bh=rCJSH+f1ZesMSijFe3Gr98WlRwNm/lNyyPwt05fbdhc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YFu8GdJFF4XNXsIjpHBqz03PQICRVTyASsgP145C1pN8vhLy/ATmHUK4cckYNKd30
	 zltT00JCmF8ICdS4l/haJUw+WAarj1PIzVDqT/LXAjBR6449DmruvRqB8TjBF+oVUj
	 KtlOr1DSsxdvOvQc0xJzTaXW6asK5+EK7y/2/uxS13dFDr96do3jt5vhvh/Lx6iBRV
	 oeNF6CAAJ+NYTrqdV0xr6Bn583P5dVARpvp+qJf44jg6yX/R78gYrooMCwYuudxh7h
	 rJrNix6pl+S7/pHYeNGCfIfPCzByK9CxxEaTqq0uX++BS+pKVh1qgmnaxFyiuFYqem
	 kS1WWsFyrS4xw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [212.144.252.253] ([212.144.252.253]) by web-mail.web.de
 (3c-app-webde-bs29.server.lan [172.19.170.29]) (via HTTP); Mon, 26 Sep 2022
 09:36:32 +0200
MIME-Version: 1.0
Message-ID: <trinity-bcb29359-5c27-4c34-95f6-f5827e936702-1664177792747@3c-app-webde-bs29>
From: Markus Elfring <Markus.Elfring@web.de>
To: julia.lawall@inria.fr
Cc: Yuan Can <yuancan@huawei.com>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Sep 2022 09:36:32 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <alpine.DEB.2.22.394.2209251906090.3293@hadrien>
References: <alpine.DEB.2.22.394.2209251906090.3293@hadrien>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:G1qE1PivTUw7UZwW916ADWXkvCW40gXaJ8y1cnWlFjVCTQ8W7Y80Jswe+A9LThk67SIYk
 YfeP6r6HMo34TBPvdLUDFJU28BPwsqXROn7rZ06r4J2x3Ui+biI+3yxqLJHempbUqu3zWicSqac+
 RHGB9GujO/pbHZIpm37DKWfx8Y6O0cgo8ZHXdIGVQ0L//xH4zID5vvctulNL0/b/31H3nnXsT5Cc
 vB2HXygoTIsZ2VEaBW6wZk2p5zk4NnyIlF4Bd8ArhRwJQh7q3BhV+agbio0rAMBj8oZIxUfgiad3
 C4=
X-UI-Out-Filterresults: notjunk:1;V03:K0:Pfn2s6z7CDo=:5ugCaIYV38rXnZJfTdONih
 6ZerE7jEz1E1rZ1+YcZHUWhSIz2J5PWR/3ivBgbSNdJttCl6yoFGEwWy31kIg07WEZ5B9SC8j
 eBlxtJJjQlUY46j+e6un6K6tb4rDQM22IdiZfXMqmF987lAXzEMXta16x3XVBMxGTAh0b5kUo
 p9nYJWDN90iq57SPCz+Ih4/Fe+z7WeCyzWPXAGcr0PqzxxbwMI92N3wtCDJIsMx6IMJ5VezRu
 jr1OHGhPOmKQQxxa1M1X8m9eQYnEM/A7lMRQMg8x3ghM5sc5rT3YK+Xj6hcYjbsy7mTJMMIK8
 8F7BbNPeIqTGXF0VKNQ4KQWBOxGfBXfvP63kFXHac6dnlS4XYc5VJ2/4EQvEKCEuZS9s/LPbf
 o2dhlp7A3kPqabyguHd8wYFdHAxjvw87UgSlarGgLkdhnacewCxt+tqUc7vYJ//FdN7dqTSxi
 XLDSJ61mqb+tTioCCjC6h+ctOiI3P7UDyiY9v35G2dKnpzTw+7u77aTKN0FKdBx9OACIAsd9T
 qDeeFKGlBKEy9QhnIcyPSye5Llwff0xRbbpm3Bg17UcMje3o6QDxRmeSrmot5Xk3qYsKOiPpe
 W1DH2GnqiyZoqAX16pgQXF38bAHBj7QWps3EGqxRUdIs74BAYzIFoDvKDgCVEraK/gct6gcIk
 O9hvtHGHqECg6prDW57qbErQKqguBFfhyDyVAX13kbBATA0hJ7TvcoOke/rnADdtxNNBJGdVt
 O8yX0Qe3B92Ce2RyHbwEmaKrmikHu5koJJmU6OorsDSQ+fenSb+hxWlqkMToK3DY47mzFbJjR
 9b2kGaG
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] Checking the usage of locks with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 586
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/trinity-bcb29359-5c27-4c34-95f6-f5827e936702-1664177792747%403c-app-webde-bs29>

> @create4@
> identifier t,f;
> position pa;
> typedef spinlock_t;
> @@
>
> struct t {
>    ...
>    struct mutex f@pa[...];
>    ...
> }

* How much does the type definition matter for the referenced data structu=
re
  in this SmPL rule?

* The shown source code search refers to an array as a member.
  Can such a selection be combined with a previous filter by using
  a corresponding SmPL disjunction?

* Would the application of iteration functionality become feasible
  for the discussed use case?

Regards,
Markus
