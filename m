Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A19BC77B6F
	for <cocci@archiver.kernel.org>; Fri, 14 Apr 2023 09:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=44LqQWQ9Wf+drCaZr6ILzD7eD9xbp90qKn73INAXXX4=;
  b=P9ufqDqWzOIQ/yETFBXMZcbxGFqVNsWjTjBqoFij0UCHKc1aVgm8ZoAL
   PIcz+7l4oRovrLAQ8RyAvvXgopqI3Av1VTSnnlCgaQnYA5/RvneW0/i2j
   dattRPIXKRwBJd3iylKqBaXL4opWUzuitsW3iVyWVsSNU4XLcrkiOvp5n
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
X-IronPort-AV: E=Sophos;i="5.99,195,1677538800"; 
   d="scan'208";a="103065745"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Apr 2023 11:16:50 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 29F97E0C55; Fri, 14 Apr 2023 11:16:51 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 593B3E0171
	for <cocci@sympa.inria.fr>; Fri, 14 Apr 2023 11:16:48 +0200 (CEST)
IronPort-SDR: 643919ff_BXot9P386SVNjHbAXMmtZX2mtHcm0I57R49Mdx9vw0jpkvX
 BlxqS/C/zP4SLzU9p9rCQaHYXLx63mkIaWYV2GA==
X-IPAS-Result: =?us-ascii?q?A0EcAAD6GDlkhwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIHokSA4Qwhy6MJYQDgVaBQD4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEOIFTgnQChT0CHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBA?=
 =?us-ascii?q?gQFAQIQAQEBGgkXBw4QBSKFaA0Igi8pARFkgQgBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBARICRz4DAyMEGQEBESYBDx8GAh8HAgJXBgEMBgIBAYJ6gigBAzEHr?=
 =?us-ascii?q?xB/M4EBgggBAQacCx8sIlSBXgmBFC0BjQmEMCcPgVVEgTwMgkdviB+CZ5Fzi?=
 =?us-ascii?q?F8KgTR0gSAOgTyBBAIJAhFrgRAIaYF5QAINYwsOb4FJY0yBewQCFEcOFCUED?=
 =?us-ascii?q?gMZKx1AAgELOzo/NQYDCx8GVmsCCSMREwUDCxUqRwQIOAYcNBECCA8SDyxED?=
 =?us-ascii?q?EI3MxMGXAEpCw4RA0+BRwSBCoEBBgEmJJ52IAFSO0MJgh0NkjuxADQHgiuBV?=
 =?us-ascii?q?oFZDJ8NBhMvlwkOBpIkAS6HMJAXIKd/gWM6gVwzGiSDNk8DGQ+OIAwNCRWDb?=
 =?us-ascii?q?o8JAT4/ND0CBwEKAQEDCYVGAQGFfQEB?=
