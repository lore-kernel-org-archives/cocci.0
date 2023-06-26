Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C36FEB64D7
	for <cocci@archiver.kernel.org>; Mon, 26 Jun 2023 09:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qKlWiUAmFcUUA7xY+aphInCTwMYf7FGUQlfaFB++1l8=;
  b=joBYUdB7RcxqjSvYElPTt3duqTzPQP7vRfPMzVJJVHZdJd+rTrCZeO2x
   t5YPCU9fOung6G0FbilLP8jLibvsfd7vOzijLxA7Lc7G4BWI7+tq43EMi
   piKpzrkN47I4yb9vaY1FuOZsrSwct+Afg60WV+Iuu5sFu4y95wKVmDPjd
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
X-IronPort-AV: E=Sophos;i="6.01,159,1684792800"; 
   d="scan'208";a="114635545"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Jun 2023 11:19:45 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EF261E03AD; Mon, 26 Jun 2023 11:19:44 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id ADB8EE0157
	for <cocci@sympa.inria.fr>; Mon, 26 Jun 2023 11:19:39 +0200 (CEST)
IronPort-SDR: 6499582b_5bp6RrVDIYRc45xwpV94YzOGBTbwLC/00Sd+wEL4nP73JRX
 9NxE0gwmZcBhrsH6K3D4fJpIPW3Iz4B9+GNuVTw==
X-IPAS-Result: =?us-ascii?q?A0FeAADqVplkhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIydQNTMAQLRwOET4gdiQgxhDaOeIhsgVaBQD4PAQMBDT0EAQIEA?=
 =?us-ascii?q?QEDBIQ5PAoChgYCHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBA?=
 =?us-ascii?q?gQFAQIQAQEBIxcHDhAnhWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBARICDTo/AQICASMdAQERJgEECwsaAiYCAlcGAQwIAQGCegGCJwEDDiMHD?=
 =?us-ascii?q?a9sgTKBAYIIAQEGr1MfLCJVgV8DBoEVLQGNNYM7eicPgVVEgTyDBD6CSxcEG?=
 =?us-ascii?q?IUhgmeLJw4MgmeDNIIvAwSMG4Eob4EegSB6AgkCEWeBCAhfgXFAAg1UCwtjg?=
 =?us-ascii?q?RxSOh6BKAICEScTFAVOeBsDBwOBBRAvBwQyCRYJBgkYGBclBlEHLSQJExVBB?=
 =?us-ascii?q?INYCoEMPxUOEYJZIgIHNj8bUYJtCRcOKgQOAxkrHUACAQtwPTUGAwsfBkICK?=
 =?us-ascii?q?YFXMFZ0JCSgcAOCMmwGgTUGgU2XAAGNLqBdNQeCMIFbgV0MihOVCQYTL4Nuk?=
 =?us-ascii?q?ycOBpIvmB8gjTyaXoFjOoFcMxokgzZPAxkPjiAZhA6EYYpnPzQCAQELLAIHC?=
 =?us-ascii?q?wEBAwmFRgEBhgABAQ?=
IronPort-PHdr: A9a23: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
 YZIVbJRElA4RKty4qFNA9EIZpt6DGtMrA==
IronPort-Data: A9a23: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
 OzyIkHNAyU=
IronPort-HdrOrdr: A9a23:MtM2QKO2l3VvQ8BcThWjsMiBIKoaSvp037Dk7TESdfUnSL39qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YET0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:D+AWLGN6E/62Ze5DZjQ7y2g+F50fIyeH9E70PkyqGEBIV+jA
X-Talos-MUID: 9a23:frPBtQilyHzb+p4g5OJkrsMpGe1tu7iDMVg3uogcmIqED3FdKQ2mpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,159,1684792800"; 
   d="scan'208";a="114635528"
X-MGA-submission: =?us-ascii?q?MDG3S3rT17orOpMrxIYQK30xG5Lo3nPh62+Kcx?=
 =?us-ascii?q?8c4luAPMcHtUdm1U0fIdQjSAZ2W/Hfy4fCST63W6wuJ8IRGGKpGUb6Do?=
 =?us-ascii?q?WCIN4gJrQ87PTabS/09Z49tdLc2Z7x4iVfjA3bbKCf/Dr5pkl9nsllYL?=
 =?us-ascii?q?EbmIRCItE+5LrVxgNyenzolA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 11:19:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687771135; x=1688375935; i=markus.elfring@web.de;
 bh=qKlWiUAmFcUUA7xY+aphInCTwMYf7FGUQlfaFB++1l8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=LNoFr01va8XQ8k0BcmEZM/Brc31bbW7ykpSpEMvO1KVuR+lkd5Hi2kSNyEWY6Lb6B2MHOjT
 VydHpjmQJAPqDZYprBwYwv2CfaGC+eWgsTW9imoVXI+AammtxXI2I3dSIOKr7T1QxBl9t4ssp
 rk4tNU0TXh/Lc1JOFx8333LrB10pgbV5h1EhkPZLADkCg2SBi2TdjOGC6w0r5GnQngNDdIwCL
 cGOGM9hstXR/MUkoJC1dA9DdyAb/7ueMLHABvo15TW4+eXrDJOFgOTOo5UwPtdlCX6dAcFvNz
 RdTGjS2qsejqyKvNr29MflPoxjK+3wc4GgFZVIlWub2ZYzt5msZQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUUAG-1qe4uU3ZnE-00QdUJ; Mon, 26
 Jun 2023 11:18:54 +0200
