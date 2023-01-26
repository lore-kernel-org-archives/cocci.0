Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC698C05027
	for <cocci@archiver.kernel.org>; Thu, 26 Jan 2023 15:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=xIMTCQexRRxZCQAoufSL5lY+hGvHNuIvhwimraoUODs=;
  b=e4E8kdSY1OItsCTSpCZMtTQwhS2rtjgG7wnPUkvHy4eovE+mEe0OegxK
   EIuZizhLnz4FY/Y075OuYPknLusaRcpoSL1D2/fnTvg4Bql+Ix612tkmr
   jpTPdJn4t625xiBljT0wTRo1wKM3Nvlz3rGukoFfwGyKsyk8vtUNvEbh0
   0=;
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
X-IronPort-AV: E=Sophos;i="5.97,248,1669071600"; 
   d="scan'208";a="89592204"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Jan 2023 16:38:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 69AB7E0AF2; Thu, 26 Jan 2023 16:38:54 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 71F2EE021D
	for <cocci@sympa.inria.fr>; Thu, 26 Jan 2023 16:38:49 +0100 (CET)
IronPort-SDR: 63d29e88_56V+2kdcg4cYdY7SYah28nPIcqKcFjXlUdrKi+vSPhnq1To
 sHO0ydoi3DKw4cY4wwEnBMz/JVgUigOEZ+BTngg==
X-IPAS-Result: =?us-ascii?q?A0EZBABQndJjh07ASNlaHgEBCxIMQIFEC4ItgV4uBAtFh?=
 =?us-ascii?q?E+OeoZThyeHMohjgVaBQD4PAQMBDUEBAgQBAQMEhQAChSMCHQcBBDEIDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBARgLFwcOEAUihWgNg?=
 =?us-ascii?q?jcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICR1M9AwMjHQEBESYBD?=
 =?us-ascii?q?wsODAImAgJXBgEMCAEBgnqCbgEDMQerIYEygQGCCAEBBpwJHywiU4FeCYEUL?=
 =?us-ascii?q?Ix1hDEnEIFVRIE8DIJ3PogcgmeQQosBCoE5eIElDoFGgQ8CCQIRfCUEDgMZK?=
 =?us-ascii?q?x1AAgELOzIKPzUGAwILSisaGweBBioJHxUDBAQDAgYTAyICDSgxFAQpEw0nJ?=
 =?us-ascii?q?mkJAgMiYgMDBCgtCSAfBxURJDwHVhIlAQUCDx83BgMJAwIfT3ACCSUREwUDC?=
 =?us-ascii?q?xUqRwQINgUGHDYSAggPEg8GJkQOQjc0EwZcASkLDhEDUIFOBC9egQQGKSa1U?=
 =?us-ascii?q?bAzNAeCJIFRgVIMnnYGEy6DZgGTFA4GkhuXTSCiaIUIgWMBOIFcMxokgzZPA?=
 =?us-ascii?q?xkPjiAZhAyPP0A0OwIHAQoBAQMJhUcBAYZaAQE?=
IronPort-PHdr: A9a23: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
 ZBIRrIJDDTd+dsFB04jENFQef9K
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:5N0KRqnGe9jCc4D7D6VOAyS6cWPpDfI/3DAbv31ZSRFFG/Fw8P
 rCoB1773PJYVkqOU3I9erwXZVoIkmyyXcK2+ks1N6ZNWGM0ldASrsSibcKqAeQeREWmNQttp
 uIC5IRNOHN
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,248,1669071600"; 
   d="scan'208";a="46099555"
X-MGA-submission: =?us-ascii?q?MDGstWoBikea1SK3W92EtRCSYzVnHDTtgQ769R?=
 =?us-ascii?q?cuHBDmaBFCWCkiybq5uBb5oycrcPc/Pl6MEM3CpECJ26VmijfBvqa+5V?=
 =?us-ascii?q?X8qU0w/BHTUrtEI2p+I9bw7QKJbq4EtkPuuWs1R4szd6SzdQXkcDPe0G?=
 =?us-ascii?q?3Elap9mdQ9xUyosO6qTxY/ww=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 16:38:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1674747526; bh=xIMTCQexRRxZCQAoufSL5lY+hGvHNuIvhwimraoUODs=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=V88JYafn64u287hcWEzmxb3SkBCA/W09fduyWFVVxotn91mAKOWw8wcYHc0EHyGH0
	 TLo52gFApuvkQWFDjGqBAK90ZLQod7zyX1nk5MVjGWaFpq+U+lMJSsm2qAByomgdVx
	 a4KLm0a21jMPDB4OGrIZRo4Tihrx8UZUZdZkHgKXbLYgHe2f3Wc1Vjh44gLAt9+n7m
	 TNR8FNWn9xAvghE2TC2HAxeYNftUe8TFR9h97kwC8KxHcdUv2FSfRpKC5Ct5SyEsIL
	 ZzUev22VpRVrTwv8EKiWUm9cnHjXG3JeWgruDXXLobZuIGvhsThChXBj7Mx3I8UcvP
	 gR/loQmPR/AOQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MumJF-1oTvYD3M6F-00rrnB; Thu, 26
 Jan 2023 16:38:46 +0100
