Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D4EC3DA6E
	for <cocci@archiver.kernel.org>; Wed,  3 Jan 2024 09:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=AxUo59lf3PVIF7TFP9z9JW5Tfu2kkaO8nWAW7E7rQxw=;
  b=jc/Jd/v5WpX5WqOA7/y6ATJ2K0el0bjERPTABpnIoaC6/0RTjwcKO/7X
   F69bpQ8mcq/prulS5/mz/IuetC1yEMtU3lrnLUfxeosMOSAIz8ArhMk1Z
   na32/BMxxGHiuVKjlLEn5h1KW3kvoCH3FLrLzwJjPexSgAIKx4OOPKW7x
   o=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,327,1695679200"; 
   d="scan'208";a="144660833"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Jan 2024 10:06:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F07B6E0CCE; Wed,  3 Jan 2024 10:06:25 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3AE6FE004E
	for <cocci@sympa.inria.fr>; Wed,  3 Jan 2024 10:06:21 +0100 (CET)
IronPort-SDR: 6595238c_NPwJLgjUWTrw2gMg0PmICOeGooz+WKZezA68ABECXHdDPEl
 iz2v0/QbrheU7WcQWn8s/+T9qsXKus8doXmlDSg==
X-IPAS-Result: =?us-ascii?q?A0HBBwAMIpVle07ASNlagQmBT4I5fANTMgQLSIRTkTaEa?=
 =?us-ascii?q?48BiG+BVoFAPg8BAwENOwYBAgQBAQMDAYR/Aoc2Ah4HAQQyBw4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBJBgGDgULJ4VsDYJcARCBDIEeA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECDTpCA?=
 =?us-ascii?q?wMjHQEBESYBDwsaAiYCAlYGARICAQGCfAGCKgEDMQcNBq98gTKBAYIKAQEGg?=
 =?us-ascii?q?UUCDAJDTqxyHywiVoFgAwaBGi6IGwGFZ4Q7Jw+BVUSBPIMDPoJhA4Ffg1uCa?=
 =?us-ascii?q?INohTYHMoVriiGHM1siBAFBcBsDBwN/DysHBDAbBwYJFBgVIwZQBCghCRMSQ?=
 =?us-ascii?q?IFfgVIKfj8PDhGCPis2NhlIglgVDDQERnUQKgQUF4EOBGobEh43ERAFEg0DC?=
 =?us-ascii?q?HQdAhEjPAMFAwQzCh0LIQVWA0IGSQsDAhoFAwMEgTAFDRoCEBoGDCcDAxJJA?=
 =?us-ascii?q?hAUAzsDAwYDCjEDMFVEDFADZR8yCTwLBAwaAhseDScjAixCAxEFEAIWAyQWB?=
 =?us-ascii?q?DQRCQsoAywGOAISDAYGCV0mBw8JBCUDCAQDKykDI3QRAwQKAxQHCwdQAxkrH?=
 =?us-ascii?q?UACAQttPTUGAwsbBj4CJ6IvgTYBgjd8FCkCx0s0B4I0gWCBYQyKGJUTBhMvg?=
 =?us-ascii?q?24TkyUOBpJULodQkE8ggjGJI4F2mnyBagkqgVwzGiSDNk8DGQ+SS4ELg1aKZ?=
 =?us-ascii?q?kA1AjkCBwEKAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:FmbNxKs4eV8U54mplb8cdTHb7skDotV00zEX/kB9WHVpmwKj5q
 eTdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniFhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDxHZK3BgDVQfexQpeWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:nwU5om6uxZdN41ZJEdssrlAbEN0+XnTk7HrBJhCUD1RJeaPEcArF
X-Talos-MUID: 9a23:S6YGKQgahp9jVZ4TKLgal8MpF4BwoISnVmo3tJwcvMS5cnRvJRmfpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,327,1695679200"; 
   d="scan'208";a="75695340"
X-MGA-submission: =?us-ascii?q?MDGyjzkfTXV8n1c37HTwFp+YetNv8jWP9+n6dB?=
 =?us-ascii?q?QuV5q8GWyoJQxWwImXz5PuvkH8iQ8WDvuX58lamCmYRYaKjV3Bc3f/XP?=
 =?us-ascii?q?m65gAOLz2MIKYflcAx64rUED0QH7s+KJd/ga7sNyOLc436tsupbylK2n?=
 =?us-ascii?q?bHmMpChJO42EMYc3Q7/StQfg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 10:06:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704272779; x=1704877579; i=markus.elfring@web.de;
	bh=Fb/E0bLfK4HYiwHmpycQDyjgyUrLghAFd2etpy2dGyo=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:
	 In-Reply-To;
	b=YRY4Vu/uF/q09ZyO20+wDkEtIp40KkprS+whmkQ2V8g4+/dyjXryX6vxXUHw8fxf
	 gVov6sfLeWV3cICN4x2SyrYQtT1PrdW64VnBQgU3fHsmQF79JZl8AMqeZScgS3JvZ
	 gpXYCeVzkDFIIHWu19FiZw/YH/Z43Z3PKJeO3lib5V9sJZMkUZEtOyPoef55e0xzE
	 VkGJ1+IMX3pCJ9CWAKtq7fUNsFrVrNW+JCU+lHYBauXsIk61OcL0Og9yERX5n003W
	 dN8cCnXK5fSvcl3Hoiikj03ZW61XEIxVrlM67dX+Ru0z+jtdS1v5Rd4GJjx6dCCrN
	 rXq1vFykn47Ff0wtHw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MODiN-1raAhm0cNl-00ONpl; Wed, 03
 Jan 2024 10:06:19 +0100
