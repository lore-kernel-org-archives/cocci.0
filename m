Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764CEC6FD1D
	for <cocci@archiver.kernel.org>; Mon, 27 Mar 2023 17:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=89hYLekr6EKX+kqGKcGCE3UE7cZVKmfDTBcKCYixUHk=;
  b=RHvBs7Mdlu3rp7LUYzGxkMcWlkgu+aw9duktHKkbQog6JfVCOPD6z7lE
   Vw8UQsa5O6g+A0aJCKDbMPVGvSmx8lZ+sMwsaWjQHCHxsE/e73tqfwLD6
   1Y5ODwrURG2Q5py9GVJKypv3lW6dndyh5IfmEqZHpr3f4EuAqAnhFe+IS
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
X-IronPort-AV: E=Sophos;i="5.98,295,1673910000"; 
   d="scan'208";a="99378953"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Mar 2023 19:37:19 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9642BE0D41; Mon, 27 Mar 2023 19:37:19 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2E553E0D40
	for <cocci@sympa.inria.fr>; Mon, 27 Mar 2023 19:37:16 +0200 (CEST)
IronPort-SDR: 6421d44b_/KKqIeHTrxXykwgOxLP99q6U3VotLtMX3U7Eo7KMlDcrz/G
 0A3VykLd+u3zOw3iVoAOqL/MjW84BBhvMjeL6hg==
X-IPAS-Result: =?us-ascii?q?A0HHAACD0iFkhk7ASNlaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YItgUsvBAtGhFORATGEL4cshzqEZ4QCgxY+DwEDAQ1BAQIEAQEDBIR+AoU5A?=
 =?us-ascii?q?h0HAQQzBg4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEYC?=
 =?us-ascii?q?RkHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESAkdTP?=
 =?us-ascii?q?QECAgEjHQEBESYBBAsLGgImAgJXBgEMCAEBgnqCKAEDDiMHrmyBMoEBgggBA?=
 =?us-ascii?q?QacCh8sIlOBXgmBFC0BjQSDNnonD4FVRIE8DIJ3PoREg1iCZ4l4hBqLKQqBN?=
 =?us-ascii?q?HaBIA6BPYEEAgkCEWuBEghngXxAAg1jCw5vgUoCZEyBESUEDgMZKx1AAgELO?=
 =?us-ascii?q?zo/NQYDCyAGWGsCCSMREwUDCxUqRwQIOQYaNBECCA8SDwYmRA5CNzQTBlwBK?=
 =?us-ascii?q?QsOEQNPgUcEL1uBAQYBJiSeO5VEsGs0B4IogVWBWQyfDAYTLoNqAZMdDgaSI?=
 =?us-ascii?q?y6HLZAPIKd6gXkkgVwzGiSDNk8DGQ+OIBmEDI8JAT4/NDsCBwsBAQMJhUYBA?=
 =?us-ascii?q?YV7AQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 d0DgKbOyckwYNicTSjB3Q==
IronPort-HdrOrdr: A9a23:KbFkiaNxw2E/jMBcThWjsMiBIKoaSvp037Dk7TEVdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YFT0EUMr3N5DZB/KTHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,295,1673910000"; 
   d="scan'208";a="51405036"
X-MGA-submission: =?us-ascii?q?MDH8tObLDJQ4vaWxBWJUoh40TVXint/nNlWyEh?=
 =?us-ascii?q?sTr/4b7W4iEWaMXE4bfjPqvPIzCEABA2eWyqwKFX6HfuhkFcwGc4fkXs?=
 =?us-ascii?q?KH3YqmY0Bq8uRoHhDHFkB6HzBbkJ0Mw1GgdCADv2jPuZUmHXUPQNtRma?=
 =?us-ascii?q?h0W/IfyPCk1pAJyRsQVlq1DQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 19:37:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679938583; i=markus.elfring@web.de;
	bh=RNRjWYt/21meVFXg5H0JE5TZJFwLSu4rYoXGHdHNpqI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=e+xCAiso7sHACKQgPCdozEX9eYE3twijX/IAG/NqyHLzIujl9lgcHhjFYav14cAis
	 WxQWK610AY7VYe1S8Xue97zkYA77Kj4jhhKXS2v7PXHeZ9wsT4PBAkGX4/W0+dz3MO
	 AzOXsj6ruIRXhz8gyZ2mtXkOG7ZEvOLKLRfZsz4A68NpWEH4n8s+7ouU9b4Ww8Q31F
	 Lv1N6K/rIfAEeNl2TyihcrbDIPcL0dCmJCVwPMl7Y5mxYvxLKwzy6uf1aZYOvHlNRR
	 bZkkn3bfSxX6HY5DKiA6+svoGtzwpbZFQrirPZVK/IF6A+AQVfYCqJx/YgBL2YO4Ck
	 hj/bjTm0Y/ziA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXoYQ-1pxInC47Mi-00Y8s1; Mon, 27
 Mar 2023 19:36:23 +0200
