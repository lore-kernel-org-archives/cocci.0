Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC125EB64D9
	for <cocci@archiver.kernel.org>; Mon, 19 Jun 2023 09:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=lj70GAUzXQUalK9eQWbuQbBFvBSSs45/cY2D8hkp3Jg=;
  b=b1aD229LSMFxUb6dI0LLnDijJIewTsfM7xlGcA2kGNvfya/viv//ijJ8
   +tCUTUbb8Z0vaGytJwUEm7fSAtTeiQhzF8kRUBptj47LX48tLOpkDJvmI
   fVZFi7U90bQUZG9cf3PAwiJ0RtxTjKSCuyUeKaaE2AsJiER39xvW1R1+t
   U=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.00,254,1681164000"; 
   d="scan'208";a="113522220"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Jun 2023 11:43:50 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 93C76E03AE; Mon, 19 Jun 2023 11:43:50 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 351F1E0157
	for <cocci@sympa.inria.fr>; Mon, 19 Jun 2023 11:43:45 +0200 (CEST)
IronPort-SDR: 64902350_WyAh+TUR4LuMtW3bzkFyWHLQdedFMGqwWfUS8Blo8grWorT
 /H85xKsBuSwcoYbV8GBbYYOdFEZXm51zqlZyMBg==
X-IPAS-Result: =?us-ascii?q?A0HtAACMIpBkhwsR49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YIueFMwBAtHhFKIHYcQgXYxhDaHModFhGiEBIFWFIEsPg8BAwENQQECBAEBA?=
 =?us-ascii?q?wSBTIMpCgKGAAIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECB?=
 =?us-ascii?q?AUBAhABAQEjFwcOECeFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBEgJHPwECAgEjHQEBESYBDwsODAImAgJXBgEMCAEBgnqCKAEDDiMHrWGBM?=
 =?us-ascii?q?oEBgggBAQacDh8sIlWBXwmBFS0BjS6DN3onD4FVRIE8gwQ+hCozg0KCZ44wh?=
 =?us-ascii?q?WWLQYEob4EegSJ6AgkCEWeBCAhfgXFAAg1VCwsPVIEcUjqBRgICEScTFAVNe?=
 =?us-ascii?q?BsDBwOBBRAvBwQvCRYJBgkYGBclBlEHLSQJExVBBINYCoENPxUOEYJaIgIHN?=
 =?us-ascii?q?j8bUYIBJQQOAxkrHUACAQtwPTUGAwsfBiYBHgIpgVcwWHUjJKMkVIMao0WgW?=
 =?us-ascii?q?TUHgjCBW4FdDJ8cBhMvg26TJw4Gki8uhzqQMSCoGIFjOoFcMxokgzZPAxkPj?=
 =?us-ascii?q?iAZhA6PSD80OwIHCwEBAwmFRgEBhgABAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 ewjFrbM0tRdD32nqSv/JhB2vAu/+s7n+w==
IronPort-HdrOrdr: A9a23:eRjimK7Gj7b6pIQowwPXwBzXdLJyesId70hD6qm+c203TiXqrb
 HLoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkdNDSaNykesS+V2mmFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:29W7HGDEg1hm9/X6EyJM81wFGO8+STrmyVT7KUuIVGk0aYTAHA==
X-Talos-MUID: 9a23:cxrxXQROLGwrw+NuRXTcjmxwNMZk4p+cI2MukJMcnte9GnBZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,254,1681164000"; 
   d="scan'208";a="59098539"
X-MGA-submission: =?us-ascii?q?MDGv5ZAhdnyxyDx/dnCZaJvy/y9HMec3jgJSYB?=
 =?us-ascii?q?23x3Ugw+bqz6JTcaeGeSmkslXuANKDRz/hHc5xPNbymsc1gdx0la/zN/?=
 =?us-ascii?q?NIvIG/wwLWyAKN1xZtOaorbMTsZcG8dlnOTo1pUpyqrR26jANSXi3DlN?=
 =?us-ascii?q?ldp5GdzThG+503fVAAI6TwyQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 11:43:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687167823; x=1687772623; i=markus.elfring@web.de;
 bh=lj70GAUzXQUalK9eQWbuQbBFvBSSs45/cY2D8hkp3Jg=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=LK0YFt4BRxPa+8ukMkKhtS4qR/dDcQmLpvI22fR6TInJ2v6c+SWG8BIaN9vFSy5E5W+8eTY
 eXlaZPJGskKVAED8SP2o0W6xiSwpIAQvH/D5Q48EKciwzq0qpDaN2sZlOJkKWJef3gfI4F4R6
 01OTRz9w+dVfuWms5H8uKXT4zOCFCddQ93bIwleVMzIxiypzXcAKAynMi3MDWXgowHCGaBz0D
 6xbluHXQ+j69yTJdHhF189B28uaNisyHK3uV/uZB6UWFDk7xazaX9kIgZUxx32Gp9BHcRRxHW
 DV5NRXniEk4pm6S2fnpqaOJuRZ2y0am/qNnUNoOrFLoeKGnKPaaA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MftBr-1paDuY19Qn-00gFob; Mon, 19
 Jun 2023 11:43:43 +0200
