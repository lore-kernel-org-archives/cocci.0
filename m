Return-Path: <SRS0=qX47=VU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E6AC7618B
	for <cocci@archiver.kernel.org>; Tue, 23 Jul 2019 13:42:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09638218D4
	for <cocci@archiver.kernel.org>; Tue, 23 Jul 2019 13:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09638218D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6NDgN8a005438;
	Tue, 23 Jul 2019 15:42:23 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 04A26777C;
	Tue, 23 Jul 2019 15:42:23 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 31A8B76BF
 for <cocci@systeme.lip6.fr>; Tue, 23 Jul 2019 15:42:21 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0176.hostedemail.com
 [216.40.44.176])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6NDgJWI014564
 for <cocci@systeme.lip6.fr>; Tue, 23 Jul 2019 15:42:20 +0200 (CEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 980581800D64C
 for <cocci@systeme.lip6.fr>; Tue, 23 Jul 2019 00:46:33 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay02.hostedemail.com (Postfix) with ESMTP id B525F40D3;
 Tue, 23 Jul 2019 00:46:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cent57_72f1b01a7b963
X-Filterd-Recvd-Size: 8794
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com
 [23.242.196.136]) (Authenticated sender: joe@perches.com)
 by omf07.hostedemail.com (Postfix) with ESMTPA;
 Tue, 23 Jul 2019 00:46:29 +0000 (UTC)
Message-ID: <66fcdbf607d7d0bea41edb39e5579d63b62b7d84.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Julia Lawall <julia.lawall@lip6.fr>, cocci <cocci@systeme.lip6.fr>
Date: Mon, 22 Jul 2019 17:46:27 -0700
References: <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>
Content-Type: multipart/mixed; boundary="=-PQzEZXvpk5qvk1Zhvstk"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 23 Jul 2019 15:42:23 +0200 (CEST)
X-Greylist: Delayed for 01:09:59 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Tue, 23 Jul 2019 15:42:20 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [Cocci] [Fwd: [PATCH 1/2] string: Add stracpy and stracpy_pad
	mechanisms]
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr


--=-PQzEZXvpk5qvk1Zhvstk
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hello Julia.

I just sent a patch to add yet another string copy mechanism.

This could help avoid misuses of strscpy and strlcpy like this
patch set:

https://lore.kernel.org/lkml/cover.1562283944.git.joe@perches.com/T/

A possible cocci script to do conversions could be:

   $ cat str.cpy.cocci
   @@
   expression e1;
   expression e2;
   @@

   - strscpy(e1, e2, sizeof(e1))
   + stracpy(e1, e2)

   @@
   expression e1;
   expression e2;
   @@

   - strlcpy(e1, e2, sizeof(e1))
   + stracpy(e1, e2)

This obviously does not match the style of all the
scripts/coccinelle cocci files, but this might be
something that could be added improved and added.

This script produces:

$ spatch --in-place -sp-file str.cpy.cocci .
$ git checkout tools/
$ git diff --shortstat
 958 files changed, 2179 insertions(+), 2655 deletions(-)

The remainder of strlcpy and strscpy uses in the
kernel would generally have a form like:

	strlcpy(to, from, DEFINE)

where DEFINE is the specified size of to

Could the cocci script above be updated to find
and correct those styles as well?

cheers, Joe

--=-PQzEZXvpk5qvk1Zhvstk
Content-Disposition: inline
Content-Description: Forwarded message =?UTF-8?Q?=E2=80=94?= [PATCH 1/2]
 string: Add stracpy and stracpy_pad mechanisms
Content-Type: message/rfc822

Return-Path: linux-kernel-owner@vger.kernel.org
Delivered-To: joe@perches.com
X-FDA: 75739338654.01.hot66_2cb38a9397152
X-Spam-Summary:  2,0,0,14da73eccbb67bae,d41d8cd98f00b204,linux-kernel-owner@vger.kernel.org,:torvalds@linux-foundation.org:linux-kernel@vger.kernel.org:corbet@lwn.net:steve@sk2.org:keescook@chromium.org:nitin.r.gote@intel.com:jannh@google.com:kernel-hardening@lists.openwall.com:rasmus.villemoes@prevas.dk:akpm@linux-foundation.org,RULES_HIT:41:355:379:541:800:899:904:960:973:988:989:997:1260:1345:1359:1437:1535:1542:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2915:3138:3139:3140:3141:3142:3355:3865:3866:3867:3868:3871:3874:4321:5007:6261:7875:8603:10004:11026:11473:11658:11914:12043:12291:12296:12297:12555:12683:12895:13141:13161:13229:13230:14181:14394:14721:21080:21451:21627:30012:30034:30054:30069:30079:30090,0,RBL:209.132.180.67:@vger.kernel.org:.lbl8.mailshell.net-62.8.0.100
 66.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not
 bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: hot66_2cb38a9397152