Message-ID: <ecdcc089-2d29-6808-3685-674bf27ccecd@web.de>
Date: Mon, 27 Mar 2023 19:36:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
To: Adrian Hunter <adrian.hunter@intel.com>, kernel-janitors@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Sandipan Das <sandipan.das@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 Zhouyi Zhou <zhouzhouyi@gmail.com>, x86@kernel.org
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <ab860edf-79ca-2035-c5a3-d25be6fd9dac@web.de>
 <3a35fb28-5937-72f8-b2e8-b1d9899b5e43@web.de>
 <d691d740-c172-a5cb-e4f0-5bc5687c8464@intel.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d691d740-c172-a5cb-e4f0-5bc5687c8464@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1I+420tfFs402uGJZdubPhcuJQCNaLATESZ8//E5btwcP1o4BFb
 HDTtkmeiiYXLFwlnWYx98btdUIRKxBZj/cIuzo/I162fQah6TOdUMaqKBTT2ptZRCilPNKA
 bPutmDUx7BHUQFpxTljl2NHSJAC8e20Q71Rlt5TzkY5pab/Cd4Tgel/XJ2BsTgh14lOeOr/
 Oztx3a+pweIBe3vyCzZGA==
UI-OutboundReport: notjunk:1;M01:P0:HoO22d5nXSc=;ukwe7O4XUkAWIJdzAUTyw9Iel2M
 EEpk4ixVSbbW5ztBYHLPrzhzCZf9hjwvTJmbt1Pk88de8kX0F44JBxQi2bRYyAhWuYFVjPfuo
 AgUeFes23C/Is+sLK5zT2aT4R5PDtEklykve6MXFfiLfxiBj+CFrJGvAFqmW++t6pglUI13PR
 +hQ7z4P0th8eCb8wpxSy77HIcgk3SBwMYHt2UoDCUn/OVwy5AscCD6nSxT5MnV9rx2K4WZKTV
 paEQiS8GjtdMQ/7v4gYoCKKk5cy1mMsugUMPAIE7/AFxAqJaViBK0d3i/tohTBBQMwRMElSnV
 k686p72rWdZj7Q+mR7EGSNBkQdp0+ut9ZifGXXIJv4YuFSiN09IXPPW3pHsRB5MyObw8KikfB
 6dU4pxSveEj/xaLjsRYvGy78htGUpJcZ1ydZpILBeoIo14gM91u1M3TFiic0pqBua8ZGhgp6x
 eMWDTWEaRelpC+xCAOFKzLYvsVyyH91cc4MKr8401FDfsz7PuL2WTD3xwHqygdbdQmK9Lcfp7
 m0pGvDxGA9lL2l8IobtALLKPpYzkSgG2yS9C+4ZvM9jWAiwmo5lEj4IiQEUobhyzOB+mhWsxE
 jhUQvFMgN2zF0jf/jIW1iaCok7tRuPQ7vybtGUiA8ytRqv1HuWECS1zcw5X9txiVcfa7pYUNN
 7rkgXAOWJ/NT2k+U+QsrKfIlMa9yk8iG6lDgnkOZbudDmpABB+630I7FEEHer/BuLf8xZrQso
 iiBAnt8ahGjTFP2aKGKO7p/b9tK5++8n5TMBTnqCs/aFub9AJjixV8hSlqzaE3Ao12DUN/9Gh
 3H91cS5hsAooEvOPpT5ScANf9xaZip9cs6oq7l/lpODKqVsxDLpmRvhUmdMluTVgUfgDrjGmm
 D6Bzg3zcKxdmOWFTGHiGsVQu8m5ljESUHlJLT5kuTIdr+bKjuD+cuvJMV
Subject: Re: [cocci] perf/x86/amd/uncore: Fix exception handling in
 amd_uncore_cpu_up_prepare()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 966
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/ecdcc089-2d29-6808-3685-674bf27ccecd%40web.de>

> Redundant calls to kfree do not break anything.

Can such function calls influence computation resources in undesirable way=
s?


> Also avoid using the term "exception" since, in x86, exceptions are
> hardware events.  Better to just call it "error handling".

Will another bit of fine-tuning become helpful for the affected function i=
mplementation?

Regards,
Markus
