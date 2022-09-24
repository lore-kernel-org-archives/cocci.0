Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02C0C07E9D
	for <cocci@archiver.kernel.org>; Sat, 24 Sep 2022 08:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=2RgBZfJu5KFzikoB9VzaaGxZdusTR8pLRMhYL8jFOB8=;
  b=Ae2uKijb5c6e1e8zqTA9zN1QdWMWg69zwMfA07R/rwTdT/UsmDr62sZI
   D7+dPDWSklOhPDroHAzqGfP7jOhWxHST4MyIaDel9Wd48Xvo+uRSPINYA
   22TN9X08ydl0EcSoZAQVpzaKJxl9zpmYfuEMnSMEPrHWMvV+NIU68CYPV
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
X-IronPort-AV: E=Sophos;i="5.93,341,1654552800"; 
   d="scan'208";a="54325187"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Sep 2022 10:36:58 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5E7FEE0235; Sat, 24 Sep 2022 10:36:58 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 876C0E0090
	for <cocci@sympa.inria.fr>; Sat, 24 Sep 2022 10:36:56 +0200 (CEST)
IronPort-SDR: 632ec1a8_J+ZnjjrbpZOTufbBdWWcDqbu9Vn5xFbs4Xvd40e88bCF7I6
 H1cplJbFFStDDTLz62M4U8PsdSJ9eN09Hz1eUrg==
X-IPAS-Result: =?us-ascii?q?A0DtAACzwC5jh07ASNlaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YIjgVcuBAtFhE6Ob4MHg0eHGIclhFqHUQsBAwENPwECBAEBhHsKAoRsAh0HA?=
 =?us-ascii?q?QQzBg4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBFwsXBw4QB?=
 =?us-ascii?q?SKFaA2CNSkBg2QDAyMdAQERJgEPCxoCJgICVwYBDAgBAYJ5gm0BAzAHq1yBM?=
 =?us-ascii?q?oEBgggBAQaETh8sIlKBXAmBESwBjACEKCcQgVVEgTyDAz6IGoJmlHuEJCYED?=
 =?us-ascii?q?gMZKx1BAgELQjQDFQMUAwUkBwMZDyMNDQQWBwwDAwUlAwICGwcCAgMCBhMFA?=
 =?us-ascii?q?gJNNggECAQrIw8FAgcvBQQvAh4EBQYRCAIWAgYEBAQEFQIQCAIIJhcHExgbG?=
 =?us-ascii?q?QEFMicQCSEcCgQaDQUGEwMgbwUKOg8oMWsrHRsKgQwqKBUDBAQDAgYTAwMiA?=
 =?us-ascii?q?hAqMRQEKRMSLQcrcwkCAyJnBQMDBCgsAwkhHwcoJjwHWDoBBAMDECI9BgMJA?=
 =?us-ascii?q?wIkE0h1AjcTFQUDDRkmCAUjFx0ECDwCBQZXEwIKEgMTmmGDfpJYj3OfDTQHg?=
 =?us-ascii?q?hiBRIFJDJ5NBhMug2QBkwIOBpIJLYcJE49BIKdJgXckgVszGiSDNk4DGQ+OI?=
 =?us-ascii?q?Bkeg26KLT80OwIGCwEBAwmFRwEBhR0BAQ?=
IronPort-PHdr: A9a23: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
 NTCxvubwNJq7N/eu8cRVZC8FQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:tgAkAai7xZFWe8ZGHk9QeRJ3I3BQXv4ji2hC6mlwRA09TyVXrb
 HLoB1p726WtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykesS+Q2mmF+rgbsbu6GeyT5Ns31B1WPHpXgkxbnn1E4j/wKDwKeOHMaKBSKK
 ah
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,341,1654552800"; 
   d="scan'208";a="54325184"
X-MGA-submission: =?us-ascii?q?MDHnUIJW5e8BA6ihFRYzknnIs7IHx8cKRw/m4P?=
 =?us-ascii?q?TyXqQzUDDyZCuJk1MmcRG6H4s4EvD9fUX1CROt7WpflJbKt3xLyHswqa?=
 =?us-ascii?q?rs/pXTvn3RxGCud/HUi3h1OtA9PeJyl31q93zwkA82wdkoq5kI9/zJp1?=
 =?us-ascii?q?iDEsNnDw0/aOxwxKKEPw+iJg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2022 10:36:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1664008603; bh=2RgBZfJu5KFzikoB9VzaaGxZdusTR8pLRMhYL8jFOB8=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=BVWeBicv2sNCaL+4OkQDUm3B7ai23LS1Zx9046wvWsh/651NjBNjYhEpkURGIFqHs
	 AN2AhTegPqFr0FEYzZyEp0w/crWyoKUehKexGdMU7i+vGqlx9bzljwbMjB3drzUFSJ
	 BkPq5aPBzAyWDP2I2/s84gKbS3yz6HXJ3/lffGMsis1Ahp1ZAdMWeVGTRl/dRUdZBW
	 i+/EM3D1P3eei04PxwWKPPbr/CmaQaGUp1j30nG0/i8BzGnPNjjILv/qspoT1oDTO9
	 RJbL8h9gMOc2C6puzFjqgmgp8KttaAFFdbq8LyzL6YUdIhxquL2jHblU4b8YeBTYd+
	 xUqqQmn0AIGxw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.160]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQ8ao-1oxxNb0S3c-00MNGJ; Sat, 24
 Sep 2022 10:36:43 +0200
