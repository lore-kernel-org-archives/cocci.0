Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B145C5B552
	for <cocci@archiver.kernel.org>; Tue, 10 Jun 2025 16:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vSGBUuxY3gDIunt9EEwMjqaLaoftQcVSKjZhvst5R44=;
  b=C+UGYs9XmpLrh56PhQyZPLrhcSisnX0/GdpTTCNjvJ4P8Uuhfg8kmCMG
   vSlflzqcNnztif2z15Fy7DArHcaQl96+0268B0H5mXssidHGL9AdSC6Sk
   rlNH4S500SuU0UThsgOZYNchw68FDsEM4ViXGhQbSJsETWN8IMAbP8xJk
   s=;
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
X-IronPort-AV: E=Sophos;i="6.16,225,1744063200"; 
   d="scan'208";a="226164186"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jun 2025 18:40:18 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D25D6E01A8; Tue, 10 Jun 2025 18:40:17 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id F2DDEE0131
	for <cocci@sympa.inria.fr>; Tue, 10 Jun 2025 18:40:14 +0200 (CEST)
IronPort-SDR: 68485fee_dHjo+qCqzf4k5C20DB6m9smUww0AygCG6iI82shX8Xw5kFQ
 Z6mfsBkwmMQnSla5F7ErHVDjL9D2bNo3bGXKY3g==
