Return-Path: <SRS0=qQWm=KN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FEBC433B4
	for <cocci@archiver.kernel.org>; Tue, 18 May 2021 09:09:44 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 459C2610CC
	for <cocci@archiver.kernel.org>; Tue, 18 May 2021 09:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459C2610CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 14I99dR0016185;
	Tue, 18 May 2021 11:09:39 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4311877DD;
	Tue, 18 May 2021 11:09:39 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5DD573E16
 for <cocci@systeme.lip6.fr>; Tue, 18 May 2021 11:09:38 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 14I99b9S024175
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 18 May 2021 11:09:37 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AgRcJdau78I1GjhvwJj1IVqpy7skDY9V00zEX?=
 =?us-ascii?q?/kB9WHVpmwKj9/xG/c536faaslgssR0b8uxofZPgfZqjz/RICPgqUYtKNTOO0F?=
 =?us-ascii?q?dAbrsSj7cKqAeOJ8SRzJ8/6U4ZSdkaNOHN?=
X-IronPort-AV: E=Sophos;i="5.82,309,1613430000"; d="scan'208";a="508676330"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 May 2021 11:09:36 +0200
Date: Tue, 18 May 2021 11:09:36 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
In-Reply-To: <1d3320d81fd7db23beaaea78888c389ab5f85ab8.1621328716.git.mchehab+huawei@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2105181109220.6885@hadrien>
References: <1d3320d81fd7db23beaaea78888c389ab5f85ab8.1621328716.git.mchehab+huawei@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-397356270-1621328977=:6885"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 18 May 2021 11:09:39 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 18 May 2021 11:09:37 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, mauro.chehab@huawei.com,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] scripts: coccicheck: fix troubles on
 non-English builds
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

--8323329-397356270-1621328977=:6885
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 18 May 2021, Mauro Carvalho Chehab wrote:

> When LANG is not set to English, the logic which checks the
> number of CPUs fail, as the messages can be localized, and
> the logic at:
>
>     THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd "[:digit:]")
>
> will not get the number of threads per core.
>
> This causes the script to not run properly, as it will produce
> a warning:
>
> 	$ make coccicheck COCCI=$PWD/scripts/coccinelle/misc/add_namespace.cocci MODE=report drivers/media/
> 	./scripts/coccicheck: linha 93: [: número excessivo de argumentos
>
> Fix it by forcing LANG=C when calling lscpu.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied, thanks.

julia

> ---
>  scripts/coccicheck | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 65fee63aeadb..caba0bff6da7 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -87,7 +87,7 @@ else
>      fi
>
>      # Use only one thread per core by default if hyperthreading is enabled
> -    THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd "[:digit:]")
> +    THREADS_PER_CORE=$(LANG=C lscpu | grep "Thread(s) per core: " | tr -cd "[:digit:]")
>      if [ -z "$J" ]; then
>          NPROC=$(getconf _NPROCESSORS_ONLN)
>  	if [ $THREADS_PER_CORE -gt 1 -a $NPROC -gt 4 ] ; then
> --
> 2.31.1
>
>
--8323329-397356270-1621328977=:6885
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-397356270-1621328977=:6885--
