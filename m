Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7C3C282DE
	for <cocci@archiver.kernel.org>; Wed,  5 Mar 2025 17:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=xtiQKLe0sh2b/5K2i8jzCLuSRfvmaqQV+l/0T1lc8Vc=;
  b=icWCX4ykcO7Hoq2wT1dB7IfyO7c+w3ETqcfd9A48UhuxBgIQFwb532fV
   JVBHYwNqtfxUzhuCA7lDD3EfHoLRW74AFTM1OouAcGENMTvTWOvraHnuT
   nCmMq4OMo/NlpTu66vUA8RfrUznY1/EiYrgGK6eoosAdSKjsJFKW1KBm/
   c=;
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
X-IronPort-AV: E=Sophos;i="6.14,223,1736809200"; 
   d="scan'208";a="211398314"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Mar 2025 18:29:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A4B7FE0D1E; Wed,  5 Mar 2025 18:29:22 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 46FE9E0260
	for <cocci@sympa.inria.fr>; Wed,  5 Mar 2025 18:29:21 +0100 (CET)
IronPort-SDR: 67c889f0_cqSiBKjXEYnZALzW0MvyMpnzRdGkoj1TEckQRiR92uxRiaP
 DeqM5vxKMkulDSui1mzdY/6blIc3OCQqk8m8eNw==
X-IPAS-Result: =?us-ascii?q?A0HIGgAAichniwwR49RaHgEBCxIMQIFIC4JEYhtaMwQLS?=
 =?us-ascii?q?IRWj0+BdDCEO48OhG+EBoFWFIFqDwEDAQ09BAECBAEBAwSFAAKLFgIeBwEEM?=
 =?us-ascii?q?AkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQE8BQ4KMYV7D?=
 =?us-ascii?q?YJiAYEkgSYBAQEBAQEBAQEBAQEdAhQzRAEBAQIBIwQZAQERJgEECwsaAhEVA?=
 =?us-ascii?q?gJWBgEUAQGCfgGCLwEDDiMHDa9hfzOBAYIMAQEG2lwfLCJXgWUDBoEaLoVsg?=
 =?us-ascii?q?mMBhVIZO4NCeicPgVVEgTyCUjE+gmEEGH9HP4McgmmCM4EIgguBLWeBbIUwh?=
 =?us-ascii?q?SUcIwqCCxoIeIU1BBFXbIJKjl9SexwDWSwBVRMXCwcFgSkQMwMgCjQUHQIUD?=
 =?us-ascii?q?Q8BDwYQBGoFNAo3OoILaUk6Ag0CNYIeJFiCK2oEBYEkgjeEPYRCgj9RgkKCE?=
 =?us-ascii?q?XFvAwMWDwGDH3ccg0x3O4R1HUACAQttPTcGAwsbBj2hbzuEQ4E5c8ZggQo0B?=
 =?us-ascii?q?4I4gWaBYwyKKZU1BhMvg3CTVg4Gkn0umFAijWObLoFnOoFcMxokgzYTPAMZD?=
 =?us-ascii?q?44hGR+DdTfHNUI1AjoCBwsBAQMJhUYBAYpUgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 YT4eIycfHyGdA==
IronPort-HdrOrdr: A9a23:JMzCoKwWA1fLGCzmqdjNKrPw+L1zdoMgy1knxilNoNJuA66lfr
 OV7ZAmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebjN5DNB7foSjjPIcOoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:KRnRq2NykrfVsu5DdxJo2UhPPtscc17Z4kz8c1eBVEt0R+jA
X-Talos-MUID: 9a23:3SJSUQRS1sLqe36KRXTAozNbMPZ0xJ2/EX0wiMgtueq0GitZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,223,1736809200"; 
   d="scan'208";a="110764850"
