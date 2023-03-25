Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17BDC6FD1C
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 10:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=rWnNGg848/4ESnPkppnlngB1EcCz0m1xGjD3TSsmV+E=;
  b=FBwrtYAbr4tQ3S6Ej8d6LrfyVwM9m5SiY7SFiaFg6GI/LvN/YFx1CLH1
   qgpfQje140P2xQVHdXW/iz9fZQIVB5+Xx+PoPybbqseMQf1r3uATJwwmK
   meUYS1E96N6D8AIfx09X7UehWraAtU3mhGYQ3IC/ubceTjxfaWauvuzCN
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99051101"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 11:25:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 20318E0D45; Sat, 25 Mar 2023 11:25:26 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id EC422E0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 11:25:24 +0100 (CET)
IronPort-SDR: 641ecc16_1fv45OjlqLiQ3ZblOSb7hzMtQXaR/riHSj1oAp3i6a3/kjW
 et1bK8ydqSjHTwWE9nrxgeLjFi+M6ZB5MI9Oqng==
X-IPAS-Result: =?us-ascii?q?A0HHAABXyx5khwMP49RaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YItgUsvBAtGhFORATGEL4cshzqIaYFqgSw+DwEDAQ1BAQIEAQEDBDiERgKFO?=
 =?us-ascii?q?gIdBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBG?=
 =?us-ascii?q?gkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEgJHU?=
 =?us-ascii?q?z0DAyMdAQERJgEPHwYCERUCAlcGAQwIAQGCeoIoAQMxB7EhgTKBAYIIAQEGg?=
 =?us-ascii?q?mOZJx8sIlOBXgmBFC0BjQSDNnonD4FVRIE8g0GDfYEGgxmCZ5lSCoE0dYEgD?=
 =?us-ascii?q?oE9gQQCCQIRa4ESCGuBfUACDWQLDm+BSgJkTIEeJQQOAxkrHUACAQs7Oj81B?=
 =?us-ascii?q?gMLIAZYawIJIxETBQMLFSpHBAg5Bhw0EQIIDxIPLEQOQjc0EwZcASkLDhEDU?=
 =?us-ascii?q?IFHBIEKgQEGASYknVuBDpVfsD00B4IogVWBWQyfDAYTLoNqARKTCw4GkiOXa?=
 =?us-ascii?q?iCCLqVMgXkkgVwzGiSDNk8DGQ+OIBmEDI9HQDQ7AgcLAQEDCYVGAQGFewEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ezLru6mZ+/bzuCRj2SKvO+M/tR/pDfL43DAbv31ZSRFFG/FwWf
 re+MjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQmVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6voSizPZLz9P+qjjzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99051100"
X-MGA-submission: =?us-ascii?q?MDGfD7HCd8N8vyrT9I2uDLReokFBhhKzqzVdnr?=
 =?us-ascii?q?VsBddmz2Q5MtejNy/zPvIzo/uULLxcjFqA0Czkk6jW+ZvTqV9lNDiRM5?=
 =?us-ascii?q?JQQFKGaricwwrLwgEhRfMs5f+mLQSc7IVxsThDcNMkJtq6Y098cqWfAN?=
 =?us-ascii?q?p4H7CnlBIqkp6On64IYZXARw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 11:25:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679739903; i=markus.elfring@web.de;
	bh=bOcO/iKvyPMLTwXXKXEUVrmqxj9/6HnBV6djOSChWXA=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=OupEE/H0u6ktkH0RSf19O14hnWOjcQ2F5Jc36/5nKuylEj45Ta8MlyQdM1TZOV/iT
	 e5omrfakZrQVMFZhoEqffjZZDyrgxxnLJRUyZBYMsbqIQ1zHKwZjtfkq5v6fi1CQe2
	 RdeKBETolmlrtQAz9ChkSxbGIwTk2h5ABXKww5xNm2soZ7gVOYm+Gmd1w+ofj8/hCw
	 iWqZx+BGq/ab2GI4O2OVKUVrO2fIIe8d/ctZ+frNgPh31Eqh1qNEFATnn/uDinWNQV
	 ONxEZ75w2WhJ0VicF/zhLnkVVa6YbVFCsNROvwMyXURIg1KK+LB7Q5yTCkDPE/YhTd
	 CVwZJsB/O9vIQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2jaS-1qc8Sx0ENY-0138pG; Sat, 25
 Mar 2023 11:25:03 +0100
