Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1773AC77B76
	for <cocci@archiver.kernel.org>; Thu, 20 Apr 2023 10:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Isf7/B9FdQ7KmHVg2eLTENeIsQjfqUYiGFIJikHu8TQ=;
  b=ivePpMQdG7gV6+AWvJVvgrgX9Ct5l7lH+y40r/l8/6iP0qZVknHueYVd
   3ph48VBTk8FwZagci479pNzs+MywWjefODqQOabxf7vqu/+xbWU+V9qGU
   czli0QjgNXgx0V1dZJy5foTmDXhsIFu2pEPg+89il3nCUhGW5R24nN58G
   g=;
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
X-IronPort-AV: E=Sophos;i="5.99,212,1677538800"; 
   d="scan'208";a="103964738"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Apr 2023 12:54:33 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C2F34E0269; Thu, 20 Apr 2023 12:54:32 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D7C6CE019E
	for <cocci@sympa.inria.fr>; Thu, 20 Apr 2023 12:54:31 +0200 (CEST)
IronPort-SDR: 644119e8_/NTCH3y4fAQobksr1HXzii++af6ZY3QHLAJd+sfWUg6d769
 Usk2dbtO/yJE3cjUUsqds0etVp7BCDFN/fxYiRg==
X-IPAS-Result: =?us-ascii?q?A0EDAABJGEFkhw4P49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE7BQEBAQELAYItgUsvBAtGhFOIHYkZhDCHLoc+hGeEA4FWF?=
 =?us-ascii?q?IEsPg8BAwENQQECBAEBAwQ4hEcChT0CHQcBBDAJDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEDAQEFAQEBAgEBAgQFAQIQAQEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBEgJHPgMDIx0BAREmAQ8fBgIRFQICVwYBDAgBA?=
 =?us-ascii?q?YJ6gigBAzEHqxqBMoEBgggBAQaCZJkoHywiVIFeCYEULQGNFIQwJw+BVUSBP?=
 =?us-ascii?q?AyDNoN9gQaDHIJnmwaBNHaBIA6BPIEEAgkCEWuBEAhqgXlAAg1kCw5xgUljT?=
 =?us-ascii?q?IF7BAIURA4YBiglBA4DGSsdQAIBCzs6PTUGAwsfBlZrAgkjERMFAwsVKkcEC?=
 =?us-ascii?q?DgGGzQRAggPEg8sRAxCNzMTBlwBKQsOEQNOgUcEgQt8CgYBJiSfSoEOlV+wV?=
 =?us-ascii?q?TQHgiuBVoFZDJ8NBhMvg2oBEpMMDgaSJS6HMpAXIIIupVGBYzqBXDMaJIM2T?=
 =?us-ascii?q?wMZD44gGYQMj0g/ND0CBwEKAQEDCYVGAQGFfQEB?=
IronPort-PHdr: A9a23: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
 iM=
IronPort-Data: A9a23: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
 vlGkkDN0tONLl2FiArdCjFXQQuq+x8C+k81xA==
IronPort-HdrOrdr: A9a23:syO0+aPb7TzBK8BcThWjsMiBIKoaSvp037Dk7TEXdfUnSL39qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFgrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YET0EUMr3N5DZB/KTHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AzGasgmtiUE0vUjM3+RatC9yv6IsDaVjzzFjyOnW?=
 =?us-ascii?q?bKj92TZuTSByaw6BNxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AsOhp7gzEViIjHiUn8/L3oVjuVP2aqIuIMHlQqI1?=
 =?us-ascii?q?bgeC/JRN9Jh2xpXO3S6Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,212,1677538800"; 
   d="scan'208";a="103964723"
X-MGA-submission: =?us-ascii?q?MDFK5idfIqU2ziNdtSwHT/+4nQYCRrR34RJNR2?=
 =?us-ascii?q?orgsLmEFBjY5yQsIcRvO+8+a4iFqf1uE8mqmF527VZMr+U9pFBh4Ebse?=
 =?us-ascii?q?JcEHorJYlb17C9pNEGowK54v3iys430llveA9DZii9KwIHl6ClLZM9da?=
 =?us-ascii?q?Xb1GlKchVxejXR4Qh1nt27Kw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 12:54:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681988069; i=markus.elfring@web.de;
	bh=5Hd0u5JOugHNMhUh8SCnU+ikBmTrD5in2V/ZBCXNYm4=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=kLeYlNIxfBwU8DyHbUoEKDvCBFgZPk0V4JC9O8e+7m7Nw7bfHyamFWxablhHNIlG8
	 z8Dm7LXgiMyEd9HIZ1th5qZk9h2VINd4MuZVqz+24gHgs4kdYp+OV0UNalOenznpTM
	 r9BHDw22Gu+kCU0/5SAyFW0Z8TpgmYy7WUyKr4lpjW96EaXtEoufr10QZq7dLD3m9N
	 woflFsMAUaUoUCYKuZOO4SaEJ11GcJpkvIvupin2bL3Oo7pt6hUZgwOCm+nb85Gch5
	 NNO9DR3VvDE8+xUpZbrXXOTIssWieqMJOiL9tseg3y15n5nXHVd9M+VJez9jA+W1bs
	 OQP0/kkus8WpA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MT7aV-1pkKAk0iqd-00UaU9; Thu, 20
 Apr 2023 12:54:29 +0200