X-MGA-submission: =?us-ascii?q?MDHyNjElANdyfi+sRgNR9YN+g0gLRY06Gixba1?=
 =?us-ascii?q?CQLosghEITNDfFEQM9oC1DL8z9vbP8f2do1su40+gAAIaLjCRXOX4/fN?=
 =?us-ascii?q?SDbRjUOmglfQUSs0sCkTu3EOGsCC8XHcOXYhomECYYZ82MIwhtNMjUJH?=
 =?us-ascii?q?lRpksAZnWS97SrwnzLqh1JZQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 18:29:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741195738; x=1741800538; i=markus.elfring@web.de;
	bh=xtiQKLe0sh2b/5K2i8jzCLuSRfvmaqQV+l/0T1lc8Vc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cvyNvSK7JhyaAmdAq1JK1chrv4QprDbNH6hoqgkxFk1feZ5vTk43BevHf+2nHg9K
	 P4A513oALEtWPNcM3qu0e+nvbllCfGkM7nebEo11in/gQk5yLIn+NVp5qqkHJtEd3
	 hk9ioe+QSojqxyncq4aHYOYrl3EaoDE4jfcicoQfL0pdV3YgRDf4c55XFOOBMS5aV
	 lyISBbosBh22FBqi1F6rcie9MbLYF3PvEaZ92+SsyuHRLQjKkx0CCFE4AqyFPfsJA
	 EdU8wM87Mpsr6zG/0BTbnPAJ3zjjCkoewSbCk8EZjOxz1mLDRuKQweZgtro9kpZwR
	 Lc+/PXeAze2DjqKTwA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.10]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M91Po-1tvx5b3WNS-00H6a9; Wed, 05
 Mar 2025 18:28:57 +0100
Message-ID: <e9372f7e-cefb-4f8a-9dbd-b26baceb0d3a@web.de>
Date: Wed, 5 Mar 2025 18:28:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Helge Deller <deller@gmx.de>, Dan Carpenter <dan.carpenter@linaro.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: Antonino Daplas <adaplas@pol.net>, Thomas Zimmermann
 <tzimmermann@suse.de>, Yihao Han <hanyihao@vivo.com>, cocci@inria.fr,
 LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <86551e6f-d529-1ff6-6ce6-b9669d10e6cb@web.de>
 <3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de>
 <ugymllbkcsg22ffgyofvkquh5afbvoyv2nna5udmy3xfhv2rjz@jhgghzldzm4u>
 <eebf8c0c-7a6a-405f-aaab-2a8a8c2bd91f@stanley.mountain>
 <hwk2nf62owdo3olxrwt5tu7nwfpjkrr3yawizfpb3xn6ydeekx@xwz7nh5ece2c>
 <47c37d1a-5740-4f48-ac0f-635d8b6f51b2@stanley.mountain>
 <9d042e6a-6d93-4ae4-8373-28b9dec21867@web.de>
 <81a620bb-205f-45f7-9036-e8e44a8e7be9@gmx.de>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <81a620bb-205f-45f7-9036-e8e44a8e7be9@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yWGWNO6K9aUNn3g3Qc5ZNkQf3WSZXFZx/7sAlXKN2G2OkmRvkTM
 OOorb9nBJRzzmErR9eJErw6GmksCApLqzMDcyKGuL3v4Qalgpp5Oo9wJ3hULjiXC7J/bBVT
 BDd3SQO+O0DWCKxnpPQhgtzzOvZVrnHen1F1NTITC3WjdS1jKPIEEhHglUQ5+uuk2CmrSEC
 oWIV86XuELAY2ecrMErmQ==