Message-ID: <5735e010-98c9-de06-4d99-63ff1c6a5bea@web.de>
Date: Mon, 26 Jun 2023 11:18:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Ruiqi Gong <gongruiqi@huaweicloud.com>, linux-mm@kvack.org,
 linux-hardening@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexander Potapenko <glider@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 David Rientjes <rientjes@google.com>, Dennis Zhou <dennis@kernel.org>,
 Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Kees Cook <keescook@chromium.org>,
 Marco Elver <elver@google.com>, Paul Moore <paul@paul-moore.com>,
 Pedro Falcato <pedro.falcato@gmail.com>, Pekka Enberg <penberg@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 "Serge E . Hallyn" <serge@hallyn.com>, Tejun Heo <tj@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>, Wang Weiyang <wangweiyang2@huawei.com>,
 Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20230616111843.3677378-1-gongruiqi@huaweicloud.com>
 <570d788b-d7f3-64ab-97e1-4e847aef1321@web.de>
 <71bd6de4-2cde-54eb-5720-3665d421d8ea@huaweicloud.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <71bd6de4-2cde-54eb-5720-3665d421d8ea@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/ASPfAw179hxaunNTLFOAuNGGninSd3XmqiQFing7sNd7c7IEEJ
 2WHuZ0F6NnSTYTmjX/gcCLSjbR1Utzvya6BDeHO9DuilsyfC036LanTupeZMoXiMMtABdjY
 gfDdsN7yGtdH0wgd106q3N/fTOSjh2YV1yBh1Y7GGV8IBwE0cmubrJaLAv6hE57rUVivDAm
 3uQz0mvfzmHWYltrQojZg==
UI-OutboundReport: notjunk:1;M01:P0:GdbTE3IufF8=;XL3BjFrJ3GfReZu+7Ccx5o0VXmg
 nfGjH2k6uwEq+l9LnrJvmLglX5C2xZn9TH86zKwCscbZJJ9hrxahbCecQO+kpMfJM4i+oQEC3
 Cx5DvNjD4YJNr6BAYGycAd2KUlP/fr/DfVsoJbGBbDKe2T3kSFNV61XlS0e6cocUAUhJsSS44
 V+TICELguzuXp3/7NAZf6X/tiBaLxzC2BTspPrVnvNgnJwwu0javMw63FMP3fIStfEMVeeOqX
 4IPwr3mBLEe0kUBC7l1ZFVuBap1YdovfV5a2KxLAShSgxRVopnqYqI5PeLZyx+Cj5Gi5gX19q
 pNPR/PFs17rlJYGvWNcAmp8DbYwy6IXjI2aPV7fGrJ853TM7JcmIpY5Bg2a/HsKi2ISzlyMrp
 Fkmbd+jsTJ9eoXgh9q8DK/oiNOcjmQI+cm4q9X3JIOgCbckij6OYhOPw98i+ujHYwqakybHEV
 1oRTKFIkE/O+MAtLKIzOgU6vO6DXfko4LkYYXxjZSxjFPdJEEoebEx7Bf6EhpblDMFIruSSO1
 70mZpjwRZcvPfXF8msd25HihwjY7eSpTuefWuJNa+HE+BuPQ2fcruEtYax6iFMdbcN/S6BZ/H
 qrW/OsQnVvsm3gFz3qJKol32jNjRpS5vbPFTW/LBbNQfJyinMhlD2kBwwROR5cuwZFsE/P64M
 /8lYwfkuHyoG9peRCAq8nKLFujNI/Jwi1opZ7C4V/PteoNNieV8UnzdfsDYfY8j4qcg9p9QLV
 XA7Bnbvi8X8r0FMiSwIf+kjRPyHZgdCGfRf8AAprfznoTUtAT9UOyhCPclzSk7tS80gzV4fpQ
 wWZ4cnzxjxz3R4Vmf0oLP8XvwCJDQsrrMyFbCJF0GfvmVYSY5SkHGodc3Y4JcKMIFGiKTUBoS
 xsruijsqL3JY+QzxfT1eX9wrYsjBuA0kEDr1Rcn8DsbQNvQ0yYQaJExAeLqZej+roAs6J+oX8
 Tl3s6Q==
Subject: Re: [cocci] [v3 0/1] Randomized slab caches for kmalloc()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1212
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/5735e010-98c9-de06-4d99-63ff1c6a5bea%40web.de>

> Usually I wouldn't made a cover letter for a single patch,

I find such feedback interesting.


> while this case is an exception because I need a place to hold the additional
> explanation about its transformation from RFC patch to formal patch.

Are you aware that further information can be put below triple dashes
(or even into improved change descriptions)?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.4#n686

Regards,
Markus
