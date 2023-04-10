Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB608C76196
	for <cocci@archiver.kernel.org>; Mon, 10 Apr 2023 05:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=042mPpo+x/9u41ZEmsNaZZHVU1FLBLBqjQpKQJSNqNk=;
  b=nxI5fF+nNhF3iis9nlH/pUCLOJcYlYSu+z06t2gJWVga6aUbU8zSrpdP
   r6mTI0JgY5zrYrHsjocEkRrRQYhGdTPqJC/ipwcYjG4MwyZiqQMQUH/zG
   MscQUDR0pc0U928ozvSxAc0oqS1xioWT8W41CcnGl+EcoBKdANkp+RyPU
   I=;
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
X-IronPort-AV: E=Sophos;i="5.98,332,1673910000"; 
   d="scan'208";a="102244979"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Apr 2023 07:26:12 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A025AE7312; Mon, 10 Apr 2023 07:26:12 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 48D8BE72F8
	for <cocci@sympa.inria.fr>; Mon, 10 Apr 2023 07:26:04 +0200 (CEST)
IronPort-SDR: 64339dea_v3z9Vo6gyC+6wT7NAq7lM6jRVkB1ykNFq5WVJAXABarN994
 x3Wa7bXnLDsKGNYuw+4fzmR74grXK1m/W0AkgBA==
X-IPAS-Result: =?us-ascii?q?A0FBAACyQzNkh07ASNlaHQEBAQEJARIBBQUBQIE8BwELA?=
 =?us-ascii?q?YItgUsvBAtGhFORMIQwhy6HPohrgVaBQD4PAQMBDUEBAgQBAQMEhH8ChT0CH?=
 =?us-ascii?q?QcBBDEIDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQAQEBGAsXB?=
 =?us-ascii?q?w4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEgJHPgECA?=
 =?us-ascii?q?gEjBBkBAREnBAsLGgImAgJXBgEMCAEBgnqCKAEDDiMHq3h/M4EBgggBAQacC?=
 =?us-ascii?q?x8sIlSBXgmBFC0BjQmEMCcPgVVEgTwMgkcwPoREg1uCZ45mi0WBNHSBIA6BP?=
 =?us-ascii?q?YEEAgkCEWuBEAhrgXlAAg1kCw5vgUljTIF7BAIULSUEDgMZKx1AAgELdT81B?=
 =?us-ascii?q?gMLHwZYawIJIxETBQMLFSpHBAg4Bhs0EQIIDxIPBiZEDkI3MxMGgQYLDhEDU?=
 =?us-ascii?q?IFGBC9ZgQEGS6Fdk1QusDk0B4IqgVaBWQyfDQYTL4NqAZMeDgaSJZdzIKd/g?=
 =?us-ascii?q?WUCNoFcMxokgzZPAxkPjiAZHoNuj0g/ND0CBwEKAQEDCYVGAQGFfQEB?=
IronPort-PHdr: A9a23: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
 HUmVbJRElA4RKpyNw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:23Rj+67wFtNWnJtDbwPXwBbXdLJyesId70hD6qkDc20xTiX+rb
 HWoB17726TtN91YhodcL+7V5VoLUmskaKdpLNhWotKPzOJhILLFu1fBOLZqlWMJ8S9zJ8+6U
 4KSchD4bPLfDtHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNz2CJ5sA0+9jYDzranGeqTM2fqbQn/
 enjPZ6mw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,332,1673910000"; 
   d="scan'208";a="102244970"
X-MGA-submission: =?us-ascii?q?MDGqmBXNTwmNNFwwbdXkxlHYAi6N4jZEExRV82?=
 =?us-ascii?q?hf2Do9OtMFfUOYJoPxO0Ch3TbIws2aO2UPuldr8tVz/gCiteFR7OW5IO?=
 =?us-ascii?q?OMBw8TEHkZerGEYxach7k1GCjxS04sil/ltO1LfOip/TC1YsE7d3UJdx?=
 =?us-ascii?q?0Ej32QDif7FBsAYb8Xl31+4A=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 07:26:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681104363; i=markus.elfring@web.de;
	bh=042mPpo+x/9u41ZEmsNaZZHVU1FLBLBqjQpKQJSNqNk=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=HRxLX3+YIcjUa+U6Vt+ZoMw6xZACjAAV8TeU5hc09jkZ5tIexqPGI5B5za2+MEgIQ
	 cxKmwQ8RUPjImNBLdgKoDTfqFgCMYilZ0iGy1kFo+dfICpbdWFDG26CkaEuvDZmjJG
	 zxmqNRVAulomL20XhZ0uFkp864kNlbtJ7OI19Ai4194M+ZBI3nZJMLsiG9WMj/aCM1
	 jrRgWdYOdmzeDkZsnGdpohBAJlI1QBU1bIBDQbrsCDcmoJn6a1eUtWm67TKXjp8wta
	 TdZvXYOkZguYjuFoIYY3WmpTSSyoZl0pw6QU5D+7aeoacigjlnzZGH9P50YLyDvBxo
	 8NBlA82nqMCFQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7ux6-1pgmEL1ESQ-005H4L; Mon, 10
 Apr 2023 07:26:03 +0200
