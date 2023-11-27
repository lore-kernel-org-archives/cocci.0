Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD78C4167B
	for <cocci@archiver.kernel.org>; Mon, 27 Nov 2023 20:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=X4kFMywBbmzP4QeDC9X9JPUHMIlL/mVX+dcffIUF5w8=;
  b=uoko7a9du/RDeYv6nefUPTmglEPIucISDbYYXu3GAy3eazFK7t/CjY9d
   wptX6A8EEBIuOTOLnoKQNBYB6s6LFyj+1orcV1pSFdQHl87dm26L/+vDd
   abk+uHFSPowK2bAAlUAcUD7XqYFm1O89meBcN6yj1i5yOXIV8YvdkOuGB
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,231,1695679200"; 
   d="scan'208";a="138858465"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Nov 2023 21:40:43 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 80183E0CCA; Mon, 27 Nov 2023 21:40:43 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 01596E004E
	for <cocci@sympa.inria.fr>; Mon, 27 Nov 2023 21:40:37 +0100 (CET)
IronPort-SDR: 6564fec5_76GQUs8gqqx+F+RZ0EsluCAHrLSoaRWCLOqxABYjLEE3Uau
 OH1yhMP+jKgU60bjeXm+QPFRHE7dybVIsfI3Bcw==
X-IPAS-Result: =?us-ascii?q?A0EKBQCd/WRlh07ASNlaHgEBCxIMQIFEC4I5gVAwBAtIh?=
 =?us-ascii?q?FOPPYIlhDuHNIdKiG+DFj4PAQMBDUEBAgQBAQMEhHUBCQKHKgIeBwEEMwYOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAhABAQEjFwcOCgEFJ4VoD?=
 =?us-ascii?q?YJcARCBDIEeAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgECAgEjHQEBEScECwsaA?=
 =?us-ascii?q?iYCAlcGARQBAYJ8gioBAw4jB6wggTKBAYIJAQEGr1UfLCJWgV8JgRouiA0Bh?=
 =?us-ascii?q?VmENScPgVVEgTwLgkcxPogegmiDbIU2BzKEYIEUjn1dIgVCcBsDBwN/DysHB?=
 =?us-ascii?q?C0bBwYJFBgVIwZRBCghCRMSPgSBYYFRCn8/Dw4Rgj0rNjYZSIJbFQw0BEZ2E?=
 =?us-ascii?q?CoEFBeBEgRqGxMeNxESBRINAwh0HQIRIzwDBQMEMwoSDQshBVYDRQZJCwMCG?=
 =?us-ascii?q?gUDAwSBMwUNHgIQGgYMJwMDEk0CEBQDOwMDBgMLMQMwVUQMTwNuHzYJPA8MH?=
 =?us-ascii?q?wIbHg0nJQIyQgMRBRICFgMkFgQ2EQkLKwMvBjgCEwwGBgkrBA4DGSsdQAIBC?=
 =?us-ascii?q?209NQYDCxsGPgInp1GjbKB7NAeCMYFfgWAMnyMGEy+DbgGTMw4Gkk+YQCCoN?=
 =?us-ascii?q?IF5JIFcMxokgzZPAxkPjiAZhBKPR0A1OwIHCwEBAwmFRgEBg1qBQAEB?=
IronPort-PHdr: A9a23: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
 Q==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:RSnWH6ni+ERCgeVl74m88MQ1HTzpDfIg3DAbv31ZSRFFG/Fwwf
 re+MjzpiWUtN9xYh4dcL+7VJVoLUm3yXcx2/hzAV7AZmLbUQmTTL2KhLGKqwEIWReOlNK1vp
 0QFpSWZuecMbAy5/yV3DWF
X-Talos-CUID: 9a23:Ww07VG8DFXQwnirofSmVvxAeJPF8UljY90mOCV6nCGNGdbiSbFDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3A+d6z4g9nVi3s2e5XjHJ/QtOQf/ovuJSoL24Eq58?=
 =?us-ascii?q?PuPWBKn1+Ag2UiTviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,231,1695679200"; 
   d="scan'208";a="72746451"
X-MGA-submission: =?us-ascii?q?MDGHHnS2jeUvYD2tjjixTjbv8pris/QoArXgNZ?=
 =?us-ascii?q?UWrT2Ryx0DdQWQffpfMxHpJeVcWj5Ny4sTcN0NLnHg7y6awEEo5ODf/r?=
 =?us-ascii?q?7qRRHvoiGhfCgqwYmHwF4inGyw2f/a/CHnm0Miz4Gs6NHSwRm0if2pHS?=
 =?us-ascii?q?qbiB5x0nstdSCQb9FHvqDq/g=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 21:40:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1701117628; x=1701722428; i=markus.elfring@web.de;
	bh=/SqzSGhgW+qFv5I4suDCOIPEW8ON/ugqSbf0BhdMhEw=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=WvkFrw07LXGqYYKzKhPKQgXA792Ug6fbMFlBu1FIxfu0oNslvfLYiP9oXL1BfOY7
	 I+CRNzoXux2/CYEQ8/BweK8IM9e2koxPAtJDkl7+puUnrENmwY1CJZOPavSObZ1OM
	 aU7m+Y5x2KVCILZD9Rbayark9R9IFYZ1vh0naXJdVHtAR5RDlJk3OUIZZoNkx4+eA
	 WIHnk0PDRFoDe5/uoud602YN5QSQ1SCnD2BAFTZvc/FwU6U0vqhIqqW5EVDn9MncL
	 /k+PbZCYO26iiEfsJ3jg6D9DWAu57LGrSJ86XoCwOhbju0RMWLlYx4TuzphtcHfFg
	 OJEc5c2aALzCpYN/DA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mv3UY-1rP6jM1VLs-00rIEB; Mon, 27
 Nov 2023 21:40:28 +0100
