Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05274CAC5B5
	for <cocci@archiver.kernel.org>; Sun, 28 Sep 2025 13:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:content-transfer-encoding:from:message-id:
   date:references:in-reply-to:to:cc:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=mUzyFutsblmkPn7Po+GCTOzGzeaoZrt/PHsk+7XI6D4=;
  b=kxWN0DeABTQPBDHypU58sWKNgUIFbvV7C6vkKt5PuWWtDSgl6tcwIi1b
   8zM29Y0uvOskLYb1eWwb1TDq9rFJGrPZWJ+8RXIN3Le9+p0QuEn3pmycP
   j7gYLTHCkFhDSFAs+DAA34mJSh138Lymsk47CChz4ZG3JfYh7zLbiUpwF
   g=;
X-CSE-ConnectionGUID: WjSQKwd+T6WSDoQG8kihUg==
X-CSE-MsgGUID: +dwxRXwdQV60100zPfdN2A==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.18,299,1751234400"; 
   d="scan'208";a="241375696"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Sep 2025 15:36:35 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 43F7AE0BE9; Sun, 28 Sep 2025 15:36:35 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BC768E0171
	for <cocci@sympa.inria.fr>; Fri, 26 Sep 2025 21:50:18 +0200 (CEST)
X-CSE-ConnectionGUID: h/72tkB7RLKV360eaDUZ2Q==
X-CSE-MsgGUID: 35aEhNwEQHOqzuE+uhIcxA==
IronPort-SDR: 68d6ee79_zaM4fA4VzKboEDLXStOL2sFMkQtsGJN/NOb1p8tEyDEbm6B
 tcpmHNvfNPAmdiiItCLZJFk+4aiHZFSdepGjMkg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EBAACO7dZohR/86qxaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYFtUoECBlUyBAtJhFWIHF+IeZxFgVWBfQIPA?=
 =?us-ascii?q?QMBDT0UBAEBAwEDhHwCAgKMRgIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQEBA?=
 =?us-ascii?q?Q0BAQUBAQECAQECBAYBAhABAQEBQEmGTw2CYgFXTXQwAgEBAQEBAQEBAQEBA?=
 =?us-ascii?q?R0CDX4BAQEDIw8BDQEBNwEPCxgCAiYCAkYQBhODAgGCIgdJAwEQtS6BMoEBg?=
 =?us-ascii?q?gwBAQbcPIFNAwaBGy4BiDUaAXN7g36CSIE1eieCKIFHgng+gmEDgXQIgz6Ca?=
 =?us-ascii?q?YImgRaDVoQAiFmOMAlJeBwDWSwBVRMXCwcFXkJDA4EPI0sFLR2BJ3eEFINZR?=
 =?us-ascii?q?StPghxygQ9lV0GDUxENBmsPBoEVGUkCAgIFAkM+gWsGHAYfEgIDAQICOlcNg?=
 =?us-ascii?q?XoCAgSCL4ESgg5AAwttPTcUGwY9mC6BAIMeGj0ClXmDFUqvVo8egSaVUzOXU?=
 =?us-ascii?q?hSTBZkGjgiVYIVZgWg6gVx9gypPAxkPjiEZiHrDDUQ0AgE5AgcLAQEDCZIeg?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:bM+Fw6DeWbciAxVW/7Pnw5YqxClBgxIJ4kV8jS/XYbTApGlxgWcBm
 mAYXDzUPquMMTCme9AlPYvg8kJX78XcndY3OVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG86yQ6jOfQG+eU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEAHjgm4c3l48sfrZ9Us+5qqq5Fv0g3RnDRx1lA+G/5UqJMlHTU2BByOQapVZGOe8W
 9HCwNmRlkvF/w0gA8+Sib3ydEsHWNb6ZWBiXVILM0QKqkEqSh0ais7XBtJEAatko2nhc+RK9
 Tl4ncfYpTHFkUH7sL91vxFwS0mSNEDdkVPNCSDXXce7lyUqf5ZwqhnH4Y5f0YAwo45K7W9yG
 fMwKHdSNAyArb2M5JGFEbc0i80PEfuxBdZK0p1g5Wmx4fcOWp3KBb7N+MVT0XEzi9pIEPKYY
 NAWAdZtRE2fOVsVYQtRUs9k2rzx7pX8W2UwRFa9vaMr6GjMyxZylbLqLJnTd8CGSNtfhkiwp
 W/c+Wn9RBYAO7RzzBLcqCzy17WVzHiTtIQ6T+Cx2/5Mn3Cq5ksKGgA7Fka7gPKpoxvrMz5YA
 xdIpXZ//PNaGFaQZt30QBS8pFaWvxsWQdMWEusg6QjLxLC8yw2eDWMFZiVQbcQv8s4wXz0jk
 FGT9+4FHhR0vbTTUnWA7LyZ6zC/Iy4YKSkFfyBsoRY5D8fLoMZs1A7MZIlZNI2L1YOtFDjc/
 gLQlX1r71kMtvIj26K+9FHBpjujoJnVUwI4jjk7uEr7smuVg6b7O+SVBUjn0BpWEGqOorC8U
 JUsgMWXqvsJEIuGmWqOTf8LEbXv4OyKWNE9vbKNN8dwn9hO0yT5FWy13N2YDBw4WirjUWOyC
 HI/QSsLuPdu0IKCNMebmb6ZBcUw1rTHHt/4TP3SZdcmSsEuKV/Xpnw3OhTKjzyFfK0QfUcXZ
 8jznSGEUyZyNEib5GPsH711PUIDn3tnlTyDGcyTI+qPjOLOPyTMIVv6DLd+Rrtls//V8V69H
 yd3PsiDzhxeGPHzaSnR9ooUIlEHNjA6A5uww/G7hcbdSjeK7FoJUqeLqZt4ItwNt/oOzI/go
 CriMnK0PXKk3hUr3y3RMSg7MNsCnP9X8RoGAMDbFQ/xiyl7Mdf3svx3mlleVeBPydGPBMVcF
 5EtE/hsyNwWItge02VCNcvOv8Z5eQ61hAmDGSOgbXJtN9RjXgHFsJusNAfm6CBEXGL9uNocs
 o+Q8FrRYaMCYAB+U+fQSvaklG2qsVYnxeldYkrvI/toQnvKzrREESLKo8ESH9AtMjTGnzuT6
 BaXC0wXpM7LuI4Ez+PKjqGl8aavNe9PJRdIFTLl/IfsCDTTpFSyy4p+S8KNLCHvRULv2aCYf
 e4O5erNAP4Gu1drsoRHDLdgy5wl1ebvv7N3ygdFHm3BSlaWVoNbPXiN2PdQup13xrN2vRW8X
 mSN8IJ4PYqlFdzEEllLAiYYdcWGiO8pnwfN4cQPIEnV4DF9+JyFWx5wOziOkClsE6tnArg6w
 OsOuN8k1CLns0AEau25tyFz83iAClciUK9975ETP9LNuzoRk1pHZcTRNz/y7JSxcO5zC0gNI
 AKPpa/8lr9Zl1vjcX0yKCD35tBjp68y4TJE8FxTAG6yuIvhpuQ21xhv4zgIXlxr7hFY4dlSZ
 ElvFWNIfJurwRk5qvRHbW6WHyN5OCa44W30klsAq33YRRKnV0vLN2wMBtyO90E4rUNZYjxQ+
 eycwk24Tz3vd8DV9QkxUH5DtPbMY4FQ9ArDucb/BOWDPcAwTgTEi5+UR1gjikXYE+Joo2Ofv
 shs3uJ7SZOjBB4qu6dhVrWrj+UBei6LNElpYK9H/ppQOUr+ZTvr+zyFC37pS/N3P/aQrHOJU
 Z1/FPluCSa7+j2F9A0AJKg2JLRxov4lyfwCdp7vJk8Eq7GvlSVogr2B6hnBgHIXfPs2nfYfM
 o/xcxewIl6Uj1ZQmE7Pq5BgEUi8at8megb9/b6U9MMkKpE9i9xvIHoCiuaMg3aoMQVc7021u
 iHHbPTo1OBM89lnsLbtNaRhPD+KD+3Pet6Gyy2JiOQWX+jzaZ/Pkyg3tmjYOx9nOOpNetZvy
 pWInt3F/GLEm7cUSVLpuYSzKLZU756QWstWLcPFA31IlgSSWMLXwkUi+kLpDbdrgd9i9s2ca
 A/gU/SJdPkRQMZ7+H1ZTwN8AiQtIf37QYm4rBzsssnWLAYW1DL2Ce+O9FjrXDl9TTAJMZivM
 T3Eka+iyf4ApbsdGSJeIe9tBqJ5B1rRWaEGUdnVnhvAB0mKhmKygJfTpSAC2xrqVEbdSN3b5
 KjbTCfQbB6x4aHE7O9IurxI4yE4MixPvvkSTGk8pfhNlDGIPEwXJ788MLIHKK1uvA7c6ZXaX
 AzJPUweUXjTfDIdfRvFtYGpGk/VA+EVId72KwA4507eOW/8GIqEB6An7St6pWt/fjz41uy8N
 NUC4TvKMwOsxo1yD/MmjhBhbTyLGtuBrp7Jxaz8ryA2Kw0TCPMR02F7FwcLViHdFczJ0kLRK
 gDZgIyCrF6TESbM/QRIIha52y31eBvswi8uYCPJx8zQ02le5PMV0+XxYokfzZVaBPnn59cyq
 bffRGaX5W2SnHsJtsPFfj7vbbBcUZq2IyRxEEMvqcD+UU19BqTL8v7uRRYycfw=
