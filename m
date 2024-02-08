Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE309C48260
	for <cocci@archiver.kernel.org>; Thu,  8 Feb 2024 14:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=APwYlBfZLKqIqHL9DCFH/tzZ+Vx8nT7ROLzIG00vOlA=;
  b=TttHhSbrjkwelfun9brn21yu44jI4T5/pXms52YkJ4RV4AVsXFHa4Ssx
   XFQvm4EOcKSZYIKxmjcfzE4RTdqzhRg+Trda+79kaa0eqJjkOBaWZb1GK
   6rDHVe6s+QNZ0R2VgQKGLgbFW5BAyqqncCKtyqwfhj3eCaDFzKzEgpvLb
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.05,254,1701126000"; 
   d="scan'208";a="150981866"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Feb 2024 15:06:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 00A07E0CD7; Thu,  8 Feb 2024 15:06:01 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8BC36E008A
	for <cocci@sympa.inria.fr>; Thu,  8 Feb 2024 15:05:59 +0100 (CET)
IronPort-SDR: 65c4dfc7_DiURd4N+6ZisQjHgmgYGeJI9k3aqNzzM4fz3U05LpYTIWAf
 NISTlwxycpcpNFztZG6hUklRXmB9v5PKfgtIYvA==
X-IPAS-Result: =?us-ascii?q?A0FUAAAS38RlhwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYI4f1MyBAtIhFOROjCEO4c3h06IcIFWgUA+DwEDAQ1BAQIEAQEDB?=
 =?us-ascii?q?IILgnQCh1cCHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAQEBIxcHDhAnhWwNglwBEIEOgSYBAQEBAQEBAQEBAQEBAQEBAQEXAkdCA?=
 =?us-ascii?q?QICASMdAQERJwQLCxoCJgICVgYBFAEBgnyCKwEDDiMHty2BMoEBggoBAQavW?=
 =?us-ascii?q?h8sIlaBYQmBGi4BiCUBhW6EOycPgVVEgTwLgkcxPoRDg1uCaIsjkWlUfx0Dg?=
 =?us-ascii?q?QUEWg0bEB43ERATDQMIbh0CMToDBQMEMgoSDAsfBVUDQwZJCwMCGgUDAwSBM?=
 =?us-ascii?q?AUNGgIQGgYMJgMDEkkCEBQDOAMDBgMKMTBVQQxQA2QfMgk8CwQMGgIbGw0nI?=
 =?us-ascii?q?wIsQAMREAIWAx0WBDIRCQsmAyoGNgISDAYGBl0jBw8JBCUDCAQDKykDIXQRA?=
 =?us-ascii?q?wQKAxQHCwd4ggmBPgQTRAMQgTSFPoMRAxkrHUACAQttPTUJCxsGPQKfTweDW?=
 =?us-ascii?q?R4rD8RtNAeCNIFggWEMnzcGEy+XLg4Gkl6YVyCoV4FqATKBXDMaJIM2TwMZD?=
 =?us-ascii?q?44gGR+DdY9HQjU7AgcBCgEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
 tWdzcobyR9H9M/Iu9QRDY7YJZDfWEc=
IronPort-Data: A9a23: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
 IT1qa15rJmHdHPM
IronPort-HdrOrdr: A9a23:91DkqaOHmBIId8BcTh+jsMiBIKoaSvp037BZ7TETdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVyaygc378
 ddmsZFeb/NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: =?us-ascii?q?9a23=3Aqm8lrWoJ1RhjdJmvloqpEQ/mUYMvV3Hm4VHpGVW?=
 =?us-ascii?q?xTl4zUruLSUOs17wxxg=3D=3D?=
X-Talos-MUID: 9a23:hLoBewgpi56179NUeMpYX8MpCZhNpJmSD0E3zoQel+zHMgVuISm4tWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,254,1701126000"; 
   d="scan'208";a="150981849"
X-MGA-submission: =?us-ascii?q?MDEebEkD2b7iOv2/7dAtPTrLkWokfds+5xrkSS?=
 =?us-ascii?q?FcDeggPakFgWM55YnEXpTPba9mXKvF0gurN+67D5SuadB9co2/aVb2/P?=
 =?us-ascii?q?2ngFNOcPfP/rKQVhQI9ocgMI88KG+AV17rRdD+SBxgGLYcW+IKLI06BC?=
 =?us-ascii?q?Y2lGBA/AwesNWbYcuwqK8BwQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 15:05:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707401158; x=1708005958; i=markus.elfring@web.de;
	bh=mJN50/KYRm5/kPlm5WJKDiKXtZeze1fVN2d7/mQGiGA=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=eCdhxZSr5OTPGCmxhjDmMxgXdjrk4QfFgbRNCldGDjoHG65QiUUtx14YfKFtskls
	 ewulr7z8b3UEsFqeJeJqec1BPijC4TYdqaOo9jdWIKcDfENaMx0hClvVNFEmc4g+q
	 HyuogQNu6dqPb5fDt1FT5Go/JIEClNViEB828W13R6BelDGXHGMbNxBhUzW+IZZze
	 QCcej5VgZHixiY1ZUC4ZwMU4xdfYRu3VWDbVv7u00ObekcQuCvbBo3a7jIy9j7wza
	 Z6mpFfaWc7qg0A8B5z4BY41XTGUjykLJ7htyiExLBo4jIksvOsdmCbecroO80jiE3
	 ioHJfO6jjpLGNCAt2Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQgl2-1rKEqm1Y3S-00NhmW; Thu, 08
 Feb 2024 15:05:58 +0100