Message-ID: <f7057212-eb4b-55cf-48f7-1bbbd1519fcc@web.de>
Date: Sat, 25 Mar 2023 11:25:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Zenghui Yu <yuzenghui@huawei.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <5f9ad9bd-2626-90cd-2b4b-2640a210c500@web.de>
In-Reply-To: <5f9ad9bd-2626-90cd-2b4b-2640a210c500@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QeliVmXv3K+LngwYQqpYQeIojEhPCYDRImggR3gs/FHbIu8u7t4
 7SqYhllzopglarrTE1tI+KW5QoXFDB2r7h3U9r6414KBlCYS1zB6QkF7Os4TK5DNvw9fI+X
 sQCmBcwwjVCPmt7qUWK1M04XE3VG4LcwEEqwwIg+vRjmQzke4XC6Z0nJHS+uPK6DAk2WHcn
 yTR4qNKJ0+GHAekjvRL5w==
UI-OutboundReport: notjunk:1;M01:P0:x4wq60HkOI0=;uRqytHjnmT5Yd2Bd6PqFb3/aF6S
 0GaDrHbC3u6+u36C02emQ90oRSrPgdxqCKgozmO4TAiL7O9iLpyOWYcm06Ubjh1vNI3CknO2x
 m1slcS/ML5OchxWbLHLp1sVQbLmErG8gDZmHOaP2s/7VXUtrrqyI4/F48iFvT3ERC2qXLqbbv
 oy33sWY4tTEAWbjMdJ6JL/fQaINTqy+cMutpmLIGHKIHWp42557AsYqCsPhXs0cjIPIJov0VT
 etXmzXVpEgwSmoOZGaTyPfzSxo75lu628Wd1/zgLuDc+rdXTcetus4dNO6+wFI7xcSjjhTkv2
 cx5WkuoeeFNvaqK8pi3ojQ4p5YBJUHjL2iZ5fuIzr94I7z1QkITsUV8M6LONf3ZGm1euWuNMi
 /Sz5SlkuaORjTUJgmiDZWkTS3WWTHJLUfMnOoz6baC8JmnQKc2xgzJ8aQzzeeUGn3P75NHebv
 HeqA3ez8FTBqByKNc2SSuoXUFKz60K9/JnO6qcJzZGA/P52h3A4eIKdSkAZterMMl5yFnl5K6
 W6j3nZlvGFLMsIGvmn20X3asLJXy3JdfOoXHMtrUvQd0Mirmhv69CBGLHqlPvLRUzxJHPBp+r
 Ee8rm5tNEMQql86DnoU/yGWYgq5gfSkP0Ya9QjTcvOW/4ugtJGxh/9ZhUSexty4xnV4LxP/7P
 2CqVflg8tf5JwBzWagikcwBSgx70hYGkZ/bVbVJgqw+4QFgQ6JJHHJDHfqsEWFQTpSlmXbBA2
 Kh1ZLYGquyg43ee9TCWZ4C+K2lVHLnqyTZJdR+Ez4J6ILfDhXkSdWh36Nthoc54FBnB9Xy1hn
 1jzznEF3Y6ORNOE2EnkcAXnCO1TW725I7VhMlYE0qBVInCImaINtUGZF4OGiVTRQlCy07Iwoi
 Qs85MVsWilLECxDtJhl5xXAmGbuI7/iVNUs79GYU4yYD/UeikhM+d8Pf2
Subject: [cocci] [PATCH resent 0/2] irqchip/gic-v4: Adjustments for two
 function implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 938
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/f7057212-eb4b-55cf-48f7-1bbbd1519fcc%40web.de>

Date: Sun, 19 Mar 2023 20:54:05 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Fix exception handling in its_alloc_vcpu_irqs()
  Fix exception handling in its_alloc_vcpu_sgis()

 drivers/irqchip/irq-gic-v4.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

=2D-
2.40.0

