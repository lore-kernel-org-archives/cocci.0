Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A14CAC5BB
	for <cocci@archiver.kernel.org>; Sun, 28 Sep 2025 09:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=U4QcvzKP6hfY2fERf2M1xddAbzjCGAJe2gLd9SGznx4=;
  b=VWIRsdzecxJAgAXZN6tnExehQZ/EhnOKPJysU9b5Bnknrx4bSmn6XCK2
   l2vFZo4RHoTiLxuhrli9r3iLtipvLyKbTwJHbahfBBPkT2dIv4gwJmVSJ
   EdHuwOAV1fGXbM06xbOJx83VORhn61jNt4onOZmJ+9JEXJiPdnKqCyN//
   0=;
X-CSE-ConnectionGUID: HnDjjLFPQC2cutwrBmc5Fg==
X-CSE-MsgGUID: k23NOvcqSeqVsEshzt/2+w==
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
X-IronPort-AV: E=Sophos;i="6.18,299,1751234400"; 
   d="scan'208";a="241365049"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Sep 2025 11:22:45 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BB807E0172; Sun, 28 Sep 2025 11:22:45 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4F2EAE0171
	for <cocci@sympa.inria.fr>; Sun, 28 Sep 2025 11:22:41 +0200 (CEST)
X-CSE-ConnectionGUID: NlHtEt0yT0W4Chi8isQ2Og==
X-CSE-MsgGUID: JSoo+bP+RZ+SqC9m0YPLAg==
IronPort-SDR: 68d8fe60_SM9e6REtv3tGjMJQrCIyp/sBquNA2eiBZKQxcpJXKf7G/d3
 ej7UdLmGI/zenSkwXMeu+Yw225SF11+sepDVZOw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FCDwDm/NhogA4P49RagQmBU4JAZR0GVDMEC0kIhE2PU?=
 =?us-ascii?q?IZfmAqBVYF9Ag8BAwENSgQBAgQBAQMDAYIMjzwCHgcBBDIHDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYZPDYJbgSyBJgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAkdtHQEBE?=
 =?us-ascii?q?Sc0AiYCcwEBgn4BgiIBBhABAzUHDQa0KIEygQGCDAEBBoFYQVDXdh8sIlmBZ?=
 =?us-ascii?q?AMGgRsuhWyCShoBBW6KFw+BVUSBPAuCR4NQAQOCK4MOgmmCJoEWg1iEAIhZj?=
 =?us-ascii?q?jOBShwDWSwBVRMXCwcFgWMDgQ8yPDIdgSeDfoENhB4rT4UCPlqDUyRrDwaBF?=
 =?us-ascii?q?YNbiR89QAIBC209NwkLGwY9mDOEHi0slXmzATQHgjiBZwWBXwyJCIEmlT4GE?=
 =?us-ascii?q?y+XUg4GkwWZBo4IlWCFWYFvCimBXDMaJIM2TwMZD44tFoQRgQvGUUE1AgkxA?=
 =?us-ascii?q?gcBCgEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 twCR+0DPGE=
IronPort-Data: A9a23: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
 aTZiIyKrIxXiaI8LCq4R0NoJQ==
IronPort-HdrOrdr: A9a23:Sp6GpaMImqiZMMBcTuOjsMiBIKoaSvp037BZ7TETdfUzSL3+qy
 nOpoV+6faQsl0ssR4b9uxoVJPwI080lqQa3WByB9uftWDd0QPEEGgI1/qG/9SPIU3D39J8kY
 F9bqN5FNr8NlRii93miTPIa+rIjOPnzEiy792uqUuFoDsaEp2JZGpCYDqmLg==
X-Talos-CUID: 9a23:pFcHTm+TvQcCbU76a6+Vv2gQOtwIbiXM8C/vf2S4CDZoU4TPblDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AxzrDWQ9cY1Yi3jNUlFHLMT2Qf+VT5KPtAnhOq6d?=
 =?us-ascii?q?FgNCvZCkoCg+5pTviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,299,1751234400"; 
   d="scan'208";a="241365048"
