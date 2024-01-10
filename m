Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71358C4707B
	for <cocci@archiver.kernel.org>; Wed, 10 Jan 2024 17:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=PssHRtF5NCFxMrOVSzK9cE/CrEeDMepbD+5B5a+b+zA=;
  b=X50ex1p6LJr0Csf7ijmvgQ9gsg4+8PsXK8KHulCSK4/oDe0tR84WvmKA
   nE5FPRkT644sDmlmJ7UVJe3j/yJ8H8xDzwjDKHovIY2wxbe0rik8BGxxK
   DVWyQ4d82x/XGB9NXiaPsaQxvk2lzeT3ezAQCajzaFQmSimQEk2OZSC/D
   E=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="145943925"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jan 2024 18:08:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5C76BE0CD0; Wed, 10 Jan 2024 18:08:42 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C4699E004E
	for <cocci@sympa.inria.fr>; Wed, 10 Jan 2024 18:08:41 +0100 (CET)
IronPort-SDR: 659ecf19_H/85MTMYWlaM/iJF3qOodBBbfMiNasTY7s4+7rb4YAIQkcJ
 5yBcxRCLiSFcX3aHrdvOguBaM/Vs512OAu4WMzw==
X-IPAS-Result: =?us-ascii?q?A0GXAgA2zp5l/wsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+COQeBSzIEC0iEU5E2MIQ7hzWMN4QEgxY+DwEDAQ1BAQIEAQEDBIR/Aoc/A?=
 =?us-ascii?q?h4HAQQ0EwECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQKBBhOFbA2CX?=
 =?us-ascii?q?AEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR0IBBAEjBBkBAREmAQQLCw4MA?=
 =?us-ascii?q?iYCAlYGARQBAYJ8gisBAw4jB7ZXfzOBAYIKAQEGr1gfLCJWgWAJgRouiBsBh?=
 =?us-ascii?q?WeDQXonD4FVRIEVJ4MDPoRDg1uCaIIag0KFUopiUn8dA4EFBFwPGw8eNxEQB?=
 =?us-ascii?q?Q4NAwhuHQIxPAMFAwQyChwLIQVVA0AGSQsDAhoFAwMEgTAFDRoCEBoGDCYDA?=
 =?us-ascii?q?xJJAhAUAzsDAwYDCjEDMFVCDFADZR8yCTwPDBoCGx4NJyMCLEIDEQUQAhYDJ?=
 =?us-ascii?q?BYENBEJCyYDKgY4AhIMBgYJXSYHDwkEJQMIBAMrKQMjdBEDBAoDFAcLB3uBK?=
 =?us-ascii?q?QMZKx1AAgELbT01BgMLGwY9AphqCRCDDsRjNAeCNIFggWEMnysGEy+XJg4Gk?=
 =?us-ascii?q?lQuh1CQTyCoRoF6JoFZMxokgzZPAxkPjiAMFhaDc48JAT1ANTsCBwsBAQMJh?=
 =?us-ascii?q?UYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Gwzmr6hv5a9wAdf5+qasXaummHBQXgMji2hC6mlwRA09TyX4ra
 yTdZEgviMc5wx/ZJheo7690cW7IE8036QU3WBpB8bAYOC+ghrLEGgA1/qG/9SfIVybygcH79
 YGT0EWMrSZMbEdt7ed3ODSKbsdKbe8mpxBcY3lvg5QpHlRGtldB4wTMHfhLqX9LzM2f6bQrf
 Gnl7d6mwY=
X-Talos-CUID: =?us-ascii?q?9a23=3AwdmyUmoeZt2oVvWNh5ya4tfmUf56XyHm707fH0/?=
 =?us-ascii?q?7WTdkZ7+EeHaiprwxxg=3D=3D?=
