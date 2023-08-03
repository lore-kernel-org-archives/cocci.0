Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DF5C001DF
	for <cocci@archiver.kernel.org>; Thu,  3 Aug 2023 09:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Th5KmTnvXyzMgOPWBRMX66gYdZiKfPPr2V/16MHp2cw=;
  b=aEB9bYfzEKlsW/lG42ktUbBGJaxZftFStZmjGBQHz9kfE13ecHoohF33
   vRKAqJAZe0eRgFdLKLaC1PwNKXzlR/7QyCRoRtzl8JjQfrtvk5JW77tEe
   aKQ/5gMWIed/XzBYH27qRdagmt/WP2Cz4h4ta1hOVzPuYFvZhTlm9zYdV
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.01,251,1684792800"; 
   d="scan'208";a="120050511"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Aug 2023 11:01:18 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0B56CE0145; Thu,  3 Aug 2023 11:01:18 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 522A9E0133
	for <cocci@sympa.inria.fr>; Thu,  3 Aug 2023 11:01:16 +0200 (CEST)
IronPort-SDR: 64cb6cdb_3kgE0+bTM3DP6QcE+Y8PJV9xDYwZS7C4zcmtXbuuUfJuVzK
 Fh1Uwxh2Ii//0R2bWUpRIvGkyRMzNMYxhQf3iwQ==
X-IPAS-Result: =?us-ascii?q?A0GTCQBSbMtkgAMP49RaHQEBAQEJARIBBQUBQIFPgjN4U?=
 =?us-ascii?q?zAEC0eEUpYWhzOHSYRphASDFj4PAQMBDUEBAgQBAQMEhH8ChkgCHQcBBDQTA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAhABASQXBw4OKYVoDYI3K?=
 =?us-ascii?q?QERZIEIAQEBAQEBAQEBAQEBAQEBAQEBFwJHPwMDIx0BAREmAQ8LGgImAgJXB?=
 =?us-ascii?q?gEUAQGCeoIoAQMxB64PgTKBAYIJAQEGr1QfLCJVgV8JgRUtiAEBhH9EhDUnD?=
 =?us-ascii?q?4FVRIE8DIJ4PoREg1uCZ4l1hUwHMoI1igMrgQgIXoFvPQINVAsLZYEXUjmBP?=
 =?us-ascii?q?QICEScTEwVFcx0DBwOBBRAvBwQyGwcGCRgYFyUGUQctJAkTFUAEgXiBVgqBB?=
 =?us-ascii?q?j8VDhGCTis2OBtLgmoJFQw0BEx4EC4EFBiBFARLJx8aHj0REgUUDQUIfx0CE?=
 =?us-ascii?q?Sc/AwUDBDkKFQ0LHQQOAxkrHUACAQtwPTUGAwsbBiUBHgInnluCQMgqNAeCM?=
 =?us-ascii?q?YFdgV0Mnx4GEy+DbpMnDgaSMi6HQJA6IKgggXojgVwzGiSDNk8DGQ+OIDeDc?=
 =?us-ascii?q?I9IPzU7AgcBCgEBAwmFRgEBhgABAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:lW6f/qBLVn+3d0blHel455DYdb4zR+YMi2TDGXoBLiC9Afbo9P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO0s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFpSWY+eRMbEVt7eZ3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3AZm2RXWmFRKTR2WIzFEV1uEFj8YzXOVbtz1yJBHO?=
 =?us-ascii?q?8Ml50ep2eYEWRxKNZrdU7zg=3D=3D?=
X-Talos-MUID: 9a23:F3BBswaAN3ztYeBTrBjApjR8GulS3eeJKwcso7I34sjcOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,251,1684792800"; 
   d="scan'208";a="62915036"
X-MGA-submission: =?us-ascii?q?MDFYRYzsEmzCx/0mkn/KZ+2cJ54VpNnQvT5+Ps?=
 =?us-ascii?q?S7jdmhcGCH3T4sdONNvSQwg7kPcYqfRjM1IRRbMlMK0bypCPMCyswJNJ?=
 =?us-ascii?q?ovNXT3uw4GChP8K3HHKKRNO54andzIT4BHgsayZ/4CkqBF2rKLPub/ok?=
 =?us-ascii?q?8dL2b3UpO7nxg77vVecQxfNQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 11:01:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1691053251; x=1691658051; i=markus.elfring@web.de;
 bh=K/xfaB15lDa6wcndr0Nm4D7aW27E1Ldq4tbpAkMa4rg=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
 b=r81udUrTTEPHd9IBuTTLGzfsUCJaTkhaEpsQ3FeWamq9x6U9sEMYgZEJmSxQJtJxwPCcv0Y
 L8uUXhA0oUc1hYljLWQ4sfHQ28A0Mdt2Rv7QKX/ueusUxP6mZurbLbRWOSsa/nOBom4R0tIzV
 76XWxDvVy889qACZALYtD67aRk1Ld7hEvLQhVnlTExPAUuwlAgbRPM6yPbHF3utdQoBIB2xl5
 tDzI1GT9P4vQxA8FPzUyJiZVzG3Lb/esJ9Sz0v3N63uUm+/pnMpdG4E306Jxt5wPi1mrXKBZ0
 h9/1gNhBLY6QSSbXZchbWcnhYyn8hW360xV0Ul4n2aXSAyPl613A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MWzD3-1qKWBH3oFd-00X2ac; Thu, 03
 Aug 2023 11:00:50 +0200
