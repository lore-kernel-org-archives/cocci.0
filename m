Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BEFC28B24
	for <cocci@archiver.kernel.org>; Thu,  6 Mar 2025 09:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qSFgqG5zZ8uB7/EdqFI+tBOKNwncrau+EHb9ROl1Elw=;
  b=FHKJAjWY5UGdfSvt0dqbcQBt5y1l+DDdpMv5WMmrtLGZICH4hAgekYAP
   gpQUvE/lnO9Tt5+HpTv5l83ooOPg7GaKGIZ8ujRPBsVG9n3myCiQzaSTb
   Y4v7JVbGfzX46b69KFK4rWKMGA2LrHpevcgWYsBJkg0LmcVXVMZfJrNjY
   M=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=deller@gmx.de
X-IronPort-AV: E=Sophos;i="6.14,225,1736809200"; 
   d="scan'208";a="211492059"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Mar 2025 10:10:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EC1FFE0D25; Thu,  6 Mar 2025 10:10:04 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 48074E0260
	for <cocci@sympa.inria.fr>; Wed,  5 Mar 2025 18:08:07 +0100 (CET)
IronPort-SDR: 67c884f7_PSgVjAHxwFgYoISKajbJnrp6WpFlfXg1IfzhYtePM4hJ3I0
 RKx0aSwXaQWPVk+8RURI1C+I2lxIvBHgrFHxt6g==
X-IPAS-Result: =?us-ascii?q?A0ERAABFhMhnfhMP49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFABAEBAQELAYJDfVozBAtIhBo8j0+BdDCEO48OhG+EBoFWg?=
 =?us-ascii?q?VYoDwEDAQ05CAECBAEBAwSEfAICAosWAh4HAQQxCA4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBEAEBBQEBAQIBAQIEBgECEAEBOwcOECuFew2CYgGBJIEmAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBHQINHxtEAQEBAwwXBBEIAQE3AQ8JAhgCAiYCAlYGARQBAYJ+AYIvAQMxB?=
 =?us-ascii?q?w2TH5EHiz5/M4EBggwBAQbaWwFLA4JbAwaBGi4BhHSDWgGFUhk7g0J6JxuCD?=
 =?us-ascii?q?YE8C4JHMT6CYQWBXYNbgmmCM4Fpgz6GO6IqUnscA1ksAVUTFwsHBYEpEDMDI?=
 =?us-ascii?q?Ao0FB0CFA0PAQ8GEARqBTQKNzqCC2lJMAoCDQI1gh4kWIIragQFgSSCNyWEG?=
 =?us-ascii?q?AuDUWZ1gUpRNIIOghFxSAMkAwMWDwGDH10aHIRDO4R1HUACAQttPTcGAwsbB?=
 =?us-ascii?q?j2hbzuEQ4E5c8gegj+BOyuEb4cplTUGEy+XWpJ9LphQIo1jmy6BaAE4gVwzG?=
 =?us-ascii?q?ggcFIMiTwMZD44hOINCM8dxQjU8AgcBCgEBAwmFRgEBilSBSwEB?=
IronPort-PHdr: A9a23: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
 Kc=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:9oKRA66Rq7QesNoOawPXwAvXdLJyesId70hD6mlYVQFSeNeJjt
 3GpoV86fY7skdyZJhSo6HlBEDmewKmyXcV2/hoAV7GZmLbUQSTQ72KgbGSpAEIXheOj9K1tp
 0PT0EdMrHN5DFB5K6W3OD7KadE/DDtysCVbInlvhRQZD1LL4d98gx+FgGXKUFuQhJabKBJaK
 Z0qvAnm9K6E05nFPhT60N1ItQqLLDw/q7bXQ==
X-Talos-CUID: 9a23:JIRJEGzyCSlNAyDuM5U5BgUKOsE4T1DBw03RHGG/DlRSEaWKRUefrfY=
X-Talos-MUID: 9a23:4XuQaQSISfcdu8b+RXTS2HYhDsZ1wZ68J2QXk5QCg/KObCF/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,223,1736809200"; 
   d="scan'208";a="211393644"
X-MGA-submission: =?us-ascii?q?MDFqJHut05ZG/y0OdERfRMx9nF6H8lMC71hy0M?=
 =?us-ascii?q?9HX5Y1edZl32nyR80PWnQh78xrm/J4+P/VFs80BO0MAjjRlYUWVgNPME?=
 =?us-ascii?q?4/0fmbwQEFPagpqUxH0ToE9YWfyRQKeRlRth7v2KvkWR/yVdZWLpAzcp?=
 =?us-ascii?q?BPDQ//Xdzn1o9oW1eWv0LTyA=3D=3D?=
Received: from mout.gmx.net ([212.227.15.19])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 18:08:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741194465; x=1741799265; i=deller@gmx.de;
	bh=qSFgqG5zZ8uB7/EdqFI+tBOKNwncrau+EHb9ROl1Elw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VLZt800FdvjEs4Wqu2oAd1ndh0gQt+LYR1bd9ct4ymHbjq5inIR0VsniqcXzEiFU
	 4CzNxJ71unLvywDgSbhWNd/jYc60J8jbdoA10YFT4krLPsAWkzPwxS849M5eNgCCu
	 o3d1AxHq1n5dypUshP5255PeVKSoMAT5izhHY/Ta2rGeboC80ughh0Yen88yWrcCs
	 EFgh9Ft3Swj1dQX016nJtahLCO2NREWlek7aXz0nDFABzebkmo68N2/MXV3VkXUog
	 igBg84iiQRpQ7lKDYEu7RIwiWBQ1aa9bS8zTSK9w7GQr/4j7i6spp5XD25UaLnrMZ
	 /ImaYIOcsoChvOAbzg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.121]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEV3I-1u1U8R0Cni-008r0T; Wed, 05
 Mar 2025 18:07:45 +0100