Message-ID: <aa4d9a5d-aebb-d31c-d578-da03108db626@web.de>
Date: Sat, 24 Sep 2022 10:36:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-GB
To: Yuan Can <yuancan@huawei.com>, cocci@inria.fr
References: <20220922115535.44132-1-yuancan@huawei.com>
 <20220922115535.44132-2-yuancan@huawei.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20220922115535.44132-2-yuancan@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:iyC4uZejKzwW1BdT+7MEzvYUF4g+Aj6Am02jR2LbGq1PwXVDdF1
 yxnSDG8yEEwd7LZfFZtnDDtNckSrq8rAlnq9igA11C+SsTxfoCIqtLDXm57vfx1UTOEAuIb
 sbB4x4EEIK266fYk9KUvSARRYfpOc8KQhaJs8H0EG4Zeh+7Xs2EnNUDs53qmm8E/nZVrL9d
 P1RbS64zRvTQocCOskeFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5od43ZX/tyg=:8Fnc77JFaKtJmiIX6Pou1J
 5Q66rK95yWF6OVR2ZQxfyJJx6aq4g6cLN0yk07dNQy7djDWLyZ0vGDS9Tfc/PDoHpJmPkPHoh
 W4WD4amOR/m7lr43Dpn1NuN3PQ93eUn2cweMegkEitdCIRj9GBsFOb/UxDopDFh86epHuzTQd
 y8THPwSUlVqdMiCxc/vgobmZRaRXc9M7XRNWV25YDFJH2c5xvAnSjQsxhYTej3vS+UENJzDeV
 LilZmXI7V1VAOKqPQ7Pk4adHf3dv0t4eQdL6Sd3jslEX/MknIPJb8Nu2wGCzYdW1BOWvG3Jmf
 2s552cTNUpx/a+w+WYBXUs704X2xlFXxdn9YGVnH889nYSz6bux4sVslZntGSA2ublpokap3X
 guYmtpUxyyBKMUIHURKuq6GmWAm8FtbMd+j18RZeWXobMPEbHA/zWgkHHkgMRtOpT0IiE2ymN
 SkdSghRwtZwR5uP2+9onx9EKQ0/yyDvkbBtZLxyQEd5o/puZR5nBFViXx/qrrlsKYwjJFP1jW
 9WyKLh49dj674GrIzNCdrTOkbzQ9TZGuOHwTdydsISL8pu9M9jFxEDqTG4YsmcUi8XvgSJkvz
 UewFTCBRHyh6fL/3au9MRM7Hd5lM3IMLjjYkVWit00UpIpv5m7+35dDVrF08h0tJZ7BjBurYF
 xDqm1izsMPqK711p9vy2iqMhNtSTz9g5j0vGrTgYHd3qDkb/ZYZj2g7ynuqsLjEal77TPTBPF
 Re8SxZ65bCzpy3/vyjCGsMwtnt/cOn6J/JSITpXhNT7rOvuX4vcDcd9p/DAN8ZNfSZ2k0HVuu
 PgmK64mLHk5oLR4TQIpkzx8ajy0tcwfS6Pb03439l68ujgO2gg89zAQPtD4Dagh/CnR+w5BJ+
 pnMhwRvOcIpEPKEMMMkg9FkaDATN2HOW7BtLYIwdUlPIc8GA/vR7MaY4jr2Yl9yq/6/7gJgOf
 q5UbL9Li2sjVs7QQYUB2ZBMIoirYvmOkPfID94UtRCBrMejb1h0aotXq+GEZbFkDVzSJCJNym
 58orpPcQvHPDJF/naq6Zdo/iEFxpbO5WBdJYfDsjGocePIZGj7V34OftMIi018WqBxDKqP5ne
 FBTDMRFwtdc+vpMC1EPr8yEGIRiL3D2ZHdWQiQPMC82DzvNKGgJrBvbW5r8hcJjhqvAYyiaNX
 a6qmPYnJ6VPAJTHqjtejwL3tmS
Subject: Re: [cocci] [PATCH v3 1/2] coccinelle: locks: add
 missing_mutex_init.cocci script
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 581
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/aa4d9a5d-aebb-d31c-d578-da03108db626%40web.de>

> +@r5 depends on r4@
> +identifier r3.s;
> +struct s *mm;
> +position p;
> +@@
> +mm@p = \(kmalloc\|kzalloc\|devm_kmalloc\|devm_kzalloc\)(...)


Would you like to support another case distinction?

How do you think about to handle variable initialisations besides assignments
with a corresponding SmPL code variant?

Regards,
Markus