Message-ID: <a4a7c712-f66a-4039-b4f2-16d7ef8a6691@web.de>
Date: Thu, 8 Feb 2024 15:05:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <dcb996ea-f041-406e-b641-0e6b515b9a0a@web.de>
 <7639c70-41e8-9a1-3a5-3a7711fc465@inria.fr>
 <1f8cb65b-715f-404c-84f7-8eee6de02352@web.de>
 <e2189114-2fa3-1045-1ae1-fb308b8c5c1f@inria.fr>
 <cffc1d24-5bb3-4a90-9593-31d3905449e4@web.de>
 <510575-bbc0-442-85a3-3c2fa510aba7@inria.fr>
 <bcf3a2f8-8578-43ba-8ace-99bad4ac5761@web.de>
 <a022eeae-c5d2-3cbe-8794-a81931944da@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <a022eeae-c5d2-3cbe-8794-a81931944da@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ldp1gHT5kxBP/69R6NUDTB+CwzF0ZuzQaAYjPsHS5awYaHU+Mi3
 L8Uluyrb4IV0C3UflYSUj9JHfdBvGPhHtukRZxxGnQHFr16FzqdRsDqZG+rtkHtwRo9cGl3
 TS5c/bu8a2roSMVv3ROxyC7Ib9SDEdf+toGEmHr8ON0hlRmrA9VZaDquQcmgdj7GnJh4ANR
 DTHGJ8GoZsU6VMIoVTQ7Q==
UI-OutboundReport: notjunk:1;M01:P0:rMb2doOAQ6E=;uQ1sU7BIbCyAzNyUeIac+IIjKud
 iatJ5nb2oiwtjWsPRcfE3d+SKK1YZitcVPiEUdxxdZpN0RiorKHjXVR5GlJl5cWr5GtgCwpu+
 JUgvARND/ghgYVxcdRTVyaR0TCTUe4/FoiH1t6xTbgatvKS/gWDCyBYG6z1xkHTOHOQPD+Rr5
 6OnE0W6mUxQunz3Uq1ulC0G4Aod8bSS01++ySRuPI/tOV2GcSTkLaueYv0nMjfdjr1tuIz8rM
 PMgYoCd9AWujdpT56qxZPGSwpzkUVIVpfUiH1JNZWRjuajWSTl4VLnYUNVZ8Dk6xiDwRg07uw
 GB/QbTKhyxWSVapuX8zf2rbJq1Dl7J8JISxZMp+ULEnA9C6C3AB9M+euia2wjEbCo7agbhD25
 z9C9GPlXb0lUIaQpCQleOlW77ncjQCFuSbsO5OJD+cI61UfjZ0LTFdwjrPuRhlx+ztNk80LD4
 grFE3Yeq/bD8mkW31pR+7YyqnPxWwKjuQsbdpUapRdG2Ne79gI44SLXylq8grIqQPlUcVJIt9
 BE/GYBBizqk+SXRYbFz6CsIxmL2b+RL6YIGoDecFXUqcz/pdrtFiOphiJxY4IPVdoGyk+r5Oe
 90FvQ5MTFh8OMPLFXEohXwhfNEynAJ4VGTowHVgVlMrsBJAk0sndu21BoUVd3T8vAXMpYL1k8
 QgfH2fnNwoimhR/OOUxRXTinGKVX0n1Pb0R7yk59btKFYZ8grwxe/ZWka7A4M/65TcIGE9JAd
 +vKweWYGS3RG+9vVX71znaL9hg5NmMptd6tTCgk7SsrYi4MoBBczBl7HTi58RVzkH/1fauZfd
 cqmFx+iv150Y3GEj7/3thkxrq1D7CorQPMB817z2yOYK0=
Subject: Re: [cocci] Improving support for code positions with opposite SmPL
 dependencies
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1523
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/a4a7c712-f66a-4039-b4f2-16d7ef8a6691%40web.de>

>> I would appreciate that the SmPL design pattern =E2=80=9Cdepends on tes=
t_switch=E2=80=9D
>> and a companion rule depends on the negation would work for more use ca=
ses.
>> I find it essential for the convenient selection of desirable source co=
de transformations.
>> Can they occasionally become safer if SmPL position variables are appli=
ed accordingly?
>
> No.  I already explained why.  The position can have changed.

At which place by which SmPL rule?


> Coccinelle has no way to know that.

I suggest to reconsider this view a bit more.

The dependencies were intentionally specified for two SmPL rules
so that only one of them should perform a desired transformation.

Why does the Coccinelle software behave differently if the specification =
=E2=80=9Cvirtual test_switch=E2=80=9D
is not used for a test case?

Regards,
Markus
