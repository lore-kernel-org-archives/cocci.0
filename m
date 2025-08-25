Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBD4CA0FE1
	for <cocci@archiver.kernel.org>; Mon, 25 Aug 2025 07:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=x7b7KM6j1olmX7tk4Pi1MmXVIPo5kgG3MZLq5xyTLm4=;
  b=U9sqUP0QFK3go0pALJwO02YJc4QxT/q9qM11JWpyXLG/VMWJjRVMhvrE
   alEJ3VgJD1XZZcpfy5XGa+RVQ/2khzQrwhRYsiGUlPaco8GNwmuNvDrqB
   CnpDtcMZxG85LedT7l7GJtWZExGnYlY4JsONF8Zah4m5djZKO6DUUaxw3
   Y=;
X-CSE-ConnectionGUID: QbCoDNT5RcuLqqKw0LT3TA==
X-CSE-MsgGUID: aggOJ4BVT1K8WnngkkBhsg==
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
X-IronPort-AV: E=Sophos;i="6.17,312,1747692000"; 
   d="scan'208";a="235946329"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Aug 2025 09:30:44 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F39E3E0BE9; Mon, 25 Aug 2025 09:30:43 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 85AC8E0172
	for <cocci@sympa.inria.fr>; Mon, 25 Aug 2025 09:30:40 +0200 (CEST)
X-CSE-ConnectionGUID: ejpEg5/WS5OHsnUaJjOgFA==
X-CSE-MsgGUID: kVEkGPj1SlSUzvyHAhSxcA==
IronPort-SDR: 68ac111f_RSvpTvNVB+VFapxGZZ21l9/TcJFXeF5RuKNdck4EpP24Lb7
 /sHLFEuTDy7D/CpUce/9MBnm38t/q5YDUAm7yww==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EJAQAiEKxogA4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAYI/gQdUMwQLSYRVj1CCJIQ7hzyHVYpOgX0CDwEDAQ1OAQIEAQEDB?=
 =?us-ascii?q?IUAAowmAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBOwcOCjGGTw2CW4EsgSYBAQEBAQEBAQEBAQEBAQEBAQEXAkdEAQEBA?=
 =?us-ascii?q?gEjHQEBESYBBAsLGgImAgJLCxsBAYJ+giMBBhABAw8mB7BVgTKBAYIMAQEG2?=
 =?us-ascii?q?l4fLCJZgWQJgRsuAYVrgmQBhVyFBycPgVVEgTyDAz6EQ02DDoJpgiaBFoNYl?=
 =?us-ascii?q?m5SeBwDWSwBVRMXCwcFgSBDA4EPI0sFLR2BJ3mDB4EOg1tFK0+CG3KBdUEZP?=
 =?us-ascii?q?4NTHgZrDwaBFRkdLgICAgUCQz6BcQYeBh8SAgMBAgKBEBACM0ACAQttPTcJC?=
 =?us-ascii?q?xsGPZRPhwcSkyCzKTQHgjiBZ4FkDJ9sBhMvl1IOBpMFhiKSZKlBNoE5AjGBX?=
 =?us-ascii?q?DMaJIM2TwMZD44hhDO4TUE1PAIHAQoBAQMJAYFVg3ABAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 uU=
IronPort-Data: A9a23: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
 IT1qa15rJmHdHPM
IronPort-HdrOrdr: A9a23:1a1qGqp5r9J8QUDFkLa5SLwaV5r/eYIsimQD101hICG9vPbo8v
 xG785rsiMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLWrbUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaWSS5vyb3ODXKadD/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: 9a23:ef1OS2OlOGXuse5DVSt/2UFJXf8eL1r913HtKm26LmlHYejA
X-Talos-MUID: 9a23:81VXywsnTqIKyNHPW82nhw9PN+hQ4f2VDHswg4sXm+CEDjx7EmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,312,1747692000"; 
   d="scan'208";a="123806336"
X-MGA-submission: =?us-ascii?q?MDE4tmIXxCJj8vpMXF1aIZjFnCs2xGEZTl1/qg?=
 =?us-ascii?q?75WGTbXHkcqoijIA+2RXX6s7z73eoxXbMMtUguZCzwBOovWPmfxwMGxa?=
 =?us-ascii?q?yyBTLawtYqtdz5YsFVbdxa4CkrPlOsObBn6NczGGwbC+pnyMU85teRSp?=
 =?us-ascii?q?k7KWI693yxWgmtzp95Zcca6A=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 09:30:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756107038; x=1756711838; i=markus.elfring@web.de;
	bh=x7b7KM6j1olmX7tk4Pi1MmXVIPo5kgG3MZLq5xyTLm4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Bf43Z7A+G6ojwANsnOwGvMsuX6uIyh3jMjJWDa55cVBpY601EcRaFE5yTHlIPAO1
	 ITTylTFyLy+WljwwX5iyJ7rtDVxQO6VmizUjkCOT9sbI9c842CZOTRS+Qb3DJMJiF
	 zmAtwkW9YpclqFdgrDZOUzXO4emgaf2RgZQHkU3ykuE3VVvNiv++NR0GqjZgdmS+Z
	 WXpXkGI3+U2UW2z6OOqoUcxkWmrL5VHreU11GLF30nuIqG4Zsi9yJ+ic20WhMoY0i
	 C9IeGk4usw0vHKMeJW1Ek2xkRSZuZhC9hBIm4kpLBmrtYGNQyDgyIuxoE5Am1zrcu
	 gZSQukY3iefxiTbz+Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.250]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8Vsr-1uUwdb2wXR-0127ni; Mon, 25
 Aug 2025 09:30:38 +0200
Message-ID: <eb3e0445-39fa-4f4a-aeed-96eadc94657d@web.de>
Date: Mon, 25 Aug 2025 09:30:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <574a6fa0-00a0-43c2-8e66-cc6443f5cfd4@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <574a6fa0-00a0-43c2-8e66-cc6443f5cfd4@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sbUIoRHwyzbe1P8FCbNYmE/R/rNOv01LsPWd08M73Kg9f/teBny
 kFyxD6qmbqCLkGlK8f4OciGgZ0SteyAGrkz86UEj3tI0z4ij5PF8OSUZqBfxt2wa1om5wBF
 zBw3PgJfVfz4/CdANXksyh6UvM1+Pj6jYoqQvTP0X9cSwwZDZVWrbZYF/ahUMWZFIQZbxHE
 +vSI4f6h1wEDXNm4FcfQQ==
UI-OutboundReport: notjunk:1;M01:P0:NGK5Ld/ho2c=;zDpl6giyDuvkyR5NakLjUaAa5PN
 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
Subject: Re: [cocci] [RFC] Choosing =?UTF-8?Q?=E2=80=9Csemantics=E2=80=9D?=
 better for SmPL script parts?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2981
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/eb3e0445-39fa-4f4a-aeed-96eadc94657d%40web.de>

> A bit of information is provided about special =E2=80=9Csemantics=E2=80=
=9D (also in the manual
> for the semantic patch language).

The usage of the semantic match functionality influences which default sem=
antics
should be applied for the evaluation of an SmPL rule.
I imagine that the corresponding data processing can become more interesti=
ng
when the needed semantics would actually be the opposite setting.

* Do you tend to look for the existence of selected implementation details
  more than that source code variants can occur on all executions paths
  according to evolving control flows?

* Would you expect to use the source code search parameter =E2=80=9Cexists=
=E2=80=9D more often
  then =E2=80=9Cforall=E2=80=9D?


Regards,
Markus
