Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F85C3600C
	for <cocci@archiver.kernel.org>; Thu,  3 Apr 2025 06:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Z2mXjRtgdg0FOaJ25YSTkoC76+W+T6jrfh7gFrmkiX0=;
  b=jfbVihjoJAzhUInx0R3Z5AHjKUA8J3tvqR1vtuSkIENiJFa2jDQPDlwY
   +BPGuhbP6X5wrRP7/myo0kwGcFHSJjgrdr22JjztuHknmAip7ZpQ9spKS
   4WtlrwIgdC+Z+l5W4clq+wsxQn6Zd+wb+Lyu3VIkPTPNdFcAPDLzBwKlf
   I=;
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
X-IronPort-AV: E=Sophos;i="6.15,184,1739833200"; 
   d="scan'208";a="216120708"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Apr 2025 08:50:36 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 397E6E0D1D; Thu,  3 Apr 2025 08:50:36 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 83911E007A
	for <cocci@sympa.inria.fr>; Thu,  3 Apr 2025 08:50:34 +0200 (CEST)
IronPort-SDR: 67ee2fbb_eJ5/oPLQsrVLiWQpX99p9IDUHbjJG0pwmnesJ5KjgKy8Tgj
 fd7Xs1OiA2IQuheGSF5kPNiR0IT2VcJp80bgQJA==
X-IPAS-Result: =?us-ascii?q?A0G6AAB5Lu5ng07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UIEAQELAYJDgVczBAtIhFWPUYF0MIQ7hzuHU4h0g1QPAQMBDUEBAgQBAQMEg?=
 =?us-ascii?q?gyCdAKLKQIeBwEEMwYOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABAQE6Bw47hXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJ?=
 =?us-ascii?q?gEECwsODAImAgJWBgEUAQGCfoIwAQMOIwetc3qBMoEBggwBAQbaXB8sIleBZ?=
 =?us-ascii?q?QmBGi4BhWyCYwGGJ4Q8Jw+BVUSBPAuBCYFvPoRDg1uCaYIzhB4lZ4wUhDOES?=
 =?us-ascii?q?4RaV4JxhEKJYFJ7HANZLAFVExcLBwWBKUMDKjQxI4EiBTQ0DlqBY2lJOgINA?=
 =?us-ascii?q?jWCGyRYgiZqBAWBI4I1hDyEQIVNghGBXAMDIgGDHnUcg0WBKYQXRi1Pgz4/H?=
 =?us-ascii?q?UACAQttPTcJCxsGPaRthD4IgQ2CSx49xWU0B4I4gWaBYwyfXgYTL5dGDgaSf?=
 =?us-ascii?q?Zh+IqEgh3GBfSSBXDMaJIM2TwMZD44hGR+DdcoVQTU8AgcBCgEBAwmFRgEBi?=
 =?us-ascii?q?lSBSwEB?=
IronPort-PHdr: A9a23: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
 tWdzMrO
IronPort-Data: A9a23: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
 IT7qa2ogK12dKIpLftdRg==
IronPort-HdrOrdr: A9a23:6IVyh6zbzNyxYpIqg4UmKrPw+L1zdoMgy1knxilNoNJuA6ulfr
 OV7ZEmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bHYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFeb/N5DNB7foSjjPIcOoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: =?us-ascii?q?9a23=3ArYdZNmv47O8JmZi7QF8ZHKyo6IssSmDZ6yrRYHT?=
 =?us-ascii?q?hMjw1deOqZlrJwpprxp8=3D?=
X-Talos-MUID: 9a23:YArqmwh7SYNhL7BzSjTNisMpFftx7pmJUWA0tqoBhPaYF3MzEgyDtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,184,1739833200"; 
   d="scan'208";a="216120699"
