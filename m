Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BF0D2ED0F
	for <cocci@archiver.kernel.org>; Tue, 20 Jan 2026 10:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=7ZDIxAuQXdSZKM+omOFdw1K6fCzWMGD3B/LiysTgYjs=;
  b=rVRR1ZMN43HsolrcMKsazrXb8c51Fm10SraTeViLLGxltDhOC/R4eaqr
   pqjGXTgc555u64fBCPcIXVO8C1KNHty0ZGvvaYCgtAJS5GfPvJX5k+Fgg
   WcoZuSwn85ujHH6k8ScFwNpX/UZ1agHYVUcCH7Uf4z8tpPT6mdO6cG7tP
   s=;
X-CSE-ConnectionGUID: HyXZww9hTj+rkbRBqjGb7Q==
X-CSE-MsgGUID: zZKxLw72S2GHMqeJ5tyxjQ==
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
   d="scan'208";a="259430495"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jan 2026 11:48:43 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id F335D83A0A; Tue, 20 Jan 2026 11:48:42 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 1CA4381EBC
	for <cocci@sympa.inria.fr>; Tue,  6 Jan 2026 20:09:33 +0100 (CET)
X-CSE-ConnectionGUID: 0KqKESn1QkSBpGMQA622UQ==
X-CSE-MsgGUID: 0779+J+/SByi+1/fAUEGmQ==
IronPort-SDR: 695d5dec_YfGnxHPZwMQOz3A+E5Q5GSudNxrloFbi9ojRQZjAROEymFM
 KE5DUObz7F5o5IOHRuxsB/0PdKa8ZhdCNCuHGzA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GaBACkXF1pfMPWVdFaglkCgj8WgVAzBFSWTItKMAKSI?=
 =?us-ascii?q?YFAPQIPAQMBCwEBTwIEAQEDBDiESAKMagIeBwEEMgcOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQ0BAQUBAQECAQECBAYBAhABASIZBw4SKYZPDUkBDAEIAYICAYEkY?=
 =?us-ascii?q?QIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAixfA?=
 =?us-ascii?q?gEDEiABDQEbHQEDDAYQOyACEQEFARwGAQoIIoJggiMBBhABAzYCAaR9gQVCj?=
 =?us-ascii?q?FMFAhaBAYINBlPaEAoZKA1uA4FgAQICBwkBCgEBgTcBhHUpTw6COAGFHXGDf?=
 =?us-ascii?q?nongiiBFYNogh+COYYNIgSCDYEjgR+DIJBTAQcHHxIIARwGCAICSBUSAwQDB?=
 =?us-ascii?q?AQBAgsTCQMDAg4CCAMCCAYZAT8SBBMCCAMGBAsHBR8KAgwUCigiEgIpCgMqC?=
 =?us-ascii?q?xIPAxMFFQEIBgICBAQCBAwCCQICBQMEAgQNAwQBAQgCAi0DAQMZCAkIAgsFE?=
 =?us-ascii?q?RgMCwUCCicDDwEJAx8DFBgKAQEFFjgCCQYEFQEgCQUDBgIFCwIOAQ8CFAIBA?=
 =?us-ascii?q?wEBBgIEBAMKBgIGBQICAQQDBwIBAgECCAMCBwMCAwIBDxgDAgMKAgYFBAYCA?=
 =?us-ascii?q?gMDBAICAgkBAwYBAQEBAgICAwICBQYGCAQEBAEBEQogAQMFAgQHAgEDAgIBB?=
 =?us-ascii?q?AEBAwMCAQIBAgMBAgIEAgMDAwMDBAUDAQEDAgMFAgIDAgICAgQBAQMLAQIEA?=
 =?us-ascii?q?wEFAQcFAwEDBQMEBAMCBAUDCgICBAIDAwYDAwYDAgUCBwICAQUFAgEBAQEMC?=
 =?us-ascii?q?QICAgcDDgMCAgIDBAECAwQDBQIDBAEBAQEEBQIDAwICAQMFAgIBAQICBAQCA?=
 =?us-ascii?q?wMGAgQCDgIBBRoRAQIGBgMCAQMFAwMDAwMCBAICAgIGBwsMBAQEAwUDAwUGA?=
 =?us-ascii?q?wEDBAMIAwoCBBgGBQICAgECDA8DAQIKBAQDAgUCBgkDAgMDBAEDORwTBAUCB?=
 =?us-ascii?q?QMDAToDDgQDCB4CAQECBgIBAwMDBQIDAQMCBwMUBgEGCAIEBAoCAwMHBgUHA?=
 =?us-ascii?q?hEoBAICAgIEAwMDCggHBAMBBwMDDAICEAIDBwQCAxMGAwMEAwwGAwECEhgGA?=
 =?us-ascii?q?QMHAwgDAgcEAggHDQIEAgkDBQUBFQQCBAMCAgICATEDAwMFBwIEAQQGAQMDA?=
 =?us-ascii?q?wcDAgwCAgISAwUCBQYCAQMMAwQDAwUFCy0QBAcTCgYEAwMHBQIDAgIUBgIGD?=
 =?us-ascii?q?BIDAwQBBAIBAgICOgQDAwgBDRoOAgQGBQoDAwQGARgFAgMCAwUBAwEHBxICC?=
 =?us-ascii?q?ggDDh4BAwIGAgkBAwECAQcTDwMLCQgHDAE8DAcKJAQEDCoBBg4UBwQlGWcHB?=
 =?us-ascii?q?wKQC4J3PQ0ZGBMBE4NmAQEBkhqDI4xxgh6fU01CJQkBBgEBgkeBChU4gWSZe?=
 =?us-ascii?q?IV8GjOEBJNOR5JShTyTSiKRcJJHhD0CCgcHESQSgTkDMIFcMxojgQFtgUlPA?=
 =?us-ascii?q?xkPkiHDaTs1PAIHCwEBAwmFQyYThFmFVYF0gUsBAQ?=
