Return-Path: <SRS0=uwmw=AM=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A8FC433E0
	for <cocci@archiver.kernel.org>; Wed,  1 Jul 2020 19:26:19 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E97C20760
	for <cocci@archiver.kernel.org>; Wed,  1 Jul 2020 19:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E97C20760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 061JQ5fm009485;
	Wed, 1 Jul 2020 21:26:05 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EA9E8776E;
	Wed,  1 Jul 2020 21:26:04 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 765C7742B
 for <cocci@systeme.lip6.fr>; Wed,  1 Jul 2020 21:26:03 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 061JQ1LZ022167
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 1 Jul 2020 21:26:01 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.75,301,1589234400"; d="scan'208";a="353307649"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 21:26:00 +0200
Date: Wed, 1 Jul 2020 21:26:00 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <def28907-18b9-5b7a-e743-79b0418c946c@infradead.org>
Message-ID: <alpine.DEB.2.22.394.2007012125440.2540@hadrien>
References: <def28907-18b9-5b7a-e743-79b0418c946c@infradead.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 01 Jul 2020 21:26:05 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 01 Jul 2020 21:26:01 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>, Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Markus Elfring <Markus.Elfring@web.de>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH v3] Documentation: Coccinelle: fix various typos
 etc.
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



On Wed, 1 Jul 2020, Randy Dunlap wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix various typos etc. in dev-tools/coccinelle.rst:
>
> - punctuation, grammar, wording

Acked-by: Julia Lawall <julia.lawall@inria.fr>

Thanks!

julia



