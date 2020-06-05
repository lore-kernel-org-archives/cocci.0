Return-Path: <SRS0=6Z8s=7U=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C290C433E0
	for <cocci@archiver.kernel.org>; Sun,  7 Jun 2020 20:01:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E022075A
	for <cocci@archiver.kernel.org>; Sun,  7 Jun 2020 20:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bA+S4VqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E022075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 057K1udF009291;
	Sun, 7 Jun 2020 22:01:56 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 696C63F9A;
	Sun,  7 Jun 2020 22:01:56 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 913B03F9A
 for <cocci@systeme.lip6.fr>; Fri,  5 Jun 2020 05:04:14 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05534CRN012244
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 5 Jun 2020 05:04:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1591326251;
 bh=mpINj1KwByMO1KKdJlJWvUCeORzynM/wkwVpAy35eLs=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=bA+S4VqQyF6mNzBW0YJXISEUnOIxkhwh3vM8LKMl/YMG+UUnGornrcoFzu4lCAzz8
 S9xnfmmCg2EbtH0JsQ4UGfO0Fac/OyzX7L0YvrwZAPapAbmHFWfDreYl49tW6urlRt
 AfPVCBmgYUP4zM1D3klz2cWkO45ZqTM+K0D15Yjo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([88.152.145.75]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M72oH-1jbnrI0NaB-008dDL; Fri, 05
 Jun 2020 05:04:11 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Fri,  5 Jun 2020 05:04:05 +0200
Message-Id: <20200605030405.6479-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Provags-ID: V03:K1:3s5T/IQAmPGdmmYoPPG2S6A5XKsqSFM9bCF4a56hyILj+j8BqJS
 2Y3ctYhXEEt5igjR37mJJGoO0+c8Cih/Nht790x9PLsOx+iKsp45l7qLv1CdO2xT/Rw1PwT
 E71x2sv8e2aKqkGFDc8Uj4nZ9Xz2x5WL7GyNM+pB2e4hA/HLes6NymiHiu1FZZby/DHIZ4m
 v2Y2eF6vE5dWmVrurTvpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hue4DUo+I+o=:7EVRn8VLxVI1G2RxIaVtsL
 caBxYP4LqlINeokpHjvu6/efpn6CbLBWQgskGfQAv6lqLZDZZUQOMiLGowZHZaWfBza5UwgjN
 fFfCGOInMKe+I82EV1KVtmaTDBl2NER+dvDD0iXdutZKvysmRVpF+6AS4WG8BD18F4W8GIF4J
 hHFF3UtFMSp1C8JCd6aLI0FFBUR9t9i3UE6I1qnTDEN5JcfPFuaIPPhK4C3A+yA0JLR7Oisx/
 gIx0EmwoInhd7zcvGPRp3P0/jUrIkHttxa3s7gH1IBqzsKLVbILohg8LfFrkQv0JSvCA06TP4
 ZEP5s+MdQxEa/X9/vjg+/rn9P2BPKW8SmLCKwO06oZA5jOsHZM4XvP4zYsTHjPlKkJhBkFgAW
 hGkZGBSXCkqPYlOzByd7XShxKCNyMSb/q2e823mGTip3su9/UKI+KzkxXFTIi7Y0paXWZ/fQD
 v1IxMOnm1VZmbG5Z2YUZe0l1ick57/AiZuXiDAiwSKMLHfI07unajIZoWXIkMPd4hq/LJlAQO
 RMMxA8jm8cAS6Tl+Ne1OFiiHceQ+jToZZ4dmtd0Gnafv4vqx3EVEfCnY+wOlXnSCBlkotif8l
 SzIJ4SBHzMc12MoI29SQtzHjTEf3N7xNrFjUN1ISmycY8mVxLE4PqzNU+Rm3RQGmPnuuZS3uM
 C176H/Bb8G+oSJ11xjsALLxxUbUgEG98j+x7S/XcDpXrMxJ1kKHzu6d9r2Zg2XEgijliz70Eh
 eUM2opu8wAfEXaTzsTsAgxtnyP1rYm3U+aZLyDat65RDVnv/pt79gC0XFtD58Ptmcyrfb1kIh
 pavHjJ8tQR5ava0Cg/P8wERkjn9KVg2ESMU1a0mDG+Z3GGQF99PXaQOWSlT2ncoh5smC9nN1L
 jJXuQ7caqjlwJZavCFGOzeOSZMWq+FS+uowqBWGuktLtI66R+jk3ZSGJSIijnmu2iFqc9n+eR
 fhAh0nC8MD1bfC2dRWTiqSjV5dQLehdDgifr+umYl6R4lHIq46sE80gcIoS4L+Gb4CsesxUy9
 0rHtv7hxlOElPrHfIbZkKl9JxbioMQ2gkvFwr+iYzDu/g+s3oX12hNO2VaC/S05s4Kvp+CpKV
 ydW1yzxoE7VKYht8koap9dgxx71up/8f0Jk0xFg/jAoFwXwts33JQa76UKmTCbLOwqx/Q9PZJ
 2HcncrKIZK1GaJ2ZKBQs0rU3h2sPZ0VraL/q92i2lfB3YcL0dd0qBxiAGwgq0j8799nAlMEF9
 gzFq2nNVqQxj/+F0X
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 07 Jun 2020 22:01:56 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 05 Jun 2020 05:04:13 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sun, 07 Jun 2020 22:01:55 +0200
Cc: Michal Marek <michal.lkml@markovi.net>, Jonathan Corbet <corbet@lwn.net>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>, linux-doc@vger.kernel.org,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>, cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH 1/1] docs: dev-tools: coccinelle: underlines
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

Underline lengths should match the lengths of headings to avoid build
warnings with Sphinx.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 Documentation/dev-tools/coccinelle.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 00a3409b0c28..70274c3f5f5a 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -14,7 +14,7 @@ many uses in kernel development, including the application of complex,
 tree-wide patches and detection of problematic programming patterns.

 Getting Coccinelle
--------------------
+------------------

 The semantic patches included in the kernel use features and options
 which are provided by Coccinelle version 1.0.0-rc11 and above.
@@ -56,7 +56,7 @@ found at:
 https://github.com/coccinelle/coccinelle/blob/master/install.txt

 Supplemental documentation
----------------------------
+--------------------------

 For supplemental documentation refer to the wiki:

@@ -128,7 +128,7 @@ To enable verbose messages set the V= variable, for example::
    make coccicheck MODE=report V=1

 Coccinelle parallelization
----------------------------
+--------------------------

 By default, coccicheck tries to run as parallel as possible. To change
 the parallelism, set the J= variable. For example, to run across 4 CPUs::
@@ -333,7 +333,7 @@ as an example if requiring at least Coccinelle >= 1.0.5::
 	// Requires: 1.0.5

 Proposing new semantic patches
--------------------------------
+------------------------------

 New semantic patches can be proposed and submitted by kernel
 developers. For sake of clarity, they should be organized in the
--
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
