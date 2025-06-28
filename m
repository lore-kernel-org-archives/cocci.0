Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB68BC54ED1
	for <cocci@archiver.kernel.org>; Sat, 28 Jun 2025 20:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Ms7Q7ePgAbJSFT1XQpXCt0QuyzgBjWIbII1D+Wv3UnE=;
  b=fpR7cOyx70H6lm7LDiITTZkSTnoGaO0n1JLEsbk/c2lNoNfASJ/Rb1mq
   WPFadrQeG/nLDbwS7uvDUgVsDKzrIMbHU7Gko4Fw4zIlJmQX8Z5uMC9ZO
   1cTNJyqIgn7svQPTGKCPp4BD54m4cQq+JHEh2LHLkG4NcDtu2j4syP4iX
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
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; 
   d="scan'208";a="229434995"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jun 2025 22:08:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C5DC0E01A8; Sat, 28 Jun 2025 22:08:10 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1F00FE0131
	for <cocci@sympa.inria.fr>; Sat, 28 Jun 2025 22:08:09 +0200 (CEST)
IronPort-SDR: 68604ba6_yr2MHqvADU9BZTpVypnG56w2PTw2uhtLOWGo5tBJVIKob2J
 S7wgwBf22alA07H6iTuOUdeLjsBWzQd4AojWFpQ==
X-IPAS-Result: =?us-ascii?q?A0HzBgB+SmBogAMP49RaHgEBCxIMQIFIC4JEgQZUMwQLS?=
 =?us-ascii?q?YRVj1CBdDCEO4c8h1OId4FVgX0CDwEDAQ1OAQIEAQEDBIUAAotyAh4HAQQyB?=
 =?us-ascii?q?w4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CY?=
 =?us-ascii?q?gGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIwQZAQERJwQLCxoCJgICVgYBF?=
 =?us-ascii?q?AEBgn6CIgEGEAEDDiQHslt/M4EBggwBAQbaXh8sIliBZQmBGy6FbYJkAYYnh?=
 =?us-ascii?q?DwnD4FVRIE8gwM+iB6CaYImgRaFTZQAUngcA1ksAVUTFwsHBYEgQwMqNDEjD?=
 =?us-ascii?q?zwFLR2BJ3+BThyDHoEbhEUrT4IoAXuBekEZQYNdHgZtDwaBIRs2QAIBC209N?=
 =?us-ascii?q?wkLGwY9kwKCdIEogV6BYsV1NAeCOIFmgWQMn2kGEy+XTA4GkwKZBSKpGoFvC?=
 =?us-ascii?q?CuBXDMaJIM2TwMZD44hhDO8Q0E1PAIHCwEBAwmFRgEBil2BSwEB?=
IronPort-PHdr: A9a23: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
 9KJmK+hcV+qEvrR+tYAQdfZIoSLPSh5WSc=
IronPort-Data: A9a23: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
 4T4qaCojXxXkXLMLPs=
IronPort-HdrOrdr: A9a23:tQ16y6sRlR3pjqeLRjk7ykhX7skDqNV00zEX/kB9WHVpm7+j5q
 WTdZMgpGbJYVcqKRcdcLW7U5VoLkmyyXcY2/h0AV7mZniAhILKFu9fBOnZrwEIcheWnoNgPO
 VbAspD4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAb0+40MGem+lYdfng/OXPVLu
 vm2iLNygDLRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3AsPOL72trWuG3sLCGmWAiwuk66IsDcFOBwnPQJ3b?=
 =?us-ascii?q?iLiU0d5S5WHmy3qFrxp8=3D?=
X-Talos-MUID: 9a23:ZZX8qwrleQxLdLbUc9UezzFFD/cx/KT1MU1XzsgUupmcbx5BYw7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; 
   d="scan'208";a="120204396"