X-MGA-submission: =?us-ascii?q?MDHpEBoP4uytQKZ4DW3QiWk8AdvI4tshbjrxCC?=
 =?us-ascii?q?AnikVZohkDZfVuUTaKRsSb+4vy+suw3nSCSR3jJ84WF30n4iWz4SY6Zn?=
 =?us-ascii?q?+tcMUHBSPh9Ij1BFyNobKyBXe7rSz7lWcOil9UWN2YTVzeEqLkMjxoo1?=
 =?us-ascii?q?o8dI97ixsX0mx3RqBmClITGA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 08:50:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743663028; x=1744267828; i=markus.elfring@web.de;
	bh=Z2mXjRtgdg0FOaJ25YSTkoC76+W+T6jrfh7gFrmkiX0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lb7rW0OoEhQO39MIhzo2okpyQVb1NV7lCgkeY+klDtvtKP6kvJzHrPSoitk1VHwx
	 xmQdhkqx+tNmx7SG9UNWcMC+A3hHSwNB11nLolNWma3wCTbLW+svi2gTP4SYfWL79
	 kjWhHjWspd482WmO1b17j+WIsLReRe/isKSXDve9aAG2ERksVXQaxA87nKlvdU12Y
	 WW1PAiU6la7O3kHD4oROGWKqmBXukwOKf07XqI2dDS0q7vvKx0zQWZmq+4VbjBWQ3
	 Tu5bEt7CN3nqPy7zSjRd6/6bQIJvtKACbKTHB+xH8HdNzw5l035VQtvmj3GaMfF1+
	 NbNSiu/QsRZL1077jA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.50]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTOli-1tWYT13XX2-00LIdj; Thu, 03
 Apr 2025 08:50:27 +0200
Message-ID: <f25737a5-b012-41a5-9731-6da1221e2773@web.de>
Date: Thu, 3 Apr 2025 08:50:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Luis Chamberlain <mcgrof@kernel.org>, kdevops@lists.linux.dev
References: <20250403020123.1806887-1-mcgrof@kernel.org>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr, gost.dev@samsung.com, Davidlohr Bueso
 <dave@stgolabs.net>, Jan Kara <jack@suse.cz>,
 Julia Lawall <julia.lawall@inria.fr>
In-Reply-To: <20250403020123.1806887-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lLkC1k2NZGJo0Qa044kWTpUWNqFJs+Q93vtDSSfgdMrLjhQEfLc
 H6Ei8dWBzdzaOngjRNtsJlwEez0dWMS+OynVX5pgIjciJ9oL/2Mze5KqnBVSUDyE6YfARWD
 IaNPAgxhDqRblKV7q1bCvL+Oe2L37P3+dL6No/tgOp9b5pBuhVY4K+NEHptCco/IHB18Rkr
 Q5NrMbqbtiDj5KM4pbwIw==
