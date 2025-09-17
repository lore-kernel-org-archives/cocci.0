Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC809CAC59D
	for <cocci@archiver.kernel.org>; Wed, 17 Sep 2025 13:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=f5rLxi2vrEYZR/qeOqMv+vefbFtRVb/33nguO+ZDTqE=;
  b=m0SHvClTu7yCwNygQB1V1Buo1MQGktmcYR8XRHEGoFBIfn0ePoMygonw
   ljL9Wy5taW0+uSIS+rIAvCY0OAav6tMgY2Q53N55dkbR4b6bjDyG5/zY2
   G0AJoVcUM3W25AgV0gGVq/akhw4qsKzC1zB9reuEIcDFt3lD0945WnsmL
   s=;
X-CSE-ConnectionGUID: nPZaojbDQW6l9mTXFImmGg==
X-CSE-MsgGUID: xYzvwjM1TguNdVWBSOeWSg==
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
X-IronPort-AV: E=Sophos;i="6.18,272,1751234400"; 
   d="scan'208";a="239640530"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Sep 2025 15:07:57 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 50CA4E0BE9; Wed, 17 Sep 2025 15:07:57 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7812DE0171
	for <cocci@sympa.inria.fr>; Wed, 17 Sep 2025 15:07:52 +0200 (CEST)
X-CSE-ConnectionGUID: d1H1ODedRbav4L6tvwxASw==
X-CSE-MsgGUID: x8fF9zL4R16NA3f7ixbrzA==
IronPort-SDR: 68cab2a7_dMtnpqn8IwLeaUDI0JhPPzuzh2lB5r6hsZu2OCwZ69wOz7g
 aDCeYcXbZZnxOPlShcUI2LyxW95XKzl5NyK173w==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EmAABiscpog07ASNlaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBQQQBAQELAYI/gQIGVDMEC0kIhE2PUIIkhDuPEYpOgX0CDwEDAQ1KB?=
 =?us-ascii?q?AECBAEBAwMBhQACjDYCHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQIQAQEBOgcOO4ZPDYJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQJHRAEBAQIBIx0BAREmAQQLCxoCJ?=
 =?us-ascii?q?gICVgYVAQGCfgGCIgEGEAEDDyYHDQa+bYEygQGCDAEBBtpfHywiWYFkAwaBG?=
 =?us-ascii?q?y4BhWuCZAGKYycPgVVEgTyDAz6CYQEDgV6DW4JpgiaBFoNYhncCiFaJKFJ4H?=
 =?us-ascii?q?ANZLAFVExcLBwWBIEMDgQ8jSwUtHYEnd4MHgQ2CAIIeK0+CHHKBdD4ZQYNTH?=
 =?us-ascii?q?gZrDwaBFRlJAgICBQJDPoFrBhwGHxICAwECAjpXEIF8AgIEghVAAgELbT03C?=
 =?us-ascii?q?QsbBj2WV4QKNSxNyC00B4I4gWeBZAyKLpU+BhMvl1IOBpMFiDCQVo4ImzmBb?=
 =?us-ascii?q?wcsgVwzGiSDNk8DGQ+OIRmEGoELwHBBNQIJMQIHAQoBAQMJhUYBAYxWgUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 A==
IronPort-HdrOrdr: A9a23:RBIaPKFKEDJjtuRXpLqEPMeALOsnbusQ8zAXPo5KOHhom7+j5q
 WTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAspD4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: 9a23:s1f6aGByuP7JIAv6EyU+1BczNs0pSHfU0iv0fVOmFnZAc6LAHA==
X-Talos-MUID: 9a23:RwUk0QU+WB4bnVrq/C+8ih8zJuM02f3wLmlWn8oHq8OeJwUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,272,1751234400"; 
   d="scan'208";a="125786599"
X-MGA-submission: =?us-ascii?q?MDFONTG3dDnxkvLMrcaADpYv48tmdBmdLZcnAA?=
 =?us-ascii?q?83tswiCqjkkyIaFtC5KZU0LlpA3WHkdi434aAGhfC9wuZxQtGG+ssUCm?=
 =?us-ascii?q?e1YyysPGVKFmlgVb2wdYWZW8frlDx8WKnCU8RKD23+blZsLfJElYTdNF?=
 =?us-ascii?q?fNK/f3+wNkK/5Bu2mNmBQ4Cw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 15:07:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758114469; x=1758719269; i=markus.elfring@web.de;
	bh=f5rLxi2vrEYZR/qeOqMv+vefbFtRVb/33nguO+ZDTqE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=r5GpwyFFIp2aYG5VbWgdlQzT6qF4cpjr0odotiPP31XhZQbOlcHbLqitkVkoupZW
	 ZJYsDeO1GZL1ftaE56BB2k8iNoaXUPbvmJypXXR7QvMAk/4LaWEdiDe9xc9B50VAv
	 Ib+txI8Qi6/3g+6Hi3BdBd0Sjie0NJGMroL7z1FQi64qGCiU584PhHd4MyBchVRmJ
	 Y7x4uIdDOAjm/05yDyTlrZnUdgcqaPp/E32QWIvmtkAKcmB7BUUu9EDulbTbHctSa
	 c7OebTastdeh4t5DjNnW8NDrY1E3JL0Rkfjg5xbDvu6430u4Pyna4V7DMwooMxzI6
	 OFZmFnXHrMi+LXBNTA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.215]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsrhK-1u5oMP2Bya-018Hm9; Wed, 17
 Sep 2025 15:07:49 +0200
Message-ID: <3324d3c2-d9be-4e22-8fa3-611d1f53a68e@web.de>
Date: Wed, 17 Sep 2025 15:07:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Gaston Fernandez <gaston.fernandez@eclypsium.com>
References: <CAE0_PArbd-jaTHr8NR-mdP7pkDPsfHVSAAw_Xe16vvexx+eVrA@mail.gmail.com>
Content-Language: en-GB, de-DE
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAE0_PArbd-jaTHr8NR-mdP7pkDPsfHVSAAw_Xe16vvexx+eVrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bHkTNdrWc2tTM8kiJqnVpvILKqDx5Y+hbyKKU2N9Gwf3VkCVip4
 BHBQeQFuOImnt2SeB8WMqvXXsKALRWMI3z92ZfSSomeb6F6yw5f8xsUstOuHivMyPxifrxi
 bkegStQ5RPugVuXvDsSNjKvTSUZbvmQw9WqAsIR0DU/Z5BxJAzVZGiPoM/Q8JEwf0tmpkSr
 c0n9Eda/iGhxw9yU0zLgw==
UI-OutboundReport: notjunk:1;M01:P0:m/oOTr2V/Fw=;J5PKKM82Azlf24ah+FU4szlnIRS
 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
Subject: Re: [cocci] Reordering of if/else branches with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3027
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/3324d3c2-d9be-4e22-8fa3-611d1f53a68e%40web.de>

> Hi! I'm having some trouble with running a cocci pattern,=C2=A0and I wou=
ld like=C2=A0to know if it's a mistake related to my=C2=A0pattern,=C2=A0or=
 a coccinelle's=C2=A0limitation.
>=20
> _### What the patch should do ###_
> - The patch *[if_else_swap.cocci]* should take every instance of if/else=
 statements from the file *[test-nested.c]*, negate the condition and then=
 swap its bodies. (A double negative)

I suggest to take another look at data processing consequences
also according to a known isomorphism like =E2=80=9Cneg_if=E2=80=9D.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/7674e29155d23846c4150=
4948f4e4b1e796d07ec/standard.iso#L421-432

Would you eventually like to disable it for the mentioned transformation?

Regards,
Markus
