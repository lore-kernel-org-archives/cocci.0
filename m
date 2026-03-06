Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA97EF51419
	for <cocci@archiver.kernel.org>; Fri,  6 Mar 2026 07:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=BixBb8N7VtDhDb7MaweYW8ogQVgyibOtJ6r2yxqVKCg=;
  b=SmnitGPbR315fv0cNx4dLCHo7rPR1Zu9xlhr7x8ERgFtyjxw2TnQcmrt
   adsV5Dut80shiEDDRS0cGDziXOpyU5Muj8zp9ctUoe+NeB+KtuF/eBRBI
   EIFzEkAr7ktQ6fUM4GIANPHaCrDlTr4DcjPMq+lSlJ/lkQYTmbvVo1dZr
   k=;
X-CSE-ConnectionGUID: R+sS9Hi/TOygdljGjnaIXw==
X-CSE-MsgGUID: KM7tQ3gfTwGPYxPYkZQeHQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,104,1770591600"; 
   d="scan'208";a="266509616"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Mar 2026 08:16:05 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 3983380682; Fri,  6 Mar 2026 08:16:04 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 7769380541
	for <cocci@sympa.inria.fr>; Fri,  6 Mar 2026 08:16:02 +0100 (CET)
X-CSE-ConnectionGUID: 6+8zw4SSSmeFwUcw1e4gWw==
X-CSE-MsgGUID: 8DXYsCmxQf2GivPBblCY/w==
IronPort-SDR: 69aa7f31_gCGAUUilPbbYw7bO+AjdA2pRbKrqKTUpaOppMJFbqn/sREb
 m+H8DWJ6RJjz7gdSZ6yhORk3vZlZdywiBEKeozw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EFAgDMfappg07ASNlaHgEBCxIMQIFFC4JBaH00BAtJh?=
 =?us-ascii?q?FiPU4ZfhzyHVYpOgX0CDwEDAQ1OAQIEAQEDBIUAAo0gAh4HAQQwCQ4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBASEZBw47hk8NgluBL?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBHQJHRAIBAyMdAQERJgEPCw4MAhgOAgJWBhUBAYJ+g?=
 =?us-ascii?q?iMBBhABAzYHqwuBMoEBggwBAQbaZB8sIlmBZwkVgQouhW+CZQGKbicPgVVEg?=
 =?us-ascii?q?RUngwM+iB6CaYImgQ6TKlJ4HANZLAFVExcLBwWBI0MDgQYjSwUtHYEjIR0XF?=
 =?us-ascii?q?B9YGwcFEiEqgXR4ggEPhmt5Ay54DiICOlxKPgoBWgWCGAIBC209NwkLGwQ9j?=
 =?us-ascii?q?nI+gi2XErMpNAeCOIFngWQMn20GEy+DcZNhDpMLLodlkHOpQYFoOoFcMxokg?=
 =?us-ascii?q?zZPAxkPjiEZhBrIAkUyPAIHAQoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:GR29sKM7oBI5LcBcThWjsMiBIKoaSvp037Dk7TEUdfUnSL38qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AtBBp92rHLYxOb80GV2Q7M0zmUZ5mIm/CkEzrGEq?=
 =?us-ascii?q?1J3lUQ6LMRAOfx7wxxg=3D=3D?=
X-Talos-MUID: 9a23:Y2zdawRbuMeDsFaiRXS8qAFTL+xt852gUm8Mj60ssc2vBGtvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,104,1770591600"; 
   d="scan'208";a="140573256"
X-MGA-submission: =?us-ascii?q?MDE+Zs/6/cjZfHYBL83qTtBjKFq9yDtKtnESaG?=
 =?us-ascii?q?wMqeV1VQQQcXXa7pxQCuDP3GHMWjD1X0qn28BY6vmEZ848BWVo213MAm?=
 =?us-ascii?q?7/dY2UNnLMJTRCJbCqQ8AUqUjoeqtu/wZemV1JTLFlBc6rtzzJMX2zog?=
 =?us-ascii?q?z3LYBSmrNaUkHjkYVWYmasPw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 08:16:01 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MV2Oi-1w7eI51sZS-00Wy8V; Fri, 06
 Mar 2026 08:15:59 +0100
Message-ID: <eb4d5476-cd85-43d9-8b23-c02452dfbfb1@web.de>
Date: Fri, 6 Mar 2026 08:15:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Philipp Hahn <phahn-oss@avm.de>
References: <726546e758862eac541526151f085401756edc64.1772645314.git.p.hahn@avm.de>
Content-Language: en-GB, de-DE
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <726546e758862eac541526151f085401756edc64.1772645314.git.p.hahn@avm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1gfQNln728tZUfmSa+mYv863J58C4Xgd4y9hyy5Ud8XoId8SEbB
 4ZAvxc65xA+YkVzxRK9OGzK+ypuhfXONF29kb0+JW3d+rQzuH+VMThsATzSmuMqrMAWR4uy
 ABpCMo2aG9lv50dNK3sIVR21s8ht7ZWStYT4uzb+Zqe3T95H5MLjutyrRE4+Bi6EGd2MUDF
 S7hFm3Q7CUmZkt1Q/sh7Q==
UI-OutboundReport: notjunk:1;M01:P0:Ublg3hPM4gg=;1cf8cIF4AwLlbBEzh818RNYFS7K
 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
Subject: Re: [cocci] [RFC] Coccinelle: Use IS_ERR_OR_NULL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3324
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/MadB3Kns9v7oCHJm_FFlig>

=E2=80=A6
> +@p1 depends on patch@
> +expression E;
> +@@
> +(
> +-	E !=3D NULL && !IS_ERR(E)
> ++	!IS_ERR_OR_NULL(E)
> +|
> +-	E =3D=3D NULL || IS_ERR(E)
> ++	!IS_ERR_OR_NULL(E)
> +|
> +-	!IS_ERR(E) && E !=3D NULL
> ++	IS_ERR_OR_NULL(E)
> +|
> +-	IS_ERR(E) || E =3D=3D NULL
> ++	IS_ERR_OR_NULL(E)
> +)
=E2=80=A6

I find such case distinctions questionable.
Thus I suggest to clarify presented implementation details in more detail
also for better source code transformation approaches.

Regards,
Markus
