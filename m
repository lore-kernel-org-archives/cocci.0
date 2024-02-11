Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2A7C4829B
	for <cocci@archiver.kernel.org>; Sun, 11 Feb 2024 13:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=n00gljv0jQx+lvhcQ5GXN9An9BLMqQJSkirVEwSwFhU=;
  b=BH6fXtla8IfDX+0nVcifpZzWDI4gxkiw8if/YrDdDYLpGWzcyfklBH5E
   TRD8QXRnnHAPVv58HeV0IRt66/0kdS0X1yrI0E3Z7J2PL644XvqQrpDn9
   4nvddQsYv6+reGAQqQUUKeDvARWSQr6W9qzBhCcCqpQulSyfisrg225xV
   4=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.05,261,1701126000"; 
   d="scan'208";a="151358130"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Feb 2024 14:12:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 494D0E0CD5; Sun, 11 Feb 2024 14:12:42 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1A363E008A
	for <cocci@sympa.inria.fr>; Sun, 11 Feb 2024 14:12:39 +0100 (CET)
IronPort-SDR: 65c8c7c6_MWBj23/YDPlEXFhin57UYek71M7hbzgjWva7/5uLhu9zz8G
 mJE/e1KKfI+T3MFYeXWbhptvhu7EGzIbxNT7hhw==
X-IPAS-Result: =?us-ascii?q?A0GnAACExshlhwQP49RaHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YI4f1MyBAtIhFOROTCEO4c3h06IcIFWgUA+DwEDAQ1BAQIEAQEDBIR/AodXA?=
 =?us-ascii?q?h4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXB?=
 =?us-ascii?q?w4QJ4VsDYJcARCBDoEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgECAgEjHQEBE?=
 =?us-ascii?q?ScECwsaAiYCAlYGARQBAYJ8gisBAw4jB7IOgTKBAYIKAQEGr1ofLCJWgWEJg?=
 =?us-ascii?q?RouAYglAYVvhDsnD4FVRIE8glIxPoRDg1uCaIIYgzuYVVR/HQOBBQRcDRsQH?=
 =?us-ascii?q?jcREBMNAwhuHQIxOgMFAwQyChIMCx8FVANDBkkLAwIaBQMDBIEwBQ0aAhAaB?=
 =?us-ascii?q?gwmAwMSSQIQFAM4AwMGAwoxMFVBDFADZB8yCTwLBAwaAhsbDSQjAiw+AxEQA?=
 =?us-ascii?q?hYDHRYEMhEJCyYDKgY2AhIMBgYGXSMHDwkEJQMIBAMrKQMhdBEDBAoDEwcLB?=
 =?us-ascii?q?3iCCYE9BBNEAxCBNIU+hGoDGSsdQAIBC209NQkLGwYiAR0CoVoTxwuBBjQHg?=
 =?us-ascii?q?jSBYIFhDJ84BhMvg3KTPA4Gkl6YVyCoV4FqAjGBXDMaJIM2TwMZD44gGYQUj?=
 =?us-ascii?q?0dCNTsCBwEKAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
 rAne4rsJT0E/9+GpKMh
IronPort-Data: A9a23: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
 ajZiF2omH2GdHM=
IronPort-HdrOrdr: A9a23:9ot/v6u90xCe+7j7AWAFfIdc7skDqNV00zEX/kB9WHVpm7+j5q
 OTdZMgpGbJYVcqKRcdcLW7U5VoLkmyyXcY2/h0AV7mZniAhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgjWQL/Zl5sWb+6a1gurkw25qVhwCUdAb0+40MGem+lYdfng/OXPVLu
 vm2iLNygDLRUgq
X-Talos-CUID: 9a23:jkShmmOpGlIQvu5DQzNEqUMYFJoeSGDinVLAelDhDUJHV+jA
X-Talos-MUID: 9a23:DsuYZASSYFFgZEQ6RXTFgi9lOfpF7JiRVhpUnowFt5nHbwZZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,261,1701126000"; 
   d="scan'208";a="79313349"
X-MGA-submission: =?us-ascii?q?MDF7sajNOOT37753AcTWYHAJucio55mBaTOVhW?=
 =?us-ascii?q?4Sz8erUIWXhkLaS0HtWH8rwAfV7TVq/AnJ8EH7X7wvH8p5emHqL1hwDH?=
 =?us-ascii?q?jaibZBdQGCPTLbdcS8godttb2gES4KPASfve3812x3AjYXkinEzsSiFw?=
 =?us-ascii?q?C4vPUe7qHO/AzrVKqReXvApQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 14:12:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707657157; x=1708261957; i=markus.elfring@web.de;
	bh=FhyXi8/xkw9lIq6cEiYth0uBVPNUwX4xItxcwK/oEw4=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=CVQ7GlKV32akRGaZIf/YTBQiWmkGxh6j9qU0RkRe/aZvbpYuEp87/SZHtvaNzHvJ
	 7jDNUHZyRxZyaD7ruLfrtur3zh6EkLNSNDLXaNMhbxy7TdU3VjhH0/roW814xeTLJ
	 aUrVP0Ea3FG/PhOgRScSDH0a9UczQi/L8Z5zr8rr3FywvI/HKjqpqx7UXee+ohpDe
	 0c8FJ7z0p7ykxUW6cHHJJ2wKzN8FGlNQKtzcXsnCItL48fW6+9b7D8niCJLKNPH89
	 NPbJRXmdhPKHaN5yoxhwPPzPXQx1ocR4X4Cm95MsgKTN2nfHVU2QuH0VibVWgxVtu
	 JXDEFrozxmSAyiV7eg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzCA3-1qnOCs0WcV-00wGSc; Sun, 11
 Feb 2024 14:12:37 +0100
