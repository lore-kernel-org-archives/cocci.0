Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A18C5ACB3
	for <cocci@archiver.kernel.org>; Sat, 18 Nov 2023 16:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=CQBpc2vh9HQN4tT9nBoNJyRogzGDAx/e4sULPoZDeuk=;
  b=pfYZxxtT2G1sqtH62kQF0wcDxN2KPNJ/fQBjxmlASTL2uyx+8CrAgTP2
   KoexWTXr+M3IJKy7MjFijtSN9/1+mzaDLGVrE8VIayBv5fh7Ik2vTZIMj
   jlxwocxjIl6wG4q3448OKB+yyvLs8ek5S4VI+yVulJSfD33ZPxZdjxssx
   c=;
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
X-IronPort-AV: E=Sophos;i="6.04,209,1695679200"; 
   d="scan'208";a="137137802"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Nov 2023 17:42:41 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B6432E0AF1; Sat, 18 Nov 2023 17:42:41 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 10F01E004E
	for <cocci@sympa.inria.fr>; Sat, 18 Nov 2023 17:42:40 +0100 (CET)
IronPort-SDR: 6558e97f_Ps5S6vbMk1dqpddMmxSpbb0v/og58DwOmsVsmw4ofk29O8z
 NV30JBUHrpbsdduNK0+jx9d5KI3YYVH1MHo4qsQ==
X-IPAS-Result: =?us-ascii?q?A0EOBQAU6Vhl/wwR49RaHgEBCxIMQIFEC4I5B4FJMAQLS?=
 =?us-ascii?q?IRTkTIwhDuHNIdKiG+BVoFAPg8BAwENQQECBAEBAwSCC4J0AocoAh4HAQQwC?=
 =?us-ascii?q?Q4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECgQYThWgNglUYgQyBH?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAQEBAQEBARcCR0IBBAEjHQEBESYBBAsLGgImAgJXBgEUA?=
 =?us-ascii?q?QGCfIIqAQMOIweqY4EygQGCCQEBBq9VHywiVoFfCYEaLogNAYVZgzt6Jw+BV?=
 =?us-ascii?q?USBFScLgng+iB6CaJ4XXSIFQnAbAwcDfw8rBwQtGwcGCRQYFSMGUQQoIQkTE?=
 =?us-ascii?q?j4EgV+BUQqBAj8PDhGCPys2NhlIglsVDDUERnYQKgQUF4ESBGobEx43ERIFE?=
 =?us-ascii?q?g0DCHQdAhEjPAMFAwQzChINCyEFVgNFBkkLAwIaBQMDBIE2BQ0eAhAaBgwnA?=
 =?us-ascii?q?wMSTQIQFAM7AwMGAwsxAzBVRAxQA24fGB4JPA8MHwIbHg0nJQIyQgMRBRICF?=
 =?us-ascii?q?gMkFgQ2EQkLKwMvBjoCDwQOAxkrHUACAQttPTUGAwsbBj4CJ6ZXpC6gezQHg?=
 =?us-ascii?q?jGBX4FfDJ8jBhMvg24TkyEOBpJPmEAggjCmBIFjPYFZMxokgzZPAxkPjiCEK?=
 =?us-ascii?q?49HQDU7AgcLAQEDCYVGAQGDWoFAAQE?=
IronPort-PHdr: A9a23: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
 /DQmai1JDoQq7o8HOMZANXIbt2KOjwtPEixcAM=
