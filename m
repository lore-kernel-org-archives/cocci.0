Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3433DC43334
	for <cocci@archiver.kernel.org>; Fri,  1 Jul 2022 16:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=7V7QiVhGGwVFOQzjw/n4rbbk7WHjDaawLY2Z99wzRQw=;
  b=aj+Gv/SYa6R15BF6sqabi/15aucOR731njj7B4OreXLOh9lw5bQk21cT
   WWdOr4Em7NvXk2Q9p4eS/2Dp4vjzaKzkseezPoURVVvOGkAp1gVWtA6lG
   YIe/naPgRaSeGnn1GkP9vUAY+q+wmWj5ix0YQ6G3iZCVGAz2Pzg7WSsEj
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.92,237,1650924000"; 
   d="scan'208";a="43882795"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Jul 2022 18:55:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7FD12E0359; Fri,  1 Jul 2022 18:55:23 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9B829E0092
	for <cocci@sympa.inria.fr>; Fri,  1 Jul 2022 18:55:16 +0200 (CEST)
IronPort-SDR: 5+glr9/3BcarISynGjcoN37tABhI2kVYqmNbQ3OamhmZjep3eDkzzddEchdJLIcSxiHd/+i17k
 B1L2FttBrCdFzXWFqo1WoWdjTsBFcUzAUT4beukq0skaDRvdsCfdLEnp+b3yK4qcEz7PfCGh1e
 bnzps90LaSV+X+5nhrpp1flpAtpQNG0EszPzirfjptHEdgwjDw8bBPQTeucWNQAbs1ovHn60qO
 An1T1FMm/xLqZuQEJWZq/4LrszAKjFxIQJ6Z9ECacrvi7fxv45R3gVe+t+2m/eFtvc8Fv+9N4s
 IjVhSMKhRcA4hOMdKjV8n9a2
X-IPAS-Result: =?us-ascii?q?A0ALAAAKJr9ihwMP49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE+AgEBAQELAYIjgQFWLgQLRIQRPZBfLgOEI5hkgWgLAQMBD?=
 =?us-ascii?q?TsEAQIEAQGFAAICAoVLAh0HAQQzBg4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBA?=
 =?us-ascii?q?QIBAQIEBAETAQEBDA0JBQgKBw4QBTYGXgZkBIFLBIF0CzQNgjUpAYNkAQICA?=
 =?us-ascii?q?QwXBBkBAREmAQQLCQIaAhEVAgJXBgEMBgIBAReCYgGCZAEDDSMHC5EDnBR/M?=
 =?us-ascii?q?oEBgggBAQaBPwGDCx8sIlKBXAMGgREsAYpdgyR6JxCBVUSBFScMgQmBPjA+g?=
 =?us-ascii?q?Q+BUwEBAoEXRz+DF4JljHWKfII3JgQPAxotLxKBH24BCAQDAwcKBTAGAgwYF?=
 =?us-ascii?q?AQCExJNBhwCEgUHCgYVDhQcEhIXDA8DEgMRAQcCCRIIFSsIAwIDCAMCAyALA?=
 =?us-ascii?q?gMWCQcKAx0IChwSEBQCBBEeCwgDGR4sCQIEDgNACAsKAxEEAxMYCRYIEAQGA?=
 =?us-ascii?q?wgvDScLAwUPDQEGAwYCBQUBAyADFAMFJAcDIQ8mDQ0EGwcdAwMFJQMCAhsHA?=
 =?us-ascii?q?gIDAgYVBgICGFYuDQgECAQYHyQPBQIHLwUELwIeBAUGEQgCFgIGBAUCBAQWA?=
 =?us-ascii?q?hAIAggnFwcTGBsZAQUyJxAJIRYGCh8KBgUGFQMhRyYFCjsPKDQ2PCwfGwqBG?=
 =?us-ascii?q?iwJIhYDBAQDAgYaAwMiAhApBjIDFQYtFRMGIgEbAps9awaBDyyCBA+hHaAfN?=
 =?us-ascii?q?AeCFIE9gUQMiVGUYAYTLZZWDgaRepZzII0SmhGBd4F/MxokgzdOAQIBAg0BA?=
 =?us-ascii?q?gIDAQIBAgkBAQKOHRkegzszgQuJIj80AgkwAgYBCgEBAwmFRwEBiTwBAQ?=