X-Filterd-Recvd-Size: 5346
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by imf13.hostedemail.com (Postfix) with ESMTP
	for <joe@perches.com>; Tue, 23 Jul 2019 00:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733116AbfGWAi0 (ORCPT <rfc822;joe@perches.com>);
        Mon, 22 Jul 2019 20:38:26 -0400
Received: from smtprelay0192.hostedemail.com ([216.40.44.192]:50395 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728573AbfGWAiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 20:38:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60]) by smtprelay03.hostedemail.com (Postfix) with ESMTP id
 33C9A83777ED; Tue, 23 Jul 2019 00:38:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary:  2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:541:800:960:973:988:989:1260:1345:1359:1437:1534:1542:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2915:3138:3139:3140:3141:3142:3355:3865:3866:3867:3868:3871:3874:4321:5007:6261:7875:8603:10004:10848:11026:11473:11658:11914:12043:12291:12296:12297:12555:12683:12895:13141:13161:13229:13230:14181:14394:14721:21080:21451:21627:30012:30034:30054:30069:30079:30090,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180
 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not
 bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:17,LUA_SUMMARY:none
X-HE-Tag: wheel67_2bd70514adf25
X-Filterd-Recvd-Size: 3459
Received: from joe-laptop.perches.com (cpe-23-242-196-136.socal.res.rr.com
 [23.242.196.136]) (Authenticated sender: joe@perches.com) by
 omf13.hostedemail.com (Postfix) with ESMTPA; Tue, 23 Jul 2019 00:38:21
 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Stephen Kitt <steve@sk2.org>,
        Kees Cook <keescook@chromium.org>,
        Nitin Gote <nitin.r.gote@intel.com>, jannh@google.com,
        kernel-hardening@lists.openwall.com,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/2] string: Add stracpy and stracpy_pad mechanisms
Date: Mon, 22 Jul 2019 17:38:15 -0700
Message-Id: <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1563841972.git.joe@perches.com>
References: <cover.1563841972.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Several uses of strlcpy and strscpy have had defects because the
last argument of each function is misused or typoed.

Add macro mechanisms to avoid this defect.

stracpy (copy a string to a string array) must have a string
array as the first argument (to) and uses sizeof(to) as the
size.

These mechanisms verify that the to argument is an array of
char or other compatible types like u8 or unsigned char.

A BUILD_BUG is emitted when the type of to is not compatible.

Signed-off-by: Joe Perches <joe@perches.com>
---
 include/linux/string.h | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 4deb11f7976b..f80b0973f0e5 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -35,6 +35,47 @@ ssize_t strscpy(char *, const char *, size_t);
 /* Wraps calls to strscpy()/memset(), no arch specific code required */
 ssize_t strscpy_pad(char *dest, const char *src, size_t count);
 
+/**
+ * stracpy - Copy a C-string into an array of char
+ * @to: Where to copy the string, must be an array of char and not a pointer
+ * @from: String to copy, may be a pointer or const char array
+ *
+ * Helper for strscpy.
+ * Copies a maximum of sizeof(@to) bytes of @from with %NUL termination.
+ *
+ * Returns:
+ * * The number of characters copied (not including the trailing %NUL)
+ * * -E2BIG if @to is a zero size array.
+ */
+#define stracpy(to, from)					\
+({								\
+	size_t size = ARRAY_SIZE(to);				\
+	BUILD_BUG_ON(!__same_type(typeof(*to), char));		\
+								\
+	strscpy(to, from, size);				\
+})
+
+/**
+ * stracpy_pad - Copy a C-string into an array of char with %NUL padding
+ * @to: Where to copy the string, must be an array of char and not a pointer
+ * @from: String to copy, may be a pointer or const char array
+ *
+ * Helper for strscpy_pad.
+ * Copies a maximum of sizeof(@to) bytes of @from with %NUL termination
+ * and zero-pads the remaining size of @to
+ *
+ * Returns:
+ * * The number of characters copied (not including the trailing %NUL)
+ * * -E2BIG if @to is a zero size array.
+ */
+#define stracpy_pad(to, from)					\
+({								\
+	size_t size = ARRAY_SIZE(to);				\
+	BUILD_BUG_ON(!__same_type(typeof(*to), char));		\
+								\
+	strscpy_pad(to, from, size);				\
+})
+
 #ifndef __HAVE_ARCH_STRCAT
 extern char * strcat(char *, const char *);
 #endif
-- 
2.15.0


--=-PQzEZXvpk5qvk1Zhvstk
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--=-PQzEZXvpk5qvk1Zhvstk--

