Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BADC6FD18
	for <cocci@archiver.kernel.org>; Tue, 28 Mar 2023 18:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=e0F6LO1z0788AxBtQVIKOhVwXOLXoMVXfzwpHbQp2vw=;
  b=U656ff5BuXBy+hWNPPvoytEzoSH7XKLJhxMktUNKBQ0BLvojW/pmuTt+
   YawDp8JWfFjzXZ7kXIxPic4rywKdQn2peUXUiflv3xlpV8uG1I3zTDLqo
   tiXk+gk9oHeffKZkk1PPkYaPf/Dc8gt7f+Nac81LmbfncYQuplMMNsa2u
   o=;
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
X-IronPort-AV: E=Sophos;i="5.98,297,1673910000"; 
   d="scan'208";a="99582201"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Mar 2023 20:46:42 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 50D55E0D44; Tue, 28 Mar 2023 20:46:42 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 21C86E0D40
	for <cocci@sympa.inria.fr>; Tue, 28 Mar 2023 20:46:38 +0200 (CEST)
IronPort-SDR: 6423360d_eXBIXlFSHSsRvMgP+LWTzzyNp5tXi771HxaN/DjRLduAeWm
 GP9yE6y/vJa5me6cMTtDdnJg5MnEw/DmNS4ngag==
X-IPAS-Result: =?us-ascii?q?A0FCAAAjNSNkhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYItgUsvBAtGhFORATGEL4cshzqIaYFWFIEsPg8BAwENQQECBAEBA?=
 =?us-ascii?q?wQ4hEYChTkCHQcBBDIHDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEA?=
 =?us-ascii?q?QECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBARICR1M9AwMjHQEBESYBDx8GAhEVAgJXBgEMCAEBgnqCKAEDMQevGoEyg?=
 =?us-ascii?q?QGCCAEBBoJjmScfLCJTgV4JgRQtAY0EhDAnD4FVRIE8g0GDfYEGgxmCZ4Ipl?=
 =?us-ascii?q?xsKgTRzgSAOgT2BBAIJAhFrgRIIa4F8QAINZAsOcYFKAmRMgSAlBA4DGSsdQ?=
 =?us-ascii?q?AIBCzs6PzUGAwsgBlhrAgkjERMFAwsVKkcECDkGGzQRAggPEg8sRA5CNzQTB?=
 =?us-ascii?q?lwBKQsOEQNQgUcEgQ18CgYBJiSdU4EOlU6SQJ4ONAeCKIFVgVkMnwwGEy6Da?=
 =?us-ascii?q?gESkwsOBpIjLoctkA8ggi6lTIFqATKBXDMaJIM2TwMZD44gGYQMjwkBPj80O?=
 =?us-ascii?q?wIHCwEBAwmFRgEBhXsBAQ?=
IronPort-PHdr: A9a23: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
 lf/owg3nLycUd1wbnpIBuM5
IronPort-Data: A9a23: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
 R/yN5Ew0tWMLklVeNsu
IronPort-HdrOrdr: A9a23:9mT80q8ARjNlguDRxehuk+AMI+orL9Y04lQ7vn2ZhyYlFfBw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNWftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObOEYZmIbsS+V2njcL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,297,1673910000"; 
   d="scan'208";a="51520645"
X-MGA-submission: =?us-ascii?q?MDENEDmkdyzYknBIR3IPtujmcvYmaycOWgatay?=
 =?us-ascii?q?zr1uk1k7Bq8ZHPvkTpjM+eG8/srIPfZZK6oWIDzZaIJyThuX4FKfnRD8?=
 =?us-ascii?q?tpRiUNp9lnXE2syKikeb1unwYOHQeweTvCi+VBmvhrbKiqP20G0BKTjE?=
 =?us-ascii?q?spwNzerpz1C1mQ+/BKqOZrCw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 20:46:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680029142; i=markus.elfring@web.de;
	bh=fltazK4Bhjl94xYORWNKgJwnzVXJt8yHobRipDcgqcQ=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=uaz29TUTzuihAEAcI0t5eoZvq/J1HpvrPqtk0yjFlRl1J4vuQ+uA1Ty5/w7wtsMqs
	 nE+K7yu1z0IETFN4hVTgSJvlX3pl2QpZIJRRECAb8BlkKu/3HzZj6McunX5uf8HXKw
	 zysLjxrcNrzyRfbQidoJznwhTpSK5kD/qkGGiAzAniZanRH1zm4ca7RmV5qge7KJ0y
	 xxAU/F1eBFMOW5H3oZ+F4p/lesOZ8VdGJl8r8fZGe9QxsqKcKC0IwlmarBZSRkFmvA
	 +lR3WkXTFupmpy8+6n+1BZChfnNwPT4iZk/pChaBf6QZ77erceTS1kysOdwr5dKn+b
	 SC+z3XW985hKw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQxnv-1q3YGH135T-00O1Mp; Tue, 28
 Mar 2023 20:45:42 +0200
