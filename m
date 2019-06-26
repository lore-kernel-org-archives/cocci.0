Return-Path: <SRS0=awHQ=UZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94BBC4646B
	for <cocci@archiver.kernel.org>; Wed, 26 Jun 2019 06:04:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4916C208CB
	for <cocci@archiver.kernel.org>; Wed, 26 Jun 2019 06:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4916C208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5Q64HAk007211;
	Wed, 26 Jun 2019 08:04:17 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2CB067771;
	Wed, 26 Jun 2019 08:04:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 66AD27770
 for <cocci@systeme.lip6.fr>; Wed, 26 Jun 2019 08:04:15 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5Q64F4C023976
 for <cocci@systeme.lip6.fr>; Wed, 26 Jun 2019 08:04:15 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.63,418,1557180000"; d="scan'208";a="389086659"
Received: from lneuilly-657-1-50-202.w80-11.abo.wanadoo.fr (HELO hadrien)
 ([80.11.18.202])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Jun 2019 08:04:14 +0200
Date: Wed, 26 Jun 2019 08:04:14 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Michele Martone <michelemartone@users.sf.net>
In-Reply-To: <20190626055059.GA9241@localhost>
Message-ID: <alpine.DEB.2.21.1906260804030.2496@hadrien>
References: <20190626055059.GA9241@localhost>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 26 Jun 2019 08:04:17 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Wed, 26 Jun 2019 08:04:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] --c++ --test will assume .cpp extension, not .c
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



On Wed, 26 Jun 2019, Michele Martone wrote:

> --c++ --test will assume .cpp extension, not .c
>
> Signed-off-by: Michele Martone <michelemartone@users.sf.net>

Applied, thanks.

julia

> ---
> diff --git a/testing.ml b/testing.ml
> index 258e6c6f..784040fe 100644
> --- a/testing.ml
> +++ b/testing.ml
> @@ -97,7 +97,7 @@ let testone prefix x compare_with_expected =
>    let x    = if x =~ "\\(.*\\)_ver0$" then matched1 x else x in
>    let base = if x =~ "\\(.*\\)_ver[0-9]+$" then matched1 x else x in
>
> -  let cfile      = prefix ^ x ^ ".c" in
> +  let cfile      = if !Flag.c_plus_plus then prefix ^ x ^ ".cpp" else prefix ^ x ^ ".c" in
>    let cocci_file = prefix ^ base ^ ".cocci" in
>
>    let expected_out = prefix ^ base ^ out_suffix in
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
