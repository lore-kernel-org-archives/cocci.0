Return-Path: <SRS0=70je=MP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957BAC4338F
	for <cocci@archiver.kernel.org>; Fri, 23 Jul 2021 19:40:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D70A660F38
	for <cocci@archiver.kernel.org>; Fri, 23 Jul 2021 19:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D70A660F38
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 16NJe7w6009321;
	Fri, 23 Jul 2021 21:40:07 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8E9177783;
	Fri, 23 Jul 2021 21:40:07 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 289C93783
 for <cocci@systeme.lip6.fr>; Fri, 23 Jul 2021 21:40:06 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 16NJe51P001962
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 23 Jul 2021 21:40:05 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AA2ctw6km8tUquo0DctbYL3OUam/pDfIr3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fw9vre+MjzuiWetN98YhsdcJW7WZVoIkmskKKdg7NwAV7KZmCPhI?=
 =?us-ascii?q?LrFvAA0WKI+VPd8kPFmtK1mZ0QEZRWOZnASWJ3isv3+2CDfuoIytPvys+Vuds?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.84,264,1620684000"; d="scan'208";a="521330283"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Jul 2021 21:40:05 +0200
Date: Fri, 23 Jul 2021 21:40:05 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: =?UTF-8?Q?Andrew_=F0=9F=91=BD__Yourtchenko?= <ayourtch@gmail.com>
In-Reply-To: <CAPi140Ns4Qo1V=MqSUS46oJvO_0jgG5rPFuu0EvNrYw_3LoN0g@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2107232138560.2938@hadrien>
References: <CAPi140Mgk8zEk9vStbBU4Hh6oEMU2i6Kaji502AojELjFCR1OA@mail.gmail.com>
 <alpine.DEB.2.22.394.2107222203110.42931@hadrien>
 <CAPi140Ns4Qo1V=MqSUS46oJvO_0jgG5rPFuu0EvNrYw_3LoN0g@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 23 Jul 2021 21:40:07 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 23 Jul 2021 21:40:05 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] how to make substitutions at the end of the function,
 vs. the end of each block ?
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

> yourtch@ayourtch-lnx:~/cocci$ diff -c patch-old.cocci patch-new.cocci
> *** patch-old.cocci	2021-07-22 22:41:19.516957878 +0200
> --- patch-new.cocci	2021-07-22 22:41:52.625184341 +0200
> ***************
> *** 3,8 ****
> --- 3,9 ----
>   fresh identifier LAIN = "line_" ## AIN;
>
>   statement S1;
> + expression exp;
>
>   typedef clib_error_t, vlib_main_t, unformat_input_t, vlib_cli_command_t;
>   @@
> ***************
> *** 20,30 ****
>   -  while (unformat_check_input (AIN) != UNFORMAT_END_OF_INPUT)
>   + while (unformat_check_input (LAIN) != UNFORMAT_END_OF_INPUT)
>   S1
> ! <...
>   - return ERR;
>   + e = ERR;
>   + goto done;
> ! ...>
>   +done:
>   + unformat_free(LAIN);
>   + return e;
> --- 21,32 ----
>   -  while (unformat_check_input (AIN) != UNFORMAT_END_OF_INPUT)
>   + while (unformat_check_input (LAIN) != UNFORMAT_END_OF_INPUT)
>   S1
> ! <... when != true exp
> !      when exists
>   - return ERR;
>   + e = ERR;
>   + goto done;
> ! ...>
>   +done:
>   + unformat_free(LAIN);
>   + return e;
> ayourtch@ayourtch-lnx:~/cocci$
>
> And the result was the same...

My trick doesn't work because the return of interest is under a switch,
where there is no test expression that has the value true or false.  I
will see if something else can be done.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