IronPort-PHdr: A9a23:SpK5uBwtIgH9eJzXCzILw1BlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 hGZv6Q1xwaQFazgqNt6yMPu+5j6XmIB5ZvT+FsjS7drEyE/tMMNggY7C9SEA0CoZNTjbig9A
 dgQHAQ9pyLzPkdaAtvxaEPPqXOu8zESBg//NQ1oLejpB4Lelcu62/6y9pHJfQlFgCaxbbxvI
 BmrsA7cqtQYjYx+J6k+zRfEvmFGcPlMy2NyIlKTkRf85sOu85Nm7i9dpfEv+dNeXKvjZ6g3Q
 qBWAzogM2Au+c3krgLDQheV5nsdSWoZjBxFCBXY4R7gX5fxtiz6tvdh2CSfIMb7Q6w4VSik4
 qx2UxLjljsJOCAl/2HWksxwjbxUoBS9pxxk3oXYZJiZOOdicq/BeN8XQ3dKUMRMWCxbGo6yb
 IUBAOUPMuhFr4fzuVUOoAW8CgawC+3i0SNIhmbs0KEmz+gsHwPL0Qo9FNwOqnTUq9D1Ob8VX
 ++v1qnIzijDb+hL0jny7IjIfAohofCKXbJ/bMHczk4hGBnfjlWTtIzlJCmZ2OsJs2iV9epgV
 OSvi2E8pgB/vDeg3d0ghZTXiY8MzF3P6Cp2zpovK9KiVE57fcCrEIFWtyyCKod7QMwvTWFmt
 ion17EKpYO3cSgJxZkj2hLSZfOKfYiW7h/iVOucPzZ1iG5qdbyxgxu88VWsx/PzW8WozVpGs
 ixImcTPuHAVzxHf9NWLRuVn8ku/xzqC1Rrf5vxGLEwuiKbXNoYtz7o/m5YJv0nPAzX6lUb2g
 aOMdUgp9O6l4Pn9bLr8vJ+TLYp0hxn+Mqswnsy/Bvw1Mg0JX2iG5eSwzrPi8lPiT7lQk/I5j
 LHVsJHcJcsFuq60GxFZ3ps95xqlETuqztYVkWMaIF9HYh6LkpXlN0nLIP/iDPe/h1qskC1sx
 /DDJrDvBY/CLmLAkLf8ZrZx8UFSyA49zdBF5pJUDL4BLen9W0Dvr9PUFAI2PBKsz+bhE9pyz
 pkeVn6XAq+FLKPStkeF6v83L+mWeIAVoCr9K+Qi5/P2kXA5nkMScrWo3ZYMc3C5HvFmI12Db
 nb2g9cBF30KvgskQ+Dwhl2CS20bW3HnXK8m4Dw/TYCvC4bfQZq2qKKO0T39HZBMYG1CTFeWH
 jOgc4SCRudJcymJI+d/nTEeE7usUYks0VeprgC+g6F7KfDd9SAUuIzL0dl+/erYlRAqszdzC
 oDV/2aLB0tul2gFD2s626Y5q1Z0wVqr1KlzmftTFd1LofhOV1F+fdT+xul3EJjfHErjOJ+jT
 0q6RdCiDCB7BoYzzt0ES0J8HciyyBHJ2myhBLpD0/SpA5F80qva02rwJI4pyXHd2bEhyUVgQ
 sJJOX+nhYZ/707YAIuf1w3Tsq+waaUalA2LvF+O0WeUp0xeGkYkVKzfQXEZIFPbsdnj/U7EZ
 7i0AL8jP01KzsvUbuNvY8H1xXpPWPr4cIDban6tm2qvQxmB2r6XRIryPW4a2XOZQG0FkA1b2
 HeCMQUkTnOkomneBTFqU1fuZ0fh68F1oXW8SE4/xgXMZEpkgf79wRUSmeDUd/4e2vpQoywmt
 ykyAFuw2/rWE5yLoA83OO0WWs8w+FdK0yr88URWN5mtNadkzBZKaA9+uk700BNfAIhJi8Qto
 zUhxwc0Kbre21REIWC2x5f1b5jeMGrv51iCb6DM21fRmIKz870M9e9+hlHtpgCvGWI9/n8h3
 9QDgCjU3YnDEAdHCcG5aU0w7RUv4uiCOkHVhqvR3HxoauyvtyPanskuHK0jwwqheNFWNOWFE
 hXzGosUHZvmM/Qkzn6uaB9MJ+VO7OgsJcrzUvKc27Owestkkiini2tv/413lE6BpGJnUuCd5
 58e2LmD2xefETL1jVOvqMfyzKVNfzIPBSySzSb+BYheTrJ/d8AHBDTmONW5k/N5gZOlQHtE7
 BijClcBjdeuYgaXZkfh0Bd40EMKvTq4lCH+wzEcfygBiK2Z0WSOxu3jcEFCIWtXXCx5ik+qJ
 4GojtccVUzubg4zlRLj61yoj65c7L9yKWXeWyIqN2D/Mn1iX62st7GDf98H6ZUmtj9SWfi9Z
 lbSQ6D0oh8T2SfuV2VEwzVzezavs5T/1xt07QDVZFN6tnnEYoddwRnF5drTbeFc1HwKSWgwi
 DXaAES9I8j85c+dxN/ItuGzUX7kV4UGK3Cxi9na623iuiszWE7a/bj7gNDsHAkk3DWu0tBrU
 X6NtxPgeszw0Lz8N+t7f05uDVu66sxgG4g4nJFj4fNYkXUcmJiR+mIK1GnpNtAOk4f3dnkQX
 ngmx9DP4Q7q8FJuJDSFysiqMxfVitskfNS8bm4Mj2gY5tpJFbzSwbhKhypzrXKnoAiXbfU3z
 VJ/gbM+rXUdhe8Oog8kyC6QV6sTEUdvNivpjx2U7tq6oc27fU6XeKOrnAp7lNGlV/SZpx1EH
 W3+YtEkFDNx6cN2NBTN1mfy48fqYouYYdUWvxyS2xDO6oodYLc4jPkXnmxKPWznvHsq4/E2h
 1pi0Nm2sZOGJGNk4K+iSkQBbHuvPZxVo26r1P8Wl93ex421G5R9BjgHOfmgBemlFj4fr7WvN
 gqDFiE9tmbOHLPeGQGF70I153nLEp2tKzSWPCxDlI8kHkPCYhUAxllND1BY1tYjGwunxdLsa
 hJ87zEVvRvjrwdUj/lvL1/5W3veowGhbnE1ToKeJVxY9FInhQ+dPMqA4+Z0Bywd8IemqVnHD
 2WBZBlTS0wNVFaFAV/LIbSko9XNubv9ZKL2P77VbLOCpPYLHdKB35Gyyc1L+ziWN8OAFmZvB
 bs31wAQOBIxU9SckDIJRSsNkivLZMPOvxaw9Bp8qcWn+ejqUgbitsOfTqFfOtJ191WqkL+OY
 qSO0T1hJ28ShfZujTfYjaIS11kIh2RyeimxRP4e4DXVQvuYm7cLXURCMWUpbpQOtvhimFAXa
 YmB17aXnvZ5lqJnUQ4fEwa7xYfwOIpSZDvgfFLfWBTRbe7Af2eUhZioJ/v7E+IYjf0I5Ufp5
 nDESQm6b27FzWW5EEr+VIMExCCDYE4O4sfkLEsrUDWyCoqhMEPzMccr32dvnvtr3DWQbTFaa
 X8mLAtMtuHCt3oHxKolXTUQtDw7ca7exUP7p6HZMspE4aEtW3op0bgAsTJjkOMd7TkYFqwv3
 nKM85g0+AngyLPHjzNjVFAmRi9jooWNsA0iPKzY8sIFQnPY5FcW6n3WDR0WptxjA9mpuqZKy
 9GJmrihYDFFu8nZ+8cRHa22YIqOLWYhPBz1GTXVEBpNTDilMnvajlBcl/fa/2Ocr5wzoJzh0
 JQUTboTWFswH/IcQkNreb5KaI9wRS8hmKWHgdQg4H2jsF/OSc8csp2GHvOeDPPzKSqI2LlJY
 xxbpNGwZY8XN4D9xwljcgwgxd6MQRCPG4kS5HQ4PWpW6A1X/XNzT3M+wRfgYwKpuzoIEOKs2
 wUxkk14aPgs8zHl5xE2IEDLrW0+ihpU+52tjDaPfTr2NKr1U5tRDn++kkErMY7gBStxYxezm
 0NMKzrOAb5cxegFFygjmErHtJ1DFOQJB7VDewMVzOqLau8A1FNBtmO4yEUB6eaPWv4A3EM6N
 JWrqXxHwQdqatU4cLfRKKR+xV9VnquSvyWs24jZIScbIFsRtnyfcmgEtR5QXlHDDzWl9Kpg5
 F7a89OsUHcBXbwmr6Aznn4=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:q9zpD6FuxFqMjlkkpLqEw8eALOsnbusQ8zAXPiFKOHlom6mj/a
 2TdZsguSMc5Ax/ZJhYo6H4BEDiewK/yXcW2+ks1N6ZNWHbUQ2TQr2KhrGSoAEIdReeygdr79
 YFT0EvMrbN5IBB/L3HCdODYrAdKQS8gceVbDvlvg9QpN9RGttd0zs=
