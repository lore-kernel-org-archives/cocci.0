Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1C6C6FD1C
	for <cocci@archiver.kernel.org>; Sun, 26 Mar 2023 08:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=0hOXMUsTjQwfIGkRK6IQA5bCvVxoMO8D/eIb/X7Jn6o=;
  b=h27s7AFjPFNk4DISMS/Bsu9JpAwo0hNZ8DDV4lnYal83BHdkeVMmwQeO
   gcZtACutxsvjEfUp2Y+MWd73cv5wNpzCtRglv/xEimbjn39rtUrTXVsFY
   3QdCKoQKwZIjckBIiqkHgGZXHn/yJPLq2yTqdUITq+DbyNoOwGheSLic3
   Q=;
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
X-IronPort-AV: E=Sophos;i="5.98,292,1673910000"; 
   d="scan'208";a="99115457"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Mar 2023 10:16:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DF666E0D41; Sun, 26 Mar 2023 10:16:22 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6534AE0D40
	for <cocci@sympa.inria.fr>; Sun, 26 Mar 2023 10:16:16 +0200 (CEST)
IronPort-SDR: 641fff4f_Exh9D0YZRlGtHBdONxra+gd17SvD6OCCqRfsNV+bF3shOGy
 uMF0IkR1zRY/gpDOmWbtgPKULWRYo9PnmK7bCDQ==
X-IPAS-Result: =?us-ascii?q?A0FEAABA/h9khwsR49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YItdVYvBAtGhFODT4RQiGIuA2mDRpNNhAKBVoFAPg8BAwENPQQBAgQBAQMBA?=
 =?us-ascii?q?gE4gVOBYE5FAoU6Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBA?=
 =?us-ascii?q?QIEBAEBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEHAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAg06GDs9AQICASMdAQERJgEEC?=
 =?us-ascii?q?wsODAImAgJXBgEMBgIBAYJ6AYInAQMOIwcMBq4qgTKBAYIIAQEGgQY6AQMCD?=
 =?us-ascii?q?AJDmXMfLCJTgV4JgRQtAY0EgzZ6Jw+BVUSBPIEVgW4+gksXAwEYgTIUg1iCZ?=
 =?us-ascii?q?4Ioh1aEKIJ9iC8KgTR1gSAOgT2BBAIJAhFrgRIIa4F9QAINZAsOb4FKAmRMg?=
 =?us-ascii?q?R4lBA4DGSsdQAIBCzs6PzUGAwsgBlhrAgkjERMFAwsVKkcECDkGHDQRAggPE?=
 =?us-ascii?q?g8GJkQOQjc0EwZcASkLDhEDUIFHBC9bgQEGASYkmnIDgXMGbAJSKCcWAiAmg?=
 =?us-ascii?q?Qc3BG+SDh2SQJ4ONAeCKIFVgVkMigyVAAYTLoVSkTYOBpEUgQ8uhy2QDyCLQ?=
 =?us-ascii?q?4FvmkiBYzqBXDMaJIM2CUYDGQ+OIBkeg26BC0uDC4ooAT4/NAIBATcCBwEKA?=
 =?us-ascii?q?QEDCYVGAQGFewEB?=
IronPort-PHdr: A9a23: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
 2Uk68McAt+z3UueIcq1dNbtLD0y6Q6tKFjXVJx0
