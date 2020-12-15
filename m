Return-Path: <SRS0=J+fH=FT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB9DC2BB9A
	for <cocci@archiver.kernel.org>; Tue, 15 Dec 2020 12:56:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90351224D4
	for <cocci@archiver.kernel.org>; Tue, 15 Dec 2020 12:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90351224D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0BFCuUHj022174;
	Tue, 15 Dec 2020 13:56:30 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9583F77D9;
	Tue, 15 Dec 2020 13:56:30 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3B0023A53
 for <cocci@systeme.lip6.fr>; Tue, 15 Dec 2020 13:25:16 +0100 (CET)
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com
 [64.147.123.26])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0BFCPDqo018225
 for <cocci@systeme.lip6.fr>; Tue, 15 Dec 2020 13:25:14 +0100 (CET)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailnew.west.internal (Postfix) with ESMTP id B558A3CC;
 Tue, 15 Dec 2020 07:25:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Tue, 15 Dec 2020 07:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=0IHKA3G+trfDmCkSG+yf7UomNc
 7kttQP2WEV3qoL1cs=; b=iowRTIEJ900+1Pqb/dWa9MmZ0D/hdKL0wTU7haR2Ba
 BEI0jG6YUZ82N06FGBgynd8LxiYpkn6DodeJe+kVYDxb71Xm4Vr4zyYGFeDgHZ06
 Ec35KPnkga825wBFGaEy+7oxvTPD3yfauOE3x3ech0moTrjwx4o+bp8FdLdydWPs
 zRgCdm7R2M107lba03uocop7RilDgFyIwZuz1g5O5xLQUnDu0kIpyjklSMTbUI8k
 iJ/UzC8PQPiyFzBorfx3sC86pe3iqNkE4lO2UlV1mN+WFCM1r2MDIV7HkGGxvnwG
 jpcH3tC7l6y7GuHkKGp9Db+o0tQ6ICQuHgdgvmSnqGmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=0IHKA3G+trfDmCkSG
 +yf7UomNc7kttQP2WEV3qoL1cs=; b=mYMzOt0DHISJXKO/A5QHVLtAVZT0xuurp
 HRvo8DdBkw89tv3N+lTwfF8Uu/dFC4AnHz0mKYfqWxl2IKZZKJ6kYvki0QTcXeGs
 YRIaGWavxe8APGOLhGlso7KZwlN78X3U6gzdJ110nflq62QfkW/UUpsCgADhebMD
 /p4Gu1HpQpxQhZQoiCdrZn7dFC9rLMBXFGu1m75cyB8b9OltB/s6c7iMsEaepgvO
 Mtq7XwFI4yJeOIDfP02B+UXG+u6S+IMvGgDUcRg9FVkynC0QdY6Rg+PxRP4B+9Cx
 JzjmtLvdZNZjy9OBzcV9KXGRkRVH+5r5LTrLthfx3QVPFn18H1kVg==
X-ME-Sender: <xms:JKvYX33yX23sP6R8LmC2CeIrE3hK8lwcKGv49RWdJWP2tPdBju2lKQ>
 <xme:JKvYX2Gp6P4WRgkpCPzq3nwr_DCACwv7TL-iFaQIKexDaatEQdbdZH_txseCRPpAT
 lFEsC4hIhaEeZlAco0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeltddggedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcu
 tfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrthhtvg
 hrnhepgffhieeuffegiefgtddtkeffieeuhffhkeeggfeigeefgfefuedugfeugeefvdfh
 necuffhomhgrihhnpehlihhpiedrfhhrnecukfhppeeltddrkeelrdeikedrjeeinecuve
 hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgv
 segtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:JKvYX36cCcyFmY9PmL4UKFaf_H5jPbp34-YLdFr4FDOKi_q1Rcgjnw>
 <xmx:JKvYX81BvE_jE-3kVfHmAexq-Nu-QFemk4zPs3NaimCUsj25LnCa5A>
 <xmx:JKvYX6H2hcGO3APcQyiY3Yl_gtlQYEyufTGNat6Hr0l_xcN-8qpOxg>
 <xmx:JqvYX9BvSYVUitbvBQcI9CTSNub5gQ9eC_GwzuRquG_7Ga-gk3DnYXyD9OM>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 81DAB108005F;
 Tue, 15 Dec 2020 07:25:08 -0500 (EST)
