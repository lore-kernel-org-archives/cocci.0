Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFADD2ECF7
	for <cocci@archiver.kernel.org>; Tue, 20 Jan 2026 10:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=Nlou64nYMOBcyUqd2ccm2AWusSoW1FtniTuMk2SuGkY=;
  b=LsTtlScXdU8sY9mpZ00TgTtFUgcSnrwZGKFFnXAzJUJBGTRaL03z/yPf
   appU0z6zRtpesws20edOLF2AG2C+/bfbf6HOVDAJW8rRjzZm9EK7IwhtU
   UVjp82pEy/RaZJU7DAr0x6q3vzZ77mECmXAzmkXmPGVuZpyGeI2v45fEb
   E=;
X-CSE-ConnectionGUID: lu7HID3IRW+udHJac9Bz6w==
X-CSE-MsgGUID: Ple4B8tWQ2aSKxRslYXMJA==
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
X-IronPort-AV: E=Sophos;i="6.21,240,1763420400"; 
   d="scan'208";a="259430405"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jan 2026 11:48:37 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 133EA83A08; Tue, 20 Jan 2026 11:48:37 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 87FF781EBC
	for <cocci@sympa.inria.fr>; Tue,  6 Jan 2026 20:09:08 +0100 (CET)
X-CSE-ConnectionGUID: YTFZnOjuSQKtUJ6CtZfFUQ==
X-CSE-MsgGUID: DKzicQFARGux0UXeOLiDKA==
IronPort-SDR: 695d5dd4_i+c1u8l3U5TDw0de2hKF8nrNynhEWQ1AxuwvWyHJhZLiiSe
 5ZhYr5IO8gZr2wg1ePCdU9gAD2Dg1qLAr9uBiYA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EpBQCkXF1pgcHWVdFaglkCgj+BZjMEVKIWMAKHU4pOg?=
 =?us-ascii?q?UA9Ag8BAwELAQFPAgQBAQMEhHYKjGwCHgcBBDAJDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEBAQENAQEFAQEBAgEBAgQGAQIQAQEiGQcOO4ZPDUkBDAEIAYICAYEkYQIFA?=
 =?us-ascii?q?zsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAixhFiABD?=
 =?us-ascii?q?QEbHQEDEhBdEQEFASIBCiqCYIIjAQYQAQM2AgGkfYEFQoxTBQIWgQGCDQbaY?=
 =?us-ascii?q?woZKA1uA4FjAgcJAQsBgTcBhHUpTw6COYUdcYN+gSGCKIR9hFiGDSIEgg2BD?=
 =?us-ascii?q?xSVEgEHBx8SCAEcBggCAkgVEgMEAwQEAQILEwkDAwIOAggDAggGGQE/EgQTA?=
 =?us-ascii?q?ggDBgQLBwUfCgIMFAooIhICKQoDKgsSDwMTBRUBCAYCAgQEAgQMAgkCAgUDB?=
 =?us-ascii?q?AIEDQMEAQEIAgItAwEDGQgJCAILBREYDAsFAgonAw8BCQMfAwwIGAoBAQUWO?=
 =?us-ascii?q?AIJBgQVASAJBQMGAgULAg4BDwIUAgEDAQEGAgQEAwoGAgYFAgIBBAMHAgECA?=
 =?us-ascii?q?QIIAwIHAwIDAgEPGAMCAwoCBgUEBgICAwMEAgICCQEDBgEBAQECAgIDAgIFB?=
 =?us-ascii?q?gYIBAQEAQERCiABAwUCBAcCAQMCAgEEAQEDAwIBAgECAwECAgQCAwMDAwMEB?=
 =?us-ascii?q?QMBAQMCAwUCAgMCAgICBAEBAwsBAgQDAQUBBwUDAQMFAwQEAwIEBQMKAgIEA?=
 =?us-ascii?q?gMDBgMDBgMCBQIHAgIBBQUCAQEBAQwJAgICBwMOAwICAgMEAQIDBAMFAgMEA?=
 =?us-ascii?q?QEBAQQFAgMDAgIBAwUCAgEBAgIEBAIDAwYCBAIOAgEFGhEBAgYGAwIBAwUDA?=
 =?us-ascii?q?wMDAwIEAgICAgYHCwwEBAQDBQMDBQYDAQMEAwgDCgIEGAYFAgICAQIMDwMBA?=
 =?us-ascii?q?goEBAMCBQIGCQMCAwMEAQM5HBMEBQIFAwMBOgMOBAMIHgIBAQIGAgEDAwMFA?=
 =?us-ascii?q?gMBAwIHAxQGAQYIAgQECgIDAwcGBQcCESgEAgICAgQDAwMKCAcEAwEHAwMMA?=
 =?us-ascii?q?gIQAgMHBAIDEwYDAwQDDAYDAQISGAYBAwcDCAMCBwQCCAcNAgQCCQMFBQEVB?=
 =?us-ascii?q?AIEAwICAgIBMQMDAwUHAgQBBAYBAwMDBwMCDAICAhIDBQIFBgIBAwwDBAMDB?=
 =?us-ascii?q?QULLRAEBxMKBgQDAwcFAgMCAhQGAgYMEgMDBAEEAgECAgI6BAMDCAENGg4CB?=
 =?us-ascii?q?AYFCgMDBAYBGAUCAwIDBQEDAQcHEgIKCAMOHgEDAgYCCQEDAQIBBxMPAwsJC?=
 =?us-ascii?q?AcMATwMBwokBAQMKgEGDhQHBCUZZwcHApALgndjASoBg3kBAQGVPY8PoGIlC?=
 =?us-ascii?q?QEGAQGCR4EKFTiBZJ90GjOEBJNOR5JSmQYipDeEPQIKBwcRJBKBMjqBXDMaI?=
 =?us-ascii?q?4EBbYFJTwMZD5Ihw2k7NTwCBwsBAQMJhUMmE4RZhVWBdIFLAQE?=
