Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90FDC282C6
	for <cocci@archiver.kernel.org>; Mon,  3 Mar 2025 10:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=3I1wcV88eyEZRxUAaJIlfqeblDAV/oemtgH82LOxxOs=;
  b=hAcbAPFRc7K9YRzzeCxVDKmW0nhhWWtb5ScKGZKI+wpYFbSIluflhU44
   nf0oQ+aiBxEikcNdUx2vlVKXBxwi056GUVxnn+Vn+lVZUAFQEiacl069t
   7pc+uDwUwVe27FLpgEr7zFsLxO2CLO4PITdpnbmccqVd6mfmk7hzU6qyN
   g=;
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
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="scan'208";a="210842413"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Mar 2025 11:36:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 15856E0D86; Mon,  3 Mar 2025 11:36:34 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0ECABE0261
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 11:36:31 +0100 (CET)
IronPort-SDR: 67c5862e_QUReD1F3kJXsmxrKk6Ipf/rPE4PGoxtYEBCntJO6ZmHBs0o
 uFFXM51q9oxAkLiiPdmD15gBqUPJYESoGLbk2vQ==
X-IPAS-Result: =?us-ascii?q?A0F6AgA6hcVnfgQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UAGAQELAYJDgVczBAtIhFaPT4F0MIQ7hzuHU4RvhAaBVoF+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBIR2AQkCixUCHgcBBDEIDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQE7Bw4JATGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBI?=
 =?us-ascii?q?wQZAQERJgEECwsaAiYCAlYGARQBAYJ+gjABAw4jB68efzOBAYIMAQEG2lwfL?=
 =?us-ascii?q?CJXgWUJgRouAYVrgmMBhVIZO4NCeicPgVVEgTyCUjE+hEODW4JpgjOEQGeaB?=
 =?us-ascii?q?Y5TUnscA1ksAVUTFwsHBYEpEDgDIAo0FB0CFA0PEAYQBGoFNAo3OoILaUk6A?=
 =?us-ascii?q?g0CNYIeJFiCK2oEBYEkgjeEPYRAgj9RgkKCEXFsAwMWDwGDH3ccg0+BLYRqH?=
 =?us-ascii?q?UACAQttPTcGAwsbBj2iKIRCmkOvUjQHgjiBZoFjDJ9eBhMvg3ABk1QOBpJ9L?=
 =?us-ascii?q?phPIqkPgWgBOIFcMxokgzZPAxkPjiE4g3XIOEI1PAIHCwEBAwmFRgEBilSBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
 5cEDLNWBgVdKw==
IronPort-Data: A9a23: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
 IT1qa15rJmHdHPM
IronPort-HdrOrdr: A9a23:yb9NSa5C087oF/7LCwPXwObXdLJyesId70hD6qkoc20zTiSZ//
 rAoB1p726TtN9xYgBbpTnuAtjifZqxz/NICMwqTNOftWrdyRaVxeNZnOnfKlTbckWUnNK1l5
 0QFpSWY+efMbEOt6bHCX6DcurIruPqzEniv5am854kd3ATV0hP1XYDNjqm
X-Talos-CUID: =?us-ascii?q?9a23=3An8GEsGolUxGkpCXevA8BVB/mUeE+WSffxk72GXa?=
 =?us-ascii?q?fCnZuFJmxF1iI/Yoxxg=3D=3D?=
X-Talos-MUID: 9a23:f9uR5wngKjaDNPBj1ss1dnozEeB5s56sCnkdrqoX5NCHGAd0PSqk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="scan'208";a="210842330"
X-MGA-submission: =?us-ascii?q?MDHhbEiwZth7xogOtfgLGLaG4xLbJdv8zJNc7i?=
 =?us-ascii?q?AmOF0JQn374dtaoLpD7XkxAfqD2tk0bdby/dbpDDjoA0nxYOqwcXESMj?=
 =?us-ascii?q?wne3Oh0iRc4U+82xM0ii6cpXHQXWO8Rjk9iWj3e0e/TxlAXb4EJBa6YS?=
 =?us-ascii?q?xMYsONCjHuZ5gXxcu7q4Tn3A=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 11:36:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740998190; x=1741602990; i=markus.elfring@web.de;
	bh=3I1wcV88eyEZRxUAaJIlfqeblDAV/oemtgH82LOxxOs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=syaRRWYgiccYmjw9qtXIAxcZR+keMGcrCcJdHVt3VXZv09UXatyFGPrquv2NFk2k
	 8rkHgHgD2g7XPO0fprbnhkv5tiw9dbQ7kToh8TeUXF2qrzl0gPkszu7S1y9QYT0uJ
	 EdrUOqUsU3gcsYd0migjTQbC7m89boUFAQ3arY3U+U5KpxRsvuuWXw6Fqn+/vXIJA
	 /JB1W7WK4mstuz12wAav1C8lfgxLH90kLihkhaM9hRy3pxFLl9ufqxjItLQCiJ9e2
	 y1+sB5ANVpnTWI2WPIHiytD9OZD1+m6CkUMSnBiYSD9OnWFy50JqU5cd91m+dhzyx
	 NPWiJzd8UiFK0dXpCQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mc1VL-1tH5qj13Ed-00i7EN; Mon, 03
 Mar 2025 11:36:30 +0100
