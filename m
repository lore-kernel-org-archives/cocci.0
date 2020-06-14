Return-Path: <SRS0=yQoC=73=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54D2C433DF
	for <cocci@archiver.kernel.org>; Sun, 14 Jun 2020 07:26:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F3BA206D7
	for <cocci@archiver.kernel.org>; Sun, 14 Jun 2020 07:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h5GmWLsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3BA206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05E7QkO2003286;
	Sun, 14 Jun 2020 09:26:46 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BD62F7760;
	Sun, 14 Jun 2020 09:26:46 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5B19944A7
 for <cocci@systeme.lip6.fr>; Sun, 14 Jun 2020 06:24:04 +0200 (CEST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e:0:0:0:133])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05E4O2KG008982
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 14 Jun 2020 06:24:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=KdZmbzKkPmpckL1U4hYFdBeoi6DJ0np+Y8xoq7vH/6U=; b=h5GmWLsQcvIt/aEFDPHoCu8ffg
 Frz3xLShxk9mFYQWuFp3Y6KEFZB4nQbRjX7B1rsJm89483x01gYTwVDhvZOEKHC0DaF0+KCQ7ne0U
 CW0bAUt1hDj7iy5MYLjaXrMmy3Mh+hmw3d0p5Eq8HYA1E6iWzY2U53wn2g8vctUeTMXLUj3K8yYOm
 5XIUMliuj8JGLsl7KZIkGnxsyfMTnsokk6TAtaM3ysqB1Jae5tDr/yj8Tp29eAWZEVt9U0QSUmxqL
 /+wcsePnLXmN8fZRVbiJ8SdhM9wi9z/+YHZldthUI+cRew592MnegtmtI54Fkb8RKvtDFMKZxUY4q
 YXXmqU7w==;
Received: from [2601:1c0:6280:3f0::19c2]
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jkJvZ-000403-3b; Sun, 14 Jun 2020 04:07:25 +0000
To: LKML <linux-kernel@vger.kernel.org>, cocci@systeme.lip6.fr,
        Julia Lawall <julia.lawall@lip6.fr>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b14e6d1d-afa0-5c28-547a-9bb1a987f6fd@infradead.org>
Date: Sat, 13 Jun 2020 21:07:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 14 Jun 2020 09:26:47 +0200 (CEST)
X-Greylist: Delayed for 00:16:26 by milter-greylist-4.4.3 (isis.lip6.fr
 [IPv6:2001:660:3302:283c:0:0:0:2]); Sun, 14 Jun 2020 06:24:03 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Sun, 14 Jun 2020 09:26:45 +0200
Subject: [Cocci] coccinelle issues
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

Hi,

OK, I've not used Coccinelle and now I am trying to use it.
It seems that I am having a few issues.
The primary one is when I run spatch (via 'make coccicheck' in
the kernel source tree), it tells me:

Python error: No module named coccilib.elems

I do see "elems.py" in /usr/local/lib64/coccinelle/python/coccilib.

I am using coccinelle-master downloaded from github on
Friday June 12, 2020.


I have also made the following notes while building/installing it.


Note1: The latest coccinelle tarball is not actually available
at the coccinelle home page although the kernel documentation says it is.

Note2: https://github.com/coccinelle/coccinelle/blob/master/install.txt
says that 'spatch' is a script, but it seems to be a binary executable
file.

Note3: https://github.com/coccinelle/coccinelle/blob/master/install.txt
probably should say to use 'sudo make install' instead of just
'make install', just like 'coccinelle.rst' file in the kernel tree says.


thanks for any help that you can provide.

-- 
~Randy

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
