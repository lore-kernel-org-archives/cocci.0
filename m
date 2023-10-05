Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DC8E8FDC8
	for <cocci@archiver.kernel.org>; Thu,  5 Oct 2023 10:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=OMABXqM2+WUD6XbnneH8tAwpl1Z3fHWw8DGjVtGix9E=;
  b=U44EyJbFhCMgr/uoJuN4w4An/s8j9M3CpJeHJqF+uaJkTetDMtoNerP7
   SgLtQSUdbfgAKpQUewwCqhSQXcCDO8JtwDbkrPPDo3yqpFhKTR7SbRwtn
   3lP3atSVanNf1fQupVFlqmhTtWCAVszXf5E+uqY4WHKg3AnjydDJ3I1U0
   M=;
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
X-IronPort-AV: E=Sophos;i="6.03,202,1694728800"; 
   d="scan'208";a="129636432"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Oct 2023 12:33:47 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D71F0E00B7; Thu,  5 Oct 2023 12:33:46 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 80585E0205
	for <cocci@sympa.inria.fr>; Thu,  5 Oct 2023 12:33:40 +0200 (CEST)
IronPort-SDR: 651e9103_IpNSOh62MHqcEW0v9JKQ5K6/12gzdlwHsBT7zNYdKa1hS49
 dkdQ77OUzTVtwyrqF8+tscSyXyWyxbFwJ2s0XEQ==
X-IPAS-Result: =?us-ascii?q?A0EoBAC1jx5l/wwR49RagQmBT4I3B3MDUzAEC0iEU488g?=
 =?us-ascii?q?XYwhDuOfIhugVaBQD4PAQMBDTkIAQIEAQEDBIIMgnQChwwCHgcBBDAJDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQKBBhOFaA2CNysBEYEMgR4BA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEXAg06QgEEASMdAQERJw8LGgImAgJXBgEUAQGCe?=
 =?us-ascii?q?gGCKQEDDiMHDbEMgTKBAYIJAQEGr1QfLCJVgV8DBoEaLogKAYVRhDUnD4FVR?=
 =?us-ascii?q?IE8gwQ+gkoXBAGBXYNbgkYihAWWKmEREwVCcBsDBwOBAxArBwQvGwcGCRYYF?=
 =?us-ascii?q?SUGUQQtJAkTEj4EgWeBUQqBBj8PDhGCQys2NhlLglsJFQw1ORR2ECsEFBeBF?=
 =?us-ascii?q?ARqHxUeNxESFw0DCHYdAhEjPAMFAwQ0ChUNCyEFVwNHBksLAwIcBQMDBIE4B?=
 =?us-ascii?q?Q8eAhAaBg4pAwMZTQIQFAM7AwMGAwsxAzBXSwxZBGgEDgMZKx1AAgELbT01C?=
 =?us-ascii?q?QsbBj4CJ5t9bYMkUiuBXsUxNAeCMYFegV8MihaVDAYTL4NukywOBpEogQ+YN?=
 =?us-ascii?q?yCNQpppgWM9gVkzGiSDNk8DGQ+SGDOPSD81OwIHAQoBAQMJhUYBAYNagigBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 m8cm/xu34BQabZpd7fxkfR5
IronPort-HdrOrdr: A9a23:F/D6b6syAWibNGIdpGH2l3ae7skDqNV00zEX/kB9WHVpm7+j5q
 OTdZMgpGbJYVcqKRcdcLW7U5VoLkmyyXcY2/h0AV7mZniAhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgjWQL/Zl5sWb+6a1gurkw25qVhwCUdAb0+40MGem+lYdfng/OXPVLu
 vm2iLNygDLRUgq
X-Talos-CUID: 9a23:S9xbUm09RHYwKHFJaYWscbxfPZAuSHzWwnbrMXSBFDhVFryJRFLM0fYx
X-Talos-MUID: 9a23:C07asAYfRhEVpOBT6WPuq2pfc95T4KX/IXBTlZYgldSDKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,202,1694728800"; 
   d="scan'208";a="129636405"
X-MGA-submission: =?us-ascii?q?MDHP5O/zxHIt17/S0SKc9HxHWavV140VIDToXG?=
 =?us-ascii?q?26DPxrHEe15J/vGM8OtRQ3raudn8WJzHbcMuJ4ZPV36T4SmBA12jVDsp?=
 =?us-ascii?q?fxSTEgcpONUvyuiuuRtnuQXmsaLXRQAT/9F62SqzPutzWZiGYseLxsbh?=
 =?us-ascii?q?nnnOmYTDkXreBqU+Nn8sY43g=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:33:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1696502011; x=1697106811; i=markus.elfring@web.de;
 bh=OMABXqM2+WUD6XbnneH8tAwpl1Z3fHWw8DGjVtGix9E=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=J9ifa4ZuxKeKIkswxWblP8xvO2Cfb8J+uxOSUtO9Kek4Z0wyUybzZkQ5+Bbr1WSPM4+tRQyFLm+
 W6kzgTGVaTVjAUpE2nVAqlDjr67zvKdvH04kxwzQuVoO89K42OuXtCHD1TFDEiU7N0/Lf0TkfkqYU
 v0wAMsTNt1Ucm/aVoAh8nOCWL4AVABefMH0p9cd0nJGRkKjDsKJiRzuwOQrlUAiRnwi261ABCJ5JK
 RenGJLoh6cxX7RbAQw+eBRBENaQcnD+27DLQBQe3L84TcVhuTqS7wRkgH6nwnIHtV4/KhvavN6baL
 kyyBFrkqUQM7gasCcudoCCC1WPNcY1NiSDlw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2xrq-1ql3sl1SF2-003NwR; Thu, 05
 Oct 2023 12:33:31 +0200