Message-ID: <82bce096-271a-43a7-a2cf-95b48669ce3c@web.de>
Date: Mon, 3 Mar 2025 11:36:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, kernel-janitors@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Antonino Daplas <adaplas@pol.net>, Helge Deller <deller@gmx.de>,
 Thomas Zimmermann <tzimmermann@suse.de>, Yihao Han <hanyihao@vivo.com>,
 cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <86551e6f-d529-1ff6-6ce6-b9669d10e6cb@web.de>
 <3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de>
 <ugymllbkcsg22ffgyofvkquh5afbvoyv2nna5udmy3xfhv2rjz@jhgghzldzm4u>
 <eebf8c0c-7a6a-405f-aaab-2a8a8c2bd91f@stanley.mountain>
 <hwk2nf62owdo3olxrwt5tu7nwfpjkrr3yawizfpb3xn6ydeekx@xwz7nh5ece2c>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <hwk2nf62owdo3olxrwt5tu7nwfpjkrr3yawizfpb3xn6ydeekx@xwz7nh5ece2c>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vdcLTwaxRRUTNKgdh3PAdhRaE7ojz7Hr9lnrj+MHgE+1lORdgI3
 LdUTlDAHkrkILlfVtj8Y+FWZ7efdKmsh7dpqRFXHOeHBR7Y2LJkXflzI4TeVUHOA+5S6WK7
 ducSX12HIESWGnfoCyf5qkT0mmHMrzlzrSiA2hi/nzhZG/O60wWcTcMWWLl8EQv29pU76Qj
 NN4uq50yUWCyJv4fhWAoA==
UI-OutboundReport: notjunk:1;M01:P0:6QNZLrdoyzo=;Egynd8vm+A0h2t4Qd75YIb7BLKe
 VujM9TYK15+bBtsLBJI53tpI65Z4qlFAJE3j27GIjFsUKW3YLbe6Ml7tsNYhWq8ZZsczz9FB8
 GMgmVT7galXa2FAsES6Vm4e2mqhxh0T3k8okb1CE+oz0zcBelDXH4X9hHRPZ1WDYzTiQC+1/z
 7Z5yA++/5VTizt5XBCfRe/Rk8FeecqeV0tcUrfMcbedMFJKyTXkXRBUWvB8jl7wAhKuvOHv28
 wUjJ57e6/oJfNchJKaGwkHrqYalUgvcfgrUav1YLTB/ZErIiAu/InyQjaNaOhNf921AxS1wP5
 KMTvBhrB/jNUGhvB2Vu7g9T0Aa/LponvTTVJb/MjQslfUhKEtB22JiQuRW5QJNgsTqIt9TpGF
 voUzCyoJJ73UnuH0qQiyrQEvJeOt4D6ysgXc0D0T0ejvSXqaFQGThYmdqBzF08OkuAlgTE3FN
 QXyUsQDZYK+Ao9gsml6vzF04hcH9wcN07W8jvrRtE858AYpo9mLff3+MFwSWQZZjbw7IU2Ktq
 sGlcfJn+LLnNRNA6YGrs/gnE1mXZHia8aZKJIroUHOufq12kNdJJ1aOVn8xeE9EPa+2TM9jwF
 u+zQINKT/giAGzWtl9aUo1Y1Q7JiIOCG5IOMB3imAzbWn+uEvxyI/aTdCKRcVMjJ/Jpnb/i09
 ukl/8yYwNFnYUmFcYWwgxhnpdW2QIXRmXNs8gZAAKnZ7H6fhXsKb76SBsMtLek+gUQygi1FYl
 AwMiQuxAFmWA/BoG2wyx81eB2y2oqsRlGOsPB7eN+2/YA9P/XtvoRZHpfQzW9NaJHm2mMJr+E
 d0wLekUgx0m8tzDUOEhzK01OzEb0PpogQ4vbf8/zNshffO+iAHCCwe++RmaEr/NW6DoCJVGGZ
 AKHyuqFG7EsegodcRap+TSO5amIhA8eAvb3iyCEiCX4YEsB+UHKavrceeuvoR5n1yngXui2sV
 hTS4uTTfeGEdC0HARsj/h2tJn4PsmkEv8/pKaZ3SEjCLSNU/I7QnRbUHt++MIoCI94mmOVtEe
 wyLH6sQ8rowX/WWh7heBZrI8klsxOA6k2q+OavDc3UnIdAw9WV7Ob84tjlCdlljYGmNUs2QzN
 FaDVv/RLFHixOjpF72nSHnDzZubHXNSAdJE4rNufcPYv3x8d/W47Xs8T/4HEkG21KwW6dcw8O
 sQY4I8H8lyn+SDBhynfhsFODV7w3PYs8bRWeoBsy4Thg57EEIn1XW1DX9BVp9xzuvRQWr8et1
 gZnVkpmWZt2ChNp1QP5hzUUxp3w80ANE4R7MFUwdqzCcsIsrvT/qmZGAqhkujs3bjZTvU3fN1
 UphLrxY+3rSfMzlIUG7KBA0/qJk7CRVuCSSyYE9I1xX4TovyKtV6Eg0u7YzHHi7u1Cdzr0u2C
 VONrsep64vb7vqsMn4mZSn12IFGLP0O6anM3zoxd0XapdR8G+0iHCECWBHeAXsw1ODFMGcnro
 /v/p4Ag==
Subject: Re: [cocci] video: au1100fb: Move a variable assignment behind a
 null pointer check in au1100fb_setmode()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2478
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/82bce096-271a-43a7-a2cf-95b48669ce3c%40web.de>

> 	struct fb_info *info =3D &fbdev->info;
>
> 	if (!fbdev)
> 		return -EINVAL;

Is such a null pointer check still relevant for the discussed function imp=
lementation?

Regards,
Markus
