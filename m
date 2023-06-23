Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7626BEB64D7
	for <cocci@archiver.kernel.org>; Fri, 23 Jun 2023 08:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+3dEuLuV+yukPikET7GipYrfcbWz5JctS6PpDi8sjIs=;
  b=dtLiQWC2kO8ztdW4HwVJ8ZjrS/FdPl/Rq7Q2IPlv6gPSQHp/o2Jciw9l
   W70yg9xh1krr4ixKeKfeHFFFj2PMpPeG0SzwgWMWEVTSgeW4dvyJ/DRi5
   h4lYL26ZEgUbdgl8806fh0BEf8EH70fRW6XCEV5wf3xSwld7e2VGdKWK/
   U=;
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
X-IronPort-AV: E=Sophos;i="6.01,151,1684792800"; 
   d="scan'208";a="114326909"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Jun 2023 10:31:19 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E41DEE0A8D; Fri, 23 Jun 2023 10:31:18 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3BB4FE03AB
	for <cocci@sympa.inria.fr>; Fri, 23 Jun 2023 10:31:16 +0200 (CEST)
IronPort-SDR: 64955853_0HIxMQYd9M1vyGjwrnSPi+mIXFoIIm6iElK0wEWTEPeZjA8
 MVfr2jIpP+zETvCh3AG9WVhn9P7N+3Szq+mxc8Q==
X-IPAS-Result: =?us-ascii?q?A0EKAQCdV5Vkhw4P49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YIyeFMwBAtHhFKIHYkHMYQ2hzKHRYhsgVaBQD4PAQMBDUEBAgQBAQMEgUsBg?=
 =?us-ascii?q?zMChgYCHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQA?=
 =?us-ascii?q?QEBIxcHDhAnhWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICR?=
 =?us-ascii?q?z8BAgIBIx0BAREmAQQLCxoCJgICVwYBDAgBAYJ6gigBAw4jB61egTKBAYIIA?=
 =?us-ascii?q?QEGr1IfLCJVgV8JgRUtAY0whDMnD4FVRIE8gwQ+iB+CZ44nhWUHi3SBKG+BH?=
 =?us-ascii?q?oEgegIJAhFngQgIX4FyQAINVAsLY4EcUjoegSgCAhEnExQFTngbAwcDgQcQL?=
 =?us-ascii?q?wcELwkWCQYJGBgXJQZRBy0kCRMVQQSDWAqBDD8VDhGCWSICBzY/G1GCPyUED?=
 =?us-ascii?q?gMZKx1AAgELcD01BgMLHwZCAimBVzBWcAokJL1bAa4ENQeCMIFbgV0MnxwGE?=
 =?us-ascii?q?y+DbgGTJg4Gki+YGiCoGYFjOoFcMxokgzZPAxkPjiAZhA6PSD80OwIHAQoBA?=
 =?us-ascii?q?QMJhUYBAYYAAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 z3TFr0c8yVdGq1UeNs=
IronPort-HdrOrdr: A9a23:L4nfpaPheKVC58BcThWjsMiBIKoaSvp037Dk7TEXdfUnSL38qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhbX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YCT0EUMqyTMbEVt6bHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AJ1q722hLxZdd690i164F5QcPyTJuYmTR0Fb/fh6?=
 =?us-ascii?q?ELmtXTLmJSWCf9pN4qp87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AAZcj1AzPbg8qeilPLLzFSQKV5HWaqJqcVntUiMg?=
 =?us-ascii?q?qgdOBCw5+MHCQqx2Jf6Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,151,1684792800"; 
   d="scan'208";a="114326894"
X-MGA-submission: =?us-ascii?q?MDEcM8Qx56NFv8NHoMRZPaW0oE+CwVreMoOpor?=
 =?us-ascii?q?kS6LAqsjM8KvFnHORyktO7NRTvMRLHoAs2x3SdQCvAE7xfV04+Qi4ZJb?=
 =?us-ascii?q?Ks2EcPhNXUyG2xGi+C7lCJKlSByHsGeUMRN7MxK2uQyVXNBd22Ap9zgr?=
 =?us-ascii?q?dTEtw4Vvij+E5JDw6TObej7w=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 10:31:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687509030; x=1688113830; i=markus.elfring@web.de;
 bh=+3dEuLuV+yukPikET7GipYrfcbWz5JctS6PpDi8sjIs=;
 h=X-UI-Sender-Class:Date:To:References:Subject:From:Cc:In-Reply-To;
 b=qHOFE5t3TQXt5E79s57d8AmZ3SeFtD/pskj1bwkK9aBWJVBDQRcIl6gcf+wtrPntH0/Dqj2
 Q7EKQGlHGGaglCb4r4xJbVH6/zD4b7WpOt9SBmFUW6JwNxUxhXC/9QK1CHSCeJyDPPwzq1gil
 0T4iRp8sLqlM1/AKAIYgGXQFT0lqk53yLHnTqUFKDS3XdxRKlVQJU9HcCZMS0XmHCAyB8NLw1
 95X8IBQrGqsMlO2U5AMfSr0geFTSWewusVSyo2b4N/Y5NwNKS23Qii4ZgspYOjIqFkhDJ/wAC
 0z8rxWr5fNZzi2gFsJ4ywRYaPmMo7Zow3VwYinhHCwA5Tn3DQcew==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MWQyl-1qb21V1uyR-00Xp6w; Fri, 23
 Jun 2023 10:30:30 +0200