IronPort-HdrOrdr: A9a23:nLK6TqjHERblgYUqh7UVthD9VnBQXtsji2hC6mlwRA09TyVXrb
 HWoB19737JYVcqN03I/OrsBEDuewK4yXcY2/hzAV7mZniAhILKFu9fBPXZsl/d8kTFn4Y3v8
 tdmupFebnN5DNB7foSjjPIdeod/A==
X-Talos-CUID: =?us-ascii?q?9a23=3A1HdEL2tummJ6rjRc2iljfABQ6IslNSKH0HT6fHW?=
 =?us-ascii?q?cKlgyFuWYQHOtyvldxp8=3D?=
X-Talos-MUID: 9a23:4zjelQkwFrSs9yoOaDuKdno5ac5F44KxJXkttowUpuTHKCxRMCe02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,295,1751234400"; 
   d="scan'208";a="126692293"
X-MGA-submission: =?us-ascii?q?MDECGzxPKVxRuyZeDsVhqdV7hZEzhUFMydLU5Y?=
 =?us-ascii?q?k5NCUI3SR3XmekGV4W2MtOxrihKLvvCRH+GRbL59y5j9Yr+yrwmpm/aC?=
 =?us-ascii?q?jera0fd/G+0RxjpoiCkjk9fCswEi5OzxW7CjQvoSnCOhHchjWc7fgvO8?=
 =?us-ascii?q?5uS5UaH3BRCospJuZ/B3sw+w=3D=3D?=