IronPort-Data: A9a23:ZPuE86PYtC2Eo5rvrR2+k8FynXyQoLVcMsEvi/4bfWQNrUok1TQHz
 mBNWzvTbquJZ2Ohco8gb42x9B8F65GDztUwT3M5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8mk/vgqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvU0
 T/Ji5CZaQ/NNwJcaDpOsPrY8k035ZwehRtB1rAATaAT1LPhvyJNZH4vDfnZB2f1RIBSAtm7S
 47rpF1u1j6xE78FU7tJo56jGqE4aua60Tum1hK6b5Ofbi1q/UTe5EqU2M00Mi+7gx3R9zx4J
 U4kWZaYEW/FNYWU8AgRvoUx/4iT8sSq9ZeeSUVTv/B/wGWWQ0Hy6vVCE3gGJLYyw+gwMWRU9
 dAXfWVlghCr34pawZq+TfRwwNsuJo/nMevzuFk6lGufV6x5B8mcBfyTjTNb9G9YasRmOP/EZ
 NcCLxdrYg7BZRJnJVodTp4z9AutriSmKWMJ9AnOzUYxy23twANe/On3C8XuQM6yXshK3WSjm
 luTqgwVBTlDaYDBkGPbmp62vcfEmijwWaoJBbig/7hrhkeSzyodEnUruUCTpP6klgihVtgZJ
 0F8FjcSQbYapHyRUPD9cwKBkGe/lCcSHOpVCe0W51TYokbL2DqxCm8BRz9HTdUpss4qWDAnv
 mNlefu3VFSDV5XKERqgGqeoQSCaZXlNdTRZDcMQZVtZuYa/yG0mpk+XFr5e/LiJYsrdNRyYL
 9qijyEkg64JkM4Gv0lQ1Q+Z2mnzznQlZiQ86gjRG1249B9laYuvapangWU3AN5FK5uFCEaMt
 j4IlqByDdzi77nczURho81UTdlFAspp1hWB0TaD+LF8plyQF4aLJ9w43d2HDB4B3jw4UTHoe
 lTPngha+YVeOnCnBYcuPd3gVJp7lfO4TYW9PhwxUjaoSscuHONg1H4xDXN8I0i2zyDAbIliZ
 MjAKJ/E4YgyUPQ9lmLeqxghPU8Dn31imzqKG/gXPjz+n+PWZXiJRK0DPUfGZ+9R0U93iFW9z
 jqrDOPTk083eLSmPEH/qNdPRXhXcyRTLc2o+qR/KLbeSiI4Qj1JI6GKm9sJJdc695m5Y8+To
 xlRrGcDkgun7ZAGQC3WAk1ehETHBMYg/StnZHd3bD5FGRELOO6S0UvWTLNvFZFPyQCp5acco
 yAtK5rYUMdcAC/K4SocZpTbpYlvPkbjzwGXMibvJHB1c5d8TkabspXpbyn+xhkoVyCXjMoZp
 6H/9wX5RZFYeR9uIvyLY92SznSwn0MnpsRMY2XyLOJ+Qn7cqLpRF3Spj9scAd09FhHY9z7Li
 yeUGUg5oMfOka8U8f7Ip/u2kKa0IcRDH25xPWrS3ZCpPwb0o0uhxo5hVr6TXDb/DWnbxoSrV
 d93/drdbsIVuUlsiJVtNYprwYYVxcrdl5UDwitKRHz0PkmWUJV+KXy47Oxzn6xqxI4BnzCpW
 0iKq+JoCZ/QNOzLSFcudRcYNMKd3vQpmx7X3/Q/AGP+wARVpLOnc0FjDyOguRxnDoleEd0am
 L86mcss9QaApAIgMY+GggBq5m28FCE8fJt9hK4KIr3Aq1QN+glZbI3+Gx3GxsiFS+9xP3kAJ
 h6Wg6v/hIpg+HfSTkprFVbx8Lpcob8spCF1yEQzIgXVu9jd2d4y8h5j0RU2aQV30h8c7bpXP
 GRvBkwoJpe13ixJgfJbVDuGADBxBxy++23wxWAWlWbfcVKaa2zVIEA5OseP5Eo84UsGWhR+4
 5ej13fDbTbmWOrTzxkCcxdphNK7ROMg6zCYvt6sGvq0OqUTYB3ns/eIXnUJoR62OvEBrhTLi
 scy9dkhdJChEzAbppA6LIyo1b4wbhSgD04aSNFD+JI5J03tSAuQ6xOvdX/oIthsIsbU+3CWE
 8Ztf8JDdyqv3Ra08ww0O/Q+HK9WrtUIuvwyIqjmNEwXgYu59zBJiq/dxgL6pW0sQuhtr/oDF
 5PsR2q8NVKU1FRpmD7rjchbO2CHT8EOSy/i0cuUrugYNZIxn9t9UEM107fugXSxNTFj3hOLv
 THsY73d4PxixL9NwartMPRnLCelJezjUN+n9FiIjO1PStfUI+LiihgwqGS7Dz9JPLAUZct7p
 Y6NvPHzwknBmrQ8CELdpLWsCIhL4p+UcNdME8eqMkRfozSOaPXs7zQH5Wq8D55Dy/FZx8u/Q
 jqHeNmCTsEUV/hd1U9qRXBnSThFMJvOb4DkuS+ZhNaPAEJE0QX4cfWWxUWwZmRfLiI1K5nyD
 zHvgMmX5/daktV8NEdRTbUuSZp1O0TqVqYaZsX8/2vQRHWhhlSZ/KDuj1w84DXMEWOJC9v+/
 YmDfBXlaRCuo+vd+bm1aWCpUsE/Vx6RQNXcf37xP/ZzjC2mSnELJ6IRPP3qz32SfjPajPnFi
 PPlNQPOyhkRmRxbfB+67NmLssK3GLkVItmgTtA21xr8Vsp1bb9sxJN++y0m73oelv4PCg24A
 Yl2x0Ac9SRdDn2kqSj/KxB7bSpaKivm+081