Message-ID: <bb11fd85-1fa7-429b-a379-f4a92f7f0f88@web.de>
Date: Wed, 3 Jan 2024 10:06:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Helge Deller <deller@gmx.de>
References: <913bb6fa-c168-46f7-ba39-5fdaae586b6e@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <913bb6fa-c168-46f7-ba39-5fdaae586b6e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A4M3xaazTPrShaIJhrVteu/4GqbA0GzEzzmVrL1bCQrpmNVDERV
 WCyj1rRRUVyO4tU+6n2OPqpaLolyJWevbPvHuMV8wcMGamejJAOCPt/ZKl28Bl2Unrgdokv
 osfl2ei4VkEePSz3yBcHEnanhLcMn1tFi5zDrS7X8Dfb0m5kW5J+aj4cgw/KMlbmRrEyVcH
 Y+ih3krKSGjJIq+ORzevg==
UI-OutboundReport: notjunk:1;M01:P0:vA+xCXVlgZI=;Rno+HfKZxe7/PQaAe9RUvnekz2K
 7dLwz68F9SG/kBRGvZmCXV/PXJVU/I2nhQ2ohxLew8EI4ROJyP8x8Gt99unFaFnw86wHbcbXG
 tjZ1Xi8eKBDEY810Yx9bYGa4V4Cwm7FCra08Ladj9OSO0U/GaDESfck2m7tF6sGg02qUGqDiI
 3z6/cKT3+2tiEpxCH4aJBruDR5ltWLSf53qI1rapg6kHJ5iFmxazGeJ7x00T8PGCCNZafqukg
 bQWm8gJBiOyoC7L6M8yyMtHIoapf5aAxS2CTEj/0j1iwsn+WsWDAnEplCVTtJoId28GLf69E6
 pIKLp4JBpidsUC6wQc8biLZqm4+cBrsKjn9Oxu8JgxQEzRtLDmEzbSDhdkGD9XCfnxFToSRdN
 coxvZ9pyTPHiju0DBjJbCLmZHoEw4RJiOe0UcQDXxdSyQ9E7sgL6MHDQDSjxct8qtO7ctURNz
 C+Us9to9mGSFKPIaMQMUlzI+t9cL4Ml7HjmEQOYEsezyTo2KaFcWjXzluhtzk8czqx8WAs6kU
 WxoaN2nzFalI7d4tHvx1wQ6GjQV76nZSeAF2H1G2DzopgJHZzV6K2CRvqS3ASa+UwLPxDHOOj
 KhDtuc1SPWSps24uKePPIXCMc9jCYwKFqKEjCPd7Bft2cf/48ddssUJ3V1kOMdehiDMjUeg6B
 XW2mD8WS8Gji9xKKD/63/b01yT0bIDkrZycZ1SYSMR+NP7JR4Tl2UBRIWev1ASdCng0aTaCCE
 K4x9PYILpRx/BbOcnXJFezfwEesXVEjn0l9SpzNqMfFWRVxQcj8dX4fRvdtIxUEyF9Fi+ca8I
 WIe8woZzRbzt+iFyHau0mmtoHipNoXAMAZ/ctQYYVtqTzsxbf5KVKSIgHGFCLYeoSxxgSZX+i
 RsD5gixoEtxUzzdWxbb8hvTn+kN2eYk9twXvK/tyJATVh2j3NfyyhyNqu3Slwo2+WZFMPv7zx
 MAMNvT8DnDrNCB1QUQaHljBjhhQ=
Subject: Re: [cocci] [RFC] fbdev: Completing error handling for
 fb_alloc_cmap() calls
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1428
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/bb11fd85-1fa7-429b-a379-f4a92f7f0f88%40web.de>

> @addition@
> @@
> +{
> +int rc =3D
>  fb_alloc_cmap(...);
> +if (rc)
> +   return rc;
> +}

How do you think about to apply this script for the semantic patch languag=
e
so that remaining update candidates will be found?


See also:
Clarification approach =E2=80=9CChecking addition of local error code chec=
ks=E2=80=9D
https://lore.kernel.org/cocci/913bb6fa-c168-46f7-ba39-5fdaae586b6e@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2024-01/msg00000.html


Do you find further change possibilities still relevant for 23 source file=
s?

Regards,
Markus