IronPort-PHdr: A9a23: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
 /Pn6az1J8IfO9+is3E=
IronPort-Data: A9a23:/pXZsa7ZWMeWIWdPvHCYvwxRtBTBchMFZxGqfqrLsTDasY5as4F+v
 mcbUTqCafnfYjSkft5xPdy180JX68fSyd9qSgtoqSszZn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOK6UoYoAwgpLeNeYH5JZSlLxqho2OaEvfDjW1nX4
 Yyq+pWFULOY82cc3lw8u/rrRCxH56yaVAMw5jTSstgW1LN2vyB94KM3fcldHVOgKmVnNrLSq
 9L48V2M1jixEyHBpT+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRYRQR8/ttmHozx+4
 NNBtrWyaEBwAoKWvNQ6eElgLRlPDaITrdcrIVDn2SCS50jBbmeq3PhkSk07VWEa0rwuWycUr
 6NecW1LNXhvhMruqF6/YsxlnMc+N4/GOI0Fu3dv5S7UB7AqTPgvRo2Wvo8Ihmhg16iiG97ia
 ZBCWx5LZi3PIAxzJ0lNA7IQoO230yyXnzpw8Q/J+/NuvQA/1jdZ27/mO9v9Yc2PXcwTn0CCp
 2uA8X6RKhUTK9WbzRKX83emnOaJnCXhWYtUGqfQyxJxqFiU23BVFxAcE1e2yRWktqKgc9RTK
 GUW2213kYdo0HyMZYnFYSWJkHHR63bwROFsO+E97QiMzI/d7ACYGnUIQ1Z9hDoO65ZeqdsCi
 Qbhoj/5OdB8mOHEESrGrd94uRviZXJKcQfucAdZFVNt3jX1nG0kpj7iJjqJOI28lNnuAyzwz
 lhmRwBh2exI0qbnO42R9FzKhXeTDUzTUhI44w/aRG3N0++UTIuiepDu9lXRq/pNRGp4crVjl
 Chb8yR9xLlfZX1oqMBraLtVdF1Oz6jcWAAweXY1Q/EcG82FohZPh7x47jBkP1tOOc0ZYzLva
 0K7kVoPucENZSD6NvUoONnZ5yEWIU7ISoSNuhf8MYomX3SNXFPelM2TTRPMjj62yiDAb4llY
 MrEKa5A8kr2+Yw+kWboHr5DuVPa7nlwnCvSQ4z21RKqzfKXaxaopUQtYDOzghQCxPrc+m39q
 o4BX+PTkkk3eLCgPkH/rNBCRXhXfCBTLc2n8KR/K7/TSiI4Qj1JI6GKm9sJJdc695m5Y8+To
 xlRrGcDlAGg7ZAGQC3WAk1ehETHB8kg9yhgYnJ1bT5FGRELOO6S0UvWTLNvFZFPyQCp5acco
 yAtd5rSD/JRZC7A/jhBP5DxoJY8Jgumj0SCMnP9MjQ4epdhQS3P+8PlJ1e+qnNRU3Dv7cZu8
 ae90g77QIYYQ1owBsjhaMWpkwG7s08blb8gREDPONRSJB7h/dEyeSz8h/M6Oe8WLhDHymfI3
 gqaG0lKuuTH5YM4qYGbiaeBpoavMu1/AksDQziFt+nrb3GC8zP6k4FaUeuOcTTMb0/O+f2vN
 bdP0vXxEPwbh1IU4YByJLZcy/5s7dXYobIHnB9vG2/GbgjwB75tfiuG0M1IuvEfz7NVo1LvC
 EeI58UcJriDfs/oSQZDKA0gZ+WF9PcVhjiLsaVrehqnvncv8erVS1hWMjmNlDdZcul/PrQl9
 uF96sQY3Aqy10gxOdGcgyEIrGmBci4aX6M8us1ICYPnkFNymFRFfICaFSL8pp2CMo0ePk4vK
 z6SpazDm7UFmhucKSVuTyCV0LoPn4kKtTBL0EQGeQaDlO3FsflrjhdfxjI6E1ZOxRJd3uMvY
 WVmOiWZ/0lVE+uEWSSCY4ytJ+2FLBie51C31FYD0mHUJ6VtuqohM0VlUdthPmhAm46fQtSf1
 K6VwiDpXF4GuenvizAqVxcNR+PLFLRMG86rpCxjN9uIFd82bFIJR0NoiXUg83PaPC/6uKELS
 SSGMgq9hW0X+BP8e5EGNrQ=
