Return-Path: <SRS0=v4mC=I2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5A6C433DB
	for <cocci@archiver.kernel.org>; Sun, 28 Mar 2021 09:28:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78FB56196E
	for <cocci@archiver.kernel.org>; Sun, 28 Mar 2021 09:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FB56196E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12S9RxJ5006363;
	Sun, 28 Mar 2021 11:27:59 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7E64C77C4;
	Sun, 28 Mar 2021 11:27:59 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0BAC63E8A
 for <cocci@systeme.lip6.fr>; Sun, 28 Mar 2021 11:27:58 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12S9RvCo018823
 for <cocci@systeme.lip6.fr>; Sun, 28 Mar 2021 11:27:57 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AhBZY/Kgn+2c/uSsBzJnPwiX3EHBQXjsji2hD?=
 =?us-ascii?q?6mlwRA09T+WzkceykPMHkSLlkTp5YgBFpfmsMLSNKEm2ybdb+o8UVI3JYCDHvy?=
 =?us-ascii?q?+SIJhm/c/exVTbehHW0s54+eNef7NlCNv2ZGIK6PrSxAWjCd4vzJ2m3cmT5dv2?=
 =?us-ascii?q?9HtmQQF0Z6wI1W4QNi+hHkJ7XwVAD5YifaDshfZvnSaqengcc62AaEUtYu6rnb?=
 =?us-ascii?q?H2va79bQVDLxAq7xTmt0LL1JfKVynd5BsYXj9VqI1OzUHOmWXCiZmejw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.81,285,1610406000"; d="scan'208";a="500347821"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Mar 2021 11:27:57 +0200
Date: Sun, 28 Mar 2021 11:27:57 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <0e878958-6245-a3b2-b892-5b67b1cb598f@web.de>
Message-ID: <alpine.DEB.2.22.394.2103281125350.2854@hadrien>
References: <0e878958-6245-a3b2-b892-5b67b1cb598f@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1916422777-1616923677=:2854"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 28 Mar 2021 11:27:59 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 28 Mar 2021 11:27:57 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Searching only for header files with the Coccinelle
 software
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

--8323329-1916422777-1616923677=:2854
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 28 Mar 2021, Markus Elfring wrote:

> Hello,
>
> The Coccinelle software can search for header files in addition to source files
> if the option “--include-headers” was specified.
> https://github.com/coccinelle/coccinelle/blob/287374196da8c7cfd169e721a2d23f1e462422f1/docs/manual/spatch_options.tex#L43
>
> How can it be achieved that only header files will be searched by this tool
> for special source code analysis and transformation approaches?

Probably the simplest is to put the names of the header files in a file,
eg find . -name "*h" > header_list, and then give the arguement
--file-groups header_list to Coccinelle.

Another option is to use python in te semantic patch to detect the current
file and then abort if it doesn't end in .h.  But that would be much
slower because the undesired files would still be parsed.

julia
--8323329-1916422777-1616923677=:2854
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1916422777-1616923677=:2854--
