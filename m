Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3774AC04A95
	for <cocci@archiver.kernel.org>; Sun, 25 Sep 2022 20:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=rhmRuvz+T92QDDY17gfgIemrZKGf8vDGCVUiTqnJyoo=;
  b=nZIwS12LfVyBbwqgLVHShjbK3tLvSHkBVwnjFXXV7xRkppVt1pK3Nvg+
   lhNdljVzxul0y4BDmFRQ//NIGdRyNKNAZiYwlTbsV771o8+eShVllsLyV
   lSfH6Wo5aUg2aiC3S8J1NdHFcNFIwgf/4g1O0cBjNl1PWcWOil9iFWnxN
   4=;
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
X-IronPort-AV: E=Sophos;i="5.93,344,1654552800"; 
   d="scan'208";a="54408672"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Sep 2022 22:33:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 10D55E0130; Sun, 25 Sep 2022 22:33:39 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B5FC2E0090
	for <cocci@sympa.inria.fr>; Sun, 25 Sep 2022 22:33:37 +0200 (CEST)
IronPort-SDR: 6330bb1e_wDAU3QY7PfMT+qFNvjY5VPeC+Jby+jQa5P6fK/h7kbnAXEw
 b3pOmt3RplAchvBUsOUA2lF6/wt4lpqRnvfGeqA==
X-IPAS-Result: =?us-ascii?q?A0CHAAC0ujBjhw4P49RaHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YIjgQFWLgQLRYROkGYuhCmOPYRahVWBfAsBAwENNwgBAgQBAYRARQKEbAIdB?=
 =?us-ascii?q?wEEMgcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBARkJFwcOB?=
 =?us-ascii?q?QsFIoVoDYI1KQGDZAMDIx0BAREmAQ8LGgImAgJXBgEMCAEBgnkBgmwBAzAHD?=
 =?us-ascii?q?KlngTKBAYIIAQEGgUABgw0fLCJSgVwDBoERLAGMAIJFgWMnEIFVRIE8gwM+g?=
 =?us-ascii?q?mICgWCDVoJmlQGEJCYEDgMZKx1BAgELQjUDFQMUAwUkBwMZDyMNDQQWBwwDA?=
 =?us-ascii?q?wUlAwICGwcCAgMCBhMFAgJNNggECAQrJA8FAgcvBQQvAh4EBQYRCAIWAgYEB?=
 =?us-ascii?q?AQEFQIQCAIIJhcHExgbGQEFMicQCSEcCgQaDQUGEwMgbwUKOg8oMWsrHRsKg?=
 =?us-ascii?q?QwqKBUDBAQDAgYTAwMiAhAqMRQEKRMSLQcrcwkCAyJnBQMDBCgsAwkhHwcoJ?=
 =?us-ascii?q?jwHWDoBBAMCECI9BgMJAwIkE0h2AjcTFQUDDRkmCAUjFx4ECDwCBQZXEwIKE?=
 =?us-ascii?q?gMTmF2DTCKBfRIMwVk0B4IYgUSBSQyJZpRnBhMulmcOBpIJLYcKE49BII0cl?=
 =?us-ascii?q?RCFHYFoCimBWzMaJIM2TgMZD44gGR6DOzOKLT80OwIGAQoBAQMJhUcBAYR8A?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 5cEDLNWBgVdKw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:QqL9E6wFTVSiEeqN1oGSKrPwCL1zdoMgy1knxilNoNJuA6ulfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bHYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebjN5DNB7foSjjPIcerIjOPnzEiy792utEuFoDsaEZ2J1m1Ce3um+sYafmN7OaY=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,344,1654552800"; 
   d="scan'208";a="24629639"
X-MGA-submission: =?us-ascii?q?MDG3sDwxTiZJgmquppEwG+b4D4cC2y/qbYTKV1?=
 =?us-ascii?q?Swzhre7MMq6+QDB1upujAuoOCSIFLJjezDmQHCsNLbZMI7ADaAEWXoP5?=
 =?us-ascii?q?oGOhmELQs4nbVdBcaGaHS9nm/O+SSUJchx3Y1U5bNLjHrRYeUhhDbQKb?=
 =?us-ascii?q?JtfvEp/lxxfohJgLzMKHfxyg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2022 22:33:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1664138000; bh=rhmRuvz+T92QDDY17gfgIemrZKGf8vDGCVUiTqnJyoo=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
	b=CVvqO1lnZFZPD5TUYwkEPBuSjZplp5zxMYBrd36G3rfNU0ECIykJUlVt/j7an5bkw
	 8rXV4y3Quheq6QGDOxeXoRQ2oN8eWYjmuU/RQ0V/ZLw1xidkiEUUlN32IsUyc0a9BO
	 V71f7Nh19BbYQ4jNBO4Ez+LoKkKPQnsZHY1TQHveTRyeJNPKXns92IzPS+EDMrZAvi
	 xCYE6I/317CwlvvPggspzS7l1Iu1oaRXsdqJSE1c29loaKCYs0RIMjioL1PeIPquTz
	 P0+n0HKyUaoaNPAzh4noBraHiJtleHq2+B48OXQI0YqDxRqRtMv/UK+zz6bhbOmNhj
	 CuRFiv7QKo0KA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.160]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MpCmZ-1p2ToV2nT5-00qPIZ; Sun, 25
 Sep 2022 22:33:20 +0200