From: Maxime Ripard <maxime@cerno.tech>
To: Julia.Lawall@lip6.fr, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net
Date: Tue, 15 Dec 2020 13:24:59 +0100
Message-Id: <20201215122459.283702-1-maxime@cerno.tech>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 15 Dec 2020 13:56:30 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 15 Dec 2020 13:25:14 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Tue, 15 Dec 2020 13:56:28 +0100
Cc: Jani Nikula <jani.nikula@intel.com>, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime@cerno.tech>,
        Thierry Reding <treding@nvidia.com>, cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH v2] coccinnelle: Remove ptr_ret script
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

The ptr_ret script script addresses a number of situations where we end up
testing an error pointer, and if it's an error returning it, or return 0
otherwise to transform it into a PTR_ERR_OR_ZERO call.

So it will convert a block like this:

if (IS_ERR(err))
    return PTR_ERR(err);

return 0;

into

return PTR_ERR_OR_ZERO(err);

While this is technically correct, it has a number of drawbacks. First, it
merges the error and success path, which will make it harder for a reviewer
or reader to grasp.

It's also more difficult to extend if we were to add some code between the
error check and the function return, making the author essentially revert
that patch before adding new lines, while it would have been a trivial
addition otherwise for the rewiever.

Therefore, since that script is only about cosmetic in the first place,
let's remove it since it's not worth it.

Acked-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Acked-by: Julia Lawall <julia.lawall@inria.fr>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---

Changes from v1:
  - Collected the tags

 scripts/coccinelle/api/ptr_ret.cocci | 97 ----------------------------
 1 file changed, 97 deletions(-)
 delete mode 100644 scripts/coccinelle/api/ptr_ret.cocci

diff --git a/scripts/coccinelle/api/ptr_ret.cocci b/scripts/coccinelle/api/ptr_ret.cocci
deleted file mode 100644
index e76cd5d90a8a..000000000000
--- a/scripts/coccinelle/api/ptr_ret.cocci
+++ /dev/null
@@ -1,97 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-///
-/// Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR
-///
-// Confidence: High
-// Copyright: (C) 2012 Julia Lawall, INRIA/LIP6.
-// Copyright: (C) 2012 Gilles Muller, INRIA/LiP6.
-// URL: http://coccinelle.lip6.fr/
-// Options: --no-includes --include-headers
-//
-// Keywords: ERR_PTR, PTR_ERR, PTR_ERR_OR_ZERO
-// Version min: 2.6.39
-//
-
-virtual context
-virtual patch
-virtual org
-virtual report
-
-@depends on patch@
-expression ptr;
-@@
-
-- if (IS_ERR(ptr)) return PTR_ERR(ptr); else return 0;
-+ return PTR_ERR_OR_ZERO(ptr);
-
-@depends on patch@
-expression ptr;
-@@
-
-- if (IS_ERR(ptr)) return PTR_ERR(ptr); return 0;
-+ return PTR_ERR_OR_ZERO(ptr);
-
-@depends on patch@
-expression ptr;
-@@
-
-- (IS_ERR(ptr) ? PTR_ERR(ptr) : 0)
-+ PTR_ERR_OR_ZERO(ptr)
-
-@r1 depends on !patch@
-expression ptr;
-position p1;
-@@
-
-* if@p1 (IS_ERR(ptr)) return PTR_ERR(ptr); else return 0;
-
-@r2 depends on !patch@
-expression ptr;
-position p2;
-@@
-
-* if@p2 (IS_ERR(ptr)) return PTR_ERR(ptr); return 0;
-
-@r3 depends on !patch@
-expression ptr;
-position p3;
-@@
-
-* IS_ERR@p3(ptr) ? PTR_ERR(ptr) : 0
-
-@script:python depends on org@
-p << r1.p1;
-@@
-
-coccilib.org.print_todo(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
-
-
-@script:python depends on org@
-p << r2.p2;
-@@
-
-coccilib.org.print_todo(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
-
-@script:python depends on org@
-p << r3.p3;
-@@
-
-coccilib.org.print_todo(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
-
-@script:python depends on report@
-p << r1.p1;
-@@
-
-coccilib.report.print_report(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
-
-@script:python depends on report@
-p << r2.p2;
-@@
-
-coccilib.report.print_report(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
-
-@script:python depends on report@
-p << r3.p3;
-@@
-
-coccilib.report.print_report(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
-- 
2.28.0

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
