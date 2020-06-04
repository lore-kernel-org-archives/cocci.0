Return-Path: <SRS0=OH0s=7R=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DFBC433DF
	for <cocci@archiver.kernel.org>; Thu,  4 Jun 2020 19:31:31 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6BF2206E6
	for <cocci@archiver.kernel.org>; Thu,  4 Jun 2020 19:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BF2206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 054JVQwH002197;
	Thu, 4 Jun 2020 21:31:26 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9A2527567;
	Thu,  4 Jun 2020 21:31:26 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0B6005D47
 for <cocci@systeme.lip6.fr>; Thu,  4 Jun 2020 21:31:24 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 054JVMuq009304
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 4 Jun 2020 21:31:22 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,472,1583190000"; d="scan'208";a="350624709"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 21:31:22 +0200
Date: Thu, 4 Jun 2020 21:31:21 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Matthias Maennich <maennich@google.com>
In-Reply-To: <20200604164145.173925-1-maennich@google.com>
Message-ID: <alpine.DEB.2.21.2006042130080.2577@hadrien>
References: <20200604164145.173925-1-maennich@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 04 Jun 2020 21:31:26 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 04 Jun 2020 21:31:22 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Shuah Khan <skhan@linuxfoundation.org>, YueHaibing <yuehaibing@huawei.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org, jeyu@kernel.org,
        kernel-team@android.com, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] scripts: add dummy report mode to
	add_namespace.cocci
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



On Thu, 4 Jun 2020, Matthias Maennich wrote:

> When running `make coccicheck` in report mode using the
> add_namespace.cocci file, it will fail for files that contain
> MODULE_LICENSE. Those match the replacement precondition, but spatch
> errors out as virtual.ns is not set.
>
> In order to fix that, add the virtual rule nsdeps and only do search and
> replace if that rule has been explicitly requested.
>
> In order to make spatch happy in report mode, we also need a dummy rule,
> as otherwise it errors out with "No rules apply". Using a script:python
> rule appears unrelated and odd, but this is the shortest I could come up
> with.
>
> Adjust scripts/nsdeps accordingly to set the nsdeps rule when run trough
> `make nsdeps`.
>
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Fixes: c7c4e29fb5a4 ("scripts: add_namespace: Fix coccicheck failed")
> Cc: YueHaibing <yuehaibing@huawei.com>
> Cc: jeyu@kernel.org
> Cc: cocci@systeme.lip6.fr
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthias Maennich <maennich@google.com>

Acked-by: Julia Lawall <julia.lawall@inria.fr>

Shuah reported the problem to me, so you could add

Reported-by: Shuah Khan <skhan@linuxfoundation.org>


> ---
>  scripts/coccinelle/misc/add_namespace.cocci | 8 +++++++-
>  scripts/nsdeps                              | 2 +-
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccinelle/misc/add_namespace.cocci b/scripts/coccinelle/misc/add_namespace.cocci
> index 99e93a6c2e24..cbf1614163cb 100644
> --- a/scripts/coccinelle/misc/add_namespace.cocci
> +++ b/scripts/coccinelle/misc/add_namespace.cocci
> @@ -6,6 +6,7 @@
>  /// add a missing namespace tag to a module source file.
>  ///
>
> +virtual nsdeps
>  virtual report
>
>  @has_ns_import@
> @@ -16,10 +17,15 @@ MODULE_IMPORT_NS(ns);
>
>  // Add missing imports, but only adjacent to a MODULE_LICENSE statement.
>  // That ensures we are adding it only to the main module source file.
> -@do_import depends on !has_ns_import@
> +@do_import depends on !has_ns_import && nsdeps@
>  declarer name MODULE_LICENSE;
>  expression license;
>  identifier virtual.ns;
>  @@
>  MODULE_LICENSE(license);
>  + MODULE_IMPORT_NS(ns);
> +
> +// Dummy rule for report mode that would otherwise be empty and make spatch
> +// fail ("No rules apply.")
> +@script:python depends on report@
> +@@
> diff --git a/scripts/nsdeps b/scripts/nsdeps
> index 03a8e7cbe6c7..dab4c1a0e27d 100644
> --- a/scripts/nsdeps
> +++ b/scripts/nsdeps
> @@ -29,7 +29,7 @@ fi
>
>  generate_deps_for_ns() {
>  	$SPATCH --very-quiet --in-place --sp-file \
> -		$srctree/scripts/coccinelle/misc/add_namespace.cocci -D ns=$1 $2
> +		$srctree/scripts/coccinelle/misc/add_namespace.cocci -D nsdeps -D ns=$1 $2
>  }
>
>  generate_deps() {
> --
> 2.27.0.rc2.251.g90737beb825-goog
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
