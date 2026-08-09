Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90422C5AD4E
	for <cocci@archiver.kernel.org>; Sun,  9 Aug 2026 16:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=DKhMoDE1vjjp/Bzti/o7BbIkPBVU8A/Do/SECguGYkA=;
  b=dQYJQgweHuEoWOcm7YBYknbbIggIwAtfW0Y5t32re8R3Du50+NzHKav/
   yrl+eIcesT+ilNu2FBOYAIHPX8MyQ8fx/Psr+n3TSsSnPSwdCV++qfu6k
   WiFhl0geq3QcvGkEF9wq9Ir/me2P3Mm2vVHor3i0NQmmU9nWwX0H4hXiG
   Q=;
X-CSE-ConnectionGUID: /wg0B4KmR06PB9YwpFXonQ==
X-CSE-MsgGUID: KOViQj3zRO2BrsyWIm7RlQ==
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
X-IronPort-AV: E=Sophos;i="6.25,214,1779141600"; 
   d="scan'208";a="289600694"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Aug 2026 18:53:54 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 20A4180F0A; Sun,  9 Aug 2026 18:53:54 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 8F1BA802DA
	for <cocci@sympa.inria.fr>; Sun,  9 Aug 2026 18:53:52 +0200 (CEST)
X-CSE-ConnectionGUID: GVEKbVYtQ12viG2atoAnrw==
X-CSE-MsgGUID: tjk0pRixQkeqdfjTG4XYSw==
X-IronPort-AV: E=Sophos;i="6.25,214,1779141600"; 
   d="scan'208";a="289600684"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.102.196])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 18:53:52 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	Ricardo Ribalda <ribalda@chromium.org>
Date: Sun,  9 Aug 2026 18:53:40 +0200
Message-Id: <20260809165340.1719736-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [cocci] [PATCH] coccinelle: scripts: coccinelle: devm_free: reduce
 false positives
Reply-To: Julia Lawall <Julia.Lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3669
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/gmAzhHqpI9Vvh2qAu8qV0g>

False positives could be introduced due to allocations using the new
_obj functions.  Add these to the "safe" rule accordingly.

False positives could also be introduced when the same variable
name has two possible types.  Incorporate type informationt to avoid
reporting this case  This does lead to false negatives when no type
information is available.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Reported-by: Ricardo Ribalda <ribalda@chromium.org>

---
 scripts/coccinelle/free/devm_free.cocci |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/scripts/coccinelle/free/devm_free.cocci b/scripts/coccinelle/free/devm_free.cocci
index 0880729ba..947d7e685 100644
--- a/scripts/coccinelle/free/devm_free.cocci
+++ b/scripts/coccinelle/free/devm_free.cocci
@@ -26,7 +26,8 @@ virtual report
 virtual context
 
 @r depends on context || org || report@
-expression x;
+type T;
+T x;
 @@
 
 (
@@ -56,18 +57,26 @@ expression x;
 )
 
 @safe depends on context || org || report exists@
-expression x;
+r.T x;
 position p;
 @@
 
 (
  x = kmalloc(...)
+|
+ x = kmalloc_obj(...)
+|
+ x = kmalloc_objs(...)
 |
  x = kvasprintf(...)
 |
  x = kasprintf(...)
 |
  x = kzalloc(...)
+|
+ x = kzalloc_obj(...)
+|
+ x = kzalloc_objs(...)
 |
  x = kmalloc_array(...)
 |
@@ -105,7 +114,7 @@ position p;
 )
 
 @pb@
-expression r.x;
+r.T r.x;
 position p != safe.p;
 @@
 

