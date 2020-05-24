Return-Path: <SRS0=Qcbb=7G=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B994DC433DF
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 06:08:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 042C420776
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 06:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 042C420776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04O68AbU006542;
	Sun, 24 May 2020 08:08:10 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C7C213DC8;
	Sun, 24 May 2020 08:08:10 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 805043D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 08:08:09 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04O686Nn008749
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 08:08:06 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,428,1583190000"; d="scan'208";a="451049241"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 May 2020 08:08:06 +0200
Date: Sun, 24 May 2020 08:08:06 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jerome Glisse <jglisse@redhat.com>
In-Reply-To: <20200524023824.GA2598074@redhat.com>
Message-ID: <alpine.DEB.2.21.2005240805270.2429@hadrien>
References: <20200524023824.GA2598074@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-181115109-1590300486=:2429"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 08:08:11 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 08:08:06 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Matching an expression which use an identifier
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

--8323329-181115109-1590300486=:2429
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Sat, 23 May 2020, Jerome Glisse wrote:

> Hi,
>
> I am trying to move local variable initialization of some variable to
> first statement. For instance in example below i want to move any local
> initialization that use local variable "a" to before the printf.
>
> From:
> void foo()
> {
>     int k = 8/2;
>     int a = 45*4;
>     int c = 16*2;
>     int b = a*4+2;
>     int d;
>
>     printf("%d %d %d", a, c, b);
> }
>
> To:
> void foo()
> {
>     int a = 45*4;
>     int c = 16*2;
>     int b;
>     int d;
>
>     b = a*4+2;
>     printf("%d %d %d", a, c, b);
> }
>
> Here is a rule that will move "c = 16*2"
>
> @@
> identifier V1={a};

The above line is not needed.  Just use a in your rule.

> identifier V2;
> expression E;
> statement S1;
> statement S;
> type T1, T2;
> @@
> { ... T1 V1; ...

put when any after the second ... above

> -T2 V2 = E;

put \(<+...a...+>\&E\) in place of E

> +T2 V2;
>
> // Insert it before first statement that is not a declaration.
> ... when != S

Put another when any here, below the when != S

> +V2=E;

Put a ++ instead of +, since there may be several things to add.  There is
no guarantee on the order in which the added code appears.

julia

> S1}
>
>
> This match the first declaration after "a" declaration. I have try using
> V1@E or E@V1 but it does not seem to match b declaration.
>
> Note that i do not know the form of the expression in which "a" appears,
> nor do i know the type of "b". My objective is to move the initialization
> of some local variable of some type to first statement (role played by "a"
> in above example) and then move all dependent initialization after it
> (in above example "b" is dependent on "a").
>
> I am not sure what kind of filter on E i can use to make it float to
> only expression containing "a" ...
>
> Hope this is something that can be done, i would hate having to do it
> in python :)
>
> Thank you in advance for any pointers.
>
> Cheers,
> Jérôme
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
--8323329-181115109-1590300486=:2429
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-181115109-1590300486=:2429--
