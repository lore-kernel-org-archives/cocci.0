Return-Path: <SRS0=tHwe=7W=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F49C433DF
	for <cocci@archiver.kernel.org>; Tue,  9 Jun 2020 17:54:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 686CD207C3
	for <cocci@archiver.kernel.org>; Tue,  9 Jun 2020 17:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 686CD207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 059HsLIf010180;
	Tue, 9 Jun 2020 19:54:21 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 722B77783;
	Tue,  9 Jun 2020 19:54:21 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 19DE03F9A
 for <cocci@systeme.lip6.fr>; Tue,  9 Jun 2020 19:54:19 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 059HsIQI029895
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 9 Jun 2020 19:54:18 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,492,1583190000"; d="scan'208";a="351128553"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Jun 2020 19:54:18 +0200
Date: Tue, 9 Jun 2020 19:54:17 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <88d56de0-0a22-3371-ebd9-0ccbbc81f76e@web.de>
Message-ID: <alpine.DEB.2.21.2006091952570.2516@hadrien>
References: <88d56de0-0a22-3371-ebd9-0ccbbc81f76e@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1745590462-1591725258=:2516"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 09 Jun 2020 19:54:21 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 09 Jun 2020 19:54:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking software behaviour according to selected SmPL
 code	variants
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1745590462-1591725258=:2516
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 9 Jun 2020, Markus Elfring wrote:

> Hello,
>
> My software development attention was caught also by a recent patch.
> https://lore.kernel.org/linux-fsdevel/20200608141629.GA1912173@mwanda/
> https://lore.kernel.org/patchwork/patch/1253499/
>
> Thus I have tried another tiny script out for the semantic patch language
> (according to the software combination “Coccinelle 1.0.8-00104-ge06b9156”).
>
>
> @display@
> expression e, x, y;
> @@
> *brelse(e);
> *y = x(<+... e ...+>, ...);
>
>
> An usable output is generated then as expected for a test source file
> like the following.
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/fs/exfat/nls.c?id=b676fdbcf4c8424f3c02ed7f31576d99b963bded#n652
>
> // SPDX-License-Identifier: GPL-2.0-or-later
> // deleted part
> static int exfat_load_upcase_table(struct super_block *sb,
> 		sector_t sector, unsigned long long num_sectors,
> 		unsigned int utbl_checksum)
> {
> 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> 	unsigned int sect_size = sb->s_blocksize;
> 	unsigned int i, index = 0;
> 	u32 chksum = 0;
> // deleted part
> 	while (sector < num_sectors) {
> 		struct buffer_head *bh;
>
> 		bh = sb_bread(sb, sector);
> // deleted part
> 		brelse(bh);
> 		chksum = exfat_calc_chksum32(bh->b_data, i, chksum, CS_DEFAULT);
> 	}
> // deleted part
> }
> // deleted part
>
>
> If I omit the specification “, ...” from the function call parameters
> because I could be unsure about the number of arguments in other
> software situations, I do not get the desired test output as before.

This has been discussed before.  When you put <+... ...+> in an argument
list, it doesn't mean an unknown number of arguments, it means one
arguemnt that has something as a subexpression.

>
> If I omit even the semicolon from the assignment statement in the
> search pattern, I get an error message.
>
> elfring@Sonne:~/Projekte/Coccinelle/janitor> spatch --parse-cocci show_questionable_brelse_usage6.cocci
> …
> minus: parse error:
>   File "show_questionable_brelse_usage6.cocci", line 6, column 0, charpos = 67
>   around = '',
>   whole content =

That is quite normal.  One statement should be followed by another
statement.

>
> Will such observations influence subsequent software evolution?

No.

julia
--8323329-1745590462-1591725258=:2516
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1745590462-1591725258=:2516--
