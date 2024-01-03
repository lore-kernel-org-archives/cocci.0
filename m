Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35D5C3DA6E
	for <cocci@archiver.kernel.org>; Wed,  3 Jan 2024 18:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=LArngLS54n1huul2SQS6WxIz/o3l5P7bbgnYECkKcyU=;
  b=cWDjas1XcS7YB3HjMbNkB1RFZiRDEPAb5IxnRlgjbJDRE6v223N5/Et4
   3e+jnItsr27CqNJqRw/0GCKb/VqYm82JnMtWmToEiIBhenHcMM1OPiM6z
   DdUXEPBrqpkopT/mpTAt3unxMg8NaBOMHTusXhxB4vzLIhJ7BBwGHUQHr
   8=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,328,1695679200"; 
   d="scan'208";a="144744939"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Jan 2024 19:09:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 62D42E0CCE; Wed,  3 Jan 2024 19:09:19 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A8E83E004E
	for <cocci@sympa.inria.fr>; Wed,  3 Jan 2024 19:09:13 +0100 (CET)
IronPort-SDR: 6595a2ca_LwXd/NzQKuM3KgKewoNXEchgCMr/ICUQQsDUfIPjmGcCDPT
 LQeJdCojko4P7pLGpEXhpnFutIDdnXJU4PawSCg==
X-IPAS-Result: =?us-ascii?q?A0FKAAAGopVl/07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYI4B3hTMgQLSIRTkTYwhDuHNYdMhGuEBIFWgUA+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBIILgnQChzYCHgcBBDEIDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQKBBhOFbA2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR0IBBAEdB?=
 =?us-ascii?q?h0BAREmAQQLCxoCJgICVgYBFAEBgnyCKwEDDiMHsAWBMoEBggoBAQavWB8sI?=
 =?us-ascii?q?laBYAmBGi4BiBoBhWeDQXonD4FVRIE8C4J4PoRDg1uCaIV1g2+LOViBDiADg?=
 =?us-ascii?q?QcEahsQHjcREAUODQMIbh0CMTwDBQMEMgoSDAshBVUDQgZJCwMCGgUDAwSBM?=
 =?us-ascii?q?AUNGgIQGgYMJwMDEkkCEBQDOwMDBgMKMQMwVUIMUANlHzIJPA8MGgIbHg0nI?=
 =?us-ascii?q?wIsQgMRBRACFgMkFgQ0EQkLKAMsBjgCEgwGBgldJgcPCQQlAwgEAyspAyN0E?=
 =?us-ascii?q?QMECgMUBwsHUAMZKx1AAgELbT01BgMLGwY9ApcKfIFLUpNVnVeUQTQHgjSBY?=
 =?us-ascii?q?IFhDJ8rBhMvg26TOA4GklQuh1CQTyCoRoFlAjmBWTMaJIM2TwMZD44gDBYWg?=
 =?us-ascii?q?3OPCQE9QDU7AgcBCgEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:SNsvQ6xzqG1CFQ7u27GhKrPwKr1zdoMgy1knxilNYDdeeKWj5q
 aTdZUgpHjJYVMqMk3I9urwW5VoLUm9yXcX2+gs1NWZLWvbUQKTRekI0WKI+UyEJ8SRzJ846U
 6iScRD4R/LYGSSQfyU3OBwKbgd/OU=
X-Talos-CUID: =?us-ascii?q?9a23=3AcYXBO2qS/MhllxdNAGMthK3mUeooUnft11vSGVe?=
 =?us-ascii?q?hCGtKcJqPbH+30qwxxg=3D=3D?=
X-Talos-MUID: 9a23:YOqjfgmDl3BlI43RUkNrdnpSM9pX7pmFA3wwuswrme6VN3VfGjWS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,328,1695679200"; 
   d="scan'208";a="144744922"
X-MGA-submission: =?us-ascii?q?MDEOSRkMxfrc6BpLw24Ru6PQxe7Zx2HIv7cMkG?=
 =?us-ascii?q?1Up1dbfg/7XNtOlSa+gHslYm5Q8WLH67J5n5nJ/GfB8Q6u2SsjwL79Zw?=
 =?us-ascii?q?kwXcKrNrqGrDyOo6MuCongrgvoEbYkG0+tdVCQgSTWhc1vGvfqpbuFYU?=
 =?us-ascii?q?tDyBtv5cO6AijP2G/Fx4XzjQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 19:09:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704305307; x=1704910107; i=markus.elfring@web.de;
	bh=LArngLS54n1huul2SQS6WxIz/o3l5P7bbgnYECkKcyU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=lvgN3dZoFgac2Og0zCE/HsjD4fIKJg1sLLc4GH/yoQ8LK0rk4S9JTbegNa9mS47C
	 fIeQi5EjYzBPE8csbYYcqKqkmIZefZObenzd8UfK/3b+U9uJtZs1x0F9qIsX52LEX
	 de29vkfuB5UAI0Erdi34tGlgGFAIsHG1S8x+rnauoTNZAxxZS8QI2JCT6OPdDWI9M
	 bHKKvcLmJlfPeXFsfF5FSd6R7B80LLfcYpiafglDuC2woXmuZgvyP82MBFl3qKf8G
	 p2V6CDZydTJQZfQapMcYHNa9FvGXhZTEyGWosG6bjgqStXA+FEuMSCOMqsX02/Shs
	 YgCnFivjhS3PNIpKqw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPrLN-1rYeKm0HbP-00MizZ; Wed, 03
 Jan 2024 19:08:27 +0100
