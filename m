Return-Path: <SRS0=yhX/=IB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA80C433E0
	for <cocci@archiver.kernel.org>; Wed,  3 Mar 2021 15:46:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7156764EE1
	for <cocci@archiver.kernel.org>; Wed,  3 Mar 2021 15:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7156764EE1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 123FkTXw029412;
	Wed, 3 Mar 2021 16:46:29 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1931E77CC;
	Wed,  3 Mar 2021 16:46:29 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C970E571B
 for <cocci@systeme.lip6.fr>; Wed,  3 Mar 2021 16:46:27 +0100 (CET)
Received: from smtprelay.hostedemail.com (smtprelay0062.hostedemail.com
 [216.40.44.62])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 123FkQSW015092
 for <cocci@systeme.lip6.fr>; Wed, 3 Mar 2021 16:46:26 +0100 (CET)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 0EA39801C320
 for <cocci@systeme.lip6.fr>; Wed,  3 Mar 2021 02:47:56 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay06.hostedemail.com (Postfix) with ESMTP id 42E2418225631;
 Wed,  3 Mar 2021 02:47:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tin16_1602863276c1
X-Filterd-Recvd-Size: 2532
Received: from [192.168.1.159] (unknown [47.151.137.21])
 (Authenticated sender: joe@perches.com)
 by omf07.hostedemail.com (Postfix) with ESMTPA;
 Wed,  3 Mar 2021 02:47:52 +0000 (UTC)
Message-ID: <6b8b250a06a98ce42120a14824531a8641f5e8aa.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Tue, 02 Mar 2021 18:47:51 -0800
In-Reply-To: <alpine.DEB.2.22.394.2103022241050.2906@hadrien>
References: <053b06c47f08631675c295b5c893b90be4248347.camel@perches.com>
 <alpine.DEB.2.22.394.2103022241050.2906@hadrien>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 03 Mar 2021 16:46:30 +0100 (CET)
X-Greylist: Delayed for 22:03:31 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Wed, 03 Mar 2021 16:46:26 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        cocci <cocci@systeme.lip6.fr>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Subject: Re: [Cocci] linux-kernel janitorial RFP: Mark static arrays as const
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

On Tue, 2021-03-02 at 22:41 +0100, Julia Lawall wrote:
> 
> On Tue, 2 Mar 2021, Joe Perches wrote:
> 
> > Here is a possible opportunity to reduce data usage in the kernel.
> 
> Does it actually reduce data usage?

Yes, at least for gcc.  For instance:

$ gcc --version
gcc (Ubuntu 10.2.0-13ubuntu1) 10.2.0

And with the diff below (x86-64 defconfig with hwmon/pmbus and max20730)

$ diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.c
index 9dd3dd79bc18..b824eab95456 100644
--- a/drivers/hwmon/pmbus/max20730.c
+++ b/drivers/hwmon/pmbus/max20730.c
@@ -434,7 +434,7 @@ static long direct_to_val(u16 w, enum pmbus_sensor_classes >
        return d;
 }
 
-static u32 max_current[][5] = {
+static const u32 max_current[][5] = {
        [max20710] = { 6200, 8000, 9700, 11600 },
        [max20730] = { 13000, 16600, 20100, 23600 },
        [max20734] = { 21000, 27000, 32000, 38000 },

$ size drivers/hwmon/pmbus/max20730.o*
   text	   data	    bss	    dec	    hex	filename
   9245	    256	      0	   9501	   251d	drivers/hwmon/pmbus/max20730.o.gcc.new
   9149	    352	      0	   9501	   251d	drivers/hwmon/pmbus/max20730.o.gcc.old

with clang-11 it doesn't seem to make a difference:

$ /usr/bin/clang --version
Ubuntu clang version 11.0.0-2

$ size drivers/hwmon/pmbus/max20730.o*
   text	   data	    bss	    dec	    hex	filename
   9166	    256	      1	   9423	   24cf	drivers/hwmon/pmbus/max20730.o.clang-11.new
   9166	    256	      1	   9423	   24cf	drivers/hwmon/pmbus/max20730.o.clang-11.old


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
