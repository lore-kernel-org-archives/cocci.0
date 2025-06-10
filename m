Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9E4C5B552
	for <cocci@archiver.kernel.org>; Tue, 10 Jun 2025 16:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=yiUM71e/FNIFi/GbKv2g8ByF/HWQlJCXG+hY2QmUh1M=;
  b=ftGQYxNC0kxJShQ4xi3QQ3FyQnKFc2qSk6MShp5c+gXWKg5JxWV5aBjD
   ye7gS/uguMCwlP+R/1Kesi+MsF7XyJGrpC0WlLOExDZlxoorQ25ETG7Xc
   Q1tIa86HG6BMuhKuaQwyEND04qb3vA0NnLs8YxSBseNKXu98chdk131/T
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
X-IronPort-AV: E=Sophos;i="6.16,225,1744063200"; 
   d="scan'208";a="226160452"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jun 2025 18:15:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5C497E0AF1; Tue, 10 Jun 2025 18:15:34 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0B17FE0157
	for <cocci@sympa.inria.fr>; Tue, 10 Jun 2025 18:15:30 +0200 (CEST)
IronPort-SDR: 68485a21_qOqMT0PuocWF8tfI22yrKuPXluZSnHAtyxq7GwIagHxU5DV
 mvXvEYnv10FTSRy3JieACBy5K9DajTq3sW2HfQA==
X-IPAS-Result: =?us-ascii?q?A0HTAQBLWUhogAMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VOCRIFaMwQLSYRVj1CCJIQ7hzyHU4h3g1ICDwEDAQ1OAQIEAQEDBIR2CgKLZ?=
 =?us-ascii?q?QIeBwEENBMBAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOC?=
 =?us-ascii?q?jGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREnBAsJAhoCJ?=
 =?us-ascii?q?gICVgYBFAEBgn6CIgEGEAEDDiQHk1ScRYEygQGCDAEBBtpeHywiWIFlCYEbL?=
 =?us-ascii?q?oVtgmMBhieEPCcPgVVEgTyCUjE+hAo5g1uCaYIogRaFZYcwk2pSeBwDWSwBV?=
 =?us-ascii?q?RMXCwcFgSBDAyo0MSMPPAUtHYINhRkfgXOBWQMDFg8BgiSBXhyDP4EjhEkrT?=
 =?us-ascii?q?4MigX9MGUGDYR4Gcg8HGkACAQttPTcJCxsGPZhog2kHgQ4Bph+OFZRiNAeCO?=
 =?us-ascii?q?IFmgWQMi2+TeQYTL5dLDgaTApkEIqNBhVWBfyOBXDMaJIM2TwMZD44hPoN1t?=
 =?us-ascii?q?yZBNTwCBwEKAQEDCYVGAQGKTzSBSwEB?=
IronPort-PHdr: A9a23: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
 9KJmK+hcF+qHPrL8MFaC8WGcaq6
IronPort-Data: A9a23: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
 YT4eIycfHyGdA==
IronPort-HdrOrdr: A9a23:ab2s7ajrVZPJTtYZLf50F5WUF3BQXgQji2hC6mlwRA09TyXqrb
 HKoB19726MtN9xYgBHpTnkAsK9qBznmqKdjbNhWYtKGTOW31dAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkdNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQlTuRRjz7LqVsLjM2fabR+a
 DsnfauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3Aq3vXimlX7HEOnaSkBplY2qn1FZ/XOXfG43DPDUa?=
 =?us-ascii?q?kNWpOULbOEwLO5KRkrdU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AilHJuAyb2cYPRRlRMwddxAnfHZuaqLa2UVEBtpw?=
 =?us-ascii?q?egsmnKwVaKjeHoBqxAYByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,225,1744063200"; 
   d="scan'208";a="118681860"
