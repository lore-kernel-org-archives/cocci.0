Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D165C3DA7F
	for <cocci@archiver.kernel.org>; Mon,  5 Aug 2024 14:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=XZCijr+3aTLc9z3k5qW6XI6cruAEaOTjhPmOpU7rdKs=;
  b=R9oGD2UBc8RypwitsmCZwF7+CZ0mL2HhqPMtwltkPSCQyConkrCxynMG
   7xfM0gGe4CKUrqEjtORC3fcD1kz6wNyQ7dNyHepDHp0gXevYylMHcbfCJ
   xmqw74vJP981k5meIusCU4p/ESQy/s2rF5rPRhkhy1mV56hxWSronWVGm
   w=;
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
X-IronPort-AV: E=Sophos;i="6.09,264,1716242400"; 
   d="scan'208";a="178159338"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Aug 2024 16:34:53 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E3F6BE0141; Mon,  5 Aug 2024 16:34:53 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DAB3DE0035
	for <cocci@sympa.inria.fr>; Mon,  5 Aug 2024 16:34:51 +0200 (CEST)
IronPort-SDR: 66b0e30b_Kw9txotLPV5yiZU2JFcGAHO8hMxNX1q3CGVZTPcYbWHQmds
 2Gse2FSo9KF+ZNWIdgJSL1/ZiyaL/pUS3ar71uQ==
X-IPAS-Result: =?us-ascii?q?A0FbAACk4bBmhwwR49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YJDYhsGVDMEC0gIhE6IHYcvgXUwhDuPC4h1gVaBQBYoDwEDAQ09BAECBAEBA?=
 =?us-ascii?q?wSEfwKJSgIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABAQE6Bw47hXUNgmcRgRKBJgEBAQEBAQEBAQEBAQEBAQEBARcCDQ4sRAEBA?=
 =?us-ascii?q?QIBIx0BAREmAQQLCxoCJgICVgYBFAEBgnwBgi8BAw4jBw0GrSeBMoEBggwBA?=
 =?us-ascii?q?QaCZ9dyHywiV4FjAwaBGi4BiEkBhh6EOycPgVVEgRUngwM+gkoXAQMYhSGCa?=
 =?us-ascii?q?Y5OgzUGBAUUhQ6CG1BAgXCBUiZWSwICAgcChWKBRYdkUnscA1khEwFVExcLC?=
 =?us-ascii?q?QWJSwqDIymBSyaEGAiBLRWDZQ2BXgxhh3JigQ6BPjiBJwFJgndKg2ccgWOBA?=
 =?us-ascii?q?4JjVx1AAgELbT01CQsbBj2kSIVAAgmBR6UmoS00B4I2gWKBYwyKJZUqBhMvl?=
 =?us-ascii?q?zwOBpJuLJhEIo1ZmxuBZzqBXDMaJIM2TwMZD44hGYQUgjGBdTvCWEE1AgEBN?=
 =?us-ascii?q?wIHCwEBAwmFRgEBhlyBSwEB?=
IronPort-PHdr: A9a23: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
 hFOzb6qdez706Xk1kYkZlQoxOz3
IronPort-Data: A9a23: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
 FXZnVx5fXw=
IronPort-HdrOrdr: A9a23:tTkbHqBaTyzxy9PlHel455DYdb4zR+YMi2TDGXoBLCC9Afbo8P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkOos1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QF5SWY+eRMbEVt7eZ3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: 9a23:HqNmlm60s55oTbS4H9ssy0srP844V0LnzW73AH6RMEBLR4zWcArF
X-Talos-MUID: =?us-ascii?q?9a23=3AcXtEwQ1xzYUJN3uJ7ZddaaLZrDUjzKuSN1xcyrk?=
 =?us-ascii?q?/hsy6NB17GTO0z222Tdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,264,1716242400"; 
   d="scan'208";a="178159335"
X-MGA-submission: =?us-ascii?q?MDEbEHPc1qxKHaf3w0BgiLRZT4g5Cb0eCxySLg?=
 =?us-ascii?q?OB8tGUF6y74zjjBXGUL1oGL01dICQA8v0vEmrkb7D9GdbSafUCBSjKNV?=
 =?us-ascii?q?reVSh0i8ymx/OUC0QEiKcGdFqQ5CEjvv+Yj4Pv5Mwxq1IbrF9LWkyzHV?=
 =?us-ascii?q?uPqY2PLC5zuIksDKLOkjaslg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 16:34:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722868490; x=1723473290; i=markus.elfring@web.de;
	bh=XZCijr+3aTLc9z3k5qW6XI6cruAEaOTjhPmOpU7rdKs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KUFCmSF8xsqXkilFuKY3qOvf/JtcTUzupgqmBxt84B/hETGxFb8fvabi79uUkqMS
	 nwykIirNMn8St2df2/bRrirNOKk+co4ubcK1XawL1QR3/rZgPP9jlSoEueIsdIaBg
	 FqOUiwBVb2gGu4urmu8Q+1eV7fwMeQFXjTJQSdn+iDBiaKW9fcei48onXxMJ2yD35
	 06XpcjBU42uQiZgR4S7V4dcuU83yBglbeuKH3BDW20kIwCOfZK/NszENghfdhlaHJ
	 UVyJcMw/Fn4KAF0g5KxNEakNz9b5cH3zkKBJXzqAzOE/cZSS3FPe0snu2Zhgxr95a
	 lCS40m43yojIuLQBtw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M76XN-1sajPp074B-004oJ2; Mon, 05
 Aug 2024 16:34:50 +0200
