Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202B6C3DA59
	for <cocci@archiver.kernel.org>; Tue, 16 Jul 2024 17:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=WI2HQO09kTzqMlteA5rHfvcpuDHcyI2lVAEZTKhhHMY=;
  b=Y/GuF3MdnflaIy05oK1qfkeIaoo2g5vy/ACpawccZgKhI98BBI0lrSud
   JQkh6nFL4GdIjHH+YeDaL7IrGr4q45P4RH0Ct5rOy1zEQza6KFCxotI4n
   sb74abz/YJifZqXysPcabzh20xz2askkv69xt6SdxiWlvyROrkVog3sLG
   A=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.09,212,1716242400"; 
   d="scan'208";a="175759730"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Jul 2024 19:06:28 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D4B4DE0CCC; Tue, 16 Jul 2024 19:06:26 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 36FE3E004E
	for <cocci@sympa.inria.fr>; Tue, 16 Jul 2024 19:06:22 +0200 (CEST)
IronPort-SDR: 6696a88d_KlhbAefvYAgDvC4doboC154FHnFdwI9yOXQUtBv0vwkQuVR
 r3CrcnHv9RPF7YH+WPKwn1SlXI7DoldCsEyfHUQ==
X-IPAS-Result: =?us-ascii?q?A0HMAgAup5ZmhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYJDYhoGVDMEC0gIJYQpj0iCJYQ7jwqIc4MWPg8BAwENOQgBAgQBA?=
 =?us-ascii?q?QMBA4FJQoIuRgJriEECHgcBBDMGDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQEBIxcHDhAnhXUNgmcBEHcbdDACAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBFwINOkQBAQECASMdAQERJgEECwsODAImAgJWBgEUAQGCfAGCLwEDDiMHD?=
 =?us-ascii?q?QavUoEygQGCDAEBBtpZHywiV4FjAwaBGi4BiDEBhXyDRnonD4FVRIE8C4J4P?=
 =?us-ascii?q?oJhBIFeg1uCaYUHjQKHRYtwFiYLjSxUexwDWSETAVUTFws+HQIWAxsUBDAPC?=
 =?us-ascii?q?QsmKQY5AhIMBgYGWTQJBCMDCAQDQgMgcREDBBoECwd3gXGBNAQTRAOBNwaJY?=
 =?us-ascii?q?QqCfwIFISmBSSeBIoJ3CIEtFYEHAoJfgWsMYYd7YoEPgT6BYQFLgRiBZkokg?=
 =?us-ascii?q?0mBXx1AAgELbT01BgMLGwY9qg6FHhsgx3M0B4I2gWGBYwyKIpUoBhMvhAWNA?=
 =?us-ascii?q?AOGMw4Gkm0umD0gjVibFYF9JIFcMxokgzZPAxkPjiEZg2EzyjdBNQIBOAIHA?=
 =?us-ascii?q?QoBAQMJhUYBAYNagUoBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:QWOMhapT/sxqoxzOtFjazOIaV5r/eYIsimQD101hICG9vPbo9f
 xG785rsSMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaGSS5vyb3ODXKadC/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: 9a23:GG/Ni2F8BKCDNyOkqmJ99kw3Pp0heEHHzWfRE2SCDEpxR4KaHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3A2UXxGw2BWgqimtZYJcy5xbgavTUjv/6WJBsxoLU?=
 =?us-ascii?q?/48CtF3ZBEieArRWWa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,212,1716242400"; 
   d="scan'208";a="92314011"
X-MGA-submission: =?us-ascii?q?MDFLIPquq81GVoXAXH/NsUZsQlA2X7xxN0RK55?=
 =?us-ascii?q?RDoE92LzduRcx5b/yq9iJJfEJ5PJxTfdoPC1oZxT/lqXDNBoO5i5hRH8?=
 =?us-ascii?q?1l95wGRbA+/vPpPEqEfyWM7fRpuGRyOLYbaS8LpKp5UAtk0fOx2qhT2j?=
 =?us-ascii?q?2jDDV1oNZLMQfRZTsTsIktBQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 19:06:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721149571; x=1721754371; i=markus.elfring@web.de;
	bh=WI2HQO09kTzqMlteA5rHfvcpuDHcyI2lVAEZTKhhHMY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=u02CQzIMH45HPETAUci9UtBD1e2BTOdfqnrSnn+RcvfWZdSVfrfy/U4m8LiYlXQs
	 I7CWZxtrr4LeCbITqEvLE2t2OJAa21QOKWs92Y8GTTkIc++Ik2GDyVrejEE8E2BW/
	 wTJgIf9RCF5hLHfGBZCfuVOotvxp3M5g4Fo/v8vbsHzKxfb8sQQwF55d1+VhJrsE9
	 UjovZ0GGDmrhyy7Cbb6tdlixQWMySv5Kbx5BNCowq04QUC44svBVEdXqFuyW3XF4M
	 eeMBEe8teit4hYWP4n+6hh4S/CLvEpD6Nv2zbcYAN24z1MRDIYAUyP/T02VdoHAtQ
	 JAWk44L+cvydP6Z8Gw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCogm-1scX4N0qsy-005vFu; Tue, 16
 Jul 2024 19:06:11 +0200