IronPort-Data: A9a23:xiDeFK/27nTM1ESupUsCDrUD5XuTJUtcMsCJ2f8bNWPcYEJGY0x3m
 GIaUT/Saf6NZWDyL49waoTn/U0B6JKEz4BnTQVlqyBEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHPymYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f7nWYoWo4ow/jb8kg25a2i4GlwUmEWPJingneOzxH5M7pEfcldH1OgKqFIE+izQ
 fr0zb3R1gs1KD9wYj8Nuu+TnnwiGtY+DyDW4pZlc/TKbix5m8AH+v1T2Mzwxqtgo27hc9hZk
 L2hvHErIOsjFvWkdO81C3G0H8ziVEHvFXCuzXWX6KSuI0P6n3TE/vdODkhmN7MjxPdWCnNg+
 uYyBjEhR0XW7w626OrTpuhEg8M+MI/0MYlZtnwIITPxV698B8qZHOOTupkBhl/chegWdRraT
 +8Qczlyd1LtZxNVO1EYII0zlqGkixETdhUB8w3M/vVnuzG7IApZk6PtAsbue/ywH9hVvECVr
 GfX8nzYHURPXDCY4X/fmp62vcfEmijwWaoJBbig/7hrhkeSzyodEnUruUCTpP6klgihVtgZJ
 0F8FjcSkJXePXeDFrHVNyBUalbd1vLFc4sOTb8J+0uWx7DK4g2UIGEBQ3QTIJYlrcI6D3hin
 FOAg9qjV3Qlvay3WECt0O6ejQqzHiwJck4ERysPFjUe7/fZ/YocsxPoT/RYKpCTsOHbIz/L7
 gqxnHAMvIlL1c8v/IenzG/DmAOp98ToTBZqxwD5XVCFzwJeZaz+VbOJ9Gr00PdkB6SaR2mno
 3IrtZW/7ucPLJfVjw2LYrwHM4+I7sa/Eg/3oABQDbw+0Q+y6liffYx0yxNvFndDa8orV2fgX
 x7OhFl3+pRWAkqPUYZ2RICAU+IR0qnqEIXeZMD+N9ZhTMB4S16awXtIe0WV4mHKlXosm4EZP
 bOwU56lLVQeOJRd4AuGfcUv+p51+Xlm3kLWf47x8Dq/27nHZHK1d6YMAGHTUs8HtpG7sCfn2
 PcBEfCVyidvcvz0OQjW1o8xEWokD1YGAbLOlsgGUdLbfyRHHjk6Bu7z0IERXdVvv55om9fi+
 lC/XU5ly2TDu0DXFDXSal5fRePueb1dsUMEOTcdOAf0+no7PqeqwqQtV7o2WrgF6OY486ZQS
 fUBSsTdAcZ0ay/m/g4FZsLXt71SdxWMhCOPMRG6YTM5QYVSegzR9vLgfSrt7CMrHAPtkecbv
 JubyRL9fZoPYy9AHfTmQquj4H3ptEdMhd8oeVXDJ+diXXnF8a9oGnTXteA2KcRdEifz7GKW+
 CjOCChJuNSXhZE+9eTIoqW2r42JNe9aNWgCFkn56YeGDwXrzlCB86RhDtnRJSv8UVnq8pqMf
 e9WlvHwEMMWlWZw7rZTLexZ8rIc1fDO+Zlh0QVWLFfaZQ+KC5RhAEW88+thi6lv/oJd6CyKA
 h+h298CIriYGtLXIHhILiofU+mz//U1mD7T0PcLHHvH9BJHpISgb0EDECSP2Qp8LaR0OrwL2
 e0OmtAbwC3hhwsIMuSptDF19WONIiY+UoEijJU7AZDquCUv2FptcZzRMQ6owZCtOvFnEFgmH
 S+Qv4XG349j/0vld2EhMFTwxs9fuMg+gw9Lx1o8OFi5oNrJqfsp1hl38z5sbABq4jhY8uB0Y
 E5HClZUIPiQwjJWm8RzZWCgNAVfDhm/+Eaq6V8olnXcfna4RF72M2wxFuaczn83q1sGUGBgw
 4iZ72L5XRLBXsL7hHIyUHE4jc3Td4V68wmalf23G8iAIYIBXgPkpa2TfksNlQrsBJIgpU/Ap
 NQyxt1KV4/ACXcyrZE4Wq6g7pZBeCDccSYGCbtk8bgSFG7RRCCq1HLcYwqtc8dKPLrR/VX+F
 8VqIdlVWg+j0DqV6AoWHrMIP6Q+ictBCADuoV83DTVuX3qjQjtVXFb48y/jmCk0Tt8onctVx
 kY9sd6dOjT4uJeWszalQAp41q6QftQOIgHxtAxw2PtcDIoN6YmAbmlruoZZfByp3M9P4B+e+
 g/OD0MTIyqO1qw097bR/m5/68lY5D89uClkMOx+jjiWUe7yDA==
IronPort-HdrOrdr: A9a23:fnZOGaCTDtBgF4vlHel455DYdb4zR+YMi2TDGXoBKiC9Afbo8/
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eAaGSS4/yb3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: 9a23:n1h9vW9A8u00KLbJ/c2Vv3MWOsIsInfj90nBAkSqJ2lzYpOUZXbFrQ==
X-Talos-MUID: 9a23:aD+pJQroPRpo+RLTB5oez3J5NPV02KWOMhoQkbcAtsOBJCFoGijI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,209,1695679200"; 
   d="scan'208";a="137137801"