Message-ID: <0d4309f1-9b52-47ab-bae1-e19be92346eb@web.de>
Date: Thu, 5 Oct 2023 12:33:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <d71be555-d569-4ccd-9f06-4b33d8095e6f@web.de>
 <alpine.DEB.2.22.394.2310051159410.3375@hadrien>
 <29542ba7-5d13-4089-abc3-5ab314af4fc6@web.de>
 <alpine.DEB.2.22.394.2310051222530.3375@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2310051222530.3375@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AymN/l04uoxflxllYYF1g3rgYLxAdumlwmMrnQ67RJnzFkry39v
 p5XUr4GV+rjm5ob5MH/itfyk5QHA6dTOVOfZ7bRX6FPTIvuftSiwjP6Lh5jegUIUwkiG0o3
 gLtlTZpP3MEsTBBGrcLDqxIHBskWkAgHel4CdSWygqFJ/Y513ZV67k+LmjMT/LUt0l06ar5
 h2ucJKSK2YL2g0RJFtelA==
UI-OutboundReport: notjunk:1;M01:P0:Q5D+aO51K2Y=;RAItTb8UFZJKiLXk+iWO+2c+kLj
 t0d26dIr5SXTobpw/I27u5GlSiXa8ZAPo07HL7EDm4t9F/77argIYAmhytLwJMnaPAaQXO98s
 6TQSe+NAQfA4ldQLCc3MKI8rrCJQbd2wF0dRpiq23GqsjK5N27Sh8rdG9edrqxSqo9NsXDSIn
 SWNpC9ImualpTp8MR3aoqda0T3VHENnsIFkQiQdGi4Bgw30EXBy1L8m+OtExD6dNEwlrqfMrZ
 0Rqvz+kkKkhS/fG8R6SSd8WvS0XgSd2/PZSLNTuNtaXMHusrVOnc3nDhHCkmTvJJC/dcsk3qe
 p5Fyyp4siAVs54MC5EeioFIfbEUIxu07SzjcI4keNBRxgnyL+w68PwC4Y5ZbQbFRzJqoREee5
 SXeawolhaaEgQ0/VuDifVCQrMpkm3e3HG0RHYO+3stQfDSh0uuFvWX18PRfOOE/b/+hVmiG80
 Un9NFQQlsQT34iX5bKRqIxE9l5XEcnsRWrQmRmDAm4gAST/LrlSo+tdtQMsD0/QdZ/aIKYYU0
 QPTMYMBnfuEdT1UpUck8PVcecW/ptmtKTLkzytPAovlIRjL5++TJ3EXelllaSx9i8+AA8ykvI
 7nCZENk22PCnda7QdLFKDvCe/6jE8i8bLuGcBzlJvRovL1j4Spk4waY0moHLwrAtwZFyaQX0t
 VVFFB5p8UKVeesjcg3BrhmiyzXCP0ddQxTKO8MLa114srmLFldhMy7K2CqxkMNz2RJFGeJ3m4
 ydDYN7WPVnaG/MJw9Nam55ojskjIeHdx5P5Un1ij4pxd3nH0LdDGsKWvVtWgzo/vOZXPCtmCd
 7QiUpueqpYxWjL9DBZC0S3HLX6uxOzN4mvg7pTaKvNXv7G1vgom9jT6++NFTPiO53nYn75Cze
 e+dT4ZSvgovCF1WNi66DfctypcEEbnz5rUKxVqXAktSipdrB2E4sv/KJbRAghYsUt5FPwiABq
 ur9eIrA1CaYjPAqm0VCQj6WmrGc=
Subject: Re: [cocci] Searching for variable definitions in C++ source files
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1248
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/0d4309f1-9b52-47ab-bae1-e19be92346eb%40web.de>

>> Is the current Coccinelle software status so far that the search for va=
riables
>> (where a constructor initialisation is applied) is not supported?
>> https://en.cppreference.com/w/cpp/language/definition
>> https://en.cppreference.com/w/cpp/language/constructor#Example
>
> I don't understand the question, but I think that the parenthesis notati=
on
> of C++ causes a severe parser conflict.

Can source code like =E2=80=9CRPC rpc(this);=E2=80=9D be interpreted in th=
e way
that a macro call would be applied there?

Regards,
Markus