X-MGA-submission: =?us-ascii?q?MDHEdE4MzeVynrhOcgE4coNhn1k/P7zq5Xk8ug?=
 =?us-ascii?q?5QJ/1ZVRjIiIXucLc3o21iotwTvBl8FA9O0i8G5o0nOykOnwDtwcWznU?=
 =?us-ascii?q?i854E+5hiBAq5GdJVx2znMTWQ0TqQ4sUScXfnaD3Jj4f9ZHp+IYoR+GL?=
 =?us-ascii?q?20soMr2TFhz8ljsIjzLz87VQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2025 11:22:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759051359; x=1759656159; i=markus.elfring@web.de;
	bh=U4QcvzKP6hfY2fERf2M1xddAbzjCGAJe2gLd9SGznx4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XEb4aaqB4kXWF/Oc9cEt2rsgGSAJMLT6fnmF6/DyxaExRiJW3q+vi+0fKBo4zglF
	 yX4EXqsrCyGCepYN01uUpBw99NTCgqznVl0b6V0D4Fw/TQalfy6gYc/qRwcyZcBQa
	 hY6Rhan5oiuOl5VXLCZDnQdWrxQatTf8fAuV/JjklerV8a4Mywqp34nyC0Rh5rqpJ
	 VExXJx9YTO2O09Xoz0YBY9AQuRugpvrbJPe5m5m0MPeH8NHh62u566IpqZwd2NwZv
	 3rNXWYwPa5yK2VOa7KUv8DYSEJTFOfXkR7Om4MrEuhXJZCiT9yCeN0c1NdDQ2SRQo
	 pSVeOeruAW7JazSttA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.189]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIc7N-1v8WFO2dRV-00G11h for
 <cocci@inria.fr>; Sun, 28 Sep 2025 11:22:39 +0200
Message-ID: <61f326c5-7c60-4390-bcb7-20707fc68b6f@web.de>
Date: Sun, 28 Sep 2025 11:22:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zavSK7JMfsisLAEfhO2paCu+L2W+WcDXit+OVVUI2btZQ/9bjzA
 xmQ6B4dUiw1W3nBYT8Klq2G9VmSoFjBnSI2BmBbVCXDLoD6S4ujxmeZAYCLNQI56zfJF56U
 V69VDPQ0pxQUM78JlQZXwtp8G0aXHdrWOlz5qpSlc+tCLLczR79jEJy4kQ7vUKC/qCJ3dpJ
 KAsVJbNQ25fhIeN/oQINA==
UI-OutboundReport: notjunk:1;M01:P0:avUTIMMkRIw=;Uz0UEPJko7EvZHlwd614qQEHkm4
 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
 E5/NU1fKx86FbgohEuTPV+2Dtgzx0Goc1Xw=
Subject: [cocci] Improving handling of position information for SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3044
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/61f326c5-7c60-4390-bcb7-20707fc68b6f%40web.de>

Hello,

A bit of information is provided in the manual of the semantic patch langu=
age
also for the usage of position metavariables.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/7674e29155d23846c4150=
4948f4e4b1e796d07ec/docs/manual/cocci_syntax.tex#L420-432

Some data processing results can be observed then also according to
the software combination =E2=80=9CCoccinelle 1.3.0=E2=80=9D.

Source file example:
void my_test_number(void)
{
 123;
}


A)
find_special_number_without_position.cocci:
@find@
@@
-123;

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/spatch =
=2D-show-ctl-text test_special_number.c find_special_number_without_positi=
on.cocci
=E2=80=A6
Let _r_0 =3D (EX^((TrueBranch v InLoop)) v EX^(EX^(FalseBranch))) in
 ((_r_0 & (Ex _v . 123;)) v (!_r_0 & (Ex _v . 123;)))
=E2=80=A6


B)
find_special_number_with_position.cocci:
@find@
position place;
@@
-123@place;

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/spatch =
=2D-show-ctl-text test_special_number.c find_special_number_with_position.=
cocci
=E2=80=A6
Let _r_0 =3D (EX^((TrueBranch v InLoop)) v EX^(EX^(FalseBranch))) in
 ((_r_0 & (Ex_ place . (Ex _v . 123@place ;))) v
 (!_r_0 & (Ex_ place . (Ex _v . 123@place ;))))
=E2=80=A6


A corresponding computation tree formula is generated.
But it contains still references to an extra position metavariable despite=
 of
the implementation detail that it might not be needed here.


C)
find_special_number_with_reused_position.cocci:
@start@
position place;
@@
 123@place;

@reusing@
position start.place;
@@
 123@place;

@script:python@
p << start.place;
@@
print(f"file: {p[0].file}\nfunction: {p[0].current_element}\nline: {p[0].l=
ine}")

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/spatch =
=2D-show-ctl-text test_special_number.c find_special_number_with_reused_po=
sition.cocci
=E2=80=A6
start =3D=20
=E2=80=A6
CTL =3D=20

(Ex place . (Ex _v . 123@place ;))
=E2=80=A6
reusing =3D=20
=E2=80=A6
CTL =3D=20

123@place ;
=E2=80=A6


How do you think about to clarify the shown differences in the generated t=
erms?


Will any improvements become helpful for involved software components?

Regards,
Markus
