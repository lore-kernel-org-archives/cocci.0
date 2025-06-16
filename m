Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA58FC71155
	for <cocci@archiver.kernel.org>; Mon, 16 Jun 2025 13:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qBTbr9AtU/aUzo6QwAk5/zZnn8cPtDryqDIEdOlFLc0=;
  b=tAfmJayt8b4rAp7gwOshLJnpkW/1J1HoiidEQw1cnwvY+7M3ONyXYZUo
   pd7AoMzyaJJVTMj4uKhbaHduGyd1JdJmP/M0AaOBzeq72vIwwZuSC0jPA
   Dmt3nxCNTslW/VFxPMePhaiKh17fsTf6MtdyKMwzi89D/eKMlIdBXv438
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.16,241,1744063200"; 
   d="scan'208";a="227418125"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Jun 2025 15:54:16 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 74848E02E4; Mon, 16 Jun 2025 15:54:16 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 75357E0131
	for <cocci@sympa.inria.fr>; Mon, 16 Jun 2025 15:54:13 +0200 (CEST)
IronPort-SDR: 68502205_D6VOUtP3kdZr7YepWdagu5niXjG0uyx17NVgTFoXBneo+l/
 Q8GoLzMquWwhwGC2GtheQZGGZqZs2ZZ7HLHzRIw==
X-IPAS-Result: =?us-ascii?q?A0F0AAB9IVBogAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UIEAQELAYJDgQZUMwQLSYRVj1CCJIQ7hzyHU4h3g1ICDwEDAQ1OAQIEAQEDB?=
 =?us-ascii?q?IUAAotnAh4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AEBOwcOCjGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREmA?=
 =?us-ascii?q?Q8LDgwCJgICVgYBFAEBgn6CIgEGEAEDDiQHr2OBMoEBggwBAQbaXh8sIliBZ?=
 =?us-ascii?q?QmBGy4BhWyCZAGFbDuDQnonD4FVRIEVJ4MDPogegmmCKIEWjRaIHYtwUngcA?=
 =?us-ascii?q?1ksAVUTFwsHBYEgQwMqNDEjSwUtHYINhRkfgXOBWQMDFg8BhAIcg0KBI4RJK?=
 =?us-ascii?q?0+DIoF/TBlBg18eBnEPBk9AAgELbT03CQsbBj2ZAYc/lnkBr140B4I4gWaBZ?=
 =?us-ascii?q?AyfaAYTL4NxAZNZDgaTApkEIqkWgX4kgVwzGiSDNk8DGQ+OIYQztyZBNTwCB?=
 =?us-ascii?q?wEKAQEDCYVGAQGKa4FLAQE?=
IronPort-PHdr: A9a23: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
 9KJmK+hcV+qEvrR+tYAQdfZIoSLPSh5WSc=
IronPort-Data: A9a23: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
 ajZiF2omH2GdHM=
IronPort-HdrOrdr: A9a23:JkObP60Tn1KtR0MP+wzCmwqjBGYkLtp133Aq2lEZdPWaSL37qy
 ncpoV+6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:e0gmVW1X8tvg0esi6GA+j7xfBJAhY33/9XnqBwy0IkFSEpGNSm295/Yx
X-Talos-MUID: 9a23:MUI0Wgh8UxB6y9fRuWARnsMpHepwyoqsB3w2tLYjvs26BG9WNGy8g2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,241,1744063200"; 
   d="scan'208";a="227418103"