Message-ID: <81a620bb-205f-45f7-9036-e8e44a8e7be9@gmx.de>
Date: Wed, 5 Mar 2025 18:07:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Markus Elfring <Markus.Elfring@web.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
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
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <9d042e6a-6d93-4ae4-8373-28b9dec21867@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WFCzdqPmtr/uOmd6GBJqupGfFplz0KM/ko2XNaecD3XCxy8tVLM
 H5nDyRb4i4/pCvIoqvQDEIHQdzIgGt1tlvK4W2MRNAtkH00Y965x+n7rWASwu3HfGDQk4EZ
 3h8VLzErjad8IVoyLgvMW9CIB/wfMGorhp7qopi9tv4q9IqZRBFDuIKA5WJxRO/zaAwxO7o
 lv7M8NeXLDx14Qs5Kp5TA==
UI-OutboundReport: notjunk:1;M01:P0:ZTjjDObThpw=;QUkTbV5tHNceAYaWzt1VoI4+tl7
 XGq6xbDKyijcXMXQdr4OxVGxAqp0z59T86Z87Ecs/LkY0f0cHtQUGkXSF/MJtQM5HeS2TUC6z
 ahJMY1fqhLwCIuLeFQl5/orQTlf+JY0dwnkaWiPhSCl7YJXpV35v65WEF1teGcRBvL2M9yLZg
 dAl1OtW2aGwcEL7FT2vR3aGUg+leKA3qOlu1ySvdDGoJvf44RK7QYep91ERHKfQeuZjdvLERC
 GbCQpTh26i8xBvJqo41+h1G7aSROIhzOhVg2vLTeNguaBLXgR+uy6suuklrfb6hJPkRJz0E9d
 +9vg63qLUS8KCk/v0aLJkPH80iokVr9tp4eFkJBBI4MZK/1p00dvAD1x6BNRBiQzXF1Ia3HiT
 s+Dk44aOSyuMop6tEAqtvt1XvqU/R9+kgngbDi39qW3ej6+BMOMykTs+etmcJy5gI9SD2gRXG
 6Bx1HRPNVdK2csjAY4obtXGr+SFsvpjzidO+9IDAjKIdi2AFFjgjw1ks7QoZl77fjhVb5/sjf
 UzpX8ziakIzDbOjb5ywv2Kj4Gj4LWL5N/ef8s/bSnZRVhM8FXdhmk5wwyarRBwUOJRF3wzqXt
 xhhfaFYCdvoMz3UKhvMyJ7pPMUNs4DfGStou4qbFTM4Eq2EcYpxNN3nZiKkuAPuXsRDTozvXo
 Wk+x87X9UnNM8Q/510HmrZ8HajJvwQzKAah/r4NkUhNniTEJenXZl9Aj7NP7UttP29x0QRVB7
 pKWwsWrb7tKqypP1P+0SznW5hujv0k2sbQziUN3xXLTswbgmFyLeH4sWHJGrfBc4LfRo1G7oT
 VxEIqjOitgmHVHL07LwKbdYqlQDMYLcGQddu9q/sEzkhvgegRvHv75RPCR6fIRsGHDfVfTbec
 Q9pD7GEBv4gS4sP4CperWATqvofFcVNdJeJFaSIiiA7aBpc32IbXqBzbvICCRkI5MsAq78ZeV
 +202OzXmjLeEu1Jb4nijmtOSKkfKmcvUDLRHAp4Bxh3AyAXOu60AwmL0Wj70bKY7LFpSVrVZH
 qYCsMP9m8JdhaRx2ecdjYR6ChUPxp2NvO6VbZ2ykIqr4LJ79w0PgejItZJGi3PNsqrwk6TQtc
 uFVnrz6BnqKyR80/A9crQjgcKEbycz8aASxsiFVXj3npPDHf7G5XIp+q2AgaEHdEhJ3z0UYTY
 W2IiA5YHpDS6ewVU9bMHOQaVp8+aWDIBE+cUogyktjDrIQTHUwSLjVi6pBrbAUIDRT15wZ5Ar
 C0RR/l8w1L7Ke3foW58ZPtOT0HFqAVcUm8cBsMuPwW808pdFCAbcHdc03qjfrlV6l/2tDMIay
 3uLmVYVQGX1mopLPhbtBAC3FGzwbKw7P2R44DcnXvQbBUdkbnqj7naobetDhHwdn4cXmIekTp
 5UsbywibX3IzkNtFcIOuBATyn87vhA04agxuRzK6v60TKjbZFC7bpHHTxF
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] video: au1100fb: Move a variable assignment behind a
 null pointer check in au1100fb_setmode()
Reply-To: Helge Deller <deller@gmx.de>
X-Loop: cocci@inria.fr
X-Sequence: 2563
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/81a620bb-205f-45f7-9036-e8e44a8e7be9%40gmx.de>

On 3/5/25 13:14, Markus Elfring wrote:
>> Anyway, none of that applies here, because this is just pointer math.
> Which data processing do you expect to be generally supported at the dis=
cussed
> source code place (according to the rules of the programming language =
=E2=80=9CC=E2=80=9D)?
> https://en.cppreference.com/w/c/language/behavior

There is nothing to discuss.
Dan is correct.

We have:
struct au1100fb_device {
         struct fb_info info;
...

so:

struct fb_info *info =3D &fbdev->info;
gets translated by the compiler to a trivial pointer math:
info =3D <value of fbdev> + 0     # 0 is there offset of "info" in the str=
uct.

No crash or anything can or will happen here.

Markus, maybe you missed the "&" in front of "&fbdev->info" ?

Helge
