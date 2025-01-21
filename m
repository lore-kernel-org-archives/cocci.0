Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6574EC0218C
	for <cocci@archiver.kernel.org>; Thu, 23 Jan 2025 11:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:date:message-id:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KPT9vtHtatTEvuzmSIVsLzreZj3REB5vcVBl/dJM3qM=;
  b=op8rT6WPEYDPa8gXToFyYfjBRENfqco8MFI1bTkNdzwKvCrpqktDyZS6
   pIDMnvoFStWM5yjuOtI3dR+nOUY2HwyurXHqu04k6aC3oZvnTpATZDuU3
   GhFIaYbHvMi0SVVKb/2ujBNJljgaWv+N+fD0rzLn3p0LpCwV2MMn+iIJ5
   Q=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@google.com
X-IronPort-AV: E=Sophos;i="6.13,228,1732575600"; 
   d="scan'208";a="204631983"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Jan 2025 12:18:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 662F4E0D1D; Thu, 23 Jan 2025 12:18:05 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 56A5EE0077
	for <cocci@sympa.inria.fr>; Tue, 21 Jan 2025 21:18:23 +0100 (CET)
IronPort-SDR: 6790010f_fHrmE8mkUGuxS2CFMT1tCipc/7qUha2W/UK1Ix7pF/3jdO1
 F16tQEr2l8ibrTyXwD+9EUwUYvFeVc12aJcEvFA==
X-IPAS-Result: =?us-ascii?q?A0EcAgA5AJBnfLTQVdFagQmBU4JEgVY0BAtIhFawCoElA?=
 =?us-ascii?q?1YPAQMBDUQEAQEDBIIMjWoCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQIQAQEiGQcOEimFew2CW4EsgSYBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEXAkdcER0BATglDwImAiMSAQUBNSKCX4JlA6dCgQVCikR6gTKBAYIMAQEG3?=
 =?us-ascii?q?B+BZAkUgQYugliDJ4JPAYFsh3x6JxuCDYEVNYMzaYF4AoItgw6CaYI2hTOfN?=
 =?us-ascii?q?CYJHQMHBw4rSQ8FHANZLAFVExcLBwWBcQECAXEigUl7gkZpSToCDQI1gh58g?=
 =?us-ascii?q?iuDHYE9ghiCLUeECoVeghSCEYF0gwIdQAMLYgs9NxQbTJxVPIQ/MROCS5M1k?=
 =?us-ascii?q?2SfT4QlhG+DdZh8M6pTmHypHBEjgUQ6Lg6BIDMaCBsVbAaCME8DGQ+SG71aR?=
 =?us-ascii?q?TI8AgcLAQEDCZACgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 J85q6ZhI4xb55DLhZYUhg==
IronPort-HdrOrdr: A9a23:kYdH9aH5VUZea//opLqExceALOsnbusQ8zAXPiFKOGVom6mj/f
 xG885rtyMc5AxhO03I+urhBEDjewK5yXcd2+B4VotKNzOW31dAQrsSi7fK8nnPH2nQ+uZByb
 xtacFFebjNJGk/o8K/zgfQKbkdKRq8nJxAR92y856gd29XgmhbjjtENg==
X-Talos-CUID: 9a23:1J+xqG+GA0i1aQ0idPeVv1wWA8s1fEzE8CzvfF2VIjhieLCYUkDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AUf1nEw3e3I6dXMK7t0sRZRTD7jUjzJjtDkUBj7g?=
 =?us-ascii?q?/sNi6HDNWPDyxvAaUXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,223,1732575600"; 
   d="scan'208";a="204304363"
X-MGA-submission: =?us-ascii?q?MDG5ki8Z366CLAOpzQN0mVRtpBzWTjmjB25+dc?=
 =?us-ascii?q?RwuYcAsBCSAQ7VSlQKLXsWCnXvDSotosBeBPNSdfROXTHX+bDlncvHf+?=
 =?us-ascii?q?CEKpa/gsiaWq78jiPulMaTnqYr3bZ79r1EsfigZMYDKRkLCCpnFcK5RT?=
 =?us-ascii?q?USG7W9vMY4FvuDkiZJ/mZKqg=3D=3D?=
