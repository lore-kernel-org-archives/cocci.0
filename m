Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3344ECA0EFA
	for <cocci@archiver.kernel.org>; Mon, 25 Aug 2025 15:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=fwtLws69isXqp5SL/nA3F4E6kex7z0gVjjRgxfCi2wI=;
  b=COYaFOog9hkQu/8ZMG5jnsLXPW/9CD+Uj7cBAqm1cUEyHPNZxm7sX5eX
   bn/Cj8Cz4bAaoE9WAA+Fxlm61LVYwIx9vV/Uwo/Q28bvwhxFb55z94cnF
   Ogt9f3fjXB98uTFdmFWdCer50N5Z69k6/rAqCD5b8TIctiPQV2MU7P0+Z
   w=;
X-CSE-ConnectionGUID: sV7cYWOlSuWj3ffjZLS+6A==
X-CSE-MsgGUID: NPO6AC0/R1i3hFx6HOfepw==
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
X-IronPort-AV: E=Sophos;i="6.18,213,1751234400"; 
   d="scan'208";a="236035278"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Aug 2025 17:17:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EB1A3E0264; Mon, 25 Aug 2025 17:17:31 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 406B3E0172
	for <cocci@sympa.inria.fr>; Mon, 25 Aug 2025 17:17:29 +0200 (CEST)
X-CSE-ConnectionGUID: Knp77zaIRlSNB5LsJkTjlA==
X-CSE-MsgGUID: IwtY9S/CQp+T+2GRkyoIUQ==
IronPort-SDR: 68ac7e89_S+Ds4loTYUQBBmGsoKoC13Xpad3JmlAZXZ/0aNHsf/v+gw+
 feZZmR6H2j3BKcvkO1NkBI38dWbUPr2qjX15Jkw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ELAAAXfqxofgwR49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFABAEBAQELAYI/gQdUMwQLSYRVj1CCJIQ7hzyHVYh5gVWBf?=
 =?us-ascii?q?QIPAQMBDU4BAgQBAQMEhQACjCYCHgcBBDEIDgECBAEBAQEDAgMBAQEBAQEBA?=
 =?us-ascii?q?QENAQEFAQEBAgEBAgQGAQIQAQE7Bw4JATGGTw2CYgGBJIEmAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBFwJHRAEBAQIBIx0BAREmAQQLCxoCJgICSwsGARQBAYJ+giMBB?=
 =?us-ascii?q?hABAw8mB7EjgTKBAYIMAQEG2l4fLCJZgWQJgRsuAYVrgmQBhVxLg0J6Jw+BV?=
 =?us-ascii?q?USBPIMDPogegmmCJoEWg1iWbVJ4HANZLAFVExcLBwWBIEMDKjQxI0sFLR2BJ?=
 =?us-ascii?q?3mDB4EOg1pFK0+CG3KBdUEZP4NTHgZrDwaBFRkdLgICAgUCQz6BcQYeBh8SA?=
 =?us-ascii?q?gMBAgKBEBACM0ACAQttPTcJCxsGPZROhzCkbaFFNAeCOIFngWQMn2wGEy+Dc?=
 =?us-ascii?q?ZNhDgaTBYYikmQiqR82gTQCNoFcMxokgzZPAxkPjiGEM7gjQTU8AgcBCgEBA?=
 =?us-ascii?q?wkBgVWDcAEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:GOfsm6pDbT9B7UzX2CcKI2YaV5r/eYIsimQD101hICG9vPbo9f
 xG785rsSMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaGSS5vyb3ODXKadC/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: 9a23:XHf/IG4rLKz5IESrGdss10gMRZ83e1znyEz2CRKcEkRqdL+RYArF
X-Talos-MUID: 9a23:nX9gXATnZvuOc8ZeRXTNmy1TZfwvyJ22S3xOy7o8uNiDFBFJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,213,1751234400"; 
   d="scan'208";a="236035273"
X-MGA-submission: =?us-ascii?q?MDG7icYgSo4ouGeW15NAHxieqAD+RRMYXsu62F?=
 =?us-ascii?q?RFOaPQKNBdzNo1K/Tmkmjfd/yWX+ehfjwwDtQx1GIYkaJIbih0Wdreu/?=
 =?us-ascii?q?x2U+FicWkIbBUACUnNx+9IPp47PCB/t1rkoeizOd8vvJEzXQ2Facs07n?=
 =?us-ascii?q?dZIWZRJ6yFy3KC+xyz3ZLZJA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 17:17:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756135047; x=1756739847; i=markus.elfring@web.de;
	bh=fwtLws69isXqp5SL/nA3F4E6kex7z0gVjjRgxfCi2wI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WtclVWaO3uWGfBxp0CtWoMP2HU9dns243t4/NC64BpTl6DQ+O2FBz0gacqBDiRJB
	 U7myIvGV+bkQhMML3Lu0tTmXx3Bl7svQRIU2valZxfYG6lJmiyY7jnkBi+phAtsQ7
	 o7I0HzMXpbsFkLRXV0mk2dwa5GqGD+XYo8pLLccLKESYNkN6iRHsAcRQB0DuxyRHG
	 worjk6sJcUAtaQuL25LE8vxUS2Gvbg7Q5bk+OzTJZcPD7AXB2VN9KEKwyyXS8bKt0
	 QCpfLUtI7j2iQTflXseFAM6bsjmj8+6ks2Qo6i6E7vRRLHgQCyySyXtnuGi+pYzp5
	 j+/9P1wgtYWOa05dEw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.250]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRW6Z-1vBeCo30Uf-00TYQR; Mon, 25
 Aug 2025 17:17:27 +0200
Message-ID: <a507ebb3-d87e-46eb-ba58-b9a872fcfeef@web.de>
Date: Mon, 25 Aug 2025 17:17:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <574a6fa0-00a0-43c2-8e66-cc6443f5cfd4@web.de>
 <eb3e0445-39fa-4f4a-aeed-96eadc94657d@web.de>
 <alpine.DEB.2.22.394.2508251521570.3563@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2508251521570.3563@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:x4AyKl9hl80Vc8sjRkVgvksE4klmJTD4j9kf2Xh9bOZwYXjEXCD
 5oaJxSAxT99/36eCJi3mUdVkP0W+ypelZV5sBUiX26cQI67WdSB2SOvdQlV1PIwCmSA2WYR
 xgChfC7HqTwumU6HS9BECxiN88GyTTh6O8KCIqX6D40juSM1ca6pfGfXcGias8EncvKwbTS
 HACngJmZElcx9aAx8AKsg==
UI-OutboundReport: notjunk:1;M01:P0:krr6pKgfMGE=;glvh6vJtUy+VKZ563OK2qMubdHi
 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
 mz5y6y2V9m1SBV7jCqchwIb2zn6W
Subject: Re: [cocci] [RFC] Choosing =?UTF-8?Q?=E2=80=9Csemantics=E2=80=9D?=
 better for SmPL script parts?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2983
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/a507ebb3-d87e-46eb-ba58-b9a872fcfeef%40web.de>

> The default is exists for use with * and forall with transformation, with
> the reasoning for the latter being that when transformation occurs the
> trasformed code should be consistent.  But there are cases where something
> else is desired, so this is controlled by the user.

Can SmPL script developers occasionally get any indications that they would expect
an opposite system setting?

Will the usage incidence become more interesting for the mentioned source code
search parameter?

Regards,
Markus