IronPort-PHdr: A9a23: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
 Mz0x5ql8w1mZd8xY6fXIfgRpmU=
IronPort-Data: A9a23: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
 ITteV15fQ==
IronPort-HdrOrdr: A9a23:i7Su0Kl7Lol/5olbYcuW9nan3sHpDfIB3DAbv31ZSRFFG/Fwz/
 re5cjzpiWE8Ar5OUtQ5exoXZPrfZqyz+8T3WB8B9eftWrdyRSVxeNZnO3fKlTbckWUmoEytJ
 uIGJIOauEYeGIK6foSlzPIdurIruP3k5xAzt2utEuFBTsaEZ2IMD0VNu+0KDwKeDV7
X-Talos-CUID: 9a23:njDipmNu6VgL3O5DAAp+12MvHJkccUb31Fj1GmbmUzxUcejA
X-Talos-MUID: 9a23:VoGRyApRAXfNdimR+G0ez2k9a5YrwefpM2ockNZf/MetCAFfPg7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,206,1763420400"; 
   d="scan'208";a="257289690"
X-MGA-submission: =?us-ascii?q?MDGMkDhU1xmtz7l1SQmyE6qb13ud6YXVKEtT5S?=
 =?us-ascii?q?euFVyhvVR0T4GRY5xtbCk8YcCDky4XNt3VW8JDVj5jEkajZOpTjGdRR1?=
 =?us-ascii?q?XXhwo8ZBAVaPZzlfydAIj9iO4V4Q65gMlX9zyIlG3isuyUjzJfB+7Nkp?=
 =?us-ascii?q?Sah0GZ4TbzMiEM2KAZN+Ba4Q=3D=3D?=
Received: from mail-pl1-f195.google.com ([209.85.214.195])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 20:09:32 +0100
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a0a33d0585so10591255ad.1
        for <cocci@inria.fr>; Tue, 06 Jan 2026 11:09:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767726571; x=1768331371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ZDIxAuQXdSZKM+omOFdw1K6fCzWMGD3B/LiysTgYjs=;
        b=TVZtcUB6jumeSE8rAUgbgB1ISwrLUyjcxq+X2USlalF4e5GCXn4fKqTSN6Tc5ZeCal
         dZmyf3hYsF9FFaf936wASyVxLNa17fHZO9swPhi38PYzoxz944LW7/g02UqYyl/vh/dB
         kTUTgxlx0q+ow0/j4F9VZyUIZnY1oibebRVCUuPf4BLLhUf747G2LNmiDgOpzdVk49Np
         k2qN6H6/yaBmMJmHfQcIs4BmDq6/ZJDa5AwujPabElUPWkuKz94tVxkbJ8BtBB9+HL/v
         /OZaPhRvZVFZ2o1OP4L4h4lAbOGXkhUUSI9cyQBXQS4fWs54DtAjnDQgqoDI9uIzH6Wt
         jjUQ==
X-Gm-Message-State: AOJu0YyFPs/z08J9a/atUw60En7eqgej8zJPm6VW0knm1sKLq8gMQdpB
	VdZ11d5ZxAmqyJfM00mpKRdRtGz3d4S1n+2yKdlwRAyrcHUYZVO4VG4T