X-Talos-CUID: 9a23:bqAAP25VxZovPvzcDtss8EUwE8waLHfm/VjUDEGmVUlXdo+WVgrF
X-Talos-MUID: =?us-ascii?q?9a23=3AAGVYdgy2q9LrI8saYOCJTxXnqxSaqKSNWHoWg9Y?=
 =?us-ascii?q?hgdKFNyh+Bme7yx+VU7Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,195,1677538800"; 
   d="scan'208";a="53342832"
X-MGA-submission: =?us-ascii?q?MDE45TaeqIdlnuPaTDezJlAfXdD8JzwWBzeNDR?=
 =?us-ascii?q?ALYyC7mJaSdolvqfJzhW1CjtcVXWjyI3gRArLfewcYw+mwtvCKqm0gO3?=
 =?us-ascii?q?OcH1LQjQZ+HysYeqi46LrXnws/MzKIeuTnl1/zaDUJwDsZnjEaOmGJMy?=
 =?us-ascii?q?Md7e7BD5vUG4+QB4mTDxFUCw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 11:16:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681463794; i=markus.elfring@web.de;
	bh=Rtfn1Im5FJJK0qZywomkd8UZmvjAbdtCGz5U1aF5Wi0=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=cBWI+Zf6GaHtR8FkPBAhhqXG9Bmv2RaJEUb3gaV8PauETgUmF2X9p8gm/e20ysaIX
	 Fm7qGpIrBQlbrQv2TTVJ+Tc10qLQWtTjlRZ2IlV9ple0p4hLKcIJejeXLEGO33V8C/
	 0THhENjGcgxZXGfG7ZAqZTQHvLzElSgw/sQH3vXy+c+1DU57ta39O55AlqPMiu2mrF
	 9KcYJWNTBwDq8WXgWlgq1NnMstx3/kXbUiDdRhaajgiEnvsb2ZszZ2KcC54DSxf8uo
	 bwi2Ek3FkrrGQAl3RSk/pXnSqbbr6JvNc5aNFy7LtZOWfpcVNjyvAEetIJwbTe847v
	 iRMkXk8Y7oeEw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Ml4B4-1qCiOU342u-00ljBU; Fri, 14
 Apr 2023 11:16:34 +0200
