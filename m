Return-Path: <SRS0=TTUf=7S=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9B8C433E1
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 05:58:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF024207F7
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 05:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF024207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0555weLb020567;
	Fri, 5 Jun 2020 07:58:40 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 23E4D7567;
	Fri,  5 Jun 2020 07:58:40 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5D7DB3F9A
 for <cocci@systeme.lip6.fr>; Fri,  5 Jun 2020 07:58:39 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0555wcJC003232
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 5 Jun 2020 07:58:38 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,475,1583190000"; d="scan'208";a="350650169"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Jun 2020 07:58:37 +0200
Date: Fri, 5 Jun 2020 07:58:37 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20200605030405.6479-1-xypron.glpk@gmx.de>
Message-ID: <alpine.DEB.2.21.2006050758150.2567@hadrien>
References: <20200605030405.6479-1-xypron.glpk@gmx.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 05 Jun 2020 07:58:40 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 05 Jun 2020 07:58:38 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Julia Lawall <Julia.Lawall@lip6.fr>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH 1/1] docs: dev-tools: coccinelle: underlines
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



On Fri, 5 Jun 2020, Heinrich Schuchardt wrote:

> Underline lengths should match the lengths of headings to avoid build
> warnings with Sphinx.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>


Acked-by: Julia Lawall <julia.lawall@inria.fr>

Thanks for your help.

> ---
>  Documentation/dev-tools/coccinelle.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
> index 00a3409b0c28..70274c3f5f5a 100644
> --- a/Documentation/dev-tools/coccinelle.rst
> +++ b/Documentation/dev-tools/coccinelle.rst
> @@ -14,7 +14,7 @@ many uses in kernel development, including the application of complex,
>  tree-wide patches and detection of problematic programming patterns.
>
>  Getting Coccinelle
> --------------------
> +------------------
>
>  The semantic patches included in the kernel use features and options
>  which are provided by Coccinelle version 1.0.0-rc11 and above.
> @@ -56,7 +56,7 @@ found at:
>  https://github.com/coccinelle/coccinelle/blob/master/install.txt
>
>  Supplemental documentation
> ----------------------------
> +--------------------------
>
>  For supplemental documentation refer to the wiki:
>
> @@ -128,7 +128,7 @@ To enable verbose messages set the V= variable, for example::
>     make coccicheck MODE=report V=1
>
>  Coccinelle parallelization
> ----------------------------
> +--------------------------
>
>  By default, coccicheck tries to run as parallel as possible. To change
>  the parallelism, set the J= variable. For example, to run across 4 CPUs::
> @@ -333,7 +333,7 @@ as an example if requiring at least Coccinelle >= 1.0.5::
>  	// Requires: 1.0.5
>
>  Proposing new semantic patches
> --------------------------------
> +------------------------------
>
>  New semantic patches can be proposed and submitted by kernel
>  developers. For sake of clarity, they should be organized in the
> --
> 2.26.2
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
