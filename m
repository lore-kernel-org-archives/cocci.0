Return-Path: <SRS0=DzZf=VV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210FBC7618B
	for <cocci@archiver.kernel.org>; Wed, 24 Jul 2019 04:20:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 982092190F
	for <cocci@archiver.kernel.org>; Wed, 24 Jul 2019 04:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982092190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6O4K5jU015623;
	Wed, 24 Jul 2019 06:20:05 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2E673777C;
	Wed, 24 Jul 2019 06:20:05 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5F0D1420D
 for <cocci@systeme.lip6.fr>; Wed, 24 Jul 2019 06:20:04 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0031.hostedemail.com
 [216.40.44.31])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6O4K3u8024097
 for <cocci@systeme.lip6.fr>; Wed, 24 Jul 2019 06:20:03 +0200 (CEST)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay04.hostedemail.com (Postfix) with ESMTP id 48986180A8124;
 Wed, 24 Jul 2019 04:20:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bath23_345d3f3e610
X-Filterd-Recvd-Size: 2618
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
 (Authenticated sender: joe@perches.com)
 by omf09.hostedemail.com (Postfix) with ESMTPA;
 Wed, 24 Jul 2019 04:20:01 +0000 (UTC)
Message-ID: <d5993902fd44ce89915fab94f4db03f5081c3c8e.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Date: Tue, 23 Jul 2019 21:19:57 -0700
In-Reply-To: <alpine.DEB.2.21.1907232252260.2539@hadrien>
References: <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>
 <66fcdbf607d7d0bea41edb39e5579d63b62b7d84.camel@perches.com>
 <alpine.DEB.2.21.1907231546090.2551@hadrien>
 <0f3ba090dfc956f5651e6c7c430abdba94ddcb8b.camel@perches.com>
 <alpine.DEB.2.21.1907232252260.2539@hadrien>
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 24 Jul 2019 06:20:05 +0200 (CEST)
X-Greylist: Delayed for 27:17:44 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Wed, 24 Jul 2019 06:20:03 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Cocci] [Fwd: [PATCH 1/2] string: Add stracpy and stracpy_pad
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

On Tue, 2019-07-23 at 22:54 -0500, Julia Lawall wrote:
> A seantic patch and the resulting output for the case where the third
> arugument is a constant is attached.  Likewise the resulting output on a
> recent linux-next.
> 
> julia

Nice.  Thanks Julia

A couple issues:

There is a problem with conversions with assignments
of strlcpy() so ideally the cocci script should make sure
any return value was not used before conversion.

This is not a provably good conversion:

drivers/s390/char/sclp_ftp.c
@@ -114,8 +114,7 @@ static int sclp_ftp_et7(const struct hmc
        sccb->evbuf.mdd.ftp.length = ftp->len;
        sccb->evbuf.mdd.ftp.bufaddr = virt_to_phys(ftp->buf);
 
-       len = strlcpy(sccb->evbuf.mdd.ftp.fident, ftp->fname,
-                     HMCDRV_FTP_FIDENT_MAX);
+       len = stracpy(sccb->evbuf.mdd.ftp.fident, ftp->fname);

And:

I would have expected the bit below to find and convert uses like
	drivers/hwmon/adc128d818.c:     strlcpy(info->type, "adc128d818", I2C_NAME_SIZE);
but it seems none of those were converted.

I don't know why.

//------------------------------------------
@r1@
struct i1 *e1;
expression e2;
identifier f,i1,i2;
position p;
@@
\(strscpy\|strlcpy\)(e1->f, e2, i2)@p

@@
identifier r1.i1,r1.i2;
type T;
@@
struct i1 { ... T i1[i2]; ... }

@@
identifier f,i2;
expression e1,e2;
position r1.p;
@@
(
-strscpy
+stracpy
|
-strlcpy
+stracpy
)(e1->f, e2
-    , i2
  )@p
//------------------------------------------

to find

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
