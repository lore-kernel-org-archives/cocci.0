Return-Path: <SRS0=8ujx=BV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C796C433DF
	for <cocci@archiver.kernel.org>; Tue, 11 Aug 2020 19:54:08 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64BE720782
	for <cocci@archiver.kernel.org>; Tue, 11 Aug 2020 19:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64BE720782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07BJrkkB005592;
	Tue, 11 Aug 2020 21:53:46 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BC1914084;
	Tue, 11 Aug 2020 21:53:46 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B74FD3C97
 for <cocci@systeme.lip6.fr>; Tue, 11 Aug 2020 21:53:44 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07BJriQ9027956
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 11 Aug 2020 21:53:44 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.76,301,1592863200"; d="scan'208";a="356370612"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Aug 2020 21:53:43 +0200
Date: Tue, 11 Aug 2020 21:53:42 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Sumera Priyadarsini <sylphrenadin@gmail.com>
In-Reply-To: <20200811002350.5553-1-sylphrenadin@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2008112153280.4263@hadrien>
References: <20200811002350.5553-1-sylphrenadin@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 11 Aug 2020 21:53:47 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 11 Aug 2020 21:53:44 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: michal.lkml@markovi.net, Gilles.Muller@lip6.fr, gregkh@linuxfoundation.org,
        nicolas.palix@imag.fr, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v4] documentation: coccinelle: Improve command
 example for make C={1, 2}
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



On Tue, 11 Aug 2020, Sumera Priyadarsini wrote:

> Modify coccinelle documentation to further clarify
> the usage of the makefile C variable by coccicheck.
>
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>

Acked-by: Julia Lawall <julia.lawall@inria.fr>

Thanks.


>
> ---
> Changes in v4:
>         - Modify commit message to clarify C is a variable
> ---
>  Documentation/dev-tools/coccinelle.rst | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
> index 6c791af1c859..74c5e6aeeff5 100644
> --- a/Documentation/dev-tools/coccinelle.rst
> +++ b/Documentation/dev-tools/coccinelle.rst
> @@ -175,13 +175,20 @@ For example, to check drivers/net/wireless/ one may write::
>      make coccicheck M=drivers/net/wireless/
>
>  To apply Coccinelle on a file basis, instead of a directory basis, the
> -following command may be used::
> +C variable is used by the makefile to select which files to work with.
> +This variable can be used to run scripts for the entire kernel, a
> +specific directory, or for a single file.
>
> -    make C=1 CHECK="scripts/coccicheck"
> +For example, to check drivers/bluetooth/bfusb.c, the value 1 is
> +passed to the C variable to check files that make considers
> +need to be compiled.::
>
> -To check only newly edited code, use the value 2 for the C flag, i.e.::
> +    make C=1 CHECK=scripts/coccicheck drivers/bluetooth/bfusb.o
>
> -    make C=2 CHECK="scripts/coccicheck"
> +The value 2 is passed to the C variable to check files regardless of
> +whether they need to be compiled or not.::
> +
> +    make C=2 CHECK=scripts/coccicheck drivers/bluetooth/bfusb.o
>
>  In these modes, which work on a file basis, there is no information
>  about semantic patches displayed, and no commit message proposed.
> --
> 2.17.1
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