Message-ID: <db7129ae-54b7-4719-b96e-e93864813f9c@web.de>
Date: Mon, 27 Nov 2023 21:40:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Richard Weinberger <richard@nod.at>,
 Johannes Berg <johannes@sipsolutions.net>, cocci@inria.fr
References: <1735034650.197.1700567751120.JavaMail.zimbra@nod.at>
 <101903006.275.1700570321591.JavaMail.zimbra@nod.at>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <101903006.275.1700570321591.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:eKRu1Ncro9m0tfXn7wy1ps5ijrtIQXA+x7V+wra9z/kX9u/B/vh
 hpvVFAmFXO0jERd0i8QWzNXvnNm2XgqSW5HHd3wc9G1HDLTl7LaJZQrqU5Dsel3hM/6tGUh
 l9o8KN9uOj6Dte1TXwtAmhwF4K6CpeGVtSQs4hN2ZrUjUN0xnvqBuPasyVK8wrd+iqitsW6
 0LUAdnmvBnMToWEuwMR7g==
UI-OutboundReport: notjunk:1;M01:P0:y1eexa1po/M=;5JJMnqJRkJCzZj3H+YraXI+JmDB
 ObiFKr0EKqkKv+GtOHf9mQOaZz8Ngelym9UyRy5GjjzTrok4Qs/zS0wzaJNn9dGBh1I/Fd2Cl
 i7A5D2MCESgxqWf9hXG0lASHeKZhnkjG0O343e7O8CTPm5MIp2EgpzMCVbjaX6T3iic8nq/+c
 IwSawacbeB4hLPr+Odyfvs+qffIMyzQiV3P40nWKfPgYWde9jSyDwgyIRsyDGsaxjIe7ZHGt/
 1v9xokQG3gjGXtouZjdkTD90cEYYgA2HUec+/Ye0ZRUDIucgCQvZB7MNTv8slo/tugVqYVY/3
 1ePjWv8NVeP+3ONUaiAL7Fi0pWQUQjF5LyMMqJDunVO73l8fnEaCbKErfGiS2eU83Q0TLSHTT
 sYw75QjfnDt9QzZd9Hbvf5OWhQjc5dZXlnToQ74jWhk/V5t/02EcLnf++13bFyLsUHN5m43uA
 MYKP0Fwera75w40m9DFkUSVrjO/AvtnMPjKSIduT/Url007Kv2bAxqyoO1m6XIczViZ9J2gDp
 qd+y6GKr8lPKO4FJxj8HpUtuJvERad8ScnW6aZwHD+ROzPk1JdYR218JsDzqq2XjT6vwtky6d
 IntAbrxj9cmHFv9AFrJk5OyUMpkV2/LBW8MHjU/lrzd9ZAO5GVhEk2tqLM7de28z0xg27B0mX
 50fcvNUQji1dszePS9aEdA407g9Xgac+3IjSNYGdhjRs+mAW3j/DD93Yykw4XG5NCgxlZyoTG
 9Mz27z4fq3NvI1+VuIwM9FBNZN5J9y4gdXdLI6VVb720bzd+6tGEe9WLcG9vg4V76wnTcnKwm
 IrtOkSZgHNfEAXm/thtnniZPxoBTtWnLJXXJkGfnG8xY9DVl8WGl/KEODzQGd0KlpkkgVYA4m
 jNnRN+bUvnbh/gMAJBQtajCc+uPIkqxuAz7STXwMc6AjA2oRV7cuUfB5qXHSJByBKDfmM0aax
 iu38LQ==
Subject: Re: [cocci] Updating all call sites of a function?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1344
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/db7129ae-54b7-4719-b96e-e93864813f9c%40web.de>

> Johannes pointed out on IRC that I think too complicated and gave me an example.
> This does the trick:
> @@
> expression uctx, dev, n;
> @@
> - ubi_rmvol(uctx, dev, n)
> + ubi_rmvol_wait(uctx, dev, n, 10)

How do you think about the possibility to apply the following SmPL script variant?

@adjustment@
@@
-ubi_rmvol
+ubi_rmvol_wait
 (
  ...
+ , 10
 )


Regards,
Markus