>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Julia Lawall <Julia.Lawall@lip6.fr>
> Cc: Gilles Muller <Gilles.Muller@lip6.fr>
> Cc: Nicolas Palix <nicolas.palix@imag.fr>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: cocci@systeme.lip6.fr
> Cc: Markus Elfring <Markus.Elfring@web.de>
> ---
> v2: s/at minimum/a minimum/ (Julia and Markus)
>  Documentation/dev-tools/coccinelle.rst |   40 +++++++++++------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
>
> --- linux-next-20200629.orig/Documentation/dev-tools/coccinelle.rst
> +++ linux-next-20200629/Documentation/dev-tools/coccinelle.rst
> @@ -85,7 +85,7 @@ Four basic modes are defined: ``patch``,
>    file:line:column-column: message
>
>  - ``context`` highlights lines of interest and their context in a
> -  diff-like style.Lines of interest are indicated with ``-``.
> +  diff-like style. Lines of interest are indicated with ``-``.
>
>  - ``org`` generates a report in the Org mode format of Emacs.
>
> @@ -119,7 +119,7 @@ For each semantic patch, a commit messag
>  description of the problem being checked by the semantic patch, and
>  includes a reference to Coccinelle.
>
> -As any static code analyzer, Coccinelle produces false
> +As with any static code analyzer, Coccinelle produces false
>  positives. Thus, reports must be carefully checked, and patches
>  reviewed.
>
> @@ -135,18 +135,18 @@ the parallelism, set the J= variable. Fo
>
>     make coccicheck MODE=report J=4
>
> -As of Coccinelle 1.0.2 Coccinelle uses Ocaml parmap for parallelization,
> +As of Coccinelle 1.0.2 Coccinelle uses Ocaml parmap for parallelization;
>  if support for this is detected you will benefit from parmap parallelization.
>
>  When parmap is enabled coccicheck will enable dynamic load balancing by using
> -``--chunksize 1`` argument, this ensures we keep feeding threads with work
> +``--chunksize 1`` argument. This ensures we keep feeding threads with work
>  one by one, so that we avoid the situation where most work gets done by only
>  a few threads. With dynamic load balancing, if a thread finishes early we keep
>  feeding it more work.
>
>  When parmap is enabled, if an error occurs in Coccinelle, this error
> -value is propagated back, the return value of the ``make coccicheck``
> -captures this return value.
> +value is propagated back, and the return value of the ``make coccicheck``
> +command captures this return value.
>
>  Using Coccinelle with a single semantic patch
>  ---------------------------------------------
> @@ -183,7 +183,7 @@ To check only newly edited code, use the
>
>      make C=2 CHECK="scripts/coccicheck"
>
> -In these modes, which works on a file basis, there is no information
> +In these modes, which work on a file basis, there is no information
>  about semantic patches displayed, and no commit message proposed.
>
>  This runs every semantic patch in scripts/coccinelle by default. The
> @@ -198,12 +198,12 @@ Debugging Coccinelle SmPL patches
>
>  Using coccicheck is best as it provides in the spatch command line
>  include options matching the options used when we compile the kernel.
> -You can learn what these options are by using V=1, you could then
> +You can learn what these options are by using V=1; you could then
>  manually run Coccinelle with debug options added.
>
>  Alternatively you can debug running Coccinelle against SmPL patches
> -by asking for stderr to be redirected to stderr, by default stderr
> -is redirected to /dev/null, if you'd like to capture stderr you
> +by asking for stderr to be redirected to stderr. By default stderr
> +is redirected to /dev/null; if you'd like to capture stderr you
>  can specify the ``DEBUG_FILE="file.txt"`` option to coccicheck. For
>  instance::
>
> @@ -211,8 +211,8 @@ instance::
>      make coccicheck COCCI=scripts/coccinelle/free/kfree.cocci MODE=report DEBUG_FILE=cocci.err
>      cat cocci.err
>
> -You can use SPFLAGS to add debugging flags, for instance you may want to
> -add both --profile --show-trying to SPFLAGS when debugging. For instance
> +You can use SPFLAGS to add debugging flags; for instance you may want to
> +add both --profile --show-trying to SPFLAGS when debugging. For example
>  you may want to use::
>
>      rm -f err.log
> @@ -229,7 +229,7 @@ DEBUG_FILE support is only supported whe
>  --------------------
>
>  Coccinelle supports reading .cocciconfig for default Coccinelle options that
> -should be used every time spatch is spawned, the order of precedence for
> +should be used every time spatch is spawned. The order of precedence for
>  variables for .cocciconfig is as follows:
>
>  - Your current user's home directory is processed first
> @@ -237,7 +237,7 @@ variables for .cocciconfig is as follows
>  - The directory provided with the --dir option is processed last, if used
>
>  Since coccicheck runs through make, it naturally runs from the kernel
> -proper dir, as such the second rule above would be implied for picking up a
> +proper dir; as such the second rule above would be implied for picking up a
>  .cocciconfig when using ``make coccicheck``.
>
>  ``make coccicheck`` also supports using M= targets. If you do not supply
> @@ -260,13 +260,13 @@ If not using the kernel's coccicheck tar
>  order logic of .cocciconfig reading. If using the kernel's coccicheck target,
>  override any of the kernel's .coccicheck's settings using SPFLAGS.
>
> -We help Coccinelle when used against Linux with a set of sensible defaults
> +We help Coccinelle when used against Linux with a set of sensible default
>  options for Linux with our own Linux .cocciconfig. This hints to coccinelle
> -git can be used for ``git grep`` queries over coccigrep. A timeout of 200
> +that git can be used for ``git grep`` queries over coccigrep. A timeout of 200
>  seconds should suffice for now.
>
>  The options picked up by coccinelle when reading a .cocciconfig do not appear
> -as arguments to spatch processes running on your system, to confirm what
> +as arguments to spatch processes running on your system. To confirm what
>  options will be used by Coccinelle run::
>
>        spatch --print-options-only
> @@ -290,7 +290,7 @@ given to it when options are in conflict
>
>  Coccinelle supports idutils as well but requires coccinelle >= 1.0.6.
>  When no ID file is specified coccinelle assumes your ID database file
> -is in the file .id-utils.index on the top level of the kernel, coccinelle
> +is in the file .id-utils.index on the top level of the kernel. Coccinelle
>  carries a script scripts/idutils_index.sh which creates the database with::
>
>      mkid -i C --output .id-utils.index
> @@ -317,7 +317,7 @@ SmPL patch specific options
>  ---------------------------
>
>  SmPL patches can have their own requirements for options passed
> -to Coccinelle. SmPL patch specific options can be provided by
> +to Coccinelle. SmPL patch-specific options can be provided by
>  providing them at the top of the SmPL patch, for instance::
>
>  	// Options: --no-includes --include-headers
> @@ -327,7 +327,7 @@ SmPL patch Coccinelle requirements
>
>  As Coccinelle features get added some more advanced SmPL patches
>  may require newer versions of Coccinelle. If an SmPL patch requires
> -at least a version of Coccinelle, this can be specified as follows,
> +a minimum version of Coccinelle, this can be specified as follows,
>  as an example if requiring at least Coccinelle >= 1.0.5::
>
>  	// Requires: 1.0.5
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