Message-ID: <570d788b-d7f3-64ab-97e1-4e847aef1321@web.de>
Date: Fri, 23 Jun 2023 10:30:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Ruiqi Gong <gongruiqi@huaweicloud.com>, linux-mm@kvack.org,
 linux-hardening@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20230616111843.3677378-1-gongruiqi@huaweicloud.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
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
In-Reply-To: <20230616111843.3677378-1-gongruiqi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:powE2d0TsJRrwoF7P7jAaPh8GM6C9xUZSkuiJj4nepDS7uI52w+
 aHFaIuz2P9w30W00k2n5MSnc+/UULttW/mI8UHyVcRK4bGjIDI1wFJpm5b9oVwAjv6p0EuT
 x4VOCW31js1KMZIvLbGdprse7n4LSvdQpxwH4pMeTDbVSDwv4c32LF9iCRB396QhAbDrKit
 2j47LY9EO7mFg7M/IKxlQ==
UI-OutboundReport: notjunk:1;M01:P0:jSPmdU1PPIw=;zPNJhKfDoobb6QxvdSbQqoZj/ue
 dpw8Sp2p3usDWTuoBjx26zE4Kdw8OZ9SelyQu7xTRDk+qcwtIn3ZidsZfwRCk5Gx9PFxBuRxV
 wl1HjjK/GDt0L5wCI1qmstTh4rqjQdn4Hu+sYywz7668d45rYqosDO9LKegRqy37TnsKmQ9zy
 0KnBnCIp0noTyoeA9emJfRU1zFL0PHqBBcUBr1oJLJazC77kPyg475qIpJlH2aFgRzx8VgGYZ
 kj/2zECdXQKf+KgNYhtrwZbH0lFfIJtWvz+/suvReGEgtJQuaa7NZgferiETtONShfVF+DM42
 X+6zmbY4R/44/gHvPxt/r+Q1a8IeQX06r7w+UoWIVXjhp/fY2/n93YwwgQF/AAPGRsKId60Sc
 UNM77AJwaxVhNUyqjk6xkkoLTPoBuKwSJJcdYVvhPQRjZL62614XMPTGn1LCJIXTelJatW1GQ
 LhnKHVZSlANWJU3XmlSOE9YOiT+Y2xDhsSuXvUCGvW6TZpXKuODkShAUCKkWKePI+8ZG71Rtb
 5N7D+gU9EX1KSylk/tBGd2Eu9lLo0TDYQYZBth4zRSw9+jiBJQzmQM51d55nOnuA5+s33rdZG
 CEcj/tmt8EPpSjtRVbzkXkgDFl50z95TOI9zISfWgysF42mfi0gNuFmXd2rA4zMk6OqZFT5cB
 rbZcgoYTg7lyLD8CgD2gGaeFqzj75oF0kDoHzfm/KGSNqyw7qNLGOJgiraqummO8Wjd1E+A3U
 93szA+7bizitgpAZTP5E8iGvJ+jxP7KATnJyxVoovQGoSzl4eev4bk3n4U+OvEDNekYntogPx
 rQ6juJRgvfbymUmcSxA+TCHgGntR6G63iQIuXF4f5wGuGLR1wKsIX+3RZJq9E5xNg5tCa3A7p
 E7ay6tvaOu9GBAbEQ+u7g6hD0cZA847jlEEXR+ci+8f5I7uoonrmREjvJG26JqJ58mCAiYKvt
 M69wWg==
Subject: Re: [cocci] [PATCH v3 0/1] Randomized slab caches for kmalloc()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1206
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/570d788b-d7f3-64ab-97e1-4e847aef1321%40web.de>

> I adapted the v2 patch to =E2=80=A6

I suggest to omit the cover letter for a single patch.

Will any patch series evolve for your proposed changes?

Regards,
Markus
