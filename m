Return-Path: <SRS0=yQoC=73=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE80C433DF
	for <cocci@archiver.kernel.org>; Sun, 14 Jun 2020 14:40:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07482206D7
	for <cocci@archiver.kernel.org>; Sun, 14 Jun 2020 14:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HJpq5dfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07482206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05EEeOG8004049;
	Sun, 14 Jun 2020 16:40:24 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 98CC57760;
	Sun, 14 Jun 2020 16:40:24 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5828F44A7
 for <cocci@systeme.lip6.fr>; Sun, 14 Jun 2020 16:40:22 +0200 (CEST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e:0:0:0:133])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05EEeK9s009887
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 14 Jun 2020 16:40:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=Mr+YAzLD99XJJr7FqlLfOzEn6BvtdNusuprn3XV2Rvc=; b=HJpq5dfLZkPD8vSjn03StGVsVx
 +rpnzrhiNwX890IOUzCZ82hNyByeK0oDCBdAA9hae4vBl2glafmbmek7KcQc3qZ8Dm/OQciZR0D0/
 cl3+Hs+sVrAOowB/hBm5OvIcYLDVqpokJI0NNF5DSwMWuJ017kvR3koz/Idi0gn4vBd8S379NSSNR
 57QBvi50iFPXfE46ZcCcXn9wxc3LpAR6GNf/ClKpz9vdSlK2Y/5mxdP3yEX5hwaGouJ9iAN8FUnLp
 CKD19pdTCmggZJwyuCsTG61YmDefAbFmLHj0v3HoxW5IlwgHBy5MIkq1G1bdyotsA+Bw9+kn0ADdc
 ptE5SzXw==;
Received: from [2601:1c0:6280:3f0::19c2]
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jkTo0-0000Ep-PX; Sun, 14 Jun 2020 14:40:16 +0000
To: Julia Lawall <julia.lawall@inria.fr>
References: <b14e6d1d-afa0-5c28-547a-9bb1a987f6fd@infradead.org>
 <alpine.DEB.2.22.394.2006140932490.2849@hadrien>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dadeaa1d-1146-c4b1-e757-14e9791dac59@infradead.org>
Date: Sun, 14 Jun 2020 07:40:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2006140932490.2849@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 14 Jun 2020 16:40:25 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 14 Jun 2020 16:40:21 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] coccinelle issues
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

On 6/14/20 12:39 AM, Julia Lawall wrote:
> 
> 
> On Sat, 13 Jun 2020, Randy Dunlap wrote:
> 
>> Hi,
>>
>> OK, I've not used Coccinelle and now I am trying to use it.
>> It seems that I am having a few issues.
>> The primary one is when I run spatch (via 'make coccicheck' in
>> the kernel source tree), it tells me:
>>
>> Python error: No module named coccilib.elems
>>
>> I do see "elems.py" in /usr/local/lib64/coccinelle/python/coccilib.
>>
>> I am using coccinelle-master downloaded from github on
>> Friday June 12, 2020.
>>
>>
>> I have also made the following notes while building/installing it.
>>
>>
>> Note1: The latest coccinelle tarball is not actually available
>> at the coccinelle home page although the kernel documentation says it is.
> 
> Yes, I'm aware of this problem.  We're not able to update the home page at
> the moment.  This problem is being worked on.
> 
>>
>> Note2: https://github.com/coccinelle/coccinelle/blob/master/install.txt
>> says that 'spatch' is a script, but it seems to be a binary executable
>> file.
> 
> Actually, it is a script, and the fact that you say it is a binary may be
> the reason for your python problem.  Normally there is a script
> (scripts/spatch) that make install puts in place that refers back to where
> your Coccinelle is installed.

Yes, I saw scripts/spatch, but that script is not what is installed in
/usr/local/bin.
(see more below)

>> Note3: https://github.com/coccinelle/coccinelle/blob/master/install.txt
>> probably should say to use 'sudo make install' instead of just
>> 'make install', just like 'coccinelle.rst' file in the kernel tree says.
> 
> OK.  A lot of documentation for a lot of projects seems to omit the sudo,
> but I have indeed never understood why.
> 
> Maybe try again with make distclean, ./autogen, ./configure, sudo make
> install?

OK, I did all of those.

Is this expected?

$ ./autogen
cat: VERSION: No such file or directory
cat: VERSION: No such file or directory
cat: VERSION: No such file or directory
cat: VERSION: No such file or directory
cat: VERSION: No such file or directory
cat: VERSION: No such file or directory
cat: VERSION: No such file or directory
cat: VERSION: No such file or directory
cat: VERSION: No such file or directory
cat: VERSION: No such file or directory
cat: VERSION: No such file or directory


spatch is installed in /usr/local/bin/spatch:

$ ll /usr/local/bin/spatch
-rwxr-xr-x 1 root root 15547736 Jun 14 07:32 /usr/local/bin/spatch*

$ file /usr/local/bin/spatch
/usr/local/bin/spatch: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/l, BuildID[sha1]=2b658c12a1a49deae24010b71d22d262988ce041, for GNU/Linux 3.2.0, with debug_info, not stripped


I still get this runtime error:

Python error: No module named coccilib.elems

-- 
~Randy

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
