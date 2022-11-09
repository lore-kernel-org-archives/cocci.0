Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17913C4332F
	for <cocci@archiver.kernel.org>; Wed,  9 Nov 2022 18:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=cUXzjm+xYehim/zOa9wLUsyJMP8YHIa5DFsv0VOlSjo=;
  b=pA8FP2nv0pV9evReZSGtrSUw29KghFxhKRslmCxjr8Jx9fbQX0En9u2Y
   qGrhN+2baxOQDlT2VzTdKaGep3iuVa5C9iD2vsQBgyX4+DVY8WanC/Szw
   EnPe3JjP69iiQRRr1wmYg6HRispIH9RUkvXRpx84RDgGI8LG4VThpbDAo
   U=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.96,151,1665439200"; 
   d="scan'208";a="77523603"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Nov 2022 19:00:45 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 993A2E0236; Wed,  9 Nov 2022 19:00:45 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8D46CE0236
	for <cocci@sympa.inria.fr>; Wed,  9 Nov 2022 19:00:44 +0100 (CET)
IronPort-SDR: 636beac1_hLDzB8LaIKwruWsqJ8CACuRbqs5WGM6xs4GJ736ubwZujHn
 dkm+R0eqU0NLyu62FwgFujDTz7+NIjZWCj6xozQ==
X-IPAS-Result: =?us-ascii?q?A0EYDgAe6mtjhwwR49RaHgEBCxIMQIFEC4ItgQIDUy4EC?=
 =?us-ascii?q?0UmhCmOdYF3MWmDQI5NhF+EAYNUDwEDAQ09BAECBAEBAwEDgUmCIoETAmuEE?=
 =?us-ascii?q?AIdBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBG?=
 =?us-ascii?q?QkXBw4QBSKFaA2CNSkBZw2BBgIBAQEBAQEBAQEBAQEBAQEBAQEBFgINOhg7L?=
 =?us-ascii?q?AECAgEjHQEBESYBDwsaAh8HAgJXBgEMCAEBgnkBgm0BAw0jBwyrdoEygQGCC?=
 =?us-ascii?q?AEBBpwGHywiU4FeAwaBFCwBjFsJgy16JxCBVUSBFScMgnc+gksXBBiBRoNXg?=
 =?us-ascii?q?meOfIhIJgQOAxkrHUACAQs7MgMKSRsxJw4JHxYGCgQXDQUGEgMgSCYFCjcPK?=
 =?us-ascii?q?C9nKxwbB4EMKgkfFQMEBAMCBhMDIgINKTEUBCkTDSsnbwkCAyJlBQMDBCgsA?=
 =?us-ascii?q?wkhHwcWESQ8B1cSKAEEAwIQIjoGAwkDAiRVcwIJJhEVBQMNFyUIBU0ECDkFB?=
 =?us-ascii?q?lISAgoRAxIPBiZHDko+ORYGJ0QBMw4OFANegWsENWeZboNWggTCcTQHgh6BT?=
 =?us-ascii?q?IFNDIl0lHIGEy6WbQ4GkhQthxyPaSCNI5R7hTqBeCSBXDMaJIM2TwMZD44gG?=
 =?us-ascii?q?R6DOzOEYYVLQDQCAQE3AgcBCgEBAwmFRwEBhRwBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:SzI5rqxHqNEPvn0/WtAzKrPw+L1zdoMgy1knxilNoNJuA66lfr
 OV7ZAmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebjN5DNB7foSjjPIcOoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,151,1665439200"; 
   d="scan'208";a="77523570"
X-MGA-submission: =?us-ascii?q?MDEHvH7C2XkE6+KCg3Beww6gq/k4Q57kq59Hc8?=
 =?us-ascii?q?kCHe22hx30VoI6/uQqV106u/H6JgPyGz3Vv9I7fQdRC2uP08NxcepIYf?=
 =?us-ascii?q?jq9BZqdiJC3K1XiQffYnBa+QkykI6R5p10oAS1pXwkIWyp9yvVqUFSEk?=
 =?us-ascii?q?P2biOCr/evrrYaeq6up9Rv+g=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 19:00:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1668016831; bh=qTkc0aLJIqYneh9D1eIyqfYxUqQb52K8ic/DY0DXl2o=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Gh3GnA1pGGYEhVwMKgOiC5DUkE8yDWvvzdKl9/Dd+arth1XP6xNJBMT20HyLdM1yb
	 dtjwl2Y+3h4VDq8mrjcHx4NsFVvLj5K3xCWYzhjtC/FCxW156zABYjm7jZFEJAyioH
	 YXlefjKQ3PHbb/jotzeN86r3jli8kWp1NWxnLXXdmmQk7EEe7EJIkUEVTfGCOtsPpT
	 UCeujNcgiw8MXsZqUP1lZAuENMBhHHfBEMuhggV92IR9omxzmQmuPHwrFNK3ty101I
	 T4QdB1cabApvrSTiMO009iAE+IE/yxyqAQrVCwdLs9xVYRALIyYMykcZ6FAddWel96
	 FnkAddTNLN8DQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MuFD5-1p8qFn43WX-00uChi; Wed, 09
 Nov 2022 19:00:31 +0100
