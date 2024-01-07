Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772C7C47073
	for <cocci@archiver.kernel.org>; Sun,  7 Jan 2024 18:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=tKrZigRxl3yj7aAuxhcN6RgkAeTltb8gvR5YdMlwyIA=;
  b=GVw2D24Q7in8Pcj96a8qmGdIr6+YkQqkVlK31hr0yRj5ZMULgj6HWR2X
   lA4Wo3uJxUSkmyphQe/C0AAXq7kkb+S9Sy8k9tAZTrPB3SoHZU7jBZ1Wz
   OFUwAV219QN6GzgDKgNxGrQ2scySmc9qGpJeedfIWynDgNQ06p150R/o7
   Q=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.04,339,1695679200"; 
   d="scan'208";a="145263891"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jan 2024 19:44:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 80491E0CCA; Sun,  7 Jan 2024 19:44:34 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E4D56E004E
	for <cocci@sympa.inria.fr>; Sun,  7 Jan 2024 19:35:48 +0100 (CET)
IronPort-SDR: 659aef04_ygr2ztDk5mxB8+VUY/2sgx1rcYE8x7ruv7nqhFxf2EHDOKg
 BA5Y0bv8gx2QlzG7vdIOnyWQhoyt2uRjzAvYtHA==
X-IPAS-Result: =?us-ascii?q?A0EjAADl7Zpl/9lUsotaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4B4FLMgQLSIxwX4cdAQIBAQaNL4w6hASBVoF+DwEDAQ1EBAEBA?=
 =?us-ascii?q?wSEf4c8Ah4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECg?=
 =?us-ascii?q?QYThWwNglwBgRyBHgEBAQEBAQEBAQEBAR0CDYE8BgEBNwGBPAGFcgOxKoE0g?=
 =?us-ascii?q?QGCCgEBBoJlsBYJgUgBiBoBhWeDQYEhG32BEIR9hFiGLoIbg0KKR4UOgVEdA?=
 =?us-ascii?q?4EFbxsPHjcREAUODQMIbh0CMTwDBQMEMgoSDAshBRNCA0AGSQsDAhoFAwMEg?=
 =?us-ascii?q?TAFDRoCECwmAwMSSQIQFAM7AwMGAwoxAzBVQgxQA2UfMgk8DwwaAhseDScjA?=
 =?us-ascii?q?ixCAxEFEAIWAyQWBDQRCQsoAywGOAISDAYGCV0mFgkEJQMIBANUAyN0EQMEC?=
 =?us-ascii?q?gMUBwsHdwNEHUADC209NRQbBphHEwETIZUzCZB7aIExnyaEG4RpnCoaM5cmk?=
 =?us-ascii?q?F6CCQEumB8goxGFNYFjPTmBIE0wCIMiTwMZD44giQyLBiA1OwIHCwEBAwmJI?=
 =?us-ascii?q?oFGAQE?=
IronPort-PHdr: A9a23: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
 Q==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:bZFRt60V902QnKIh0Dl38wqjBKEkLtp133Aq2lEZdPWaSK2lfq
 eV7ZAmPH7P+VMssRQb9OxoV5PtfZqxz/FICOoqTNWftWvdyQiVxehZhOOIqQEIcBefygcy78
 ldT5Q=
X-Talos-CUID: 9a23:JuIy62OJvAciQe5DVRN17QlKFsocY3zx4m/yf3KgEWtsR+jA
X-Talos-MUID: 9a23:M7R/9QpcegZwKpqM7yIez3YzH8lB6ai1M2susY4foueINBB6PQ7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,339,1695679200"; 
   d="scan'208";a="145263407"
X-MGA-submission: =?us-ascii?q?MDEcV/rkn9bNo+KXdQsCtoCGrxksYgpiEHRJl4?=
 =?us-ascii?q?pTByQkRFr7+hDy4wmChgAc3N6Yhq1sLvj8BhneTtnlI3ky69piJuMrBJ?=
 =?us-ascii?q?zQLcjw2+W6stlfs7GG06YzEUh8ZZVEh60RRYglIWvNyVMTagW8zm/rEM?=
 =?us-ascii?q?IbaZ2owmiu2befmN3qxaC3Qw=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 19:35:47 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E159B60C0F;
	Sun,  7 Jan 2024 18:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533ADC433C8;
	Sun,  7 Jan 2024 18:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704652537;
	bh=tKrZigRxl3yj7aAuxhcN6RgkAeTltb8gvR5YdMlwyIA=;
	h=Date:From:To:Cc:Subject:From;
	b=D8eaCICrbP4POUrTBzzwh+Z7e4osib+pj5KHRTDcFwREp3O2ZUX0j88prE3WCpeS8
	 fvuyWHLcpG+1IhnxcnoaSl8UaEmJWyltBJWha5TF2OwOkIoYdNSiBU6I0nkgtmlz67
	 mrju8+sPVdjjKNJY3ZBMXnc+1GWElxbvTvgLJuvH4uyE25IOJnOAit8rOKy+6Ti7Hu
	 7GiR48Kj/rSxOb+r/6/zn2s9/Bp8G2jSsVNuyjdsh9PFTO3IcjPh0eJdKQd+GrRfzU
	 6mx9dTdI5zj/t5exFvRgHba11y8eCDSRi9iu96EmMaPa5i41gT6FoQR/QZQRIEbTuO
	 qX54NjRX7F56g==
Date: Sun, 7 Jan 2024 10:35:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix
 <nicolas.palix@imag.fr>
Cc: cocci@inria.fr
Message-ID: <20240107103536.5719ce30@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] EXN: Coccinelle_modules.Common.Timeout
Reply-To: Jakub Kicinski <kuba@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 1437
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/20240107103536.5719ce30%40kernel.org>

Hi!

When running coccicheck on net-next I get:

/usr/local/bin/spatch -D report --no-show-diff --very-quiet --cocci-file ./scripts/coccinelle/free/clk_put.cocci --dir . -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/compiler-version.h --include ./include/linux/kconfig.h --jobs 64 --chunksize 1
158 files match
./drivers/bus/ti-sysc.c:2362:2-8: ERROR: missing clk_put; clk_get on line 2354 and execution via conditional on line 2361
./drivers/tty/serial/bcm63xx_uart.c:850:2-8: ERROR: missing clk_put; clk_get on line 845 and execution via conditional on line 849
EXN: Coccinelle_modules.Common.Timeout in ./drivers/cpufreq/armada-8k-cpufreq.c
EXN: Coccinelle_modules.Common.Timeout in ./drivers/cpufreq/mvebu-cpufreq.c
An error occurred when attempting to transform some files.
coccicheck failed
make[1]: *** [/home/cocci/testing/Makefile:2003: coccicheck] Error 255
make: *** [Makefile:234: __sub-make] Error 2


I couldn't google out any meaningful info about this. Is the timeout
something I can increase locally? Is something wrong?