Message-ID: <45de3da1-42b9-8c08-9c7a-c84d0338acf3@web.de>
Date: Mon, 19 Jun 2023 11:43:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Fei Shao <fshao@chromium.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 linux-clk@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>, LKML <linux-kernel@vger.kernel.org>,
 cocci@inria.fr
References: <CAC=S1njwxLfw7LcnXkgY7pbiFaqvNQVyAzHVhK9+nYJC63d=Zw@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAC=S1njwxLfw7LcnXkgY7pbiFaqvNQVyAzHVhK9+nYJC63d=Zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:rvAO5P4rJWmuj8hzlzT4x6OLQB0RfTlpf+X6AHuoTW4Bkl8loUd
 opvSbP3UlnJPfeLB/hTD5CufncXJdTznrbAeOpMR4tdLBVlGZQoQjbLdZIcnpMUQ6yydBsB
 GJPMoHQtm/JcDaG89Z5SbsxuwxIPSbUSRZiPGTH2+V6nKY0x1GG539dLBiHvSJL2DbL7I0x
 JVqiMcAS2fXnMdq6bCXUg==
UI-OutboundReport: notjunk:1;M01:P0:J1h7AKYpP9U=;ZK1bCygjS1BlcJ5v9xmeeQ3MGtZ
 2Eg8VXLfYWAdVyrDoso4DjNiunklaWwFegJgPY0ikEAmbOp+97RDXYcsOtcu+xFx7oAzAlCwb
 UKiArew9IE04W811Tnyqjy9g0q+1xNOI35Ncl6BwPFyat8aRhsjkxqI1W3yO3iK6YZMSYwQoH
 cxggWh+a6eV2jMG7VCWlPkRBT8LSsBpjz2R6wK7+Zrj4X9N3QUFQCXbn1WrOh2VnabD1bCKZ3
 EYs4INJ7LMVow0icgQHTbVZepl1MtUnU5NJWc/FilRM2U1Bo95/9XA60nzOiowrFeNsD88lcc
 JWymnvUYd49gSIqkE6FNGeKK8R3esNYfsAkjsbY3/IBopM2oZRoi4Vdgl9NO+89KOShwyLZYl
 fOnGJtVR0oH2cLDQiSNRphM3bzdsZEY//anu/NP3kvf30DQGIJjegMzC4aYbZcN0Sj1bx5JLH
 Pb60EfUOaHj+uufGHpsYpDHeEX3LNq3+LWUKyHennP3gANnnCNDFdk7yf78+PRtufMK9aheLI
 xSEMUU2niyidl/dp1X2+P/FRwleFh3GSUN3XLJTpj0+9J4VFi0NIwsGlaDPEyXsvoT/MnK1yd
 KrZFswUNFuqyVWAV/Rr8LloX+Q5jG2S2CPuG4qsNj2xQRgrzRM03/ypoqU02Tha2uoejK9dlc
 e6AZ018F9le6sjAyFv6+XTI2qMeJO2UZ7SuTfwCDRlkPbSjCRUGC+5EPJEJAd2YI3JMvhTAcm
 mzzjiHZrBQfilISrX5qGqyqpoh+S3O6C5GdGABD9kFBnoWex6HF8lidMWtCmUutBEOsyaJI0z
 OTd/TGLWwMY+jzX+2jeyBHOixlKcy7ygbE2JBQx1dLAOIql3hgAWeCAc8Qc7hLmMJB7LOBsWw
 SnvzCNloJPlDc0eth5ZZVLGlewpDKA8/SknoNbRl4EuC9dwzhRaRDiw/yvZUSpeb9oqmLJcpe
 beGO/ZYcAFRTGhkCsfZu/YWVFfo=
Subject: Re: [cocci] [v2] clk: Fix memory leak in
 devm_clk_notifier_register()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1194
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/45de3da1-42b9-8c08-9c7a-c84d0338acf3%40web.de>

> > I can think of some ways to find this bug with static analysis.
>
> It was actually detected by kmemleak on an unreleased Chromebook device.
> I added the trace snippet in the message at first but removed that
> before sending this. Maybe I shouldn't have.
>
> I can resend a v3 to add that back if that's preferable. What do you think?

I find it helpful to add another bit of background information
for an improved change description.

Regards,
Markus