Message-ID: <fffd36dd-ec5d-4678-9e63-c52b0a711e76@web.de>
Date: Fri, 14 Apr 2023 11:16:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-scsi@vger.kernel.org,
 storagedev@microchip.com, Don Brace <don.brace@microchip.com>,
 "James E. J. Bottomley" <jejb@linux.ibm.com>,
 Joe Handzik <joseph.t.handzik@hp.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Matt Gates <matthew.gates@hp.com>, Mike Miller
 <michael.miller@canonical.com>, Scott Teel <scott.teel@hp.com>,
 "Stephen M. Cameron" <scameron@beardog.cce.hp.com>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Content-Language: en-GB
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YnxtmmpBdGyXEOFXTcY+bf6JOfRWxgpeiGgeBg2ui7uVqFude7P
 AfKrDiR2dk7esMWLCamx6nBBhcm/MUIrYe+rIKwAeG9k6pgRs/yZG0sJxDecbswEjC/S8sa
 TbWucwO1H1FIpTxXLxcFiBeQ07y0W8tvKNab+96ZyOVa0Y0OH7kVtodsyFsO0fjhfEZXxrq
 9GdEzA2OHjvB6iY4KwS2A==
UI-OutboundReport: notjunk:1;M01:P0:d88s/1C9m4Q=;isIDx+SZMv/FCuGjl353xzO55n9
 LRE6B5MASFPHtSzm05iG4DcAd9CnKscVkSwHmtsWMRTG2hPMnJWq4mQ26lC1PCOUfePNc9pKM
 X2ZDpVjvHd1sfRN8vJYJFbz+WHCuuVFBvR6on37kKsdjNdkVRhpNgYhzItgEwDjx+4whVeFCX
 /R0nfO8nHlREihNRYJaMSnMf3dsoMbY1qltysfzGktI0g2ZVWsradVOgV3BXSgRCxNvINQq7a
 J0uAIULfm6+vdSUtYPI2kycLjS39dR39u6llRwPeGwsLc6ERokU5KNGuQyLVUYJA6zDYLjHvj
 pSvmNFb7dEQwylnIB72S0eaZbhp9rbT5baRYRGVn95KeASV0APTUWPjP4xKIloqCqy/zzVBej
 whwsk/QFCx2vr5wguCpWk0ogwR11/Y9J4MIzeixJl9UFFhsRuZlLGlwcsq57jQOqUEUyujE1Z
 OcAnbihGMAwOkz+n6Q5yPMLqvtWT11E49baOK3v+q3BDdHaysaVzFHX8+MMBMfSvB+gqYStFO
 +En8IfnU4We25q7YTh2cX0BoACN+iwF6wd8UGEWc+zEveHUSFX+E9qMRpiqAn6nTgzPssLtuG
 OZCNXn/iq7wdHloAV/UwBg+ZbsDzYHM+wjAKz9x81LVHXsyeKkGTVM8k7m2sgjCZTTZjO+iMR
 lppV49WTz6xEODExEXWMMtreQGj2dQRNzFtns8TTYcn6jWyv7iN0mD7R1p/l6N/ug3BmDxAyg
 Bm/pysParTBXmpiRZ3ZKlx3uEkQLWIXkVgTIJqe1ySnT0OEFuPE1ytXzTWKINetd8Cvd0qI+F
 7xpYJSid6kc6PICeQtE13TqQydtn9UL2cYhW5DdPYwsNpj8tefenNcxPqX0PP6lw7/taEXAtz
 bptHrvYW8gBwgTW9kOwIkxrtAhYmVr0ub/P+jLjd/aue0MuECLjeGSX0V