X-MGA-submission: =?us-ascii?q?MDFrSKiHlgjedIkf645O+7bjJibs2BzQeWgqvg?=
 =?us-ascii?q?nNJ0pbqYz3FW1yxTy3v+pH2BQW2Jurbx8Rvaz+TCsLRJncmCP9eiz/2I?=
 =?us-ascii?q?VDU1jE0+k5Zd8FFPDDCZxdLGmznmJa9aeCX6sdervOcuXzZgRpfiVpvJ?=
 =?us-ascii?q?iFKzQv0hCeBEG6tx28ovflhw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 18:15:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1749572128; x=1750176928; i=markus.elfring@web.de;
	bh=yiUM71e/FNIFi/GbKv2g8ByF/HWQlJCXG+hY2QmUh1M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=vvDQMvvqEcbIXKioBVVcJbVhBlqW6hc0+314+sX6xr7VaSxQWGc2p2ZaG3MgXgNM
	 2uBVPL8Lz97T8SkhQPu9YyzhSXq74LP1yhZu57SKLBF4xBl7Dv+1Z5iEiqf8eK8gH
	 y9RuuKGMYceLC+WhTyLBRvvGX1jpCAjDBdDHRHfHOp4DAHFArR5AgCb6qJSoyCAyf
	 fj6LYPPOKEYR3+D8JYUfjvAxI5ZVz4/cKdBPWv4FbE7KhAwRFgi9Sgez1AcYucyKz
	 vTcuouRdSZ04scGdqOurGuxtsZ3O4wf+WMFPcpRfJ1W88OM4vifqhknJzg+F/vo+I
	 TQdlyLyhLgp8F++Pzw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.183]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MidDH-1v4fiR0a8N-00mUsy; Tue, 10
 Jun 2025 18:15:28 +0200
Message-ID: <629fa64c-ccd0-46ba-907c-97bebc00fa0c@web.de>
Date: Tue, 10 Jun 2025 18:15:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <90822099-5434-4421-a611-785511926ecb@web.de>
 <alpine.DEB.2.22.394.2506101739440.4658@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2506101739440.4658@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q1uFtu291br2pe5N1vq4wLbhaTGP9KXTcYPvJ+H5ZYWP+HIVvSg
 j4e0f/qctc05jQfgwNuwtequnRYCPtGceydCMI/LO0zPhYQgpiKd82eKf2FvTQRyi1JmJbe
 rkCayivJXUMnVpkc4M0EOPB3mK/OyFXlzUfuFGNxL0KwQG93sMVY0HEcpX+KyundfvMs0RP
 MlB7Eu3j1cbq1b4dKmwSg==
UI-OutboundReport: notjunk:1;M01:P0:xg+JfMj6Yjk=;qo1s4Z/tLViUlD9kZh5kPx7X6+A
 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
Subject: Re: [cocci] Checking another deletion of redundant null pointer
 checks (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2754
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/629fa64c-ccd0-46ba-907c-97bebc00fa0c%40web.de>

> Could yo uplease make a small effort to make your reports understandable=
?

Why do the presented test commands trigger undesirable understanding diffi=
culties?


> 1) I don't ned to know the paths of your files?  This adds a lot of
> clutter that makes it hard to find the important information.

I find the mentioned test data relevant for further clarifications.


> 2) The proper scientific method is to cange only one thing at a time.

There are two data processing results to compare.


> You seem tohave changed two things 1: in one case you give the specific =
file name

Something looks reasonable.


> andin the second case you use the whole Linux kernel directory,

Yes.

The mentioned log file contains the following information then:
=E2=80=9C=E2=80=A6
7675 files match
=E2=80=A6=E2=80=9D

May I expect that a file name like =E2=80=9C./drivers/infiniband/hw/cxgb4/=
device.c=E2=80=9D
should occur there?


> and 2; in one case you are using linux-next from a specific date andin t=
he
> other case there is no information about what kernel version you are
> using.

The mentioned test cases refer to the same Linux development repository.

Regards,
Markus