IronPort-HdrOrdr: A9a23:3Jw1zatQRaQmsHDU/6AUnJC57skDotV00zEX/kB9WHVpmwKj5q
 KTdYcgpHvJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,292,1673910000"; 
   d="scan'208";a="51269433"
X-MGA-submission: =?us-ascii?q?MDGl+LO/YjvmkAC2zx5QBRFHEPnZ/hxjn+jare?=
 =?us-ascii?q?KDf1Mou9FRs66aBsa3Mp6RI/plJWJXj0XxbNj9SCTk9KddKn3CmV+9MQ?=
 =?us-ascii?q?tZGJC1m7hphaEU8U/XEJSP/YQrrexkxIVmg47GHDy6xYoNl3f/WLZ2jH?=
 =?us-ascii?q?iwd8PFxDPLX0skkv06tVJOCw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 10:16:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679818543; i=markus.elfring@web.de;
	bh=rBCEKqUiIg95hHqIQA+rJDnVzCS8UUItPB3j6Z3IkBs=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=i60JcdfEiXZjhXmlN0wT0hEYONtQ+sM4g9Oc04ByPbsuIwSNCVKKVvSZUmE7VPD/t
	 ypNOoxI2sA+d/y4T+WeAuuicPGKuEfgiK1h1Lm02Ofc0bNBgZvnwzf4xGkwhzR0CO5
	 D2OlYCmR/A0O9pRPh38FVNdjhw6uss8m39rqE+KhIofExgH0pTW3R2IqaNMmjPct8F
	 QBXvq3FK8NKjGuR9tQemjYVP/aAqzLElpD00tI/LGUGhI/bKOkd1cQrQVf5kjZ5Lp6
	 NtcFb2R0zDaob9RnSoJMcNxDqTCqx2GcxnlA+PA9DFq7/zsHxz7Zz5P2gFKshenPnW
	 yiLxGI2/7HzUg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCGWe-1poYjU3ycM-009t05; Sun, 26
 Mar 2023 10:15:43 +0200
Message-ID: <5b7921c9-ee5d-c372-b19b-2701bcf33148@web.de>
Date: Sun, 26 Mar 2023 10:15:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
To: Lorenzo Stoakes <lstoakes@gmail.com>, kernel-janitors@vger.kernel.org,
 linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
 linux-mm@kvack.org, Jay Kamat <jgkamat@fb.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Muchun Song <muchun.song@linux.dev>,
 Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt
 <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>,
 Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <c383bdca-6f0d-4a75-e788-e1920faa0a62@web.de>
 <fffcd98a-bb73-41cd-8545-0f2c55dd38f9@lucifer.local>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <fffcd98a-bb73-41cd-8545-0f2c55dd38f9@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CBS7TQ0coEyfU1zDX6UzZ2c/DSGRYUqAGUO/MwxFDUlXHAIwJTZ
 YGkX2BVXs1uGwMHGfSVafOqgELFusnWi4KQLjfJKPCBKxll66XQjb3G5CTAhoDplh5x8hvW
 /3yb/IyQorfWfb9jiRjhnFNzR5LJPsnt0QhZ48n3DCdP+WsOKGhuvrbq6EX0Q/R4knM3Wdh
 JrD8qnTmgTo/JpMJLF2nw==
UI-OutboundReport: notjunk:1;M01:P0:+RjmvXaqkvE=;SYhxCrqIkuIrPPvQxrSyYTbv/wH
 Ez4hZm2uNpSph3k+J0AxcSNpAeqPnccThwQLiIy1zyHKTwLB9i3E4LHC1cLYLdvPa/3zkxp4b
 8wEoFWDIAYDsHeBZSPbzjR33nS2IXV+kvz4F8ORPOWjAKRIVunwekmnjMHq9sLHzIV/GqZYzJ
 uCKcn6a9z+8r6wOAV8h+kLowO2OVGb1R1Xezbo+FjZyY2i5QgCVWZdi6My0JSszoRjnPx9ORG
 L2tZT4Yed293arWn4nsUoaPLd+WStPxH5gyp5Fn+5QPo+fQkRsuPHSvwW4wyRju46ezN3FNUM
 yXdRuj/nLN42M0f84hkU5uKd5iD8amHoysmAuk1eRBhR1Q6foGYdCPRPHLMpE9BCWeWlksDKb
 LlY5Vaasp6KjEp4xNwtQCgOTIMgIgfCweFupddWR0JR4ARBOp/E/wvcO1YQ6h+sUohEPj+WzS
 SmGwdzlBnCHcufxPCFde3EOADnNSLg1X+4jtv3iE8AumpCNW4j8+pxHNsUbc1kbIg+kJIgP8k
 K/B9kuvRSYbKOyK5wMJ7qfluogrN81niDtrry6+Rin95pxs6BTjEll6tl1iCHx/FYjWyvqlY5
 DUFQcyaY01ZpmxJcCczIp1ozP0utZKtYfuzfwEjWo2RoKcaZ3hZHw00plXJcPT8/RZMTSh5qx
 NxjDDfVxn/LSbe5gINEcQPM6LbW92qjF03N5Ej5iXjAqZ8/VuCwQ6h2vzntwONISHBQUzMqJZ
 u0hC6A9HHR/ppFlnMHmLmclxCaKVystMU0gnwJk7t0HZywdN+O1c6435hdNkfaiPjRUeRWm30
 eHt/9jDH4+hru0yr5Dx0W8t1JqJ4gg5eRSLowvG9OnLn+vCGWc+RjEk65pbV4JqH6IFV2G1Tm
 wry33gAq788wgld7i8e0/EWhSkFJRv2CgdSysM17hMbwSN2HZ8ZiimXC1
