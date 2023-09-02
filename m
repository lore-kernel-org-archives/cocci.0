Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A4CC71153
	for <cocci@archiver.kernel.org>; Sat,  2 Sep 2023 17:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:cc:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=h/M6Tj2tlQfliujMO+uKhCx/ljxo7kOT6ZWR4wsRU8c=;
  b=K/c1+bI5YcnWFF1ql+9mkbFXNVuA5J8SZjwEV5UAyNRFQVmV2QqeeY3H
   zv2jNvK7G7GUE/Hjy+4BBWgGFy80qQAmFNNgL82seW6o2OCLu76SOJkKA
   mwj1FpY1zolPFurY29bpPPkg20erYSSH6QecRd/jPz/A1bFlEjoXo6VQH
   o=;
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
X-IronPort-AV: E=Sophos;i="6.02,222,1688421600"; 
   d="scan'208";a="124030928"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Sep 2023 19:56:00 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2D8DEE0CCA; Sat,  2 Sep 2023 19:56:00 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6C170E004E
	for <cocci@sympa.inria.fr>; Sat,  2 Sep 2023 19:55:57 +0200 (CEST)
IronPort-SDR: 64f3772c_IqAhG0DkITQouZU96TngmVvRD2DE4URhDe1wIcz9cpmBL3n
 zhT8CX7QCuAWiET9KOil2itE+KSF8698v0s4Lig==
X-IPAS-Result: =?us-ascii?q?A0F+IgDEa/NkhwQP49RaHQEBPAEFBQECAQkBFYFPAoI1d?=
 =?us-ascii?q?gNTMAQLRwiESo89gXaEbI59iG2BVoFAPg8BAwENFAEBJQYBAgQBAQMENwGBU?=
 =?us-ascii?q?4J0hnACHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQA?=
 =?us-ascii?q?QEBIxcHDgULJ4VoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBFwINOmgEG?=
 =?us-ascii?q?QEBESYBNAImAnQBAYJ6AYIpAQMxBw0GqTB/M4EBggkBAQaCZqxuHywiVYFfA?=
 =?us-ascii?q?waBFy0Bh20aAQVgiUEPgVVEgRUnglODOhcBAQKCK4MOgmeJYYVFB4Jbg1+JG?=
 =?us-ascii?q?yqBCAhegWo9Ag1UCwtlgRWCRwICEToTBUVxGwMHA4ECECsHBDIiBgkXLSUGU?=
 =?us-ascii?q?QQtJAkTEj4Eg0QKgQY/EQ4RgkdhNhlLgmYJFQw0TnYQKwQUGIEUbh8VHjcRE?=
 =?us-ascii?q?hkNAwh2HQIRIzwDBQMENgoVDQshBVcDSAZMCwMCHAUDAwSBNgUPHwIQLioED?=
 =?us-ascii?q?gMZKx1AAgELbT01CQsbBkACoGJwglSBOyKVFBaxLDQHgjGBXQWBWQyIcoEjl?=
 =?us-ascii?q?QoGEy+XFw4GkjSYLI1hlR6FRoFjOoFcMxokgzZPAxkPjjmDXjOPSD81CzACB?=
 =?us-ascii?q?wEKAQEDCYVGAQGGAAEB?=
IronPort-PHdr: A9a23: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
 iff/IYGng==
IronPort-Data: A9a23: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
 T3TFrMc8/RxLlxUqT4v28GG
IronPort-HdrOrdr: A9a23:Fp7eFa9/qzaLSDdjXC5uk+AAI+orL9Y04lQ7vn2ZhyYlFvBw5P
 re/8jzsiWE7gr5OUtQ/uxoXZPqfZqyz/FICOUqTNWftWrd1ldATrsP0WKK+VSJdhEWndQtsJ
 uIHZIfNPTNLRxdkdvw5hW+Hu0t2d+d7cmT9JzjJjtWLD2DcMtbnn5E4+ugYzVLrIIqP/AEKK
 Y=
X-Talos-CUID: 9a23:aT4ixW3ZMw6IEI/qo5lnKrxfId4HUXfdl3npKnTlKmc3C4KHd3qC0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3AJIFN7A62yY2Z5wd4I14O2QVmxoxY5raUT18D0q9?=
 =?us-ascii?q?Z4fS7BCdzAAWE1hmoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.02,222,1688421600"; 
   d="scan'208";a="64932718"
X-MGA-submission: =?us-ascii?q?MDEjHtJvIy4Lnf0s4vXT4+oQPKfDs6V9gbDLuT?=
 =?us-ascii?q?NdUfU4wmgg7HvDsjQbDNFcQcm+paFzE+CudyOkck1/Oij53WcwMqCtbY?=
 =?us-ascii?q?j2ozCtLYWJ5F19mvl8qvtHUnhdCsyHKspb0VhSrhwlDbEMhjwCdK1gi6?=
 =?us-ascii?q?zbs1OuEAUEeqlKNDRCmisw5w=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 19:55:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1693677347; x=1694282147; i=markus.elfring@web.de;
 bh=h/M6Tj2tlQfliujMO+uKhCx/ljxo7kOT6ZWR4wsRU8c=;
 h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
 b=SYWPTo7z6yucFkco+4963CGqur8W75U6FZMkQCVuKK36EJkktmchhuIg32MAJCho9VMQQu2
 pj0jmgVlWl7lI2TDenT2HMrLN+0U4EiJ5JNE9bDTQvKH+F+blkRWse6pVjOXdzG75S3KYdgUe
 gQj3dR27+DjnW7Zih3LcwMUceAyPvbhQRaeP72FyeNTZiiAPc6rjk7K0gZCGcS50LXmAezHod
 i+gVNbta0XMHuZ0P6wg6vSKk8TRmS4km2VRyEOLXdgdvrINsDP2nJ+Zpk03AiEtlw37c/GBb3
 QF5OJSud9GPP7/eVh8IMwjjGmEgzHQJT9GCq0c/Q3Svb4Ej2TiiQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mi537-1pykBW1Isz-00dty0; Sat, 02
 Sep 2023 19:55:47 +0200