IronPort-PHdr: A9a23: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
 JrqpHVFiVsLUQ==
IronPort-Data: A9a23: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
 bAJeF15
IronPort-HdrOrdr: A9a23:OTPyEKhlSGJ+YTEISMANVNbjqnBQXvQji2hC6mlwRA09TyVXrb
 HLoB19726PtN91YhsdcL+7Sc+9qB/nhPxICOoqTMyftWvdyRKVxehZhOOIsl7d8kXFltK1vp
 0QFJSWZueAaGRSvILV5E2XHb8br+VvM5rFuQ4d9RpQpM1RBZ2Ilz0Jcjpz23cWeDV7
X-Talos-CUID: 9a23:M1zZCGDMloOwulH6Exhb2nwSPcI4SUT+0EryfWSkO2hHdYTAHA==
X-Talos-MUID: 9a23:5VhocARV+I6pVRsTRXTApyNjP/5Gyp6BFVBVrKULnO2FGQ9ZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,206,1763420400"; 
   d="scan'208";a="257289649"
X-MGA-submission: =?us-ascii?q?MDGDasw6FXhP6/QvE3GHe8CRYTEtqWhEthXRMF?=
 =?us-ascii?q?WWf6LjDf6e/r0J7qY4qPjZ3v9LpiBQl/THt9Er/1Sz30OAKbl8hJcoAM?=
 =?us-ascii?q?WKotiC4ELELCPbzXhkrVMS0LCcW9Qynpf4w8toZsjsEqfUkhkkSUMwjV?=
 =?us-ascii?q?0ulK8OFf38SCDXqJYV3nv0fQ=3D=3D?=