X-MGA-submission: =?us-ascii?q?MDG9ChZz2lfpM3TatmqgdnKru/PKaqNSWmN4TD?=
 =?us-ascii?q?r9ji44AHJPvTbWTkTZ7bjvYWUr5tfmH7aBGY9/5MJL5ELePJnKHt6zZi?=
 =?us-ascii?q?XT1D9SWc8gdjhmLFcRD5glus3+1G3o7mIZPBKnZ1C9WzACJICH8uamqJ?=
 =?us-ascii?q?PCll+yDEOa4S2+L1d4bXE2Fw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 17:42:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700325749; x=1700930549; i=markus.elfring@web.de;
	bh=CQBpc2vh9HQN4tT9nBoNJyRogzGDAx/e4sULPoZDeuk=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=frL2RVUHGroASYsDu/y5flARqFEwOJqkvkJ9tsk6acef23d15e1nO99k8JOIJH5m
	 LOxulL+R1EteiLOukKDk2JAwPy2o0Z6ZQE9Zh2jPanw0Y8V5eAuy3AdHFVjNOBbaK
	 /jpIUfJcM2ekPQFivRUbSc6op3ZyXKeTRZSNSH2nTTMPjDJmQiieGHGrv2426erU7
	 LfmtaQMLz/zv2f6gUTj9c8i1MFTcNHcGjz42t2rIUOyXPzkwVKxqVXKeuDsKppycs
	 LYOWoIGVD/C+Sw7IwfIctUC2+tvXqkQzaoUKsSHdzJHity4jvxNDSlwigjd15bYsz
	 S8R96L9jd0+/MSF6pg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MT7aP-1qvDAZ3vVX-00UUfW; Sat, 18
 Nov 2023 17:42:28 +0100
Message-ID: <233689d7-9409-406b-9383-49f10cd29336@web.de>
Date: Sat, 18 Nov 2023 17:42:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 kernel@pengutronix.de, kernel-janitors@vger.kernel.org
Cc: linux-spi@vger.kernel.org, cocci@inria.fr, Mark Brown
 <broonie@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20231105143932.3722920-2-u.kleine-koenig@pengutronix.de>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20231105143932.3722920-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:bimAwo914tI/X7jy3HV2tL/5MPVU1BNa4SCoqSybb64c+rPbbsI
 SByJoeECEnNN1URSLDPoKC/BGG2YSZMUXKTXd9xVaa2HF3Vfcx5sBHmeUpKQ0empNsyiv0+
 ltukrsnPmCU6/+sDaqnWL7K/Rs1iav0bVjmXpDvqe5pmOLtqYellfPbjw67hlFQWAmMXN+c
 avsiPLS9a8gclWluAshCA==
UI-OutboundReport: notjunk:1;M01:P0:WRbWlSPQY2w=;Y0bpqMauiBxhaSAbtbiw32FYtdn
 n994UDAYWifH64OcNjZk+GR1tphkCF1wqMUtq84HzT0FuWdN8k1CPJqBp6Pq6ggGV0lVuahEc
 YR8hW6uEhky04OpnwbsioOC5vpUZdPItzmPkkYUKjt1epAp9cCOWplh69zVNHftoW6W/ff7Gb
 +V7/eMwMLiAod8o3Qj8b4NLIUwgvQf8jqYcdR3yxZMWX+2KkOnUQP31nKwqqosoKlrtk9DlqU
 /5LkD7IfdJIyDdJ6BwUgGEQVAGhCRoObo57eCtfOWXX2y4iOcpkLSM/1zDesvekBbtmY9t5cI
 kMNUKEUfJeWttp1G83Xg/Xsn9gtPoD3cthk2jujK5wNtFRn8V8qRgUld8furelTugBl+kLTRL
 DHyj4ntSeEa9TjbN057p15BDpXB2w4SFm4iHYthYGA3dpNvQY1+gXzULkJak02jXq0JmGaFIg
 t89CPS9tVo12XnF+J0HRgKRdQd3dDP7mVG4SEwpRYoJh9UfiVh/FA2uD57XvUOlpO+a3abv7e
 QB9xJOVb7ykahfAbqZf/3GdgCgXjAkQz90wvSx/g6TOR64KY2aRHvb/Q3/ic4INz+JTbLEIhc
 Y49x5/kqN9KIdguU9wBE0LLUMgW4zH6B/aCSKMq/qVIlHbZ0YInSPt7JSmtJDr2WzHtxXA4Q0
 QJrwI70vP8uTO6X94jkpryUrtaorwCNhGSWtOnDL/0wcZ41zxLT+QkxK76IrYVEueli5b0OK8
 75jC2spBa2xudNQlXPgtMQs7AvC33Fy5uHXIwtLlhTcsl9gHrdWv4b4fvJKRsNN7mx2Zh8QYO
 D6aS0m6hQFFb78FciLO9LMYc+l1nHxbNMH+M9SEVLuhgA1TrR+AYbepWBK7yC3gJQ2uP7T2UJ
 gtU0ESR5NAxrF4LUOK8ChqmCx8e3xWOLwoh07CpMvf1THXBe8ZT+l6KCq86yNIOaTWvm+VGSF
 0mAVGw==
Subject: Re: [cocci] spi: cadence-xspi: Drop useless assignment to NULL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1297
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/233689d7-9409-406b-9383-49f10cd29336%40web.de>

> Static structs are initialized with zeros for unspecified fields.
> So there is no advantage to explicitly initialize .remove with NULL
> and the assignment can be dropped without side effects.

Would you become interested to delete redundant initialisation repetitions
at any more source code places?

A corresponding script for the semantic patch language (Coccinelle software)
can point more remaining update candidates out for various components.

Regards,
Markus