UI-OutboundReport: notjunk:1;M01:P0:UByq28hN30c=;zVhcrG6+Sh75YoWB+H09FcqgW8Z
 bgunNY71oawVGm5ys86Bfzfb67540oJ+u7DAgmYRadi+0yDuVnhsBjFqkBXS9yWJESCsOSZfU
 4xgJJrykXQYALn4/eCVlRvVAoYzpKDR0SGzMpZFWdB+hFqSpAO7yrjX3O3Y9qUHmGkMPJZCOn
 cTFIhVVjD21fVeX2V2oZ4NbofQkCoa9OX0/KtqN1O7Bj90dOdP7Rhs5955TPCw57vqxdIZINT
 EDxDN7hucnIllSj4HktdwGfvRVzgciVCR/nnoUSB7OeeYt+Qqe9MZEKv8OLs48GVCT2yVXeX2
 +DoXgPQDJlQfvSnXLcULgMhRhpAMRdbT9rw9T49pS3OdLxxzTi5FbYpan4orQAAObc/4Gam+G
 Ck/fSxbbd8JBEAdpATuUUwJr1RRXLv37TQl/9bqMJH+wLx/IauUHcfAQ3ziqYcnSki2F9ziyL
 Q1E4abj3MTZihySUQ4yPtvuNhnQBWWW44B2EiygAOmZaWQIPka5WebAJ7Sjy1T3mrYWjHeFPo
 8CskaPVmU4QL8uazhS0gNgFAcRT0Vi6yjHr5fN7AIktIoGoMgfNaorFcZOUoHWrM8LCsIQBB/
 jfi0OhDkRJMzOo382MpJHfpGv4sF0IDGdXlzlizhUcyT6MISK2mVuDtW2rORZJpYDz8a6Rckl
 +4exgw40+U+PoIQn+Z9XSUokVxe6OlUiROGCTAGJbdpTjWIbLXHDDXg5dvfAUkXlVq9Fv+nVP
 0mSbtQtRFOKIB0qiFYM4bOtxQTqYN3tuPVXu9deUZoo7K5vCP/FWPIPvPxzkLJQNxq3utAaXY
 wy9PW371DMmOIsHCUHKsDtdOGfw2H1lDvs6PB6l8fYLhBVU4dDlPGLgh59oEHyhkFBwPXuW5w
 3DonwIC2P/zQ4cG6tm7VZtlFzxdZ+ye5k9UO0VUYwjYPiNCx8WNRPPjfmSKXhKWFgi3p6N7g5
 IqJNj/mDysSDG7RMaM39tVrMPrcwWZ8z6oGHThg3E5KmK82dUi5vxGn6jZUhz3yu4Fc8XXkof
 x6ZwtZzdVSYWDdsBr/SyXlQ8i+cfKJ6LiyG1jn8hNyWoneUdnXcqWbXMWRD0/s/IIUFN4feVO
 I+Bf45nMJvdMnn/o7rH1XpipM/SL74qzSqCXvBmn8Us6B8Ldb+aijiIzoTFfCBXAwLGwzMSp9
 Zt2uJqzqSrKjv17g8ph2Ngy58lhUGkeMwNdZg+ECbRjvBmqa4iqqoy/GVwljXXF9MS3G9asd1
 55uKhfWqWAIurDzhp96ZZq6/p8+TCaWltkV6C1rkxi2OY29xF/DgPnppVH43MTVtZQy3LFpVK
 5sEG80yWxY2f9zBsaV4bzd2XXY4aGsbDjy4kz00PAAtDOJcQQCeAgHB79klC6ohFF0vUFZueU
 6sovH08njwKsHLeJNlo49Z1ac79ph2nit6SBuAOrxGbke7PLx+ynScb3jmLZWWyWKcHw1i9ni
 heWvOeA==
Subject: Re: [cocci] video: au1100fb: Move a variable assignment behind a
 null pointer check in au1100fb_setmode()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2543
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/e9372f7e-cefb-4f8a-9dbd-b26baceb0d3a%40web.de>

> No crash or anything can or will happen here.
>
> Markus, maybe you missed the "&" in front of "&fbdev->info" ?
Would you get into the mood to adjust development views
if you would take any feedback and further background information
(by David Svoboda for example) better into account?
https://wiki.sei.cmu.edu/confluence/display/c/EXP34-C.+Do+not+dereference+=
null+pointers?focusedCommentId=3D405504139#comment-405504139

Regards,
Markus