X-IPAS-Result: =?us-ascii?q?A0ErAAAFX0hogA4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UAGAQELAYJDgVozBAtJhFWPUIIkhDuHPIdQA4h3gVWBfQIPAQMBDU4BAgQBA?=
 =?us-ascii?q?QMEhHYKAotlAh4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBOwcOCjGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BA?=
 =?us-ascii?q?REnDwkCGgImAgJWBgEUAQGCfoIiAQYQAQMOJAeTXZxFgTKBAYIMAQEG2l4fL?=
 =?us-ascii?q?CJYgWUJgRsuAYVsgmMBhieEPCcPgVVEgTwLgkcxPoQKOYNbgmmCKIEWjRWTb?=
 =?us-ascii?q?FJ4HANZLAFVExcLBwWBIEMDKjQxIw88BS0dgg2FGR+Bc4FZAwMWDwGCJIFeH?=
 =?us-ascii?q?IM/gSOESStPgyKBf0wZQYNhHgZyDwciQAIBC209NwkLGwY9mGuDcYENjTu7X?=
 =?us-ascii?q?DQHgjiBZoFkDJ9oBhMvg3EBk1kOBpMCmQQio16FOIFqATeBXDMaJIM2TwMZD?=
 =?us-ascii?q?44hDBYcg3W3JkE1PAIHAQoBAQMJhUYBAYpPNIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:IueTnaAatZjWJRVW/+jnw5YqxClBgxIJ4kV8jS/XYbTApGkl02EPx
 2QcDGDTOazcM2Xze9l0bYvn9hxV78SEndFnOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yM6j8lkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/YuGZjdJ5xYuajhJs/za8Es11BjPkGpwUmIWNagjUGD2zCF94KI3fcmZM3b+S49IKe+2L
 86rIGaRows1Vz90Yj+Uuu6Tnn8iGtY+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0usyxVEFL0OavHJSxjSCc50SaSmLIx9I0MFh1GYwD8fZeWiZA6
 tVNfVjhbjjb7w636Le8V/UqmckpasXmVG8dkis5l3eDV6lgGM2FGvmiCdxwhF/cguhrFOzde
 tFfRD5hdhXGbDVQN11RBJ9WcOKA3COhKmME8Q3KzUYxyzTYz1Fui7G0Cv+LQo2KWuZOsGe++
 X2TqgwVBTlBaIzHkmramp62vcfLlDzyXIY6Bry9/ORjxlyV3G0aThMMPXOwpvKyi2alStdHI
 goV/DAvpO487iSWosLVWhqlvDibsxRaV9c4//AGBB+lw/bt+iKdITI4V31lacctpOZtAjI1/
 wrc9z/2PgBHvLqQQHOb076bqzKuJCQYRVPugwdaHWPpBPG8+ekOYgLzczp1LEKipvHYcQwcL
 hiPqzUiwaoeh4gH2s1XHGwrYRr9//AlrSZsuG07u15JCCskNeZJgKT2sDDmAQ5odtrxc7V4l
 CFsdzKixO4PF4qRsyeGXf8AGrqkj97cb2GN3Q80Tsd6q23wk5JGQWy2yG4jTKuOGplbEQIFn
 GeO5lMAjHOuFCD7NP4sPepd9exxlfi7T7wJqcw4nvIVPsgpL1/YlM2fTU+X2Wf22FMh+ZzTy
 r/LGftA+U0yUPw9pBLvH7l1+eZymkgWmzmPLbillUrP+eTFPha9F+xaWGZim8hjvMtoVi2Po
 44Hb6NnCnx3DIXDX8Ug2dVIfABaciBrX8+eRg4+XrfrHzeK0VoJU5f5qY7NsaQ890iMvraWo
 COOSQVDxUDhhHbKDwyPZzoxIPnsRJtz5zZzdyAlIV/iiTBpbJeN/ZUvUcI9XYAm0+h/kt9yb
 f0OIPubDtp1Fz/oxjU6bLvGlrJESiiFvwy0AneaUGANRKI4Hw3t0f34TzTr7xgLX3aWt9Nhg
 riO1TH7YJskRiY5Pvn3dcCA8lKVlloekdJUQEHnDIRyekLt0Y4yMA33rKY9DP8tICX55Amx9
 lipEzIHg9LSsqkJ8NXtroKVnbeDSudRMBJTIDjG0OyQKyLfwFuG/aZBd+S5JRbmS2L+/fSZV
 9V/lv3THqUOowdXjtBaDb1u8KMZ4unvrZ98yiBPPi3CT3avO4NaDki25+t9nYwT+eYBoiqzY
 FyFxfdCM7bQOM/FLk8YFDB4Usu9j8MrihvgxtVrBn7l5R1H3quNCmRTGBiutBZzDpVINKEd/
 ONwn/JOtiKejEIxP8eknxJk0T2GDkY9XpUNsrAYB47WiTQX9GxSXKyECgLL5MCgVtYdFGgrP
 T6eu4TajZt+2EfpUiQ+BFrN78VnlLUMvxFGlmEDA1GznvvEmf4F8xlD+hsnTglu70tm0sAiH
 kNJJkFKNaG10DMwv/d6XkeoABNkKCCC307Ml2syi2zSSne3Wlz3LGESPfiH+GYb+Tl+egd30
 a65ymG/dxrXZ+D0gzUPXHB6p8zZTdBe8hPInOalFZ+nG7g4eT/Uvb+8V1EXqhfIAdIDu2Ofn
 LNEpN1PUKzcMTIch4YZCIPAjLQZd02iFVx4GPpk+PsEIHHYdDSMwgOxEkGWeP5WBvn04ES9W
 t1PJMVOakyE7xywjAsnXIwCH7wlu8QSxosmWqjqLms4obegvmJXkJbPxBPf2k4vYftTyPgYF
 K2AVgi/AlSxhGRVkVDjtMNrGHS1SvhaaRze3NKayvQoFZUCut49KE0Zj+CGgFSIAiRa/ja/n
 gDKV4nJxcNMlKVumIrNFP1YJgOWcNncasWBwDqRgf9vM+zdFNjothwHj3XaJCFUAOchYMt2n
 rGzr9LH5kPJk7IoWWT/mZPaNa12yeitfehQaOTbEWJ7mHacZcrS/BczwWC0BphXmtd75MP8Z
 Q+ZatO1ROEFSeVm23xZRChPISkzU52tQP/bmhq8iPCQBjw28w/Ndoqn/EC0S1BrTHYDPpmmB
 zLkv/qr2Mtjk71NIx05HNBjPY5zJQ7yeKkhduCpjwKiMEuTvgqgtIfhxD0a0hOaOkncRYy+q
 djASwPlfRu/hLDQwZsL+8ZutxkQFzBmjfN2YksZ/MVshiunCHIda94QKogCFooehxmaOEsUv
 90RRDBK5eTBsTV4ndHU5dP+QkGAC+ZINtqRyvnFOa+LQ3/eOW9CKOIJGuRcD7NeZTbpiu2qQ
 T3b0mOlJQC/m/mFWs5KjsFWQo5bKjfy2X8Cv0zw+yA379DyHp1SvEFc8MFxueAr3i0DeIgn5
 YT4eIycfHyGdA==