X-MGA-submission: =?us-ascii?q?MDFAJsftfBgcsV7TNluZyNxMzozdpFIyzxq+X0?=
 =?us-ascii?q?raZF2M2Z8/7AvDBbwpGDAX1MQju/zaMqmnLGTEFrTLywrayFD8lzgQ3/?=
 =?us-ascii?q?vyLsgEzvdLuAlXrNvoGV7Rst+WMdF7y3r28hzPnbjWS+AZ+DJ7YTtB2d?=
 =?us-ascii?q?wI2ESnr9IZ/sAms/xPjosUxw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 15:54:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1750081954; x=1750686754; i=markus.elfring@web.de;
	bh=qBTbr9AtU/aUzo6QwAk5/zZnn8cPtDryqDIEdOlFLc0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NdX0rkeKpFi2wIlhsTdZYRq0es3tOHZC0FBse+6FAy0K2aeI41bhGzWxVSM3m/tH
	 oiENrRkp2UpT/SpYP1950Ge8T0cCG/SPlWfItM00Nk7dC8ER72obaFBP62iFCQWY/
	 WUtGO7VSg36SL20QPRk0nAD2D1ZcOfogn/muo7Rr2qrRijTbS82EB9Jsgoa5JIndS
	 vAqcVP8xHca9HEw0Weol53+anUpK7e8nrj1swe/fMUSvKYR2Cuu86LWVsjiYVZjpj
	 LquhL+u+Lvl+Gu1uoHAhWZZoSaXa/lTN+QYWVq/VFRZFAbKl8paz8vbkjGFvKr3aX
	 svkH9Auyr/eUXTFZnw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.254]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3ouw-1urjaU2Ptw-00sXOI; Mon, 16
 Jun 2025 15:52:34 +0200
Message-ID: <9b7e7e8a-c070-46e4-8e77-25117ec57de4@web.de>
Date: Mon, 16 Jun 2025 15:52:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Luo Jie <quic_luoj@quicinc.com>, cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 Andrew Lunn <andrew@lunn.ch>, Catalin Marinas <catalin.marinas@arm.com>,
 Joey Gouly <joey.gouly@arm.com>, Julia Lawall <Julia.Lawall@inria.fr>,
 "Kiran Kumar C.S.K" <quic_kkumarcs@quicinc.com>,
 Lei Wei <quic_leiwei@quicinc.com>, Marc Zyngier <maz@kernel.org>,
 Nicolas Palix <nicolas.palix@imag.fr>, Oliver Upton
 <oliver.upton@linux.dev>, Pavithra R <quic_pavir@quicinc.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Suruchi Agarwal <quic_suruchia@quicinc.com>,
 Suzuki Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>,
 Yury Norov <yury.norov@gmail.com>, Zenghui Yu <yuzenghui@huawei.com>,
 quic_linchen@quicinc.com
References: <20250612-field_modify-v4-0-ae4f74da45a6@quicinc.com>
 <20250612-field_modify-v4-2-ae4f74da45a6@quicinc.com>
 <3537a4ce-b5e8-44d5-a884-70a81562068d@web.de>
 <94b40ff2-9e9e-4eea-8a66-87d8976aeb70@quicinc.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <94b40ff2-9e9e-4eea-8a66-87d8976aeb70@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L1Ntp29AaKwEMr4PnjAbJmXdbPkjxodHy7XTJKBBCbq5v/CmzK/
 qbVuMqVNzxJTnr1SJz7btoks3CV6ViLCzYXeXByLRuqHlR0LtEwA7HHZVZOMSy6+iIuoxyc
 nOOIFvaNjwB75QYPFqfzAiVjnb0O5+L3+O7DjAtPRkx8SLiFgFBqJpXfcTJpc8MbeHh1uOv
 TizVwhDRSobx3P0fqL4mQ==
UI-OutboundReport: notjunk:1;M01:P0:RVf64evWiY4=;i78THtmf23u09RM2RgaXgsMiFpp
 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
 BQ6vM/IG6/NmXEsaNU/Bp/TSZAm7QWOzjXmSqA==
Subject: Re: [cocci] [v4 2/5] arm64: tlb: Convert the opencoded field modify
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2788
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/9b7e7e8a-c070-46e4-8e77-25117ec57de4%40web.de>

>>> Replace below code with the wrapper FIELD_MODIFY(MASK, &reg, val)
>>> - reg &=3D ~MASK;
>>> - reg |=3D FIELD_PREP(MASK, val);
=E2=80=A6
> I will review the generated message to improve the formatting as you
> suggested, the next time I use it.
Would indentation be more helpful for the mentioned code excerpt
(instead of trying to describe lines with bullet points)?

Regards,
Markus