Subject: Re: [cocci] [PATCH] selftests: cgroup: Fix exception handling in
 test_memcg_oom_group_score_events()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 959
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/5b7921c9-ee5d-c372-b19b-2701bcf33148%40web.de>

>> The label =E2=80=9Ccleanup=E2=80=9D was used to jump to another pointer=
 check despite of
>> the detail in the implementation of the function
>> =E2=80=9Ctest_memcg_oom_group_score_events=E2=80=9D that it was determi=
ned already
>> that a corresponding variable contained a null pointer.
>
> This is poorly writte and confusing.

A special source code combination was detected.


Reconsidering repeated pointer checks with SmPL
https://lore.kernel.org/cocci/f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00017.html



> Something like 'avoid unnecessary null check/cg_destroy() invocation'
> would be far clearer.

I (or another interested contributor) can integrate such information into
a subsequent patch if the change acceptance will grow accordingly.


>> 1. Thus return directly after a call of the function =E2=80=9Ccg_name=
=E2=80=9D failed.
>
> This feels superfluious.

Under which circumstances would you care more for the advice
=E2=80=9CIf there is no cleanup needed then just return directly.=E2=80=9D
from the section =E2=80=9CCentralized exiting of functions=E2=80=9D?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.3-rc3#n532


>> 2. Use an additional label.
>
> This also feels superfluious.

The marking of special source code positions is probably required for
the presented design goal.


>> 3. Delete a questionable check.
>
> This seems superfluois and frankly, rude. It's not questionable,

Can you find the combination of code fragments like =E2=80=9Cif (!memcg)=
=E2=80=9D
and =E2=80=9Cif (memcg)=E2=80=9D suspicious?


> it's readable, you should try to avoid language like 'questionable' when=
 the
> purpose of the check is obvious.

I tend to prefer an other known design variant at this place.


>> This issue was detected by using the Coccinelle software.
>>
>> Fixes: a987785dcd6c8ae2915460582aebd6481c81eb67 ("Add tests for memory.=
oom.group")
>
> Fixes what in the what now?

1. Check repetition (which can be undesirable)

2. Can a cg_destroy() call ever work as expected if a cg_create() call fai=
led?


>> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
>> @@ -1242,12 +1242,11 @@ static int test_memcg_oom_group_score_events(co=
nst char *root)
>>  	int safe_pid;
>>
>>  	memcg =3D cg_name(root, "memcg_test_0");
>> -
>>  	if (!memcg)
>> -		goto cleanup;
>> +		return ret;
>>
>>  	if (cg_create(memcg))
>> -		goto cleanup;
>> +		goto free_cg;
>>
>>  	if (cg_write(memcg, "memory.max", "50M"))
>>  		goto cleanup;
>> @@ -1275,8 +1274,8 @@ static int test_memcg_oom_group_score_events(cons=
t char *root)
>>  	ret =3D KSFT_PASS;
>>
>>  cleanup:
>> -	if (memcg)
>> -		cg_destroy(memcg);
>> +	cg_destroy(memcg);
>> +free_cg:
>>  	free(memcg);
>>
>>  	return ret;
>> --
=E2=80=A6
> I dislike this patch, it adds complexity for no discernible purpose and
> actively makes the code _less_ readable and in a self-test of all places=
 (!)

It seems that there is a conflict to resolve also according to another
information source.
https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+go=
to+chain+when+leaving+a+function+on+error+when+using+and+releasing+resourc=
es#MEM12C.Considerusingagotochainwhenleavingafunctiononerrorwhenusingandre=
leasingresources-CompliantSolution%28POSIX,GotoChain%29


Regards,
Markus