Message-ID: <400ced6a-bf8b-4ddc-afea-a5d0bb49234b@web.de>
Date: Sun, 11 Feb 2024 14:12:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <d4abffb5-6221-4109-9316-acb5c3720c31@web.de>
 <alpine.DEB.2.22.394.2402100936350.53569@hadrien>
 <1c2bfc73-cf2e-4949-bf60-6fc432ef67a8@web.de>
 <alpine.DEB.2.22.394.2402101124030.53569@hadrien>
 <501ef7d8-223c-4647-a302-7aeee083af14@web.de>
 <alpine.DEB.2.22.394.2402101421490.53569@hadrien>
 <836e2ebd-a9cf-4644-9619-2526bddae0bd@web.de>
 <alpine.DEB.2.22.394.2402101554070.53569@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2402101554070.53569@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k6sRI1byCCbIlHCQKnfSbX2ZJ9VHVQUvWaIBCrQfTlV0iy8E1W+
 agtSDDtlL6qmcxYj6Ja0Kbi+bN6POaV6H27mO3L0vjJDHaDNS5Awa0pbelggzPzx/P0H5+Z
 Hs8NeQJe896MzSjBhpQPlOiEyeucJBaC4AYSTQeWHYQXjbavrbTZC/+Xm9uC3uJux7OG0k8
 UxbPlUCGO9+Z2EVWub4lA==
UI-OutboundReport: notjunk:1;M01:P0:X9TwrnKLVuM=;9lTg5Cg3c7oTi6au+ktjdTb93FI
 yHFCiDK82PsuIP+z19bomh+g8Kh7/ExVHXG9N84QIqTol4qmYq92EN+Jw9OItOJQtEDc0jF/+
 CZD39/Qp9Br6h0w52nnk6j6NhGLHy37Op9xUyz0BPBxS5w1YAhNGSiUCBXrHQXfuXuHDb1J/f
 ao8IAjjGxo0lwnnBgojyEm2f4a4/sA5guKYWFjhPmvMc4akWf5eNLg/QWUmbCBUTC/7GG38nB
 WwQCd3ugwHQ8qnG28x4W6PZpLlQtcbPO7Fpa0Gs/J+Cl3YcQRs68Qi7+nseHQHiPQqxxYfPCJ
 oaGVfGBs8mo3wiJ886/qUQRNL5t1n9BglLnUp+lReVUwbA4RrXQwSDPtrh0mgGZh1he2TvjJu
 OHFobbSLUQZSks2ZZrH/9qAe7xVp/gwfqGpgby0XAdX9Xn/HoOVlbjHGCD3OaW5CQzd8RNnQ9
 RtJkuPCteDAgjl3+CLbYjkd1cxPS2fqPFOClj1oaHRNKTAtpf3yvjOdy8xViac3wbTCdTCGnX
 GhWD2erprCpXBpjO065lXYacAxHwU70eRj96I3JckCo5zD0tI6qRe2uH3csgtKbJ/zQIUgRoC
 MG4ofLfs8kf0FVXqVrkSQUT4T0jqgYiH6Y6yPOxgSq4gK79+RsojyQvde06pN0Kk4jTki7/ss
 Bv5urck1Yy/r3BppFZh2Xy9h55P3gwIis2CL7CUIoqpJb+xvmY42BuJgXGUvDV/sNU5goXGH6
 A94bdDNfVFCBHFhdD8nhci7rtZ0utqacg7vozroqDEFPOxKxjTirfWD5JE9bgpvj59s1X6Ggo
 ELThk5DtfNPWiy66Ptu6cCxydSye9Qbte50w9gWIIfpbc=
Subject: Re: [cocci] Extending handling of position information for SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1545
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/400ced6a-bf8b-4ddc-afea-a5d0bb49234b%40web.de>

> Just like for any other metavariables.  For example, if x is a metavaria=
ble,
> you can say f(x,x) with no special notation for either of them.

How do you think about to extend corresponding advices?


@rename@
identifier f;
position x;
@@
-f
+g
  (x,x)


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch --parse-c=
occi test1-position-20240210.cocci
=E2=80=A6
minus: parse error:
  File "test1-position-20240210.cocci", line 7, column 3, charpos =3D 47
  around =3D 'x',
  whole content =3D   (x,x)


Regards,
Markus