Message-ID: <7e3fdd0f-e691-4ebd-9de9-4fbdb6ece973@web.de>
Date: Sat, 2 Sep 2023 19:55:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: Thomas Adam <thomas@fvwm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6ph1D4NWfHWx2/V26St+dYF8YGBBgtK7ciOq6Xfgbbggc8Pgil8
 Tx7TX4CvwMCqBmmon/UL803FBROLZDEV4kLrdGlBpjXvLDBEvqm1FL2DMZOmTw+90vBGG3w
 xX+QNIBN29GBr1egp+VAOywiCnZ4LXa9SXv8DtTnWa7HlOh8/o4iHbSikhUAkNOhPam8tsV
 n7yUxQCbzmNtgCL5c6kiw==
UI-OutboundReport: notjunk:1;M01:P0:TKaBYJx5kLI=;nTnvpUsc5xEgzEIiJCsxZzt5gvi
 lgOyQ4kveqDOGeP/j08B/i5KV38d2uUR8su2Hj2weZZ9bRXqqIwYzSHF3vUmVwdxQ7AJrJlw+
 nlD3DF8U/agjZouN6S2IWd/5P1yzLfLly860ANreuXMphSAcZ7kcZt/er+oPULvoN33yH3rCo
 WlxYZYWnn4kII/YnpesleCC32CbmCeHoJy7VMfoWYdQjVK+jeg9WexRg2gSm8klu44cQ+CXBX
 iDsuq0oHODHs6yVqZkm6x4/8VGfHkq/oq6Qw4XjQTwFBKGxh2tvaG7DebFckULVWUthDvKYdB
 5kFL3hSjBm0WheUMUMvvMDa0B1qupmNrIkyCkL6dG+Xj5BAUAsv8Kz18Ph59WO3syfWeGIpZ0
 oqqXvrH6c+VZfy9J9zPEu1/CYoIb0FhGwFiFUS6YpfDxAF8i9pZGmBamB/PndHrAO//asU9ey
 TFpX5wseo+UOCJg+MDodvf//uuf6fXol7zu/Tc+4KPiAu2PhF+hF1woUWAnANyOzwcA2UaY48
 pEGi9EztjeW9KMZTlMQB6VkbM2ZmVs8SEcOAGHVCEVc/Nre9+2D7CpGTfCJMlrWgPMljY6MJF
 Rv0gyrkdMbEhb4tTqUt5BudOPUiYcXLusJHiiMy3xaXW/QAWhdcVaMyHBUlbUnx2tifGUZzv5
 oAWmYOpMRUSt0J09cnqofrOTnTanT4YboUzwwNb7w1cCX/e+fPZjjgOtOhmvtABDX7L4tT3xA
 3O6pfSL7XbPb+pSSmA7jvad4q1NT0D/dI/UbkeXN9OJL5jQsAdLJbs8lwvhCUnxUqMBQI7M25
 Jr90yR7hkqOo7p+iyqtC28oJJNaXLtb5oZRyRI9F/xWkpp8QSx6mHim5mTaJNTJz8Kh669TVF
 pJ4qoEZ0KAVWDZPvWzruz+tJBOC4iM9fewl0tGVwVEWuEonNwgvEJPIxxCpwAeXX2s1X7Thlp
 Z7ApxJ+KfZadJ07KEPyDkyVL9wQ=
Subject: [cocci] Checking a transformation approach for the avoidance of
 duplicate code
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1229
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-09/7e3fdd0f-e691-4ebd-9de9-4fbdb6ece973%40web.de>

Hello,

The analysis tool =E2=80=9CCppcheck 2.10.3-3.2=E2=80=9D pointed a source c=
ode place out
for further development considerations.

https://github.com/fvwmorg/fvwm3/blob/c9d00184ac3ab534e0f0ba5683106879a358=
57f6/fvwm/colorset.c#L965

(style) Condition 'tint=3D=3DNULL' is always true [knownConditionTrueFalse=
]

See also a change suggestion:
Simplify data processing for tint colour in parse_colorset()
https://github.com/fvwmorg/fvwm3/issues/897


I constructed another SmPL script variant for a desirable transformation.


@replacement@
statement s1, s2, s3;
@@
-if (tint !=3D NULL)
-{
- s1
- s2
- cs->tint =3D GetColor(tint);
- s3
-}
-else if (tint =3D=3D NULL)
-{
- s1
- s2
- cs->tint =3D GetColor(black);
- s3
-}
+s1
+s2
+cs->tint =3D GetColor(tint ? tint : black);
+s3


Now I wonder why a corresponding patch is not generated by the software
=E2=80=9CCoccinelle 1.1.1-00478-g0afff7fa=E2=80=9D (OCaml 5.0) at the mome=
nt.
I would appreciate further advices.

Regards,
Markus
