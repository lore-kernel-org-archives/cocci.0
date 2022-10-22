Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E73C433FE
	for <cocci@archiver.kernel.org>; Sat, 22 Oct 2022 09:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:content-transfer-encoding:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=HVGE1ykHEKfz2Cu4ieFWErVWClrb9kFYoLs68EJ/xII=;
  b=IL+vZANP1c8dPU1kBbWYkUjn+52vY9dAyEScNQA9ZUPtJeJQzoCWfHP3
   u+ywaC7qm2noi2zgtBQBZIex1SJMzdfsTCHUIBeaJDVtdqDZ3n6B0jpqq
   jiXozvX9TGR5V6alIhJJpzIRBKyOC0cqkEmszPrVNVUTlGrtj81E8SsZS
   M=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.95,204,1661810400"; 
   d="scan'208";a="67859177"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Oct 2022 11:22:15 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4823CE0152; Sat, 22 Oct 2022 11:22:15 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 232CBE0130
	for <cocci@sympa.inria.fr>; Sat, 22 Oct 2022 11:22:08 +0200 (CEST)
IronPort-SDR: 6353b63f_teYhJcZ7k3pLOA9HuZcNi2mkhXMH+x+Bk54A9jVWmeZD/QH
 KTwDC5/cQcUBcBeq2aX8Ax2BhXzzbEVLOW0b8Nw==
X-IPAS-Result: =?us-ascii?q?A0BaCgCztVNjfyndVdFaHQEBKwEJAQYBBQUBAgEJARWBT?=
 =?us-ascii?q?wKBQwIBZYEBA1MuBFCETpEXjEuGIowwDwEDAQsBARQBASUJBAEBhEBAAwKEc?=
 =?us-ascii?q?wIdBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBGAkZB?=
 =?us-ascii?q?w4OBSSFaA2CNSKDbhYRHQEbHQEDEhAPAiYCJREBBQFXglyCbAEDMAMEDJ46g?=
 =?us-ascii?q?QRCizKBFQUCFoEBggkGgUEBgSCBbQoZKA1oA4FaAgcJAQh/KgMBAYhchwJ6J?=
 =?us-ascii?q?xyBSUSED4NQAoF1OIMKgmYElT0BAwUUDwMDAiEDGSsdAgkDIw8DCwkIExcoB?=
 =?us-ascii?q?gMBAQwHRgQcHwMBAQ8kAQECAgIDBAcCAQMGAwwCAgEBAQUGDQMCAwgTAwIBA?=
 =?us-ascii?q?wUCAgQBAgQKCAECAgECBAUHAgEIBgUNBQkLAQECAQMHBAMRAgUDBQUDAwIBC?=
 =?us-ascii?q?QEFAgMBAgEBAwYEBAEBAgMCAgEGAgIBAQMDBAMBAgYCAgcCAwIBBAIDAwEBA?=
 =?us-ascii?q?QICAgICAgMDCQIIBwUBBgECAQQDAgIBAgcBBAEIAwMFBQkPAwUDAQMDAhQKB?=
 =?us-ascii?q?QEDCAYIAgQFAgUDAgQCAwICCAMCBAMLAwUEAgcTBwIDAgIFAgICAgIFBAMBA?=
 =?us-ascii?q?gICAgICBQIDAgEFAQICAQICAgQBAgIHBAIDAQMEDgQDAgIHAQICAQYCBwMBA?=
 =?us-ascii?q?gEEAwEBBAIEAQIFAgQBAwYCBAMKAgIDAgICBgUDAwoIAgMFAgQBAQIHBAICC?=
 =?us-ascii?q?wEGAgcCAgMQAQMBBAUFAwMDCQICAwIEAgIKAQEBAQICAQcCBAcPAgICBAICA?=
 =?us-ascii?q?gEDAgIBAQICChIBAQIDBgQGBQMCCBgBBgIBAQICAwMCBgIBAggCBAEEBQIBA?=
 =?us-ascii?q?gICAgQBAwYCAwEBAgECAgMDAgEEAgQDAwECAQICAgMCAgIDAgIBDwIGBgECA?=
 =?us-ascii?q?gICAgICAgIGAQIBAgQCBwIEAwIBAgIFAgICAwEBBgIECwEDAgcGAQMCBwUCA?=
 =?us-ascii?q?wEEAwQDAwUGBQwIAQUBAwEeAwICCAIHAgEGBQEPAwICAwICAQQKAgMFAgQCA?=
 =?us-ascii?q?QQJBwIEAQIJAwIGAgcFGAECAgcEDAoCAgIFBgIEAQECAwECAQECAwQCAwIEB?=
 =?us-ascii?q?QEFAgECBQQCAgEBAgUCDAECAQcGAgcCAgICAwEEAgECAQMDAgMBAQEDBgYFB?=
 =?us-ascii?q?AQCAwMGAgICBgICAwISAwYCBgMCBAENDwUEBQgBAgEBBwIEAgcJDgIBBgEFA?=
 =?us-ascii?q?gIDAgIBBAECAQYDAQICAgIFCAUDBAUDCQwDAQEEAwIBAgEEAwIDBwMCBAQDA?=
 =?us-ascii?q?QIDBAYGAQkDAgIGAwICAg0DBAICAQIBAgMEBAYCAgIBAgICAgMEAgIBAQMDA?=
 =?us-ascii?q?wICAgMEAgMDCwYKCAICAgMCAQULBAIDAgEDBgkCBAICBgECBAICAgICAgIDA?=
 =?us-ascii?q?QEDCgQCAQIDAgIGAwYCAQIBAgEJBQIBCQMBAgEDBAEDBgQBAgIECQIDBwUEB?=
 =?us-ascii?q?gQCAgICCAICDgMDAgEBBAICBAUCAgsCAQIHAgUBAQMFBwICAQICAQQDAQkEA?=
 =?us-ascii?q?QICAwIBAQMDEQMDAwEEAgIFAwMNCQYCAgEDAgMBDQMDAQIBAgMBBQUXAwIBC?=
 =?us-ascii?q?AcDEwMCAQEDAgECAgMGBAEIAgIDAwMCAQIFAgQDAwEFAgEBAwEFAwIOAwIDA?=
 =?us-ascii?q?wMCBgECAQECAwIDAQwEBQEBAQEWAwECAwIEAgIBAQIIAQQDAQECAQIDAgIOB?=
 =?us-ascii?q?gEEBZZhghcCFkkkCixNdsNAY4MJi0WVAjKFSJEiFJITlyGNQZoKAgoHBhAjE?=
 =?us-ascii?q?oFDJC2BLk0jFWyCNglFAxkPkAOCD4pgPzQLMAIGCwEBAwmKVQEB?=
