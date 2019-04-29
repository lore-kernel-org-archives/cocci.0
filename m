Return-Path: <SRS0=A19M=S7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9FBC43219
	for <cocci@archiver.kernel.org>; Mon, 29 Apr 2019 16:27:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27F7820675
	for <cocci@archiver.kernel.org>; Mon, 29 Apr 2019 16:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F7820675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3TGQuDG025343
          ; Mon, 29 Apr 2019 18:26:56 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EBAD07741;
	Mon, 29 Apr 2019 18:26:55 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CB9BD7732
 for <cocci@systeme.lip6.fr>; Mon, 29 Apr 2019 18:26:53 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3TGQrx5002618
 for <cocci@systeme.lip6.fr>; Mon, 29 Apr 2019 18:26:53 +0200 (CEST)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.60,410,1549926000"; d="scan'208";a="304358218"
Received: from 50-250-39-241-static.hfc.comcastbusiness.net (HELO hadrien)
 ([50.250.39.241])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Apr 2019 18:26:51 +0200
Date: Mon, 29 Apr 2019 12:26:49 -0400 (EDT)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Nicholas Mc Guire <der.herr@hofr.at>
In-Reply-To: <20190429060512.GA16251@osadl.at>
Message-ID: <alpine.DEB.2.21.1904291221350.2444@hadrien>
References: <20190429060512.GA16251@osadl.at>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 29 Apr 2019 18:26:56 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Mon, 29 Apr 2019 18:26:53 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] detecting false positive sparse with coccinelle
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



On Mon, 29 Apr 2019, Nicholas Mc Guire wrote:

>
> Hi !
>
>  I'm trying to detect false positive sparse messages by taking
>  the pattern and scanning with coccinelle for it so that the
>  fix could be generated. Basically the identification seems
>  to be working (a type-check on var is stil missing - but thats
>  a different issue) - the problem though is that I'm unable
>  to insert the (__force __be16) cast in the patch rule as
>  coccinelle is refusing hose lines. Any hint how that could be
>  done or is the problem the syntactic oddity of having a
>  unknown keyworkd followed by a type that is confusing coccinelle
>  here ?

Types like this are currently not parsed properly - see the GSoC project.
I'm not sure that there is a good solution at the moment.  This should be
parsed OK by the C parser, so you could try passing through python.  See
python_mdecl.cocci.  It may be necessary to construct the complete
expression (__force __be16)var in python.

julia

>
> thx!
> hofrat
>
> virtual report
> virtual patch
>
> @acheck depends on report@
> identifier var;
> position p;
> @@
>
> (
> * var = be16_to_cpu@p(var);
> |
> * var = be32_to_cpu@p(var);
> |
> * var = be64_to_cpu@p(var);
> |
> * var = le16_to_cpu@p(var);
> |
> * var = le32_to_cpu@p(var);
> |
> * var = le64_to_cpu@p(var);
> )
>
> @script:python depends on report@
> p << acheck.p;
> @@
>
> msg = "forced endiannes annotation needed"
> coccilib.report.print_report(p[0],msg)
>
> @afix depends on patch@
> identifier var;
> position p;
> typedef __be16, __be32, __b64, __le16, __le32, __le64;
> @@
>
> (
> - var = be16_to_cpu@p(var);
> + var = be16_to_cpu((__force __be16)var);
> |
> - var = be32_to_cpu@p(var);
> + var = be32_to_cpu((__force __be32)var);
> |
> - var = be64_to_cpu@p(var);
> + var = be64_to_cpu((__force __be64)var);
> |
> - var = le16_to_cpu@p(var);
> + var = le16_to_cpu((__force __le16)var);
> |
> - var = le32_to_cpu@p(var);
> + var = le32_to_cpu((__force __le32)var);
> |
> - var = le64_to_cpu@p(var);
> + var = le64_to_cpu((__force __le64)var);
> )
>
> @script:python depends on patch@
> p << afix.p;
> @@
>
> msg = "forced endiannes annotation added"
> coccilib.report.print_report(p[0],msg)
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