Message-ID: <93cfabee-9692-491c-8d38-dec142e90252@web.de>
Date: Wed, 3 Jan 2024 19:08:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Simon Ser <contact@emersion.fr>
References: <ff7ce5d0-59fa-470c-8dd6-68dbe65c18e5@web.de>
 <9b1e7330-f4f6-47f8-a568-eaea1624bb6f@web.de>
 <37647c33-7f9d-4763-8bf4-cfc5c9a811de@mailbox.org>
 <c5f1a7bf-b444-4934-a205-3c2b3a045ff7@web.de>
 <dd300771-851f-4cfb-b9a2-d87d2b4399aa@mailbox.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <dd300771-851f-4cfb-b9a2-d87d2b4399aa@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A7UpQmI+NpIKUou/f/ZUndvRF+daTR/IPse9QtOowTPKTCot15T
 LQyU8oOcO2qacO1a+GqlMISx99VvbZkbbiI8V9zeVOSPNR7jVbSokXwKk17WsLPxyqT1eOK
 pyX9kaPB17BMfLYKwENquvIoBLFF262QML14cFBm2CHaMzr/8MbBJp16nenXUPk0t1NUHUn
 57wnndBHm/N5t9QG6G7vg==
UI-OutboundReport: notjunk:1;M01:P0:+NqsBawroWE=;t+9FMI+RO+msEDvKFtWJHzPOShr
 X3InvC3DPjzJ6Fpq2UUDHLtWW+jUbRbCDCE+H6xwXC3CG0J6SghC10CpEi/29d8gdMRQ3xCHf
 RzWqfAzpTJZdfkNPjl8hQ+cn/nTBU5unYiFfoBWaESzRtJBMscjBIo94NfzHiYnsB2TzBRXj+
 oEkPDZ/QxyOKIciJ0yRfGqFIj5lX2xdfWLo2HWq2rx/gY/g7aJSIoZcREerqbd9GW55g7X/Y9
 v7bfsOmQh1l6m87RDipdV7YDcwzC3fFY58Z0YzlyFvlyWtrKWFm+pLKBdDwGIwAnh0Qreu7W7
 i9rcXG3fuuXvnZAMRAABMjnVoxeWfP0wPam1GL6Uj0ptZ3PSgug2yDPU1qo66rkYS9LbXKH0w
 sleGRwWVvvOP2rQ/RZb3AeuMUuuGotqXrmPQZtBxgprT3HMYHUWnBjtY5iO2qcMOqEersGX4B
 HQSdDYyoQUGEZWXEXg2CDaWPhzdVWz+L9oPstJA8BhW+4/dIZFXf9u1R79YC+o79ZynXdyLMP
 V3g32e0v1NdBHgn/3oIbs3QJH61c4FsjmJvZs/op6jZwvI+fptURnlJFl+vAZlBEp73W0mAiz
 IO7T6HEtUuYhihDrh8fsZ6CUWe3to6BVALcD7DJ0QMzrGBV8vNusm0584GgcZN7hvH4KZKoBk
 cr4/5DCUrXSpaWORUaMLAPM/81kbj+DRWqtZrV+VDGMwD8drvduFE8716ElCJLwWp3114aXu9
 t63O+CTeZ1HF5H+cMnSdwna3PMaT6d2zsMrR5wquJuAOrN6pZ+gf6ULQGFOhruWSbv8ISunho
 xweksNSh15gnJwlqASxx50KVtKMEwL/4KLj1tFe/U8DWRNsN4sSkd/R4vuBEH++WkYqBwM/qH
 Hxw//y3yCfgYuStCxPMhz6aKQl8vEXADPg089CEgnPikOIy8vnL1J5VBN9xX8VUwENDvw/qhq
 AHCufQ==
Subject: Re: [cocci] [1/3] drm: property: One function call less in
 drm_property_create() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1430
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/93cfabee-9692-491c-8d38-dec142e90252%40web.de>

>>> Out of curiosity, what exactly did Coccinelle report?
>>
>> Some SmPL scripts from my own selection tend to point questionable impl=
ementation details out.
>
> That doesn't answer my question.

It should.


> Without seeing the actual Coccinelle report,

There is no =E2=80=9Cofficial=E2=80=9D report according to the discussed p=
atch which is triggered
by known advices for the application of labels in goto chains.


> I'll assume that it didn't actually call for this change.

Software development opinions are evolving accordingly.

Regards,
Markus