IronPort-PHdr: A9a23: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
 d/Im6b+bjxF9oCMlSP5L8fRIcODdnEmNEixcAM=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:PWl/gaOeOFn40sBcTvajsMiBIKoaSvp037Dk7TEXdfUzSL3hqy
 nOpoVj6faQslwssR4b6La90cW7MBbhHP1OkPMs1NWZLWrbUQKTRekIjbcKqweAJ8SUzJ8+6U
 4PSdkbNDS9NykAsS842mWF+hQbreVvPJrGuQ4W9RlQcT0=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,204,1661810400"; 
   d="scan'208";a="67859168"
X-MGA-submission: =?us-ascii?q?MDGh6XnbQ20IuTA/YjCHFAuaKTmyIAZMQ4AGtL?=
 =?us-ascii?q?fmy2f55Z4NquTG+HNQW9GQIQSrbSnR8fqkNJ3jV27/7pulKFhKZzUljh?=
 =?us-ascii?q?P9UqA/qcHNWZKcF2Mit2NtSEjmdjeuWNhlbOjI0v4ShkH9gLEenebLMS?=
 =?us-ascii?q?+wYPurvyE9DtJSr2pqjxS9lw=3D=3D?=
Received: from mail-wr1-f41.google.com ([209.85.221.41])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 11:22:07 +0200
Received: by mail-wr1-f41.google.com with SMTP id bp11so7971347wrb.9;
        Sat, 22 Oct 2022 02:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HVGE1ykHEKfz2Cu4ieFWErVWClrb9kFYoLs68EJ/xII=;
        b=Q6jwPUwX/to2JUZJ3KzeuF2zVaxOvRLLPa2zS9WyJzi+vHod2s1l3ReHeHk/nGN/QR
         bGaNDa/eI6DQwEfoaVR6O331CbZuEOtTclGAG4GweVyltxauSEUDqcaUKlYVObOHr215
         +q7F7dstNZjdD+9PQP+ZRSVOLWUvsmYNJcQm7LGy+w9iq69bjfmjKsw5jAKuqflRpo0N
         Z9ECLhfCxz3rPFBszsHtYUMn4yr+2NRRj1dWF2nMJ/6Kcw8W8hPev6bh1T3SAT5QFih/
         J3xXFrbURBWhY/9+nCYl4Sy83B73hgcQObfDX1HFrGXf6rrD8VgCWwX7EVKT8PmSUP9Z
         D/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVGE1ykHEKfz2Cu4ieFWErVWClrb9kFYoLs68EJ/xII=;
        b=IPBhKpUAalQVrVZZejPf3unZpHlgs309oLF0nWlNhIwhI5vxI4Bzr34np9hawJYJ/0
         yT6RDNKzbdP4IvOAzvH7lt2K3qZfZaVYfKH1pchF/6WMowbMjfVI2sHDYN+GaFaMGiFR
         zo042WcFUtjEA2leLH7vHXdoXN1xNYPO62iVCqev/Ny3/FMPdLKwe062zr2kxAC8To33
         SRVJfi7otmniVNsj8Dt8JEYigaHu2N2P4Q1KrqzxBX50JhtzKDSVNQ6ezLtAIww8Mu+m
         j1xH++gYL2f2SWXmA01xABRAiEXu6ab1a/Im+AC0oG4oyGtdfTrzCRTkdYCHcVlX6gAC
         NqqQ==
