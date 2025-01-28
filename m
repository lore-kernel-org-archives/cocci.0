Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A996C02192
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 07:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9B/emTlCXMSxlx4xWwbcX65qZw1v4q1PyhnmkVUqcV4=;
  b=kxfr3yPy5hp3/sUacDVuN04zwKF68/nnrs7iF/ctyRig2iNkrRDq130S
   U72l9FpILRwUBc/hT+J28CfLNpmSnoldWVb0ul98qv+GaQEhKSDNBsaAc
   9LD58jIBQp9aEzdrQQpAOC+ZRdw4MpQ8wwoUrRI7NqowlH9KhyOKtsHj0
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
X-IronPort-AV: E=Sophos;i="6.13,240,1732575600"; 
   d="scan'208";a="205301061"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 08:00:53 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5A772E0D1E; Tue, 28 Jan 2025 08:00:53 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2CFA6E00A5
	for <cocci@sympa.inria.fr>; Tue, 28 Jan 2025 08:00:49 +0100 (CET)
IronPort-SDR: 679880a0_FopbXSwx2crYmnSEia4OxviuzF+ALSpGl81uOlwBaIcapOJ
 VR/sJU5/0Zo3XNElCwjwSPaP8RlKa2+xaegTihA==
X-IPAS-Result: =?us-ascii?q?A0HmCQASgJhngAwR49RaHgEBCxIMQIFIC4JEfVozBAtIC?=
 =?us-ascii?q?IROj0+BdDBpg1KPEYh2gVaBfg8BAwENNA0BAgQBAQMDATiBVIIuRgKKdQIeB?=
 =?us-ascii?q?wEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgoxh?=
 =?us-ascii?q?XsNgmIBgSSBJgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAg06RAEBAQIBIx0BAREmAQQLCxoCJgICVgYBFAEBgn4Bgi8BAw4jB?=
 =?us-ascii?q?w0GtCJ6gTKBAYIMAQEGgUYF2RAfLCJXgWQDBoEaLoVrgmMBhiaEPCcPgVVEg?=
 =?us-ascii?q?TwLgng+aYFhFwEDGIFGg1uCaYIzhE1nhmZUhkSTEVJ7HANZLAFVExcLBwWBK?=
 =?us-ascii?q?UgDKzYxI4EmBTVBOoINaUk3Ag0CNYIeJFiCK2sEBYEtgjuERYRThV2CFIFlA?=
 =?us-ascii?q?wMWEAGDJ3kcgXQdQAIBC209NwkLGwY9nUQ9hHhFgVFOkyyzCDQHgjiBZoFjD?=
 =?us-ascii?q?IoplTMGEy+EBJNADgaSe5h8IoI2iyybKYFnOoFcMxokgzZPAxkPjiGELYELg?=
 =?us-ascii?q?1XEc0I1AgkxAgcBCgEBAwmFRgEBilGBSwEB?=
IronPort-PHdr: A9a23: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
 NwRR7UdWFFnTpvy5Wx6EdZELJolB1sZ
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:pq66gqN6+v4FzsBcTlOjsMiBIKoaSvp037BL7TETdfUxSKelfq
 +V/cjzuSWE7Qr5IUtQ4+xoYZPwPE80i6QFn7X5TI3DYOCOggLBQr2KhrGSoQEIdReOktK1rZ
 0QD5SX/7DLfD9HZbqR2njfLz5pqOPszImYwcPXz3JiUQYvUa1m4gd/BEK6CwlOQg9CbKBUKL
 Osou5Opz+vZXNSVMi9C3kDUazivpnzkpTiJTkPAxJP0mSzZXnB0tHH+5ny5GZmb9snq41SiV
 Qsc2TCl9qeW5bS8G6m61Pu
X-Talos-CUID: =?us-ascii?q?9a23=3AhfxT/2syi391WJsXCAPW5X7q6It6bmTXk2X6OHW?=
 =?us-ascii?q?lAEU2cKSeV3Gc/bFNxp8=3D?=