Message-ID: <d9c673f9-2c32-282f-f261-b4d5762409bb@web.de>
Date: Tue, 28 Mar 2023 20:45:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
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
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UDCzDl05fy7qOWiDzXj29TH7KXagPnyP5783q+ggPg+YgBQBP9B
 Q8rhiPd3E55uFSLKHiZbaw06tBGldpOy41jKM2m80bGmULcm567uFFS+yVGFWrGkeHPWjAw
 Thj9FD1tYss2oFOeFu4G/U0tm7mSVbird03AogEutoJ+4AImdO5ZU0J36vGApN/VRYY8y47
 OUeyJvzd6vN0ceUS0JhLQ==
UI-OutboundReport: notjunk:1;M01:P0:CwQP95vxzhY=;PwYYWLq8le7b9j2YS10v/bKvDBM
 Rw/SHX0pYew8GL30TL6iSM7XVw3D44CVfbmlNWz4104Yx4kzr/etbNsdJWpWh80bFd3yxX11D
 5dxc01SKzF4o7E14rW6+XPqgBXuxDKec9ofC74mIbZTSWnAgarGmOBbFn8HZzPZI5SrUETcIs
 tmmySwMxp9xE+Zf/5srsFOL0h5IhiU2i55IJ6CO6jypuSQBKXQpHcZq+TUzVXO8vSSjzZhFFE
 9LbNVEJ6UeJOM0++HP/tG7J49SFjrtznJXOyDAS4uU0tTL4FiUctIfhZ1NFYtsQ7d+VHgmFNj
 YDkCXblwQzVqudnspqbz5xRSTqPTsvlKynjMEL53u8XtUr68uDMRYA7YvKPJvBA12yGrockL6
 ccbwVPUUUa2RQ2JxQjOQZwxsoDJOifpi/YmpXQJKIb8peIXNB2SHZKW2uEAA6Wsl9fpISHlxh
 QCJH5G1E9J3HYahL6Gij2bUzDsLP479bx1zdekJwEmdcpiJwVOOkWcJM2+jKS1UoAoWJkgbd6
 1BsvV2/lzLcyBj1V2IiffRLvdGCuZe4Hx8rAtjguwG4wHLbOcj1iO5sn3p1xjvfXevTlDb3hu
 oTkpvDdJsVBFZjNjp1FqBa4qVQ2GQSb0xzGjs3j+1h/KtifBi+OwZan7POAredoRoK7El7+E3
 iqcnYdiQXuS6yI+CrqMjmeHGQnGoHRLqnlusBDFaCZoxDsOe3181UHUL7Nc3mIoW2/gloe3nR
 BkMbasHMKqGAsST31ayoQ5RSNJ2h5Dev+e0u6thExS4rWmiMJbL8lHWNcRJFZ3gxgVfJCKGPl
 hxf4G3oomH9hjzR/NjVF7K75oSKBiXERvyJED1xSUHBT2jE7AxEnBscecDaJkpTh3pLUC+H12
 Y0G2PA+aVTOEvEFyUlgvwXKqn9Ug5rI/KCS8OIK/zTM0IMY43+fh878To
Subject: [cocci] [PATCH 0/2] perf/x86/intel/pt: Adjustments for
 pt_pmu_hw_init()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 974
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/d9c673f9-2c32-282f-f261-b4d5762409bb%40web.de>

Date: Tue, 28 Mar 2023 20:34:32 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Use -ENOMEM directly for a return statement
  Return directly after a failed kzalloc()

 arch/x86/events/intel/pt.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

=2D-
2.40.0

