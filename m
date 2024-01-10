Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AAFC4707B
	for <cocci@archiver.kernel.org>; Wed, 10 Jan 2024 11:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9IllZSxfgAYvOU7oTW4s+eyPTnJwVlhq5GY+tHFx9Eo=;
  b=pQQloOH/adBkQHCRfCkN2HQSEG2+DGBXwbkYYNZFUnY3Qc9b72Nb0/a9
   y02G31K6AYLWR0bV7enPw++cum1SIEuQdKHrBgQB3RxXfrtqHxqkLlDf2
   JJ2OOWJZM8HUnTWULSsIOOOeEE3XxUOtKhzV26DXN4Fr4JTkwQ9PcSkyF
   0=;
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
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="145858587"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jan 2024 12:46:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E56B9E004E; Wed, 10 Jan 2024 12:46:04 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B2738E004E
	for <cocci@sympa.inria.fr>; Wed, 10 Jan 2024 12:46:03 +0100 (CET)
IronPort-SDR: 659e837a_tLjKMppkNLghIMVn/0ci2ieuwmncPHtwp24bcXB0NZtPrdv
 dlDqTvS7seTX3NTqsU2VREh+p9F6UX8MxUA8iwQ==
X-IPAS-Result: =?us-ascii?q?A0EeAADlgZ5le07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4fFYyBAtIhFOIHYkZLQOEO48BiG+BVhSBLD4PAQMBDTsGAQIEA?=
 =?us-ascii?q?QEDAwE4hEcChz0CHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQEkGAYOECeFbA2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAg06QgECAgEjHQEBESYBBAsLFAYCERUCA?=
 =?us-ascii?q?lYGARICAQGCfAGCKgEDDiMHDQa2AYEygQGCCgEBBoFFAgwCQ06sch8sIlaBY?=
 =?us-ascii?q?AMGgRouAYgaAYVng0F6Jw+BVUSBPIMDPoJhA4EYgQaDHIJoghqDQoochgZSf?=
 =?us-ascii?q?x0DgQUEXA8bDx43ERATDQMIbh0CMTwDBQMEMgocCyEFVQNABkkLAwIaBQMDB?=
 =?us-ascii?q?IEwBQ0aAhAaBgwmAwMSSQIQFAM7AwMGAwoxAzBVQgxQA2UfMgk8CwQMGgIbH?=
 =?us-ascii?q?g0nIwIsQgMRBRACFgMkFgQ0EQkLJgMqBjgCEgwGBgldJgcPCQQlAwgEAyspA?=
 =?us-ascii?q?yN0EQMECgMUBwsHe4EXAxkrHUACAQttPTUGAwsbBj0ClSoBgjqBDioCghOTK?=
 =?us-ascii?q?ZMdnnI0B4I0gWCBYQyKGJUTBhMvg24TkyUOBpJULodQkE8ggjGJI4F2mnyBY?=
 =?us-ascii?q?zqBXDMaJIM2TwMZD44ghCuBC4NWiigBPUA1AjkCBwsBAQMJhUYBAYNagUYBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:klk/EaACbmeC5pDlHemV55DYdb4zR+YMi2TDtnoBMCC9F/bzqy
 nApoV/6faZskdyZJhko6HiBEDiexLhHPxOkO0s1N6ZNWGMhILrFuFfBODZslrd8kPFh4hgPG
 RbH5SWyuecMbG3t6nHCcCDfeod/A==
X-Talos-CUID: 9a23:LKkXo2NGLlhlCe5DWQZIs24yIoMcb0aF6S/7GUaEVlo1R+jA
X-Talos-MUID: 9a23:b8oMZAjVLce+KXBDT6txcsMpCJtEuJ6nIm40qb4L6uugGXxyGmi8g2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="76370701"
X-MGA-submission: =?us-ascii?q?MDHK8E5hNF72LAOzsdraUAMLd93dgY5wtZvoQ7?=
 =?us-ascii?q?bM3dE+v+FpT0xdXY5fpoi6+04ZivxD14GrJAzxsYOhQre0c98JVu+T/b?=
 =?us-ascii?q?fdpDDF7pthamFLiMmjux2gDztiDKMnuyqQe5FTklID3Lx3dQ0rpNZSAw?=
 =?us-ascii?q?kg9TQpn7jdpokGARVqt29zCw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 12:46:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704887119; x=1705491919; i=markus.elfring@web.de;
	bh=nO4zB4EcAAo5LoPaa+ofqegpVkTeHLcDqcmcZocT6mE=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=u3oXSrGqMkqB+Fz860SVm583IZDXAo82TtA0+q3MKm1sp7Mpsy9OFLh8bwjc+rdU
	 vUHT7wYN/O+gZVn0C4ndzUf7VLdiM/Ix6VM9O5H9juPlV+oKS4unydvUvtMaj1b9U
	 ZfF1tVzlhYCdvpAefQTkDBunWeu8mwX59g2tlURm8c0NC4qI+8uQ6bCZNP+vBIRSs
	 1prbm19eGB4HkxhOl2oYlVtIcg57OZVeLLaOJiot544mB0HxiyPoSeoOBcHcoNLgr
	 5E4zTa5pUaUxL7N7r+oHTEWK2EbQBemOWcJePTYZCRktkGiCAxCHig+NfPCJbOOtS
	 mskQwOQuFBtMhTFz9g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0Zo6-1r0O0B1QA8-00wcIt; Wed, 10
 Jan 2024 12:45:19 +0100