Received: from mail-pl1-f193.google.com ([209.85.214.193])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 20:09:07 +0100
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-29f102b013fso15892455ad.2
        for <cocci@inria.fr>; Tue, 06 Jan 2026 11:09:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767726546; x=1768331346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nlou64nYMOBcyUqd2ccm2AWusSoW1FtniTuMk2SuGkY=;
        b=QQudqmaQavtQIn4Tpht8epZbDGwoBV5A57fjRMbXxAKRuxJnMvA1Bn+AxoC8TS8xdj
         /OA+539hxiqis9k5kMbKuHbBJwKkayse3R3mwVtBAmSyjMsM6ZqHVXb6f2Dv3s1BR2Lm
         JI6mgm53EeSds4TWyvYeKQLzXTVlpvOHooEkjOjEFUzRadN1YFmbmPlgAWkuIknjXiUt
         dYScvHneGY/iBWzQsy7qsSWn5k+/8hwXYjfVZfIqJhkD7K61fuLkRBFoUAtE6fPesX0J
         fAcI5/pQM5qphHjtuLCKGU9EMoqMBg7o5/KZP5gWaQ5k62BmOFvi3/2fozx2zMa2tiTm
         3arA==
X-Gm-Message-State: AOJu0YyIMnfMRTEOljrKjtqOpDnV/IRUFqiYvIJoHlY0B0iH16Hos2Rz
	zGkfxbbA6DDU/i96eAfGOtUKYosi1wRayyKomXp8D+wBtgwD7mfF2e6vJ7+mmSpn
X-Gm-Gg: AY/fxX5FzIeHZ/iJ+8xWYd/crasVLuTC56R7JES6tfSOthfimn2W1Q6h0dsF10GbQc9
	sJUN6agYmvwVgorljsxs89xITW5xCzUH3tEq8UhqHNcCbW7ZPKR6ACzFJCKta/wRsFiooOUQTGd
	bw6zYTpSQfjvJG6PqfffXNYAxobnMrFMX2VpXoaGAMWKewB7V0bDYGL9bfvYlzIUW4GPz7c+enz
	8Vf7sNlUEtF1R7gaz5SE7sJTUw0HKCEHAihc/u2ArSHlruG/rL/4e92BYqLiI2JVnLsk38ysBfx
	+k6N5o2qLzR/Xc1KupuSklheH+KA2rvxXY2ElqyCPV6LjUbB93q4tVaCMr36R7LLa4176jDVDd4
	hGpAeY/UOPxakNaLWtQE8XPZfBhziY1P7rMxr0pTJv3NzMNlgt0Qgxk+17t+8zvUDjhUWBBt7nI
	/dY+EE+XRGpkcXnsKlcA==
X-Google-Smtp-Source: AGHT+IHzNi2QQ6a6YY1+BH+FZtHb24yA4doMuZNruN/8XQ2zpvmyGpEfI/vMxw9xDkIfGB9AU9JdUQ==
X-Received: by 2002:a17:903:1208:b0:2a0:be59:10cc with SMTP id d9443c01a7336-2a3e2df52a1mr36627905ad.32.1767726546276;
        Tue, 06 Jan 2026 11:09:06 -0800 (PST)
Received: from rivendell ([101.0.62.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc78c0sm29380975ad.69.2026.01.06.11.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 11:09:05 -0800 (PST)
From: Benjamin Philip <benjamin.philip495@gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Jonathan Corbet <corbet@lwn.net>
Cc: cocci@inria.fr,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Benjamin Philip <benjamin.philip495@gmail.com>
Date: Wed,  7 Jan 2026 00:38:33 +0530
Message-ID: <20260106190836.36630-1-benjamin.philip495@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH RESEND 0/3] scripts: coccicheck: document debug log
 handling
Reply-To: Benjamin Philip <benjamin.philip495@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3281
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/_Tabd-QesLDVKKs1kd0D-A>

Currently coccicheck prints debug logs to stdout unless a debug file has been
set. This makes it hard to read coccinelle's suggested changes, especially for
someone new to coccicheck.

This patchset documents this behaviour in both the coccicheck script as well as
in the dev-tools documentation. Additionally, it simplifies some of the logic
for handling debug files.

Benjamin Philip (3):
  scripts: coccicheck: simplify debug file handling
  scripts: coccicheck: warn on unset debug file
  Documentation: Coccinelle: document debug log handling

 Documentation/dev-tools/coccinelle.rst | 21 ++++++++++++++++-----
 scripts/coccicheck                     | 21 +++++++++++++--------
 2 files changed, 29 insertions(+), 13 deletions(-)

-- 
2.52.0