X-Gm-Message-State: ACrzQf1/yk+LgfKfbWJK/0sP1qoheWHbftN5C2mfjSBwvgPk+5Z6i2Eh
	GL11meegID51mu08tIbV/k8bemEeEGI=
X-Google-Smtp-Source: AMsMyM4hswpoQZkd7pEmDZeKr2MpGsD1CIfImlXnquakXev5jPx65s7Xfq60In52e1+p69YKNWKMjg==
X-Received: by 2002:adf:fa51:0:b0:236:5100:f595 with SMTP id y17-20020adffa51000000b002365100f595mr5626766wrr.309.1666430527308;
        Sat, 22 Oct 2022 02:22:07 -0700 (PDT)
Received: from [192.168.1.191] (ip-89-177-205-85.bb.vodafone.cz. [89.177.205.85])
        by smtp.gmail.com with ESMTPSA id x23-20020a1c7c17000000b003b49ab8ff53sm4829322wmc.8.2022.10.22.02.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 02:22:06 -0700 (PDT)
Message-ID: <e3746c66c0f9c0747620dd7536c98ca6deb5399b.camel@gmail.com>
From: Jan Tojnar <jtojnar@gmail.com>
To: cocci@inria.fr
Cc: Thierry.Martinez@inria.fr
Date: Sat, 22 Oct 2022 11:22:04 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.0 
MIME-Version: 1.0
Subject: [cocci] No longer possible to build with system dependencies?
Reply-To: Jan Tojnar <jtojnar@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 664
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/e3746c66c0f9c0747620dd7536c98ca6deb5399b.camel%40gmail.com>

Hi,

I tried building Coccinelle from the latest commit from master but it
appears it is no longer possible to do so without relying on bundles.

I like to use libraries from my Linux distribution since then I do not
have to build them over and over again every time I nuke the repo.
Additionally, since distros tend to use sandboxed environment for
building packages, building dependencies independently reduces
excessively long rebuild time when failure occurs higher in the
dependency tree.

Looking at the commit history, the last change to `configure.ac` file
from the following commit is responsible:

https://github.com/coccinelle/coccinelle/commit/1d0733a27006b06eef712f54100=
0a8bf10246804

in addition to:

https://github.com/coccinelle/coccinelle/commit/3f54340c8ac907e528dbe1475a4=
a7141e77b9cdd

If this was done to prevent people from using old versions of the
libraries, would it be possible to add a minimum version check instead?
Or at least add an option to force the use of system libraries,
so that distros do not have to patch the limitation out to comply with
their policies on packaging vendored dependencies?

Cheers,

Jan
