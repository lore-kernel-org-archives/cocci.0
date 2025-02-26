Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61511C021B8
	for <cocci@archiver.kernel.org>; Wed, 26 Feb 2025 08:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=JKZ0hhA194JzGtLnAGjE7Tna8UgHB+lZSaCvTNzqLik=;
  b=BT5BjTRu3B/BbVNtEzKbqOYod4fcuY7qf5p5oGoOW9jPlnnBir+kz1CI
   BirwU1TzS5EYkCArj2tURsKOYD/gu+UapJU0YntIdF5qFxvsdNsANAZkc
   g/vzMb9SYJrPV32CHFKdiEWH5IurON7BkNUHTMh4jk/oVfFguZyHCpioj
   o=;
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,316,1732575600"; 
   d="scan'208";a="210093577"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Feb 2025 09:26:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 45DF6E0D1F; Wed, 26 Feb 2025 09:26:24 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 29B64E0260
	for <cocci@sympa.inria.fr>; Wed, 26 Feb 2025 09:26:22 +0100 (CET)
IronPort-SDR: 67bed02d_t7zByi9WZPe0WihxV5m2ZNcQHBO6FtQQwQrq7aLixGajHl9
 IcepMs+ztAlkK9xjk/sBlH4R+M2212dLtY/6qBw==
X-IPAS-Result: =?us-ascii?q?A0F/AQCjz75ng07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UIEAQELAYJDgVczBAtIhFaPT4F0MIQ7hzuHU4h1g1QPAQMBDUEBAgQBAQMEh?=
 =?us-ascii?q?QACixICHgcBBDMGDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QEBOgcOO4V7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBESYBB?=
 =?us-ascii?q?AsLDgwCJgICVgYBFAEBgn6CMAEDDiMHr0eBMoEBggwBAQbaXB8sIleBZQmBG?=
 =?us-ascii?q?i4BhWuCYwGFazuEPCcPgVVEgTyDAz6EQ4NbgmmCM4RFZ5oPjgJSexwDWSwBV?=
 =?us-ascii?q?RMXCwcFgSkQOAMgCjQUHQIUDRAPBhAEagU0Cjc6ggtpSToCDQI1gh4kWIIra?=
 =?us-ascii?q?gQFgSqCN4RDXC8DAwMDgyqCP1GCQoIRcW8DAxYPAYMfdxyDUYEuhAUdQAIBC?=
 =?us-ascii?q?209NwYDCxsGPaFyiArGRTQHgjiBZoFjDJ9eBhMvg3ABk1MOBpJ9LodlkGoiq?=
 =?us-ascii?q?Q6BfSSBXDMaJIM2TwMZD44hGR+DdY8KAbwAQjU8AgcBCgEBAwmFRgEBilSBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 FXZjlyojK12pYAd3Cqgl7No9MklgQ7S
IronPort-HdrOrdr: A9a23:E25La6NyG1roQcBcThWjsMiBIKoaSvp037Dk7TEUdfUnSL38qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:A4ISS24uPfcpZDFQjtss9mIJGN4LbVvh3kjQcm6zDDowcrHSYArF
X-Talos-MUID: =?us-ascii?q?9a23=3A+i0ALQ8E/0z/DeLS4YR6kDOQf5sx6oi3E0cPq5k?=
 =?us-ascii?q?pnfGAJzZ3FBq31w3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,316,1732575600"; 
   d="scan'208";a="210093571"
X-MGA-submission: =?us-ascii?q?MDE6TxlLWQ7xQMM3CzEWx5ugHvYrvnrvDFeZyM?=
 =?us-ascii?q?vuc1QU+f7pIrCfEy4Fgw3PPfMxHXbymUCsrbF4NG2ivzeXAMzU4VlW94?=
 =?us-ascii?q?FU30l2mUtr+tbWDDHmzLLQ30OhpXKSmGGd35LYYuH+EGecY0dENH1D/W?=
 =?us-ascii?q?g4n/5Ganc0OsTJHTlArH4M5A=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 09:26:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740558375; x=1741163175; i=markus.elfring@web.de;
	bh=JKZ0hhA194JzGtLnAGjE7Tna8UgHB+lZSaCvTNzqLik=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SIvRvmLn8flUsGl5JcfolgQVFctLE8OIoa7MSA8VqUzJwiwUljIzskLbousNrkq+
	 s6YCNQz7zIL9+lFqI5WSe7vUrJx0Yo77ScqwzShmSwXuPbW+uHdWmsvfkClFpA7rK
	 usGxux+2O3/m/sH2Ol+aALD3UBAn0eLdYMCB/Zmhd8AxelKc6OigP+h1alFew5Dnc
	 gPrustT65hY/Zl11lrJKD1kY3sy1JITGeTQFZwFBRfct+lEaKac+97UB4gEf52sZf
	 Dfbezpt6AbuUfdntRPve72587MBApZwGt5tNaM+4croKEmsOyTmKlyMXy/PZQ37Cl
	 n5TfjKV2NzLDX+X+gA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.43]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLzn1-1u50kB3RC5-00JCvd; Wed, 26
 Feb 2025 09:26:14 +0100