X-Talos-MUID: 9a23:CG9bogjNv9gI8DFa1nSh0MMpCcln2YGrKk8xlapYiu2vG3IsMjiZg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,240,1732575600"; 
   d="scan'208";a="205301040"
X-MGA-submission: =?us-ascii?q?MDH2WZQgXmV5NVbQXGXp6fAMIeRkxVOLzXqCy4?=
 =?us-ascii?q?BiULKOw6g5wpdqOCWdL2ktbUwVf/HNabtqs2N3NUf/H6Iz/8B27w1RUg?=
 =?us-ascii?q?pNlMF/ZIPxi87M2oo9H0RqaiZaYUc4hgIjGu5Goplg0I9tkcjikoTg27?=
 =?us-ascii?q?wPjmzOT1CHwyn+9gSPHh0e8Q=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 08:00:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738047646; x=1738652446; i=markus.elfring@web.de;
	bh=9B/emTlCXMSxlx4xWwbcX65qZw1v4q1PyhnmkVUqcV4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HvExc/YMy0d/bGbUxBvq6imzY7soFyv2lIgkXMG3lodcrmqwoT8jfizKUpsLhgVJ
	 BScNQQ2O1VPVnTG6au9U5pZOPA4g5dhbnaXKw5lw6DnJ6z9h7cKrqasOkn72YZpGX
	 bEsdfp6gzzft6HxFDsO8ayDlHtjZibh6qzi59pR7bpK84St6plHRmgf31q5B8zAQh
	 q+2b2//UcqTgCM3nHfirai7OMN+uOHOTx3afopiPvmeaZ2rX3Irgl4Vk+dh0UMoVY
	 SFSO0iWD0OhoFO9EF+tb79FkLb/B4SOZcfzpl+ycMu47zroYTQBx7a8YlSR0H3Erd
	 ao7Khz7I3Ex47iCTog==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.40]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7gXQ-1tQ0OS0xjW-015gnw; Tue, 28
 Jan 2025 08:00:46 +0100
Message-ID: <400f2764-280f-4bbc-9814-dd6596137fc4@web.de>
Date: Tue, 28 Jan 2025 08:00:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Victor Gambier <victor.gambier@inria.fr>, cocci@inria.fr
References: <CANiDSCvLCaMdJVSMahNgg1UQMh3naoTrWGh=9+4p8pePWyLStg@mail.gmail.com>
 <1176708922.5283093.1737643285348.JavaMail.zimbra@inria.fr>
 <CANiDSCsj1r34A5ytx5u_XrJwysyX3n7oOVPO7xGOPvUgHrnHSA@mail.gmail.com>
 <e8572652-54bc-475d-a25e-241fdb83b9c1@inria.fr>
Content-Language: en-GB
Cc: Ricardo Ribalda <ribalda@google.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e8572652-54bc-475d-a25e-241fdb83b9c1@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oditIauS5VbdLlW7MkJapEdt+OuSztwPX//ATPginZSSpdBuX5k
 IPZzJTBaFoIEdcy5XuIPlvS4mSlIM/tntIqneHLaIbD7fLSm2VYtEoAJYnNq16xVEe4kOu7
 Oi6pID4QmK6D9aQ+mnow1vutepyj6z8Dj1jm12JPGgrHks7rKxYdlA/o1QR5+LEaJ3VL8uN
 mc6qCQBIwnN+f2GL9GIww==