Message-ID: <a1b7f067-efa9-4550-8351-8923a71826fa@web.de>
Date: Tue, 16 Jul 2024 19:06:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Joel Granados <j.granados@samsung.com>, kernel-janitors@vger.kernel.org,
 cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>,
 Arjan van de Ven <arjan@linux.intel.com>
References: <CGME20240714100031eucas1p16b701d3e5852ccb40305a73bdb2a2759@eucas1p1.samsung.com>
 <19c77c4d-7f81-4980-a124-d6a8e14675d9@web.de>
 <20240716154520.vtlqv4jxlihy2h7r@joelS2.panther.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240716154520.vtlqv4jxlihy2h7r@joelS2.panther.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WyOQD+X28tCW/Qvf/kz9Vcqc4NhLzMy2C6g9lKCntQYd/eB80w1
 Xn8r1xtVsBUAbkejg3ujC0EMUq+5695j3IXVujwrVsncQfFrw9eqMIpKM46Q3Gy1rwH17KQ
 aBbbOc9pQA9QeGK1X1Ct8uf5TF3pSFDSN+udZeuVtfhmu1cZPA16P+RxOacwDn1jRlqTygP
 vh/mIOrGJEoMUkkmGgHaQ==
UI-OutboundReport: notjunk:1;M01:P0:W6zPfW2N2Xs=;5msfO3uVbffYFwXCu2wubJVgo/4
 ohjGFfS3vsqUfN2/Icw6YZLcVlMumvDAtwaCQALWzFoqPCQoqrLlzoDJJeZL0qdbl2osHBILZ
 G4+uuBw6gVNBEvS223mcNAjMjgCv5/Wcxlf6k0fkJ+/41lv6AmALk/I7D3IjCQShuctYlLw7o
 InYZ+z7nSm2TphoTBHDFnAievoE8piDVChC9p0nzfAbDcMtvrDr87danEs1cyBs3+jY9TvISa
 NQbLRJpW3NxsIsssGAdAKRRZAzqAAVE+lNh+facbo2+vYy4DAikyHVSUeDforurd5vivN9CUK
 Md1edlpwZLJEIQbb6YQwkVjpMldOgi31/yGB8mW9RY3i6G6nULP0HGKOwICegu20gOPoHdv4f
 A9M69nv1n7fQOeeKlCV0lZzHZhRaipgpQqelEjYe63xMtLnJF+2kKy1uT8cG6DgB0zzgxuKF2
 k03rNeuu2GkyTbx9XkiqgkICz+X5U3Ad8YrK6pVtryLYqDnI0ohP0ckmk5xGbMrqDcHQDlNAC
 UZsh+/zj2EwogMtkoW6PyAyqiOPo5HCyFY+inzpq8jUTEBboM7rhW5evtbrWKQ1lE+SSIKUao
 7SPk6JjzgIwv/G3fv4TBLfPlQfXSz0QEghOklxx/5A/1tCZAwlI+yHy8y+OvrkDBdLWLALEd9
 WvBUe8dWcD9NgGhYajXga9wVDsc3K1N/JwLI9U4K1hG0DpN6S/xHWjss3ipyB4tDy6/YrUt6D
 3QOwvnC6kw8CStUqTNT7Z+rJoKDYnOI9G4N37zEaJlRKBkrqnCPytk4xmo/gDduV+/eZLpLhd
 KoxT0a8sCqgViMEJC1xdqi4w==
Subject: Re: [cocci] latencytop: Use seq_putc() in lstats_show()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1808
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-07/a1b7f067-efa9-4550-8351-8923a71826fa%40web.de>

> Not sure why this got forwarded to me.

The script =E2=80=9Cget_maintainer.pl=E2=80=9D pointed your recent contrib=
ution out.


>> A single line break should be put into a sequence.
>> Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.
>>
>> This issue was transformed by using the Coccinelle software.
>
> A couple of comments while I'm here:
> * The "why" is not clear; please clarify why a single line break should
>   be put into a sequence.

This is a desired data processing effect here.
https://elixir.bootlin.com/linux/v6.10/source/kernel/latencytop.c#L263


> * I don't think that a one liner merits the "coccinelle" comment.
>   However, if you *really* think it should be there, please add more
>   information, like the conccinell script.

I would appreciate if another SmPL script can eventually be integrated
for the coccicheck tool.

Regards,
Markus
