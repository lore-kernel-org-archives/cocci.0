Return-Path: <SRS0=W2E7=YY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E6BCA9EC3
	for <cocci@archiver.kernel.org>; Thu, 31 Oct 2019 12:42:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EDAA20862
	for <cocci@archiver.kernel.org>; Thu, 31 Oct 2019 12:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDAA20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9VCgWrm017343;
	Thu, 31 Oct 2019 13:42:32 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8DC3977CB;
	Thu, 31 Oct 2019 13:42:32 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7430077BA
 for <cocci@systeme.lip6.fr>; Thu, 31 Oct 2019 13:42:30 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9VCgUIP006046
 for <cocci@systeme.lip6.fr>; Thu, 31 Oct 2019 13:42:30 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.68,250,1569276000"; d="scan'208";a="325234420"
Received: from portablejulia.rsr.lip6.fr ([132.227.76.63])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Oct 2019 13:42:05 +0100
Date: Thu, 31 Oct 2019 13:42:05 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <226b4ce7-8284-ed03-a478-98e3e532cb15@web.de>
Message-ID: <alpine.DEB.2.21.1910311341240.6010@hadrien>
References: <708207db-69d7-8962-e507-cd705142d0c4@web.de>
 <226b4ce7-8284-ed03-a478-98e3e532cb15@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-386949033-1572525725=:6010"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 31 Oct 2019 13:42:33 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Thu, 31 Oct 2019 13:42:30 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Moving exception handling code to the end of a function
 implementation with SmPL?
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

--8323329-386949033-1572525725=:6010
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Thu, 31 Oct 2019, Markus Elfring wrote:

> >   Unfortunately, I stumble on the error message “replacement: already tagged token:
> >   C code context” then.

This is what I would expect.  You could use one rule with an exists to put
a position variable in the place where you want to put a kfree, and then
use another rule to put a kfree at that position.

julia


>
> It might be that the transformation approach was too generic for
> the implementation of the function “megasas_mgmt_ioctl_fw”.
> https://elixir.bootlin.com/linux/v5.4-rc5/source/drivers/scsi/megaraid/megaraid_sas_base.c#L8258
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/megaraid/megaraid_sas_base.c?id=e472c64aa4fa6150c6076fd36d101d667d71c30a#n8258
>
> The following SmPL script variant can generate an usable test result.
>
> @replacement@
> expression result;
> identifier work;
> type t != void;
> @@
>  t work(...)
>  {
>  <+...
>  if (...)
> (
> -{
> -result = -ENODEV;
>  goto
> -     out_kfree_ioc
> +     e_nodev
>  ;
> -}
> |
>  {
>  ...
> -result = -ENODEV;
>  goto
> -     out_kfree_ioc
> +     e_nodev
>  ;
>  }
> )
>  ...+>
>  out_kfree_ioc:
>  ... when exists
>  return result;
> +e_nodev:
> +result = -ENODEV;
> +goto out_kfree_ioc;
>  }
>
>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
--8323329-386949033-1572525725=:6010
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-386949033-1572525725=:6010--