X-Gm-Gg: AY/fxX6MeQsG3uMT92zU9rIfs1KpNU9aFz+er7IGY8ghGLWYpVwU/xF532E9S/Do7Dn
	4eJd7KqV2VJgOkkOaZvi89uNOXNbjslwk6OgdeCAVeEOK0lybkcvocflzx4K+832ou9r7SOUTtl
	lfMboLW79UqrivEKSddrD52D35/QPkNHGVh9RKOW6/xSQUzCjJr4V9hr8ARW5RsnFMFssduHUqX
	vaQQFsPZ4M/y7FPteLgjlPQQW5h185Ag18eGHCQTjRGRvsBvgMplLsdfcqDDuVvrqW/t01Qgj5p
	EvXIVbue9JRUycYgujsml7xjWf+vISgdw/T7BkMavac+FOKwOrl8SLQYE+yEfaHDpxpdueDONwC
	pFBpXpK+t9KW+vUytlBb930Dd2l9fXgcvb/tKpJZcJk0VfSQqfAOi2UHC7CYtnBc8okrV7UDa4W
	RlVlFCmHmeHahtomdgRg==
X-Google-Smtp-Source: AGHT+IE1WFyskV9UBz53SZomuLYRFUJQlyS3/Vk4tjY//MxsM+cH3sL/yfbwmTq7HM4vYlJFb86sSA==
X-Received: by 2002:a17:902:e80d:b0:295:9db1:ff3a with SMTP id d9443c01a7336-2a3e2df5181mr37055245ad.28.1767726570816;
        Tue, 06 Jan 2026 11:09:30 -0800 (PST)
Received: from rivendell ([101.0.62.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc78c0sm29380975ad.69.2026.01.06.11.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 11:09:30 -0800 (PST)
From: Benjamin Philip <benjamin.philip495@gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Jonathan Corbet <corbet@lwn.net>
Cc: cocci@inria.fr,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Benjamin Philip <benjamin.philip495@gmail.com>
Date: Wed,  7 Jan 2026 00:38:36 +0530
Message-ID: <20260106190836.36630-4-benjamin.philip495@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106190836.36630-1-benjamin.philip495@gmail.com>
References: <20260106190836.36630-1-benjamin.philip495@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH RESEND 3/3] Documentation: Coccinelle: document
 debug log handling
Reply-To: Benjamin Philip <benjamin.philip495@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3284
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/8ehZv3THUpu66phFk4O4gw>

The current debug documentation does not mention that logs are printed
to stdout unless DEBUG_FILE is set. It also doesn't mention that
Coccinelle cannot overwrite debug files.

Document this behaviour in the examples and reference it in the
debugging section.

Signed-off-by: Benjamin Philip <benjamin.philip495@gmail.com>
---
 Documentation/dev-tools/coccinelle.rst | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 6e70a1e9a3c0..c714780d458a 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -127,6 +127,18 @@ To enable verbose messages set the V= variable, for example::
 
    make coccicheck MODE=report V=1
 
+By default, coccicheck will print debug logs to stdout and redirect stderr to
+/dev/null. This can make coccicheck output difficult to read and understand.
+Debug and error messages can instead be written to a debug file instead by
+setting the ``DEBUG_FILE`` variable::
+
+    make coccicheck MODE=report DEBUG_FILE="cocci.log"
+
+Coccinelle cannot overwrite a debug file. Instead of repeatedly deleting a log
+file, you could include the datetime in the debug file name::
+
+    make coccicheck MODE=report DEBUG_FILE="cocci-$(date -Iseconds).log"
+
 Coccinelle parallelization
 --------------------------
 
@@ -208,11 +220,10 @@ include options matching the options used when we compile the kernel.
 You can learn what these options are by using V=1; you could then
 manually run Coccinelle with debug options added.
 
-Alternatively you can debug running Coccinelle against SmPL patches
-by asking for stderr to be redirected to stderr. By default stderr
-is redirected to /dev/null; if you'd like to capture stderr you
-can specify the ``DEBUG_FILE="file.txt"`` option to coccicheck. For
-instance::
+An easier approach to debug running Coccinelle against SmPL patches is to ask
+coccicheck to redirect stderr to a debug file. As mentioned in the examples, by
+default stderr is redirected to /dev/null; if you'd like to capture stderr you
+can specify the ``DEBUG_FILE="file.txt"`` option to coccicheck. For instance::
 
     rm -f cocci.err
     make coccicheck COCCI=scripts/coccinelle/free/kfree.cocci MODE=report DEBUG_FILE=cocci.err
-- 
2.52.0