Message-ID: <30a0618f-e115-47a5-89a9-3806c75e604d@web.de>
Date: Wed, 10 Jan 2024 12:45:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <d9c673f9-2c32-282f-f261-b4d5762409bb@web.de>
In-Reply-To: <d9c673f9-2c32-282f-f261-b4d5762409bb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9BlZaD60AkKnVzOB54qG8EG/JliLvKzC6Ve1nFkUHR+QCcwGiDZ
 zcVrGWtqV2ap3b9QBhbk+w+quJBKOx/wP73RnVZ6RfU+Ezt/KQWnTJSlEBG6pU6qMXBEQIW
 FAcN1pdTlCdE7AzUOjIBFh18XJU2FlI5M4YXR8Cv/sY5o8VIsW/kyr3L+hmTX3YQw2tpyYK
 aQtS0ZIZxbLHWlJGvquTQ==
UI-OutboundReport: notjunk:1;M01:P0:O9VFBO7l3do=;GBZDJI70NujW61S/P9XwBCmdHbu
 2bRvmHWf0e0fDratRYKhLsLtTYSwpU8BmXRn7aw9ZbqFEbU2YwOmeOhPyrKoo7tf1gyCrQiDz
 Q2+mFaqsWflYmyAh6qx6hCr6OIfphmokWLPTgYXBrTUqQLzYzw0EgUjlJ2Wtn4EgjvmoI5xBI
 +S/PzvsvyfgTgWBI54KZjd+njBhKy4PQzM2vYwPq3fD9oCcCidLJxLB0PTOk0SfLU6dXQJHjw
 mTtWuyB6fUTUByJsWKLyNkJwOA+HfQuESpeBk6gcrH0pX3CosBYsWrRYOsqjd4y/kELaf/u1A
 nk1IXegYvWcEWxwIzJ2UeBJ1AUB4t/KE6W5B0DbWaq+A/NHcfTRzSJdsS0kR0XZC7h4Xc/fhe
 8pwLnE6JwIRNMHaoACPvntPUSOa+x9pavCXASzqy/+1qsJqPvCG6fB74MaOh3+XNSXlRQxehK
 CQgmrrkMHRrrjdzgeBsbEbh+bqtk7FMRrbGsyR+QXz3JiaK0i/XECay8dFA07eFiR6byODpAq
 orrleJmZw0NuVd7qXdKKgseNzZASQn9RDTfehn2DNbvzcYij+W2KykM8vBAW0J/wdxYGF7iUE
 mkdpmWQwQkNyDzO1/SQ8EAjauyDABOOpqXYPHWMPnkgG0NgCtlt1S5fWWXYYlRIN6VLe5mtQ3
 XTQzWNEadVSJ496aZg51Spho7CA6zSocsD7P5LVCYG9uorJ2sKvnzoZ71aXJMLadEq52c7CHS
 7GhN8wJcuGFAVmcgsh6ZZ/t+L6UvF09EDZxKyVoF2YnQ5yaqeljXtzpO8+Cojr//G6kZtv+Ec
 e82DgdtpvjdPolEK7jZP74n27r8S2BVZgCEzHZiju7xBDxU2H8WVPoXhWOmLcV5+8t02DPM83
 KnETeZdLHyJ9CJvgOhaSZ5msYOYy+0w5eNsEP13uYFW+SkxSxx97++UMAlvmo09eRvrwXCh0G
 WjMMnqAB7iy8HCHBUAbT/pEiFNc=
Subject: Re: [cocci] [PATCH 0/2] perf/x86/intel/pt: Adjustments for
 pt_pmu_hw_init()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1446
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/30a0618f-e115-47a5-89a9-3806c75e604d%40web.de>

> Date: Tue, 28 Mar 2023 20:34:32 +0200
>
> A few update suggestions were taken into account
> from static source code analysis.
>
> Markus Elfring (2):
>   Use -ENOMEM directly for a return statement
>   Return directly after a failed kzalloc()
>
>  arch/x86/events/intel/pt.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Is this patch series still in review queues?

See also:
https://lore.kernel.org/cocci/d9c673f9-2c32-282f-f261-b4d5762409bb@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00101.html

Regards,
Markus