Message-ID: <0a291dad-8211-4bee-0c0b-efc2d5afab32@web.de>
Date: Wed, 9 Nov 2022 19:00:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20221107114702.15706-1-u.kleine-koenig@pengutronix.de>
 <bd13da2d-6d18-4f33-0987-a193e3c9b761@web.de>
 <20221107200815.u7hcwejileeabnct@pengutronix.de>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20221107200815.u7hcwejileeabnct@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q9M0zzHeZFJ0tIjecaE/qOntfFq/ZZFW++x1vNo1p5gOsYzv8rz
 uZGrEYn5OoO3WfoCanYzwESFihx6jEolSc/xLfeLUWgEDwMp8dnPl1rdFs62/Wb8dZVmWQQ
 kTpYO0EJE/h2SItQkzNYTUR6UU1ZwQFpCQ2EiuyjMYtxr0CFvgfexRX+sypZcbsid1a3IIP
 eD6AJOvBL4yiAppXpOROg==
UI-OutboundReport: notjunk:1;M01:P0:5dbN5nLBW44=;iJSLwhBhc9v4KalpbXEw1y0bI/G
 Z55ArAz5x6tV7DvJrobvIMMghTGNrEY1N7uf9dPq71Eq+nSuzWuToECc/5dqUQ+48lgZDj5VD
 TLBGUbJI3nGIa9eYvAbaX7sx4NuiGR7pMHMjH2x6vv5bMTbQalgXUxj68/Qbb1Ioxsb7G4eJq
 b3whMnh9GKKgaWAV2ccxWQ6gqiqpgGJk0K2/lHmb+/+3IZ9npF9zfzEd3pda71L0D6vL9J/Dx
 AEUfh1J4pX+MFJkSs3fqrGd3U+EPM3McVU0XXW9sP0sqJTLXRN+5A/BV/vTsAZV39JBGAYbbh
 /Ery7nC5g+tm0f6jygwY3B0ajzWFvaVTSJzCa6vaq9vsRNBYdXaLWDC7b/Qhnnk9aE9dBkI23
 SlRn9H7ed9FSgYRSQo/86abKKmvf24j+hNSDfV4VVFxf2/Etw8l+mlQx5wjqhTFRxsoeETSEL
 aGSxCsEKLmCd3XfnPZ3NQcaoDABxJ6tA4dOIAgWnyEkhnLUu3zsXxcurGt+fWKUBAHnpRP9uY
 yGA9/wqCV/8JTfPEKMusO+9145/n5Qy/nOcGa2vnMVp916jB3SP9mqKWEY3XBWKcDmM4mHgMd
 15lhX8wL6KeHTw7Hn8+8M7LkrSFez1xpE7/VKpMYyDTFAUA/ELFFQCkHq9i72rZDgNRkwoKk7
 89ZzyqJv/FQj/xBaXHkiQ5RAArxNrx3A3OD8vrMhyhTB6dbleYuyDQY7bp+yvwIHXvkbGZCUh
 Nj0xKmyIAC8jT0iS/Hlpa7qg4yUmzLB4hVzNyZ3lzL1wgblI0z2ZUmeC4gzTG6mBnfpPhd9J/
 srMKWYp87jrDfqI+PQ2rJfG6WNjeVIASN00HDclGPwCEBXo2KlW7YHSVGJWTAfQSF8UU6sVov
 3p4exkkvgR9LUfFA1pJZbZO6MUJVHfIkEMubhbjEV5Q3M+90x1635RRT3YkeuNGX5wN+Gtoll
 Oh/6+g==
Subject: Re: [cocci] [PATCH] coccinelle: api: Don't use
 devm_platform_get_and_ioremap_resource with res==NULL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 730
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/0a291dad-8211-4bee-0c0b-efc2d5afab32%40web.de>

>>> devm_platform_get_and_ioremap_resource(pdev, index, NULL) is equivalen=
t to
>>> the shorter devm_platform_ioremap_resource(pdev, index).
>> =E2=80=A6
>>>  create mode 100644 scripts/coccinelle/api/devm_platform_ioremap_resou=
rce.cocci
>> =E2=80=A6
>>> +@depends on patch@
>>> +expression pdev,index;
>>> +position p !=3D r1.p;
>>
>> Why do you think that different source code positions would be required=
 for
>> your transformation approach?
> That is important that the implementation of devm_platform_ioremap_resou=
rce
> isn't adapted.


You would like to exclude the modification of a known function implementat=
ion.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/base/platform.c?h=3Dv6.1-rc4#n112
https://elixir.bootlin.com/linux/v6.1-rc4/source/drivers/base/platform.c#L=
112



>>> +@@
>>> +
>>> +-  devm_platform_get_and_ioremap_resource@p(pdev, index, NULL)
>>> ++  devm_platform_ioremap_resource(pdev, index)


Can the following SmPL code variant be more appropriate?

@preserve@
@@
=C2=A0devm_platform_ioremap_resource(...)
=C2=A0{ ... }

@replacement depends on !preserve && patch@
expression pdev, index;
@@
-devm_platform_get_and_ioremap_resource
+devm_platform_ioremap_resource
=C2=A0(pdev, index
- , NULL
=C2=A0)


Regards,
Markus