Message-ID: <11ec2c22-4df1-8056-f490-7367d06a949c@web.de>
Date: Thu, 26 Jan 2023 16:38:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To: Peter Foley <pefoley2@pefoley.com>, cocci@inria.fr,
 Julia Lawall <Julia.Lawall@inria.fr>
References: <20230113-cocci-v1-1-0f4ae50494d3@pefoley.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Nicolas Palix <nicolas.palix@imag.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230113-cocci-v1-1-0f4ae50494d3@pefoley.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p6wQPqBJvpVs8qR2A0BYBbMseFKyY1IFhymEvJK9841K425e0Xn
 V9Zld2qCDlAJtXu9zB0IN9OQs+KUNFTU9baoQ+YPiq3eiwLxG6ZLSImUqbEbqHy1vD6v743
 WybsjcubDXJrdwEWetPa7f1n8ufJl34ibZgGpk5pIPrIFDuqkMVbjqXUq94jXlVZ8kZeusq
 m1yxzW2ySgOrHZrbrnEEw==
UI-OutboundReport: notjunk:1;M01:P0:m6Xc3rwtFMo=;UVKLQ/HSOFBnq5yUj8SMtRlf1SQ
 xSt5zdB1JaAZ20Z4tB0P/7PMO/ELFg1b4FqbdC+nACGrUnwu3X59qozXZEPF2csxyxyPncKxV
 hQrYQYSGO0r+F6bY2I41YnqKq/JZkMjie8GKNlnez00+yajzaP57TqbJy7i8/4IJqPFptR3cn
 89/osEemqZfpLis7RrxisHe2rhApZynhImMGR6e1Br2/D4N7tGIwqsfqTe0FU8MEhopw+izfU
 E7FxvkxuTTGA9HTfo1rYLGZ78vui1YgQFqTGJv8+beSlD8M+JiVi7yXOSK8F0p4n5X7+VI3wk
 oFup2v2Ll2wwKyVzok631NVM02zAEvnDL+fBiMUDotQWk0TZiBu3yugvrL1W4s1mM/aaJtSx/
 qc/IeLpc8ILPtIycXQVTUQcWEmZwrveoDSBwCLdCujkQBrRqEMddqkQ/QH76+zqKso45+Fqtg
 dQhahInXyTLbT0RSqyvFPBAd985/ekFHf9SA0gItgYjw+bk8xjFqlQw3lS8Rfmii8//sYj5UP
 nr1ez8Jpx/s5/br9GMTMuC+Fo/TJ1qXWwbNwOigBw/lkPBnLbq+vdT1/CVnu6ZK+L+MLP6D6h
 B22CygWAEuijiIRUQldkA6c1289fbByK3xc5ictIXWooaaq0pt1LMHQdmDoVzSxI+TNrIMTcI
 89KAoFCQ2nh0MkbYY+f9uBRInDkad0hdVDWY/9XdQT7fW30HGOFQ8BLzid9XGj/d2Sp2LpxnP
 JbirbHqLLD/2BKxdLDTYgl+1yKilweJS4zcSS3l4g1fxYnW5odLSkUTAcR78WEt/XFzRiyS5u
 734RJAMpvKqd6q6xCUgaT4PONFE+U2xZEEP4jG8q4IU8+bWrINIM73xeGckOYK6epSl8RzkCu
 fkNjooQfci6ZNEjJSQ3vfE765Ijnd2nMjHBmfzJohgasJlwtAZXW2hwL1NHUfw0hj6YzAHFgB
 +k+YGg==
Subject: Re: [cocci] [PATCH] scripts: coccicheck: Avoid warning about
 spurious escape
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 818
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/11ec2c22-4df1-8056-f490-7367d06a949c%40web.de>

> +++ b/scripts/coccicheck
=E2=80=A6
> +$SPATCH --help | grep -e "--jobs" > /dev/null && USE_JOBS=3D"yes"


How do you think about to use single quotes instead of double quotes?

Regards,
Markus