Received: from sea.source.kernel.org ([172.234.252.31])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 21:50:18 +0200
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 030F445958;
	Fri, 26 Sep 2025 19:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEB1C4CEF4;
	Fri, 26 Sep 2025 19:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758916213;
	bh=jbqfYO7LUYlssd2poqpVXDaCMPuZwPS8Lp58xLAuLXY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BD90N6Ryx9yYAjKUDF15q7bFLe8x1kcG2ze9J8zXb5kSOzYrTNzPJkJHmskb5nCkG
	 8ivdByzir5dKPwiALp+aFgv7pJVybId2W2WGuFAW0JRyYPnKnQjss94sI70q3LS4jU
	 HPn8C8gqpZdESk61pEPi7wj/259HM5aa0zAo9Mu75k5jk5ouRTUdkNrP+jOpMgWykz
	 mSc4mMO/ih8PUIclSj8yhgUvyvqpRFk05+/PzrwjzIah7OFC6DPmnz1Aw7tWEwi9yd
	 HYO2i5rxGdVbtfTQz9JTOeRmHac6389CM5u8VoLblYG2xrjr6q4Af209Kh8xyr3f1l
	 O7xZ9O32m/4JA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4998C39D0C3F;
	Fri, 26 Sep 2025 19:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175891620925.36020.4383105129946487821.git-patchwork-notify@kernel.org>
Date: Fri, 26 Sep 2025 19:50:09 +0000
References: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, Julia.Lawall@inria.fr,
 nicolas.palix@imag.fr, richardcochran@gmail.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, cocci@inria.fr, gal@nvidia.com
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH net-next 0/2] scripts/coccinelle: Symbolic error
 names script
Reply-To: patchwork-bot+netdevbpf@kernel.org
X-Loop: cocci@inria.fr
X-Sequence: 3047
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/175891620925.36020.4383105129946487821.git-patchwork-notify%40kernel.org>

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Sep 2025 13:43:45 +0300 you wrote:
> Hi,
> 
> This small series by Gal adds a new coccinelle script that spots
> potential transitions to symbolic error names in print functions, and
> then uses it in mlx5 driver.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] scripts/coccinelle: Find PTR_ERR() to %pe candidates
    https://git.kernel.org/netdev/net-next/c/57c49d235572
  - [net-next,2/2] net/mlx5: Use %pe format specifier for error pointers
    https://git.kernel.org/netdev/net-next/c/b89cd87b77d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