Message-ID: <95caa4c1-2455-2733-ef4b-3ab07783c725@web.de>
Date: Mon, 10 Apr 2023 07:25:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <alpine.DEB.2.22.394.2304092044020.3028@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2304092044020.3028@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P3x1lf7tD7ZbreJ+fejHnXfFTsF5UNFgKo1BhnPnSI0Jvdi2qQN
 vObY1V6FJqw/bW5XLcNw+NJJz4t0Fu/+GoldTyS/HxO7LPG/AE4GXLpEWUIA7traFk7+KJf
 rVu1cSzhaWx8PXzPOyxzP0q0pPwRwDNjlVYsfUnwujuhXzL2uh7XoG776ITYOPnd5uQX2P9
 +pA/QS3VaScOWcB4l1ojw==
UI-OutboundReport: notjunk:1;M01:P0:+25Pcu9Ew3A=;bFP1Sup3TY+ECm1PJOj3FLmAit+
 1yZrN4zMl9SfCsFHs4CYunq/BOXdybUjy6cQvVG4OAFQaV4Rm9kv2qQgUwxKT5a2lN7YCZstF
 Ge9fQiXihQcxIXMrT552lVZWAOsblNPdRBFkmJUQI92mf6iSkN61c8zWcAl28GKX4NAJRUHay
 enYcZIcBsPZsY32FXNsLnK/EKFTnQAdZE8yLxM9WE6pDg+UoDiu/TiTNZKQZk/KuDWoMV72uL
 usZHc13u37t8b956oyoUbspvUl32+DInIBwb4FDF7DGnHLkSLovDZPSXYwD6jGjYwcs8oP3pK
 eOcr1E0CftcLmDSuqDR96BjRM1t6D01i+RZsfD9DrvGnrlnRf8JMZNaywLllr8SKaaC8t/ZkN
 on0z/c1/GWxJ6suvET1nVKTyrOwAiZPV+mIpUtqK05Mdp8t0cbNhx+tnxffc3fYe8VHugsH1e
 TqhLOVJZzk3OVSPvAg9uVG9s7OIC5IeTmBbQc9tijQhIWL0V1/K6hbiNqYfYe2j6n1TgIqLi4
 QSbY13VP8CGspwVm8odVpHtDuwVnhBAcSVLibhAZm6oEjbLKfOVK64+WQbUoO72CdppPfCEVa
 kAOToEJd3om6YEMOOGoVp4aMJls9vnPHIRFdjfG0H9hHEa2YrWbyeLMWhgYaUJu5rNgKTEZvC
 Cz62wb8zxOaPt8FbI/PWbUhLt/mpZ5LtMmpsMTF1N4vit1pjnhCvOAL01uEU+iimD4arZRY43
 KXzzjAtaGz4iWs6Ad4e/TPUjYbOceTUXxPzobsvtks6/pkHJumragbNLkEer/YBT6FsX5hKkc
 4dW2U1RXkY0jTAKJxBxLzww7xhcaDtWgr7uPmhRWJtRXRc91jL2YD5+hhCdFvPmsoAvBL6LpA
 7Cvbzu44LREbG8Xqk+I9UVDjMKEgmwVsCjb9EUaPVOD3G/Psvf9OLbSdb
Subject: Re: [cocci] Reconsidering pointer dereferences before null pointer
 checks (with SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1017
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/95caa4c1-2455-2733-ef4b-3ab07783c725%40web.de>

> Setting var to &input->member does not cause any immediate problem.

Undefined behaviour would be involved if the expression variable =E2=80=9C=
input=E2=80=9D
will actually be resolved to a null pointer, wouldn't it?

Some implementation details should be reconsidered if null pointer checks
are occasionally performed a bit too late.
How do you think about to move variable assignments accordingly?

Regards,
Markus