Received: from mail-lj1-f180.google.com ([209.85.208.180])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 21:18:23 +0100
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30229d5b21cso51275291fa.1
        for <cocci@inria.fr>; Tue, 21 Jan 2025 12:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737490701; x=1738095501; darn=inria.fr;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KPT9vtHtatTEvuzmSIVsLzreZj3REB5vcVBl/dJM3qM=;
        b=n2DkuAYpdSRrMry4IZ7tuatOwFpHBwrYvYV9pR+fX7SrVCAFkrTgvyV8eBhLc/4jPn
         mTIFmeNaBAgmTAw8STMOVmt93FvoQkiJcELWKgsdconTTmsIVCWL+juu8O6xQjUci4qW
         E99275IFCxxOjV2o68W8GpaIhxhi5pmRtsw5uRF61KPsTSGaWRN5lwUENzKVR0ZloJYL
         Ap9PFXzp+VwIXvpcdKBH2MQ1mjftjVQC9s+OrszyQwN7qOr9rOnr32kXYIb3xQwt+yUg
         NdnGtyyZsmOTMk7Fl46Squ7/PBc/3NexTzWkyVDqVI0pVOHRyzN3jp/V9SMxoY0IUjy/
         NyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737490701; x=1738095501;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KPT9vtHtatTEvuzmSIVsLzreZj3REB5vcVBl/dJM3qM=;
        b=gBxvbAzIS/Ia5/1YuJaQ6+68IUE+7qgsm+ok3+uKRyNcl+5S8ECi+bcLOkomEvYx53
         oRtimSEp0xHlBjjeEkifK+hNQgXcm2iKEVtKIMXyaBbKeuDNUQJqZCRoADsp1dc942gR
         0naqTPqxH5o372cQr86skOzJTxqYRZGr6lKa4odo6eCfPlluLvPXvmYC6bvh0r8zy9X1
         7IGcZSHO6Ju+zw3wtJsIrXDXNFdLvG9LCSJAUcuX8cSs5DHL3mwPtaAhiKbVqp/ndoSV
         z4J2LvTQq66VLLALKGUJ55NvdJ2qFUAxwrx2Fc/t5VNisLbc60r0beECtl3+gQsy6YeW
         /EHA==
X-Gm-Message-State: AOJu0Yw0jO//jaHZtzlRnfm5f1LpR9/OsFJJGub86qkvsfJc3L+bDM/D
	DDYLOce3Vgc/M/K2c1qSMf6f967Um2NHKzpKsTyGGR6LoF64QcxbOtxN2CyPgKk3GRR/PRpwpaL
	OCAsSNI6S0F1wZlk1caTFb+bnxrfmVfLUaaZ5eLaV5faGngTLxf47
X-Gm-Gg: ASbGncvWN/0QYqupsdCOyIlx15jMJp8NljTiU1rJ48unJeWhZInvc771LfPjobBCvZa
	Wjj21mBKNdPh09y4hmTXnke3hfh1L7A2zmoIRUH+YtLkqgJTwBw==
X-Google-Smtp-Source: AGHT+IFmcTq3tEMnt7CedBey7//S6K6MLnCpRaXdLPyZ90ydxY1L/8zOssBYojEv5NVuiPFhfVr+/YwP4V4JJYVvcjE=
X-Received: by 2002:a05:651c:546:b0:306:26cf:1305 with SMTP id
 38308e7fff4ca-3072cb81105mr67472791fa.35.1737490700639; Tue, 21 Jan 2025
 12:18:20 -0800 (PST)
MIME-Version: 1.0
From: Ricardo Ribalda <ribalda@google.com>
Date: Tue, 21 Jan 2025 21:18:08 +0100
X-Gm-Features: AbW1kvZ36kYc9eAPFuGwh25X1jbYinuOMR64lIRL8pPj1mRcO_L80X0mnTNs6GM
Message-ID: <CANiDSCvLCaMdJVSMahNgg1UQMh3naoTrWGh=9+4p8pePWyLStg@mail.gmail.com>
To: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] linux-next: virtual rule report not supported
Reply-To: Ricardo Ribalda <ribalda@google.com>
X-Loop: cocci@inria.fr
X-Sequence: 2219
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/CANiDSCvLCaMdJVSMahNgg1UQMh3naoTrWGh%3D9%2B4p8pePWyLStg%40mail.gmail.com>

Hi

While trying out linux-next I have hit an error in cocci:

$make coccicheck M="$dir" MODE=report
...
/usr/bin/spatch -D report --no-show-diff --very-quiet --cocci-file
/workdir/scripts/coccinelle/misc/secs_to_jiffies.cocci --patch
/workdir --dir . -I /workdir/arch/x86/include -I
/workdir/arch/x86/include/generated -I /workdir/include -I
/workdir/include -I /workdir/arch/x86/include/uapi -I
/workdir/arch/x86/include/generated/uapi -I /workdir/include/uapi -I
/workdir/include/generated/uapi --include
/workdir/include/linux/compiler-version.h --include
/workdir/include/linux/kconfig.h --jobs 64 --chunksize 1
virtual rule report not supported
coccicheck failed
make[1]: Leaving directory '/workdir/drivers/media'
make[2]: *** [/workdir/Makefile:2094: coccicheck] Error 255
make[1]: *** [/workdir/Makefile:251: __sub-make] Error 2
make: *** [Makefile:251: __sub-make] Error 2

Deleting scripts/coccinelle/misc/secs_to_jiffies.cocci "works"





-- 
Ricardo Ribalda
Software Engineer
ribalda@google.com