IronPort-HdrOrdr: A9a23:63Wb4qO/8lGkDsBcTuWjsMiBIKoaSvp037Dk7TEVdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YFT0EUMr3N5DZB/KTHCUWDcurJ27O8gduVbArlvg1QpTgBUdAc0+/zZzzwLnFL
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,237,1650924000"; 
   d="scan'208";a="43882789"
X-MGA-submission: =?us-ascii?q?MDHvd5sVkeru2egKF5xvkePckA9EPPfMzoKa3V?=
 =?us-ascii?q?cb+s9vjhLhCtSiRTcvLzLdVEyIsy5Jiti2TDjb9z4rixbrF0ZL4n5j6u?=
 =?us-ascii?q?wRyzO0/ozRQjIZPSoGGHW6NhdclYI8wkv9SaDXcSSJdQnNRr/bBhmZ+G?=
 =?us-ascii?q?pDBwQnaUDGpkGXiAtbshR5DA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 18:55:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1656694514;
	bh=zAzpQL54NV/WXPfg2yhxYon1uKNEwUFIcCW05cII6Ho=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bgMPwL2Qk0/l+YRNqfqR9QhGPtOVVWMDcYpf61KU0wWIl/6EQOIghOKmB6VnHJ26C
	 XioepW7St9kYJT87oJYB2O+LrqUMHv+WsMy9DrXVuW/wMpXYkXkMo1TKwGWlKuohiM
	 0jjBavqZmPyT0jGEHgv8gRLAEx4MYt3tlGjf5WMs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([93.132.48.14]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MI3ox-1nsAp43KCN-00FNPd; Fri, 01
 Jul 2022 18:55:13 +0200
Message-ID: <67633a8f-9972-f1d8-edc9-3b58c9435913@web.de>
Date: Fri, 1 Jul 2022 18:55:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-GB
To: =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@netatmo.com>,
 cocci@inria.fr, kernel-janitors@vger.kernel.org
Cc: Julia Lawall <julia.lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>
References: <AS8PR03MB7603EE9F885BA2573CD56CF993BD9@AS8PR03MB7603.eurprd03.prod.outlook.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <AS8PR03MB7603EE9F885BA2573CD56CF993BD9@AS8PR03MB7603.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7KIA1M+Z7ikRxi70f7hTLXaxD/aqYGhtcLlPMDNlKK20XrXDaIJ
 RL86k9NauFbow031kSqKwxMFc+5bou8GtQ892nvNwn3NlLlJo9Y1vQgFscALsv6zmDUni2P
 RPNT9cB8vBRoefw3bFMLwI6g6UnvommJzmf/oZjcgpYWNIsW/vmPJvvAybMpg/m41zA2cUN
 PHOgpxZ/0hVxZHDKxfNzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sZ17cgqJ7IM=:JXwQ1JWWZupiKCYKcwmCv3
 sp85lkWDd24/Xqi7QPQ2bPegbsmv5+wQ1CgvG++xEE7aLifGCkg6oKjyNnS1aG6upBoVli4qa
 JMCrlww/wnmojgsNgpCQ+i714ySqSHXd56E9eNj5cxvkt3FPJppc0xNsGxX6JUAzrx1cjC9bf
 kCq3WgJIVcO9IYS1qy+skT9kWLU6XTjG7E53PTJCl6sgnU1F3PbUW7mx12LmQ4Q+PqfKDrpf4
 8Nkvv3X/xNt85so/miYj5Cv3Sca28/XHTRkwBYiSDxyGzyyR1pZ6DrEoEWdep9RadS9tSWw47
 noLpas/ZiVdfsjldAzQfKzcSnMeP71iUhbNm/PL+sf3JY/+ZPR8gp02PzG29nyOH4PYqmv5FN
 03FoxdzH3NXKAtwwsEvCgvIZOrbdvFFtDpRsmjcqnFT04qm10VI0huFMths7lESNHPGSqBIYu
 Q1rA/zyq5BkaTtqh5li/7JAHdaKEigGKXaoMYAxWncFpAy5OnCpXtDOcpRMf1Pxu/Q+VZ87Q4
 ifm/Yd9FealHI4gKcuM/CSi1HN89oMk/1YZLhLKg9WgxKYY6uRpggw3P45C/kop0IaqhcqTtR
 YrG6QlNkH9wW9y1dg72yJpQt5IB1DzYzP3/kUlj31MkHp09zq4/VAbtMXfI+3Aqu6lURIuGh1
 ISrtcnkt5P4RtKOjJFzpWsewrlnu+3h1ygMuYmsiecrp8xvrf7U7qG2A4JQ5WfyYi0Jw+b6ic
 ynulTZL5mv2GHGz3Gzma5XktxeB6LVeGEKuHdmGXqh6gJLm0ErNnX/ZcAtmMfPB9yTz78T7Yr
 PCl/kmpDhHwpVCK7D+0Wzc8ui1nkoPGtWzVvEB8f5pDPYnAvYQdCLDcZLwrH68mTdxLWxwMip
 HQ227fZlrn3+KTuTTQYYNPt97X2ZkD9tTpYq9EbhBrwWFcbwonY9rLT7wPmiy/MpqQKCkzIne
 mZE/5O+YNxgYclhwDLCMvu2FNS2HzTDagzsimN13RrzVqt5vrOjspNmpJcA2x1WkjXOZMaASV
 hQDuXaJ6kygdX4O/CCVvInbkCjsI3VmOuiQejo0YlJ1sKfnbYlupU0mCU0k0TjQXXnkBYXNL0
 TBjvidy9HH2iBpOL6/C60m/x5dKZv0HfutnJ1Vl6b5NvS3EAWo4XoA62w==
Subject: Re: [cocci] [PATCH v5] coccinelle: Extend address test from ifaddr
 semantic patch to test expressions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 472
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/67633a8f-9972-f1d8-edc9-3b58c9435913%40web.de>

> This change aims at detecting an address test in more complex conditions
> and not only in if statements.
>
> Signed-off-by: J=C3=A9r=C3=A9my Lefaure <jeremy.lefaure@netatmo.com>
> ---
> v4 -> v5: Change semantic patch to match explicit tests to NULL +
> improve commit message
> v3 -> v4: Improve patch subject
> v2 -> v3: Apply Julia's suggestion to have a more generic solution + ada=
pt
> commit message and file name to this new solution.
> v1 -> v2: Moved disjunction on the condition itself instead of being on =
the
> if statements.
>
>  scripts/coccinelle/misc/{ifaddr.cocci =3D> test_addr.cocci} | 4 +---
=E2=80=A6
> @@ -14,12 +14,10 @@ virtual context
>
>  @r@
>  expression x;
> -statement S1,S2;
>  position p;
>  @@
>
> -*if@p (&x)
> - S1 else S2
> +*\(&x@p =3D=3D NULL \| &x@p !=3D NULL\)

=E2=80=A6


Further code review concerns:
A)
I interpret such SmPL code as an undesirable contradiction.

Changes are generally context-dependent.
Thus context data are accordingly required also for the usage of structure=
 isomorphisms.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/02d51a763c8bcce054e06=
5062e43b9b196840159/standard.iso#L421
https://github.com/coccinelle/coccinelle/blob/19ee1697bf152d37a78a20cefe14=
8775bf4b0e0d/standard.iso#L421

I would prefer to extend the SmPL search pattern
so that more case distinctions will be taken better into account.


B) Reminder:
I find the sharing of SmPL asterisk functionality questionable here
for subsequent SmPL rules.


C)
The discussed SmPL script supports only the operation modes =E2=80=9Corg=
=E2=80=9D and =E2=80=9Creport=E2=80=9D so far.
Thus I find the term =E2=80=9Csemantic match=E2=80=9D more appropriate ins=
tead of =E2=80=9Csemantic patch=E2=80=9D
in the message subject.

Regards,
Markus