Message-ID: <93913f0c-4699-cf9a-0f10-8edd478fd2b3@web.de>
Date: Thu, 20 Apr 2023 12:54:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-staging@lists.linux.dev,
 Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Larry Finger <Larry.Finger@lwfinger.net>, Nam Cao <namcaov@gmail.com>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Content-Language: en-GB
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m0x13uBkifOdccciCosExyWr/uBZXNH8rt7g/Wu4MO1yifXH0Fz
 1enfkvRlYt2jXnVwkUrXaRym6InblfePcSybRazqk8mhlHbu2vSVToPqM1IZLheWmC5RbiW
 Ak0UlEbuaLxyor+u3PiUOKZwj0G8PEylvXL8Pa0sj7pzx8Nb0IOxOk53BkiBY2L92VGGpyt
 2CALgLeTvUOunOO0sItIA==
UI-OutboundReport: notjunk:1;M01:P0:+jsE5C7a9oc=;oKiJu5EXKhvMxJDWVjXRlYD1mq/
 30gksJr/qibHbUijVGadV9uIHnmEOuhAL9T3WUi26i7J3SPbnZQoao6hE1gnB1Pz8kjDGpW1Y
 KyTg7Qf40R/dzWsX5KC9u202Svexmhy/pvxo7pUfpbZ2KksgYQ9EQbc+D7SZIt6qk/EItVIwE
 9Ps4WIokrNhB7+XeC5zlKo6vflkjslVZEPysIGUxCC0y1anacP3F4898BlzCpmv7uaGnEmkqv
 B96kZeYxBal2iQub7GpHEKCdey56lDA4NhExK0WPPHIgMgF7K+WI0yzd9w877Jr7HdG7NVTCT
 hLx5nUVIccaHYPqxKKyMPnwcroG4yqkDiA43C3UMngKqH+uEUsQJjPRa8c6Zyev3OKmC7mvzb
 hWKD93mI0QjZXwC6viS1HGDf1Hq5WkOs8tCoKnrzmySSPmbKcOFN6+zEQXBC4Vssgz2kvxW/G
 mKLty/k/JCZ0y+96qFKzR24e5qeFEqpMJnaFFCu3FPIEFSf3C0FG/0CFTjWH7oFwzBssk/Ubh
 qUa91CIzOAMA7pxS4892hM9esCrCgQQFNVG7VRkgdIrU4YEgNivSHD/Y2o7yAivQpaBsK8Vlp
 BqQ/VymCTOfR6f50AQQfbgwIpwGZldoJcNHYHgVOB2Lug1dMpLfLPAwzu0thtv+4pcSDD4XVC
 OEF2zkWFJjEsJ13fBk8UrgA23Hs6QaR7yQ2ys+mDuVO8CE6l6l87adWNLddWTw5I2qsuKZxfj
 ITKmU4t5I767PmFdF4G/7J+g5SiNxtGMGhRZ9jjlfg4wsI2cY/tgADK9Y05d0xNDYAhv5XdRb
 5jl3QaoVB75RB/W+I8/0UbKLvUJQQYvMoz03zNhJbeMF/Xag6Jr7+H+K6g5H7D1eDfe2+5zRS
 96X4b/yqX0Cz06UVea4RmPQNc3W/TAUxUlzkNTI2jhshDDfrJBjX4yA1Z
Subject: [cocci] [PATCH 0/4] staging: rtl8712: Adjustments for
 process_link_qual()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1099
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/93913f0c-4699-cf9a-0f10-8edd478fd2b3%40web.de>

Date: Thu, 20 Apr 2023 12:05:12 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Delete null pointer checks
  Delete two variables
  Reduce scope for the variable =E2=80=9Csqd=E2=80=9D
  Simplify the usage of an expression

 drivers/staging/rtl8712/rtl8712_recv.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

=2D-
2.40.0