Message-ID: <3abf9e69-77bc-40eb-b84e-a84726c693a4@web.de>
Date: Wed, 26 Feb 2025 09:26:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Easwar Hariharan <eahariha@linux.microsoft.com>, cocci@inria.fr,
 Andrew Morton <akpm@linux-foundation.org>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>,
 Ilya Dryomov <idryomov@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Ricardo Ribalda <ribalda@chromium.org>, Xiubo Li <xiubli@redhat.com>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
 <20250225-converge-secs-to-jiffies-part-two-v3-1-a43967e36c88@linux.microsoft.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-1-a43967e36c88@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8T0doJfXh5Xn7cF2aNYOOKjzaCLuQ6TqMSMuzhfQJClOkTbtxxb
 WwwOPp7N2qlsBqQ00o23C3N3aVcUZY4TjAGA+UrRfMjxNPTKTdOiNBOQwZ9VQNsUmd6mbZy
 KL9u5kffTfvv716Cs7afT5khYDw06LMDjCV3+bzJsgWJ4vukB2wup+YsixbEw0HAWd2IhUU
 sgp5ksKAElGs1EpqGW8jA==
UI-OutboundReport: notjunk:1;M01:P0:OGs6+r90pjI=;Xp1eJI63N70NI9WqtvgfsrbPcjm
 rejW+UAjPV4MCQgv3/dxOZAaJVFE+L7EourFK4xAa//fhfqZ0btf2C18nTt3onMh/ij/Yb9Eb
 T0H359kFvwQMR64ul87fexPZIwayUvLL4EMgSbNeZ4Bo99udJSEfTvfapfE8PfdgejwtYtkGC
 vBgpCoA3d3unI7qRXRh9YVLc8njdbqop93SzJzAXXuvQkY0pr2isUFQYfceEEqHyZYUkasX/9
 hjnd9clqawcls/NWlpBzXvnXAdgWWjHcE4IMujQQ/PpeLAbn3IsfKZgbpv6eiTGG+Z7fqQqsZ
 dIR+iTAi+3sMw+MjNa0C/apJS83+HJ+uAVk+cEpMJCm8tp/OGvqnfUVvP4kbrGnEN5pjijKkq
 IuTDQ3D1VHOXo8aXYnRji0Z3C4oY7e1YAEwjE5PWdfkcCNxS7t6u87myzzJfNEsmWEs9jMW2+
 H0rnQaffodiEOSgUHrwEbtuLlWq4GpxSOc6Q/ZlC1jMNPSut2vd3xZ+dtmQv1Nl488cpPmwsS
 JKXdlIqpS/Uh+8ESz1Yl6L5lUJAqnFvBfMa65+cs1cjTgeHKmVDHZ8g0uMWqjjnwmcaWeGLrb
 icCBUjV9O5/YLaNVaiKyHShsLusR+U8qRmV4wk8XR7ZYZj5OeB1vpgawSCQfNexSQRRJsOXXJ
 I2QXL4g/1jt1QlapifmgrxUa6CaIzPZWYYBAm2hdaWdRzA+oSysm37nVGM2HwP+yrvthOwDo/
 5nfI0R6Tp9iaevpPpq92IfJpBCmdKka/vd3uhPaera4sRHUu+SkehtOOc+kzWtp9JMB2bmJ08
 uneEpTPQTfnJijuPS8zw91Fp41AUNHad7+GYTKS8oi7ZilDK9MgcmZDqh2yEJn8LtqKnkqY0V
 b4FrlZkeeBIJ+ZoMrM9VligtBsZQrWT/hSFTPgKF4RnMWr/xsEbIjyr7VnuDQ6W6mc/KqkvMR
 T/Z1p7RMnlXqMVMdEG/RUPfCbNqkA37xnqclEC99lb2otbZ6V5hBEsFVSIF2u4RS0wTottnz1
 ebZ4KPntTuP1H8yR8EXRi43bm0/vIb3H52E9qW0y8ZBngoivBNQ0LwyHIq2aGZ++SHVHolGOJ
 juiTRD1tRMxCHnAA8RpZVJ51z8mhkoCut4QkOKTIsG5g6DPDxGr7uIpfJIuzwFY3TBmWI4bA4
 TQ1OGIFfyt9jpEYH7mNoq2q9TF9CZly0rFAUedyRYm5LpBSHPwp6TGCjI1WAe8yJ6pbSvJoa6
 56jQAESh71iph7QxwpzQKoasaQuoeRBkQeCxh9NnE3lsHLTMCcuw3u7tn/F6wHdFCdoLcOyU3
 vnEpf/g3ha4eTjBE/N6jOgPnPN6P+USvCp0rn9Mb5kdujiLqyNfr1MmGc4W9EtG+aONjj5kGG
 pjlaod0Xin9HArUw2MYbXOw+oJWHaP1O6KCEzJV5TC9zhidAR4gDh4NUGv+eU8QBzOLaYpBOE
 0S9XESzAIgZgr0noSVz8XSbEay1E=
Subject: Re: [cocci] [PATCH v3 01/16] coccinelle: misc: secs_to_jiffies:
 Patch expressions too
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2455
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/3abf9e69-77bc-40eb-b84e-a84726c693a4%40web.de>

> Teach the script to suggest conversions for timeout patterns where the
> arguments to msecs_to_jiffies() are expressions as well.
=E2=80=A6
> ---
>  scripts/coccinelle/misc/secs_to_jiffies.cocci | 10 ++++++++++
=E2=80=A6

Will any information from previous patch review approaches trigger more de=
sirable effects
also for such an SmPL script?

Regards,
Markus