Message-ID: <af5490bc-fd9a-e9b6-f712-e37f4cdc4e9a@web.de>
Date: Sun, 25 Sep 2022 22:33:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-GB
To: Yuan Can <yuancan@huawei.com>, cocci@inria.fr
References: <20220922115535.44132-1-yuancan@huawei.com>
 <20220922115535.44132-2-yuancan@huawei.com>
From: Markus Elfring <Markus.Elfring@web.de>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org
In-Reply-To: <20220922115535.44132-2-yuancan@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/PHTc98M4GqeDs+QdGLDRByqWRtiqnqcNQhsuqcdJjnwElVxCmY
 Bqo6TutzfSLv2KNvPskMdUB2p4ZRPUsWcE8TF9PRR+Nn7ekrDI7PXYkIF4DGWrpBRDkHEaD
 WROQyIO/ClzAKSRl2Snn15p4XIXIfo7poYMKtoyKGlvgE5L+3+z4vK5xQROfLp/d/lAsmTO
 q0qotsJs66RGOei+quLjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DSRd4xPAMgQ=:Qw1a79SgY/EE9Cey715yR4
 AmIGIKtV2/67KLVvkaXjQ/XwLhzA46oEiIu5jXbAM67NUYbgV3vDJEN+hlPI033SAYuXfs1vR
 pyJo2kmhBLdpkOAFkOZ/XsXU+cHuKo6DlnQNaHixXgkoyCqqjEyZPdZSqusqTUH99QkY6v6GD
 tCIy2G9GtXla1QCSaaC4uMoaL1oitj2vt6Fhk0KLzWE8a+SH/J2O0zt6DZT1row8Q3uECJdMr
 ahPRBWZOMlG7XfD3x1z3WD6nlt1iL0c8ZCTIT+AhzzqhTtAl5Lp2mt1HNLYV1EpMFlFboplDY
 cKf7RLjZ58i0zPltt9yjMC/Cfj1oprGahEPL4u8AUy51B7axdJD3bz9GInZaVFrbQqnZZV+JY
 dsW6gxI9ZP6wbGys3QvcjDa4LEn9eB2/AfDjbF2MqwcHO04CPR5nGrBVyifPwFMxWgvAVhqLa
 wCXBBICTmNKQSF8tWNtBf35V83W1zv8MAvR2rONBTOcBbCbeKnV6jJm3lNCNRSS9uGFqW7Zvl
 0/VvnukIomBauRCwYpgwW11mPtwF/zocjbfzu3zraaa+/BJAbU8ZKdrwLVYm70LomLgspE/7D
 bbqH3f6Lyd/P4fBKec/8zuA1XH25d3ahwMUToYPZ5F7mgvfAsMM9M+xY1lMYT9dQ+81R5LP9C
 v0QETX8+cC7jB8nOd2O+SeiPdMQvMhzon4tFjcssIKOdy5Oise5EtMXOapiqnqcppNkcAHu+T
 crqN9gZKAT4Ksbo78ytLyCjA/lF3YKYkT7GzEDDTWo9OErv0t3CiN/q7O+Oy1hFhOEzwtPN2V
 MnviK1JlsjCOUfNNWgXHPs8RIp2zm8TgZmOdF9l4FNl95rPHYOKdndSSxonOaWP3eN+ZbwwqL
 JSdnCEDJN9r40CEvnDELiY3TucHVzC2lw13JX8Akp13z9b7KAFpO7WIoevum0ZBFm8QvzmtfM
 tp8NDYkpJ5JFuCV8uqdScGx7KZEjX0fXvhFShyLm5GesH9DOGeqspDql+8/0WRmJlsTq5mHWy
 Tmx7AIhdD0t6VKeqI7cRgpqWh61d7TNvUjGvu8d+3XkIdrCKe+pAKSfKdIr/Pm7WhwEhyqK1W
 NFBfgLj29pmgh0Fvk61e8QuSQubLcEaqQggAPIYQ2I3mQaS1aUB9nJVI18JWa9Qfa4S2gKBmq
 5jQozkM2R+b7YPa65qwkE/nDrh
Subject: Re: [cocci] [PATCH v3 1/2] coccinelle: locks: add
 missing_mutex_init.cocci script
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 585
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/af5490bc-fd9a-e9b6-f712-e37f4cdc4e9a%40web.de>

=E2=80=A6
> +++ b/scripts/coccinelle/locks/missing_mutex_init.cocci

=E2=80=A6

> +@r1@
=E2=80=A6
> +@r2@
=E2=80=A6
> +@r3@
=E2=80=A6
> +@r4@
=E2=80=A6
> +@r5 depends on r4@
=E2=80=A6
> +@script:python depends on org@
=E2=80=A6
> +cocci.print_main(msg, p)
> +
> +@script:python depends on report@
=E2=80=A6
> +coccilib.report.print_report(p[0], msg)


I would like to point the need out for specifying dependencies also for mo=
re
SmPL rules according to supported operation modes before final messages
will be displayed (by the means of the selected scripting languages).

Would you like to achieve any improvements also for a feature request
like the following?

2019-04-07
Support for SmPL rule groups
https://github.com/coccinelle/coccinelle/issues/164

Regards,
Markus