Message-ID: <c48956e7-f98f-407b-a4c1-29aa417c7474@web.de>
Date: Mon, 5 Aug 2024 16:34:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Ricardo Ribalda <ribalda@chromium.org>, cocci@inria.fr
Cc: Julia Lawall <Julia.Lawall@inria.fr>
References: <CANiDSCvmboKBK=Z7uS9tnN_LcPA16rx0j_iWeEoQ=jO+pEgLiA@mail.gmail.com>
 <98a94966-14c6-45c4-99d8-471f65b292ea@web.de>
 <CANiDSCuJHTsHsFLbMGC1S47myfReZX7JBfGZFVknj8y=4-QLCA@mail.gmail.com>
 <fdc397c4-8823-46c3-b471-382ebb483900@web.de>
 <CANiDSCuqX7yRyJfvEJeV99fr1wEwANtg2Ak7MNogfYNEqMJ6Hg@mail.gmail.com>
 <c05b066f-af9b-49c1-9bdb-9167d24e3d3b@web.de>
Content-Language: en-GB
In-Reply-To: <c05b066f-af9b-49c1-9bdb-9167d24e3d3b@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:JonyV/J9NiRYbYatqvgpE1M2aXkCWW3rJjnoH5hI2qVXIxaYP88
 2o9b9Pr4p5cgkYnmhWDGKSi7hHQFazOXkN+Qt0i8o3oEZlINb9gTrKmAdRFL1HujFveohz2
 +LESpO57f3OhQOTd0nitXbXrs9RsVKwIISKxQB8Ax0z+iUyE0fDg2glMtIylPrpY9OjG1fM
 RrFQvAD/0f4OcDB/16BWQ==
UI-OutboundReport: notjunk:1;M01:P0:MgB89OjZMic=;+5GpOIpVZ9/2HNMviNnep5/D9j2
 FcOvBKhTVBQZpCv2qESEY3mTMMP3x0gjaHFj2Kk2yuzU91bAYW8RbUyadZd67duhrk9zBhny8
 3kktlGhR0Xx6Wu22SXKHZpQRfkmVZoLcvnNqZHjJP5etEt9VZzW4Bgs+KrNbZNSZBs9+pQMPb
 ZLOkgeZKTDsPSaH8ZEU15n/B3ocm+cbDpb3Y6cE1U7SuwQ3x1C9PJjYm/qaggqTFGbBYU2RBQ
 qNYHkxbUCOFsYnEY4zYZC1yGFjTcCOZ+eTOzw/q4ze2rqF/82bjMvTBeJmj+N0WyeIIN9PXvp
 9X1paRPLtHAdFo9FxtNSkro5numiX0q9qOoJ1UCcRtWVcW5kwFN3uSfa4yo7Deap8XbP/Q357
 yzz8tFyJkQmJyxr1u0LWvZb41Oy/Yft2STvPd3AYiNNtABSMg6BfZcs+YBCWyYkQQFtWIbDm4
 BBSiDHDGFw8aULnqZGj3YVWKli0+3LL8nwocqBH4IhjNIB53C4pzvhPVEZc7yX1NvHlLzrSC6
 aZ8NFEjxkZvo1Ku8gnE2EzdsqtNwjfUOyKK9qw3GFeMaSGzBndB0j5t/RU2yNTpo+YbxJK8NM
 alsDMknkQOojB6sH5bQT/EU4TX4O82Y3yKj+AVmoP57uouMd+F+QQoqORJu/pAZP9jeC+d2fO
 Fo2K90ybnkQYsSHtmW6DDJ7QdLRKhspLGnjC4SkPlMWCgGMi19gmQa8zfZJpf8kP7FQ9IjWEm
 Obo3jvPQ9Lu2wGrPq7EPloA7s+K9xXexgrIan/7I/Nnvx4rQXrwlo0DtODK+luk6XFCPICu5H
 eMmK+ornDX8YQwGICMREFD+A==
Subject: Re: [cocci] Questionable run time characteristics for SmPL scripts?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1839
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/c48956e7-f98f-407b-a4c1-29aa417c7474%40web.de>

> There are more system configuration possibilities to consider.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/dev-tools/coccinelle.rst?h=v6.11-rc2#n203

Would you get further insights with the help of another development tool?

* https://remake.readthedocs.io/en/latest/features.html#profiling

* https://bashdb.sourceforge.net/remake/


> I am unsure how far you would be willing to increase corresponding measurement efforts.

Do you find any other command variations more helpful?

Example:
remake M=drivers/media/ MODE=report V=1 DEBUG_FILE=cocci-errors.txt SPFLAGS='--profile --show-trying' coccicheck


Regards,
Markus