UI-OutboundReport: notjunk:1;M01:P0:xF+ChezncdE=;EC0BohIJIlTxdwB0/RNElRgd910
 tOIIopZT0zuPxMUE/xq8ro6NuKUDmZAr/gyLOhEqxNbNpKI9cY1VcslvxGkBMKapxij9Rwvhs
 i1bhExcTlhFoNOCPp8QQGpUqguJ5oVdZ5hAHrrQGQzac/ahbr2ZFeEJzSGDiACmkI78FcNTdT
 jLfgwdjBVqOuWI94jECatH17HKMkRMI2p74aH6aRY8B4dWTL06XzGIWpi2uRHW3I+gKeq6jrt
 TmGhCDEsksHqOMn5K2Lz9jGTZHgM56b/Rdl5CgZJYOxPPoyds7wlUW4FgG9huRGSFq3JUDLKh
 U8U06Y7L3SeNykqG/Lx7m6zx3KuK0L4wzDlTt3wXWLj6hEI7L3Qi9VpkIaqMRad00JODgtejw
 sXGpLYnu5g0MwSJF9nyEUPP8ZE1huJS+O71QICnWq13h6lNdFXq7JyZYm0dQQ5A+fMNDaZ80h
 jONgLj115Pk/dPeyyaknO2FmjyN/l1LBIwtZu1QeXOFl1HWi94acvDFRn7M+cddBQLIP2MUDC
 rz8qtESKqfSJfL9/ECG2PQAG8WOSGwR97tUJl8t99zR3L26NATQ5wm4tmXMtecQUjLD9PIq+5
 fZfiUp1V1tsnlja1d0xwlxIIlho1nX/QXjmX2L01mckVtmRuYLDCkyt8sl5kgRlxcAkA/Acxl
 uLE48EqQSMzD9GErGeiZ2vDHkM/gNPL7Hu+w0d8o4gmBLrC/2RPWzVyKp4AQB8e0cHU1Qu39K
 9jTQHF7gfhCtor8syXRQmRD6RP04EF7dx/cLAHIxowieu017gfkGbpldXKjkF4vjPEwSiQVLM
 w2449gXtUKz7rubgf2r+qQgHTEigPGuUghdTGrHmsDwuUBlLMSJgdDDKnF+E5zLb628GW7eLP
 S8zfC3QBwHbSn4buOFZjgd2oF2xj8rVQ/mDV41xc6Nrk2hLwWJ0zKUbkPzJlOCP6qnl1nT6vd
 mbhgkluPJC9mXOOm2VmS7NCIfyfX5zbrzIGEML3673rfdQNjxQfl5g9A7EMKMr98qfBM7vMDU
 Lylg1I446mX4ecITYAyiBL+0bTdDz9oI0b+U4U6TxwruHcRt73EuHy/W1aMOZUGZShJhw1dFB
 GaRDzmfKwyRHjRYKIpILIguRUJ8D8l0Jaou1dMqF1V77e5y9Xxu8s66Oh8jg2f3f7e/UgGaLu
 APH2cBG3QbUOiCJJTSLmqLKFT+cbSVKPbgT7Un+q80Q==
Subject: Re: [cocci] linux-next: virtual rule report not supported
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2240
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/400f2764-280f-4bbc-9814-dd6596137fc4%40web.de>

> Either way, could you give me an exact commit for both Coccinelle and th=
e=C2=A0kernel?

Some background information can be determined from the software developmen=
t history.

* The message =E2=80=9Cvirtual rule =E2=80=A6 not supported=E2=80=9D is pr=
inted by the function =E2=80=9Cmain_with_better_error_report=E2=80=9D
  at least since the commit =E2=80=9CCoccinelle OCaml interface=E2=80=9D (=
from 2018-02-13).
  https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/8aa44ca0ff45be70f12=
4802696ea58c75843e2a9/enter.ml#L1817-1819
  https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/16d8d59045f44a4e8=
ec5aaca6f93e92eb70c32d9#e61968b4114d844c3d3796dbcdec266ae7ff5f53_0_1621

* A program call was adjusted by the commit =E2=80=9CCoccinelle: Update th=
e options used
  to the new option scheme=E2=80=9D (from 2013-06-20).
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/scripts/coccicheck?id=3D93f14468491747d6d3efd0b3a42785b1d51a127a


Would you like to clarify the handling of involved details and program exi=
t values any further?

Regards,
Markus
