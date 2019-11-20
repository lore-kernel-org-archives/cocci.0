Return-Path: <SRS0=d8Qa=ZM=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB1AC432C0
	for <cocci@archiver.kernel.org>; Wed, 20 Nov 2019 20:44:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A190E20726
	for <cocci@archiver.kernel.org>; Wed, 20 Nov 2019 20:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A190E20726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAKKiFRR003126;
	Wed, 20 Nov 2019 21:44:15 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 221AE77CE;
	Wed, 20 Nov 2019 21:44:15 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1335C77C9
 for <cocci@systeme.lip6.fr>; Wed, 20 Nov 2019 21:44:14 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAKKiDGX006536
 for <cocci@systeme.lip6.fr>; Wed, 20 Nov 2019 21:44:13 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.69,223,1571695200"; d="scan'208";a="327426388"
Received: from abo-228-123-68.mrs.modulonet.fr (HELO hadrien) ([85.68.123.228])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Nov 2019 21:44:13 +0100
Date: Wed, 20 Nov 2019 21:44:13 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
In-Reply-To: <66e7cfc9-e1c9-2b89-5d22-c6f6910aad1b@metux.net>
Message-ID: <alpine.DEB.2.21.1911202134250.2595@hadrien>
References: <66e7cfc9-e1c9-2b89-5d22-c6f6910aad1b@metux.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 20 Nov 2019 21:44:15 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Wed, 20 Nov 2019 21:44:13 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] field access scoping / check who accesses certain
 struct members ?
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



On Wed, 20 Nov 2019, Enrico Weigelt, metux IT consult wrote:

> Hi folks,
>
>
> is there a way to scan for code lines that access certain struct
> members ?

@@
struct structure_of_interest x;
@@

* x.field_of_interest

This will take care of pointers as well.

If you want to check on many types and fields, you can use the following
rule:

@@
identifier virtual.ty;
struct ty x;
identifier virtual.fld;
@@

* x.fld

Then you can run it with the command-line options:

-D ty=type_of_interest -D fld=field_of_interest

To figure out all the types, Coccinelle may need information from header
files.  So you could run it with the options

--recursive-includes --include-headers-for-types --relax-include-path

This will take a long time.

It may be useful to use to python code to note the file in which the
reference occurs, and then only print a message if it is a file that is of
concern.  So you could have:

@r@
identifier virtual.ty;
struct ty x;
identifier virtual.fld;
position p;
@@

* x.fld@p

@script:python@
p << r.p;
@@

... p[0].file ...

Let me know if anything is not clear.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
