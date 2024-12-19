Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05710E77184
	for <cocci@archiver.kernel.org>; Thu, 19 Dec 2024 11:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=yIS23wpcXBrkTXtNc5uBzy+EXQ4ppoUmB9acNbxLFdk=;
  b=Bw0zX8rqy/lHZrkFBj0kB8w8xRGg4CuGjRfg4hyeI4QANjiajqRgMK4x
   FS9/RWE8/1plk4wPB0QzMS8D9XuEL2AHtBbl55uxFwynfSJ8Zs81zwy1l
   gG41P6vY9IwY2vSt8Ur5ry0hdv3/COr+TNCy78wRV9rNQtgQbbOpxxnQP
   8=;
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
X-IronPort-AV: E=Sophos;i="6.12,247,1728943200"; 
   d="scan'208";a="200032063"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Dec 2024 12:32:35 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C1022E0D1D; Thu, 19 Dec 2024 12:32:35 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8FCBAE0077
	for <cocci@sympa.inria.fr>; Thu, 19 Dec 2024 12:32:30 +0100 (CET)
IronPort-SDR: 6764044e_NzC+NuGE8668yWl7muakPTHZhe3nCzSX7NFkR0zKK6YLwfa
 n1Wg7pyQAeLQ+CU5R1XZ0jFOMXdRSgKoVfsYcsg==
X-IPAS-Result: =?us-ascii?q?A0E0BABAA2RngA4P49RaHgEBCxIMQIFIC4JEfVozBAtIh?=
 =?us-ascii?q?FaPTYF0MIQ7jxGIdoMWPg8BAwENPQQBAgQBAQMDAYUAAoptAh4HAQQzBg4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CYgGBJ?=
 =?us-ascii?q?GUJOAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?j0KRAEBAQIBIx0BAREnBAsLGgImAgJWBgEUAQGCfQGCLwEDDiMHDQazZoEyg?=
 =?us-ascii?q?QGCDAEBBoFGBQ1B2EIfLCJXgWQDBoEaLoVrgmMBhiaEPCcPgVVEgTwLgng+g?=
 =?us-ascii?q?mEBAQIBgV2DW4Jpgj6FeWeeKVJ7HANZMgFVExcLBwWBKR8rAy42MYIFgVsFN?=
 =?us-ascii?q?0c6ghBpSTcCDQI2giIkWIJNgSUEBYEtgj2EYYRXhhqCF4FoAwMWEgGBLh1AA?=
 =?us-ascii?q?gELbT03CQsbBj2dMUeDYWhZyFA0B4I4gWWBYwyKKZUzBhMvg3GTUg4GknqYe?=
 =?us-ascii?q?yKNYJVlhUOBfSSBXDMaJIM2TwMZD44hhC2BC4NWujFCNQIJMQIHAQoBAQMJh?=
 =?us-ascii?q?UYBAYokgUsBAQ?=
IronPort-PHdr: A9a23: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
 jfni6/5bjtPoYu8FSo0As/JNISYPXBnPRe7QFbp
IronPort-Data: A9a23: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
 YT4eIycfHyGdA==
IronPort-HdrOrdr: A9a23:F0TKWatrnirEgV+QBRMKkBTJ7skDqNV00zEX/kB9WHVpm7+j5q
 WTdZMgpGbJYVcqKRcdcLW7U5VoLkmyyXcY2/h0AV7mZniAhILKFu9fBOnZrwEIcheWnoNgPO
 VbAspD4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAb0+40MGem+lYdfng/OXPVLu
 vm2iLNygDLRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3AJdoBdWtvmNR1VsDRuYe/VvtH6It6dV/Y9m+ABnS?=
 =?us-ascii?q?nKmZiWZjKWATI2b5rxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AUo1pcwwabEOOPYdimNqXosw3cc6aqL2JMF4DiMU?=
 =?us-ascii?q?5gvLaGQxcIyyi1Tu3WqZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,247,1728943200"; 
   d="scan'208";a="104756173"
X-MGA-submission: =?us-ascii?q?MDH3n/0zLlPTRaWOIksfII+8nSCSS6djea1H8z?=
 =?us-ascii?q?ueX2x/vUlqw+J3pvaZYkOmLdhaPJaA/XhoAHuCz4v6wdCUqeiKxpOsKS?=
 =?us-ascii?q?wJaKV2+y0Z67EapWU0nfaPppGMo+a33rOIcBfHgGkilp9YU9maj6D+jT?=
 =?us-ascii?q?Hb/VbEVeUnHXx/0NpFLrq9Bw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 12:32:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1734607948; x=1735212748; i=markus.elfring@web.de;
	bh=yIS23wpcXBrkTXtNc5uBzy+EXQ4ppoUmB9acNbxLFdk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lRJnFVHR4/bQ4XVEy2aJt+/Mp6f3aQhJ8h/7eiRXQmHScAgzi2xwogo9rHtrFQuo
	 WY1smTCkvsJZuqsESJuLYB107s6A3PENOnTuBcwoDVIxbOEMIJhXy+kK29g6e/tH5
	 MhiajzfMMO6lpqlhtIw3UmbHNUgAJncwNxv0i6oL4jfpRCHmsQrOd2RRH+FwymqhZ
	 KvaO/W3k5bHOHVSGzbcRCEhAr2sLd/UMo4cIhJ7MihpykLU5hdRZvfVBfm6pnAz0E
	 6qUQ5OK7zOHv2nzxodLrOssbIci2dMYx4EWG3YZY2AMDijXk+jW9wrKZhyfMNm7b2
	 oX46qjyEHp6k0FIQtw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.70.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYLmo-1t2uXW1MH4-00UD8m; Thu, 19
 Dec 2024 12:32:28 +0100