Subject: [cocci] [PATCH] scsi: hpsa: Move two variable assignments behind
 condition checks in hpsa_scsi_ioaccel_raid_map()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1045
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/fffd36dd-ec5d-4678-9e63-c52b0a711e76%40web.de>

Date: Fri, 14 Apr 2023 11:00:40 +0200

Addresses of two data structure members were determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Chpsa_scsi_ioaccel_raid_map=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for two local variables behind some condition checks.

This issue was detected by using the Coccinelle software.

Fixes: 283b4a9b98b192ebc0e15351fd6fb60e1be78c5d ("[SCSI] hpsa: add ioaccel=
l mode 1 RAID offload support.")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/scsi/hpsa.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index af18d20f3079..562bb5eab134 100644
=2D-- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -5104,8 +5104,8 @@ static int hpsa_scsi_ioaccel_raid_map(struct ctlr_in=
fo *h,
 {
 	struct scsi_cmnd *cmd =3D c->scsi_cmd;
 	struct hpsa_scsi_dev_t *dev =3D cmd->device->hostdata;
-	struct raid_map_data *map =3D &dev->raid_map;
-	struct raid_map_disk_data *dd =3D &map->data[0];
+	struct raid_map_data *map;
+	struct raid_map_disk_data *dd;
 	int is_write =3D 0;
 	u32 map_index;
 	u64 first_block, last_block;
@@ -5209,6 +5209,8 @@ static int hpsa_scsi_ioaccel_raid_map(struct ctlr_in=
fo *h,
 	if (is_write && dev->raid_level !=3D 0)
 		return IO_ACCEL_INELIGIBLE;

+	map =3D &dev->raid_map;
+
 	/* check for invalid block or wraparound */
 	if (last_block >=3D le64_to_cpu(map->volume_blk_cnt) ||
 		last_block < first_block)
@@ -5397,6 +5399,7 @@ static int hpsa_scsi_ioaccel_raid_map(struct ctlr_in=
fo *h,
 	if (!c->phys_disk)
 		return IO_ACCEL_INELIGIBLE;

+	dd =3D &map->data[0];
 	disk_handle =3D dd[map_index].ioaccel_handle;
 	disk_block =3D le64_to_cpu(map->disk_starting_blk) +
 			first_row * le16_to_cpu(map->strip_size) +
=2D-
2.40.0

