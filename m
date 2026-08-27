Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0C2C61DC6
	for <cocci@archiver.kernel.org>; Thu, 27 Aug 2026 11:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=NdlWtn7RhMPXbLXNfq/H5zVLJOCgx5THX1L6YT/apfY=;
  b=Xx4OQmC3IW/Pdv3LMrL1NUFzg9UZ9+ftSu5pgtARMwnRMQB8a1ltfo2c
   4YL4DYeOy4ZX6fnpMqVEJvYMss+JV6Z4TyTeKLIiAOE7okrJazkB5l7Qs
   gNyZbsSXJ6hhOv/UQssTRcEbPMG99piD1rLqbzGnx3Lulb7MSiZusOMWB
   c=;
X-CSE-ConnectionGUID: XtxedAjmT4q/7ZIA3ghDgg==
X-CSE-MsgGUID: 2DZ6yYRYRQ6QE+xQ77NtOw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.25,246,1779141600"; 
   d="scan'208";a="291799595"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Aug 2026 13:29:59 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 2E98380594; Thu, 27 Aug 2026 13:29:59 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 8B94A804AB
	for <cocci@sympa.inria.fr>; Thu, 27 Aug 2026 13:29:54 +0200 (CEST)
X-CSE-ConnectionGUID: c44e6LymSu2elag5f+2Slg==
X-CSE-MsgGUID: 1ilguNujREWSBp3neebU0w==
X-IronPort-AV: E=Sophos;i="6.25,246,1779141600"; 
   d="scan'208";a="291799574"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.102.196])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 13:29:54 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Ricardo Ribalda <ribalda@chromium.org>,
	dmitry.torokhov@gmail.com,
	bentiss@kernel.org,
	cocci@inria.fr,
	corbet@lwn.net,
	hadess@hadess.net,
	jikos@kernel.org,
	lains@riseup.net,
	linux-doc@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nicolas.palix@imag.fr,
	skhan@linuxfoundation.org
Date: Thu, 27 Aug 2026 13:29:49 +0200
Message-Id: <20260827112949.2431233-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [cocci] [PATCH] HID: fix semantic patch and improve its performance
Reply-To: Julia Lawall <Julia.Lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3715
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/jLk6gjz2Ugr_jYFKN_659A>

Replace "expression" with "identifier" in the declaration of hdev.
This is necessary because hdev is used as the name of a function
parameter.

Move the two uses of @p2 to the relevant function names.

Convert <... ...>, meaning that the contained pattern is optional,
to use ..., when any, and exists.  This requires that the function
contain calls to hid_hw_start, etc, which reduces the set of files
that are considered for matching against this pattern.

Reported-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 scripts/coccinelle/hid/ff_race.cocci |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/scripts/coccinelle/hid/ff_race.cocci b/scripts/coccinelle/hid/ff_race.cocci
index 479f5d1e3..e861de00c 100644
--- a/scripts/coccinelle/hid/ff_race.cocci
+++ b/scripts/coccinelle/hid/ff_race.cocci
@@ -7,18 +7,19 @@
 
 virtual report
 
-@r@
+@r exists@
 identifier probe_fn;
-expression hdev, flags;
+identifier hdev;
+expression flags;
 position p1, p2;
 @@
 
 probe_fn(struct hid_device *hdev, ...) {
-  <...
+  ... when any
   hid_hw_start@p1(hdev, flags)
   ...
-  \(input_ff_create\|input_ff_create_memless\)@p2(...)
-  ...>
+  \(input_ff_create@p2\|input_ff_create_memless@p2\)(...)
+  ... when any
 }
 
 @script:python depends on report@