IronPort-HdrOrdr: A9a23:gTSSiq4XfAKm24h5sAPXwBbXdLJyesId70hD6qkDc20xTiX+rb
 HWoB17726TtN91YhodcL+7V5VoLUmskaKdpLNhWotKPzOJhILLFu1fBOLZqlWMJ8S9zJ8+6U
 4KSchD4bPLfDtHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNz2CJ5sA0+9jYDzranGeqTM2fqbQn/
 enjPZ6mw==
X-Talos-CUID: =?us-ascii?q?9a23=3AWSPO6WqvrmXEJsCLOyYyl0vmUcl5S2T5yFCKH1b?=
 =?us-ascii?q?7LWdyQ628Ehie54oxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A6iaz2g7xjfhOFltnynttrhyXxow06KfzFxsEyK8?=
 =?us-ascii?q?j5fHVNTNTIBm8qmuoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,225,1744063200"; 
   d="scan'208";a="226164177"
X-MGA-submission: =?us-ascii?q?MDFkjJHT3Dej1RuZLmYx69qdbCxeIlIh6Z8Vb1?=
 =?us-ascii?q?paESS1MZWpf7uJrZBwwTeF3CesXrDi8NzWNDNdwiPGU+/YZl7TNClZmt?=
 =?us-ascii?q?TiIptsKS6xWC4mtsNHwcs9sH2eiAr9qfXgn1Ta3E5e3TfTy4orqc+zv1?=
 =?us-ascii?q?8n0l+ku0wMWxj2lTHaNnH8Jw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 18:40:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1749573613; x=1750178413; i=markus.elfring@web.de;
	bh=vSGBUuxY3gDIunt9EEwMjqaLaoftQcVSKjZhvst5R44=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=E+jXwQt2kg6UkJ25Jl/kAVTELZhy1z0S5b9fIoxOUITcOh+2LpnepmK037wMK/YD
	 s2vjk6UQQ/CTtM+Z7ydfCi16PlEAjfbNw4svRzELQ73JYp27RV3vFen1K8HiRJARe
	 RvbH+XBshzrww89NESLjMB5eGeKrDTdi2TXUYE9vGWJCYo4VC1i+51wXSIZ6eINBJ
	 Q6UM2HC7/NK7BoZOb8dByytWIHltIULdUf7WK8y7/+vzoEf/SBrKbyXWtC0rx266l
	 iU+ZFfSpLqPQfAVAKmSyfuk/1zxAFTmYkCtfsKLyfpbMy83P7mVwf+vWT2tNrJdB9
	 iJ4RHqwZPj3x+ElDig==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.183]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8kEP-1uTgiq1jI9-00Cqyv; Tue, 10
 Jun 2025 18:40:13 +0200
Message-ID: <be43fd17-4386-4ddb-bb14-72d2d33d793a@web.de>
Date: Tue, 10 Jun 2025 18:40:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <90822099-5434-4421-a611-785511926ecb@web.de>
 <alpine.DEB.2.22.394.2506101739440.4658@hadrien>
 <629fa64c-ccd0-46ba-907c-97bebc00fa0c@web.de>
 <alpine.DEB.2.22.394.2506101831510.4658@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2506101831510.4658@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a3BJgLR02Bz8iXLecmHHWAftGGHoYlALXoQJZhv3JtpuMml0qsO
 6rhhQo9zgeazIBgGwzb092u7PNhfF990iEzeUTPu3owOKiJIuLzjlfjYqgXEJUs3agGoOMN
 OItbtk51hLYz3poBcckTf4jkcIF/3HpTQqlUF6hKGv/z/DC/v+RUKyTQqtZ0FzzjqwMf95d
 xEFEIhYDTxN2yXGwfrfDQ==
UI-OutboundReport: notjunk:1;M01:P0:O+dcEYgL/NY=;yaO37VHIR7OtJkIuJXv/NxOWPxL
 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
 g3jSp0i
Subject: Re: [cocci] Checking another deletion of redundant null pointer
 checks (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2756
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/be43fd17-4386-4ddb-bb14-72d2d33d793a%40web.de>

>> The mentioned test cases refer to the same Linux development repository=
.
>=20
> Did you check for the HANDLING comment as requested?

The log file =E2=80=9C=E2=80=A6/Projekte/Bau/Linux/scripts/Coccinelle/dele=
tions1/next/20250606/delete_redundant_checks4-errors.txt=E2=80=9D
contains the text =E2=80=9CHANDLING: ./=E2=80=9D 7675 times at the moment.

Regards,
Markus