X-Talos-MUID: 9a23:N3agWwmadjjH8zYg/FD9dnp+MppK2bifEHwyiIxZgNOlKy5dIhmC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="145943916"
X-MGA-submission: =?us-ascii?q?MDGh0d96L8ad30p1nCP3iz+YuECovXuO52KTjX?=
 =?us-ascii?q?AqWMh0JUoRQtWtcrYgFn85JVfPN+SdZXDju34MsST/HcigmCL+BNvV56?=
 =?us-ascii?q?tNOasK+L85NmPIuWZ1m2wjDefuIt6Vx5mSRQz+hbSQsFG+Xy0C30SGkq?=
 =?us-ascii?q?ccyODHDj19G5j/GoWjwwrtUA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 18:08:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704906508; x=1705511308; i=markus.elfring@web.de;
	bh=Bz9Db2FUAkVqUkNWQ/yzViSvqlonoWs5vAEKdEJFosw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=dXA46L476Qubr3V28E5jL0y0a23JIp7SQ3wu27euvbg6brlBy2CVjMNBhe2W5z+t
	 R7qQQnwtdNC+UeElZsxnyTFYcT5FDWewIlDd0pYQA5YWmpIBH9XIcKmamu3Z67b1x
	 cSefahiBfQn7OUlP2fxWy+hk1YW1toLIhXYG5Noqij9X0TDWJpg/Rb9I6C3KBDPq9
	 wlJmUrbPhZyPzC1MVneDaTrmQ8Y+3+1Caa5mBS1QUyBvg2apUTHTyi/MlwKNZzBIp
	 1PhaZ7oqxco2MCv/+Mf/gbkf46T7FWoiCrew4c5Mdz+ouP1Xr9elkmP4O6ttkJJnj
	 40LsCVuqwLCBN2xGTQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MuVGC-1r5Fy21P9u-00rgZo; Wed, 10
 Jan 2024 18:08:28 +0100
Message-ID: <1910913d-c3fe-45ab-a871-deda5318e2cf@web.de>
Date: Wed, 10 Jan 2024 18:08:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "cocci@inria.fr" <cocci@inria.fr>
References: <6d97cafb-ad7c-41c1-9f20-41024bb18515@web.de>
 <SN6PR02MB4157AA51AD8AEBB24D0668B7D4692@SN6PR02MB4157.namprd02.prod.outlook.com>
 <82054a0a-72e5-45b2-8808-e411a9587406@web.de>
 <SN6PR02MB4157CA3901DD8D069C755C72D4692@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <SN6PR02MB4157CA3901DD8D069C755C72D4692@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:emKcMjXpJGXLjI1ChMRKyZgY9s+8+hI1Nvf2l2K6ItaH0tdCg0F
 gfgoOrCWA9s5cTuaPJuYnplHU7eHct06NwNCbQMpYaQ1YAU9gw0a2knKGg1zgUl7+x/qZ9F
 7ukQDNDwYcntZX5kg2uj8lEmJRGFm4jNUbzdLQ8UnEsu1V5QC4LLA0BDXK/FZMxjyTdIkpp
 +dTMGPQEPJwOOzQQiJ2dw==