Message-ID: <44d5062c-f525-4994-a11c-57687c6597fe@web.de>
Date: Thu, 3 Aug 2023 11:00:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Li Zetao <lizetao1@huawei.com>, cocci@inria.fr,
 Julia Lawall <julia.lawall@inria.fr>
References: <20230801094337.4145806-1-lizetao1@huawei.com>
From: Markus Elfring <Markus.Elfring@web.de>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
In-Reply-To: <20230801094337.4145806-1-lizetao1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ECIDgzPZxuykWDHJOkbsAx+WtFRAYv8YUors7wpB2LAhVrHlcnc
 BJEO/sLZfpN4yZimSCl8/Rlm8Qw5K0R69uPYz7O2mAQVGlJr5Ak290KyKJCcJ0ZFZaLEvyT
 yJt8dSNIWRXp939EOIjI2CmdXC9foj1WJ8ugg7SlTvAbaf2UpSPO79fJqIz6gNZfxfTZecW
 bHXjn6lZDfjH88NFROU4A==
UI-OutboundReport: notjunk:1;M01:P0:wjh+wRc2k1U=;0btX3siZGdHPi0M0pps2HK7PvP6
 IKhApCRsNY+FbSohuyH4MZB9youpM4KX6+C+T3C6zRFzHw5yL05R0rxBkyIfHSogqw2BqSNTY
 VsUMWwV5LrYfnvnAoG7072xg62BDNxhqX9lrdTtu6yPFvy79E2hpzPBEgF5mh6wmNcUf+Cy30
 36Wtl6bdRx4bkTbPVoZNW2wEoO53G7xtfscL+pmAAzYQaIqgwLQUnTq3nnzN/IALW3EhXGnha
 VyVZR1moDuqRAsSSJDbkP3NIsJyvELbAobz8mqblI2mI+knMMvhomHpCpR4t305sdgll76nB7
 p02xYu8f+O11oTv6+aSybqizGJAdIsOhf4L1j0z4mkm6q24Bf2d4qhwt1iK6XWy3N1v94WbiY
 VLe/zuK2Cb+41yRwPSLm9NGDuK07gloIdSgcEJ3IW0/KCdbrax+JAnPWyjJJZPGBFCFuaTQ2u
 EOnqF5qVYggfpLClLjSRIpVWLUEA4KqKvukXW9/GjSAOHn8QoYf3P/rm4yyI7553J7qwxCg5K
 zLQpTcaBboE6j7kQzDOJoMAQDq20YC4NhztX9w6XcODeICrYlEIMbCUbPxy6xTJmWtewolpOM
 8y5ukaPK6AuIxo/mI4Rm3McP1paFlE6yOrbOB1FeGA5wbsSP8Zji/nARm2DjgawF72whxUj2c
 pDqwnUD0XEti3+5hCNMcCQbpyTncj/p86eW+8LmPqzhcj1WjHcUe/5ALGgcF0izciPIiWfJl+
 qEY9hqRD/LjoeAJvp95JiV5PPYVP+War3JG9QDaTNfdsWRa3SEggL97XgvX3hHk1W4PVFInQ1
 UXORwMDPuvjRKUwiAD1vPV0nEik8V/u2MyLaWhk6Vw9WtSYTXpoEU7kzKd0XMq5JZSW04VqaH
 QGXZwML/v/DIX/5VXT4OQMszUIA0oOO/2JKo5taIhfejM+88AoiTFhCSN1uT1iPwQvU+VGKfb
 kgSOaN5B2ZVV97BmLYqsXAkGEFs=
Subject: Re: [cocci] [PATCH -next] coccinelle: platform_get_irq: Add
 dev_err_probe() check
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1224
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-08/44d5062c-f525-4994-a11c-57687c6597fe%40web.de>

=E2=80=A6
> +++ b/scripts/coccinelle/api/platform_get_irq.cocci
=E2=80=A6
> @@ -60,6 +70,16 @@ if ( \( ret < 0 \| ret <=3D 0 \) )
=E2=80=A6
> +if ( \( ret < 0 \| ret <=3D 0 \) )
> +(
> +-dev_err_probe(...);
> ++return ret;
> +|
> +-return dev_err_probe(...);
> ++return ret;
> +)
> +)

How do you think about to use the following code variant for the adjusted =
SmPL
disjunctions in the patch operation mode (for a while)?

 if ( \( ret < 0 \| ret <=3D 0 \) )
(
-dev_err_probe(...)
+return ret
 ;
|
 return
-       dev_err_probe(...)
+       ret
 ;
)


Regards,
Markus