UI-OutboundReport: notjunk:1;M01:P0:GVod44d/i3k=;gP4YVtqVql/bp+gSUQp5VY0a+MJ
 vw+VQ1RkDm/u2ExoFyw29b/deUy668pbwF3NbFfcA1tOr3ODXQDnrJ0k59YQvgqyDwM0bVITn
 Sp8DbtlBgCka82hdibxiK55i/2HwBMcJqN2tC8JV/VIbxlYa5EYUcggfh8vTIFxyAESjRuLFZ
 pd07Vih+GW+SU4bNsH18GCMQ8XBOmnIXysXelvI4bnwo+zDauue3P6DCU3ISKIS2CejnmQMap
 HWmnWvRLdnC59Xa6WFE+fCpSLG0JBrr+jjzvEmoaU1Q5WsJJfQs77J+XqqgN+mW7uev3obRhK
 aBWSlC3U1mKhO2Ke5ZKiHJzT03A82AFa/zqxFO351ZiFVvO1s7isawXMzUrZqpoB4EjTSg+zE
 Rq/0rudV0FG0iz9XBNi8seAvr0ueR1tbjknPpK0bhYGSrqr6IeqblCVJRXxeTb8OJgSVpfHE6
 K6FowKXXCzoV9zAKpyuJGO6K7Z8BB5wiQnMVqPOVMDWis5bhS1emVJNualWcCEztMVOv1D0fg
 wnzqp26elR4ktE2lwCL1mihT10qzJZEB2JhiiJL8OzDugDfkBXaTFSEdjIAnhCVrPQ5no805h
 XMS9u+PBQWP9fCFgcYohMFwwkcuE/oVsrE5oDP2Q6xE/QsiMxkFwtVz34ymkL1qh9V8lwMNc7
 ubTk/KxObSuF46NOXl+eJYIhprHhDeUPLvtQ7e6WtAvURFEpUUNyUbYwkGdQZ2gcg0GFzGB/t
 rUCtPxFHia9YlXOoQ420SsZmbH79D4MBfAlvR9GYZ1jnYB4dcrSocx2iOL6ofJeaapR7vjLRY
 KhrBiKqp8uOuqXBhMla0rHntTlZHNanUh2LoAgYuOnDNtKzks1KMx0Moc5SUffbdW6AwXhvL1
 PlI68by1VbG0laK892jlwWhJ0jFSx8+MwCDosD2XgyGF36/9qMnN3WMzmkNF41DpjAvl9eO39
 tC1pN1SpvF4iD663T+NfiU52zyIPqj5pPK5SCI3FwJ0XFLt3d3YsxUJQlwX8bknsR4ay6Q7PQ
 rvUfE9K7luJ+4ZvFCIquXdB8p71FYNKx8DG58E5sw/b1PN8/zyd1264BuP1hoSoARbTNAbz6L
 0uBdgUviGfqadC8ggzQwEwmIbotiQw+2hYoaIn2iKEyAw8KBlI+0FChV63P5qKxa10x8KljSo
 UL+EMCgG01brF4QYfpEJWTkGM2+qBtWcvsrvrbOgbtH6ymyBQQv1b4AVfPxAoPUBeh00LxcZc
 UPSsyn2S4T6UxUOdaZHNxofAPEdT8VDwq6JI65n+jnJV59dP78+K5RkXXQC5RPKpTgBTOXTYA
 KMJQwwfsXtlTZlkeyn2RjX8oe2dfqW0EjdlDy0Id/0u4NG9fZDrl08lw+UtqSD8GUoKehCNaG
 oQibXJ49zdemoA2TnQe7l4qSdKuKp2egXxTIe2wL0i9qQxEYDsvY1a7cmI5GzGh+Tcpj003Yh
 uG3DxE8/Qy8oRNGYXmZ2DbQI74aUBOHBwQGPEdfBazk8MqEqL
Subject: Re: [cocci] [PATCH kdevops] scripts/coccinelle/generation: add
 example generation script
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2683
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/f25737a5-b012-41a5-9731-6da1221e2773%40web.de>

> To do complicated tasks it is sometimes a bit difficult to write
> a coccinelle rule.

Some data processing challenges can be usual.


>                    Such is the case when you want to use the iterator,

Would you like to trigger any improvements eventually also for the softwar=
e documentation?


> which can be used to help check for nested set of calls.

Can the indicated nesting point any related functionality and requirements=
 out?


> An example use case of this is when we want to check if a routine
> may call an atomic context, or if a routine is calling any known
> existing sleep routines.

Can it be that your needs would include support for inter-procedural analy=
ses?


=E2=80=A6
> +++ b/scripts/coccinelle/generation/check_for_atomic_calls.py
> @@ -0,0 +1,443 @@
=E2=80=A6
> +# Generates a Coccinelle file which can be used to track down if a rout=
ine
> +# can sleep up to --max-depth levels (defauilt is 1).

                                         default?


>                                                        You can either sp=
ecify
> +# the sleep routine you want to check for,

Further configuration parameters?


>                                             or you can use our built-in =
db.

I am curious how the support will evolve further also for databases.

Regards,
Markus