Message-ID: <5c32cf85-fdb3-4836-ad1b-7c8a96882500@web.de>
Date: Thu, 19 Dec 2024 12:32:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mats Kindahl <mats.kindahl@gmail.com>, cocci@inria.fr
References: <f0764391-b0d3-48fa-8a54-6edddf8d2c8d@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <f0764391-b0d3-48fa-8a54-6edddf8d2c8d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:73a4MxBFAQv65wdyzoo/J7osorrRQMmIgsxmHfuMv6MWHjMpecu
 Wu5VaY5ZNQjJ3UzyNPFrzLqpJenYUdMwlqMPVn6v1j5ZIRNGFJ2EApEYx7xqIgfg3xgyqHR
 PGeLa9A0niQrfvUDcILhL+BIJIIOnb14qtbkUUjLm5Y5xnFpOnOcs8vz7/sJnZMsCBsBSV/
 BuRT4uxv72AtNFg7iPO+g==
UI-OutboundReport: notjunk:1;M01:P0:ul0vzQj+xhw=;2WIUjEz/wvXs4xHxtl3Ibf4YWUx
 kwCW103QI9E3SvPTCTFKwFERDTYiQqjhSnixKrfhuDLj89TmcdhTAkzGlRHxGx0F3whClQCOG
 5g/Q1fB4CAZxPeFs9goZ/KWCSH+vOsmVeCctIoA3b0x73+LnTozpk4RVwmvvqC9o6cUDsao9k
 YTLLTJM8QCBlDLhfEuvT3uGZcM99CxxpwgvTn+1SWlI0aJNaeB/3MIwEufzgcWrPm5TGgAiFD
 CKPyj3wDoARc9q6H9ZWGtifzS6FQqKeihyYtc9hrfzIIvWfFrXTZ1cXW4UgRdj5112iNJHHMK
 bkKDXp8933ToNfdrzeNDkxhfuB0uHv1tu4B5Kcg6O5WG6/lPwbN6XRzq0+4M7m34Yn/GUiN9P
 IYdBle6Y2IdYb0hZDxCKdw0mS8YTeRtPtCwWIio6/aIdg5oZFg4MnitaADndI72nbdnj8TjC/
 1vzsBr09wewa1TG3oFu6BQkHEnj5zc5JmrMQ5JPOIAE3LEdKlHIU3Mkk9IHtRp5UwYlOd/V9j
 LBwdq2aJvUG8WhUJmgFXN4n07o4jAbyUsFRb4Rsq81Tm8//aZ+hTrjwROb3AMRW/0bUGbX2r1
 PwSTOjku1bKCS3LfeXcdgZB7kRF0VPQq9raD4myP1jpGt1W8o5AQqF0US27Kmoi6uH7pYAaFY
 FCCnPyZnRI1BV2wFYCgxVltJ7jweeibva7zfvzydbGpPyIy36ILjsIuoWbuMCY/n8sC6vD4RJ
 bZKMypcUuJxBq/sA82UaiJZGh2QUvXF405lXxvvQeykdZsdZKQjKxBTCB6p5LPS+VvTNf0qKc
 HRAQG/fCMv5vO55uR4S7I0Ft77RslNg/7SSTOc3dfEFdu8QBJfYrfVIS9yz2zIo/NjuZfYrJ4
 nHFxn2wVIFU3a0Qadgo5Az3yuj4nnkIKjMrbJQ8cOFYqzMm1J82VOjGQVvFMW6/vxhHoAzZ9r
 CZOsowpFIEfj5o0Cc5Uy+xFErI5N6FKo/NVfRSuEbNDlWztnBF6awtlx5MzD0fwpnFB8czEDX
 om3fR/hGdjRNOV7OnDq94lV/NWDxeU2/21H03f8iGdeP8L2btAfGhHe3yEkT2S8iXPtlp4MfC
 bFLh7pkcg=
Subject: Re: [cocci] Scope for source code analyses (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2187
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/5c32cf85-fdb3-4836-ad1b-7c8a96882500%40web.de>

> I want have a case where I want to find missing resource releases.
=E2=80=A6

Does it matter for you if desired resource releases should usually be perf=
ormed
within the same function implementation (or not)?

Would you like to care for inter-procedural source code analyses?
https://en.wikipedia.org/wiki/Control-flow_graph#Inter-procedural_control-=
flow_graph

See also:
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/f0ebfea0e00e844e16c44=
03d790e9a8df87036a9/docs/manual/cocci_syntax.tex#L1771-1774

Regards,
Markus