UI-OutboundReport: notjunk:1;M01:P0:2x/ntfbrdNw=;+ZwzS1arjIKAorVjx3qIfv7jem7
 rTtEEMGp2Euk71hadmLZbIixqIn4LEMHu0UqAgPbe/q7k+h6KTTkc0UTns7PlpihYme4+6YR8
 +7ntDyLWxgjkDkHBCRmF/Np0xMO0eaH4KKkzafEZNDIyVyALb8oqUYkXRXWG4ri1gzYtUNDCO
 fE5rdEtb3a3/7l7lsLeKussW/8BuZ9EiHSpmbnnZEwQEsLmOCNaAQ5pr75v92xmTWvANk5wvv
 19KpQhtPup3YhkvJ8pS9uC4GhqKcollq+ppyeY9ingTd6OL4l459RmG3AdfP6o81o2pZ0LWv5
 qKHZSyiDVUHrGnqEKajxAS4TlLCSx3LScC1mvGWJmoKp4IGpgQH+Uoul163CpPueqy0lSQJs1
 INTnsbmRi7JfJkda+2TNMbADTxTGweF7nDffbzksFNFomqxJaNb4baR8fJPgDMkI2902Gfdyd
 b9CxOg5+ZnHIC68CbHoA34oEWvPksm9H44BF6IfFdH35/hh0UeZqU24sy2Q4gMxS4wQkEzAmX
 PWCEDY64U5Eatlv/JQJB/ZhuP2VHuGzYu8GXn7AMV4XqEffkZVoDyPsATY7QYUxBTBfqdlnaK
 XpPqZWYLvrnusjLyucaTj8MgRZK6llsY0ayPivMgTYtsZKGweNWZ47OPpJyurqH3B2pBhw2Iv
 JwOxOLy4NKmyUdnGKE5coWB80nt747zct7D+dXNhCGD9fldlgwpTX6yTCOow+MZl/J1Q9BCb0
 tsrPIcTEaUE3tqTUeT/9xtoloi7h/WkWwEyYwm5+Z3B5EeWVddB+wD8in7L82+WL3dNiMHbj8
 JC3FQo2JqFgMyPcFLcpjW5CuNvG7UOxnCdKTpJo3qzU4wyEkIowh4IbWNcrBIsj4lb2SZk7N9
 JJJYu7tVad8R9xvJSllvc95+kAf2ZFr3HCSCSzrjJpPrL99VrQHu9UeYXqDqlJ/NbHwpqLGeE
 KPWyQRbk2ZNBzz3U+ylEnvyCcZU=
Subject: Re: [cocci] Drivers: hv: vmbus: One function call less in
 create_gpadl_header() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1456
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/1910913d-c3fe-45ab-a871-deda5318e2cf%40web.de>

> It occurred to me overnight that the existing error handling
> in create_gpadl_header() is unnecessarily complicated.  Here's
> an approach that I think would fix what you have flagged, and
> would reduce complexity instead of increasing it.  Thoughts?

I find this development view interesting.


> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 56f7e06c673e..44b1d5c8dfed 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -336,7 +336,7 @@ static int create_gpadl_header(enum hv_gpadl_type ty=
pe, void *kbuffer,
>  			  sizeof(struct gpa_range) + pfncount * sizeof(u64);
>  		msgheader =3D  kzalloc(msgsize, GFP_KERNEL);
>  		if (!msgheader)
> -			goto nomem;
> +			return -ENOMEM;
>
>  		INIT_LIST_HEAD(&msgheader->submsglist);
>  		msgheader->msgsize =3D msgsize;
> @@ -386,8 +386,8 @@ static int create_gpadl_header(enum hv_gpadl_type ty=
pe, void *kbuffer,
>  					list_del(&pos->msglistentry);
>  					kfree(pos);
>  				}
> -
> -				goto nomem;
> +				kfree(msgheader);
> +				return -ENOMEM;
>  			}
>
>  			msgbody->msgsize =3D msgsize;
> @@ -416,8 +416,8 @@ static int create_gpadl_header(enum hv_gpadl_type ty=
pe, void *kbuffer,
>  			  sizeof(struct vmbus_channel_gpadl_header) +
>  			  sizeof(struct gpa_range) + pagecount * sizeof(u64);
>  		msgheader =3D kzalloc(msgsize, GFP_KERNEL);
> -		if (msgheader =3D=3D NULL)
> -			goto nomem;
> +		if (!msgheader)
> +			return -ENOMEM;
>
>  		INIT_LIST_HEAD(&msgheader->submsglist);
>  		msgheader->msgsize =3D msgsize;
> @@ -437,10 +437,6 @@ static int create_gpadl_header(enum hv_gpadl_type t=
ype, void *kbuffer,
>  	}
>
>  	return 0;
> -nomem:
> -	kfree(msgheader);
> -	kfree(msgbody);
> -	return -ENOMEM;
>  }
>
>  /*
>

Should up to two memory areas still be released after a data processing fa=
ilure?

Regards,
Markus