X-MGA-submission: =?us-ascii?q?MDHLVmmSuMZTFw6c7sweS1f9692VRe+spF26en?=
 =?us-ascii?q?6JhiR8ErB3ayr6wILnso5UH7Bdf1fi3ePTDLlML7HDqfzpdCvWMEYxJF?=
 =?us-ascii?q?ryxZaqWqPXSahHQOAafV4S/G3/ymkUGP5hbkBLGPhK+bt0gLiVzhDD/U?=
 =?us-ascii?q?Bhk6Vo8WccuICZcy0kiTMMxg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2025 22:08:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751141287; x=1751746087; i=markus.elfring@web.de;
	bh=Ms7Q7ePgAbJSFT1XQpXCt0QuyzgBjWIbII1D+Wv3UnE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ENHFnccrdSINT3Vh9yv0fojJmD9TqpsSOHs+hFMHvZpjHBJM3t2Sxxc010xN0wkM
	 Ob+KXb+V03sjOVm/IXPBIHNuOTVA7jQatqPpWqI9Y9cuY9ioJ4/T6Tc+c8cY4pF6T
	 HWNJzYETR5m+AS1NiyP0lJJl5sZazzvQ9/9AeEhb3b21U3bNQA4nUrJCLkxZMWDSc
	 DezHGZ1+P9U+j2FAw0fj4CbdlFTgVKOs/zPsKE+3l8gcptX2EBXUh91dU2nqYz03K
	 KTrxeTbGbnYtOFOh7lGIMrqo2gOjMgnRS80rewiTsd9mCtIes7A2Z0Fo+oICLTviL
	 wJOiCszbEvgUoMrmHA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.176]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6pUQ-1udryr2Gj8-009GMa; Sat, 28
 Jun 2025 22:08:07 +0200
Message-ID: <10e8aa77-30c4-492e-9fcb-dce279b7d17e@web.de>
Date: Sat, 28 Jun 2025 22:08:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <2038c080-a429-44bb-a572-c1f9e733320d@web.de>
 <alpine.DEB.2.22.394.2506281638300.50494@hadrien>
 <1f3bd2ed-0252-4347-835f-5fecda857cf0@web.de>
 <alpine.DEB.2.22.394.2506282132040.50494@hadrien>
 <8737f8dc-a10e-4f2f-8a50-87edc5c2aa78@web.de>
 <alpine.DEB.2.22.394.2506282142200.50494@hadrien>
 <47efbf70-5b53-4e7f-922f-b6405e240134@web.de>
 <alpine.DEB.2.22.394.2506282156560.50494@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2506282156560.50494@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bdUFoeXxd4hR4J+NhTU+CBYuASYDr58YwsRwybMZQM2jMNJxkmR
 enfCfYh7HhWkeuYFsKOVY5hjlMDDJBnQiCRR9teMOzZuNGbcLqBS0fXcRYiXV9VKSVgZkBa
 QMPs3+IZpozaG4g5RQDQcseUR3XJUnRn43ue2/LaM1+bN2IvBHcLxy1mHfCNzlpLqfBnsqL
 /TI7EZ1BXvIucZMyoVqAg==
UI-OutboundReport: notjunk:1;M01:P0:xrkWUgizuOc=;hJyn5yjznlgM38Bujem0VfGe5RX
 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
Subject: Re: [cocci] Avoiding metavariable confusion for duplicate
 identifiers?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2805
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/10e8aa77-30c4-492e-9fcb-dce279b7d17e%40web.de>

> You provided the example:
>=20
> @replacement@
> @@
> -msg -> msg [ 0 ] & 0xf

I tried to indicate this source code was automatically determined from
the original function definition.


> +cec_msg_destination(msg)

It is probably desirable to perform corresponding calls.


> If you don't want to ensure that the expression is called msg, you can
> write:
>=20
> @replacement@
> expression amsg;
> @@
> -amsg->msg[0] & 0xf
> +cec_msg_destination(amsg)

You point the possibility out for another manual rename.


> What is the concern you are getting at?
I imagine that an automatic separation of involved identifiers would
occasionally be more desirable.

Regards,
Markus
