Return-Path: <SRS0=Nj+g=JC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6B7C433B4
	for <cocci@archiver.kernel.org>; Mon,  5 Apr 2021 07:09:10 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7640F6139C
	for <cocci@archiver.kernel.org>; Mon,  5 Apr 2021 07:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7640F6139C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 135794LX028009;
	Mon, 5 Apr 2021 09:09:04 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AE1343CA1;
	Mon,  5 Apr 2021 09:09:04 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 594C53C26
 for <cocci@systeme.lip6.fr>; Mon,  5 Apr 2021 09:09:02 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 135791hf006701
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 5 Apr 2021 09:09:02 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AbZzAja34XOm7ms4VDkKDbwqjBCIkLtp033Aq?=
 =?us-ascii?q?2lEZdDV8btGfndu/helz73DJoRwWX2wtns3FHaGGT2/V+5Id2/h3AZ6JWg76tG?=
 =?us-ascii?q?y0aLxz9IeK+UyFJwTS/vNQvJ0BT4FQE9v1ZGIRse/b502CH88k0J279smT9ILj?=
 =?us-ascii?q?5lNMaS0vVK169Qd+DW+gYy9LbS1LH4AwGpbZxucvnVudUE8aZMi6GXUJNtKrz7?=
 =?us-ascii?q?b2vanrbhIcCxks5BPmt1+VwYTnGBuV1Ap2aV1y6IolmFKpryXE/Km599m0xhjA?=
 =?us-ascii?q?vlWjjKhrpA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.81,305,1610406000"; d="scan'208";a="501563567"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Apr 2021 09:09:01 +0200
Date: Mon, 5 Apr 2021 09:09:01 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b9f6aceb-7e68-303d-bd1e-d41a7992b58b@web.de>
Message-ID: <alpine.DEB.2.22.394.2104050907270.2981@hadrien>
References: <0756b630-a2d7-f300-3b11-59af33b48631@web.de>
 <alpine.DEB.2.22.394.2103281128560.2854@hadrien>
 <1b5f6d22-5b89-097f-37bd-13b3b2ab011a@web.de>
 <alpine.DEB.2.22.394.2103281244200.2854@hadrien>
 <173fa182-4127-aaba-262e-e3953a81a1e2@web.de>
 <alpine.DEB.2.22.394.2103281343310.2854@hadrien>
 <f720b262-708f-a603-3470-b374db625578@web.de>
 <alpine.DEB.2.22.394.2103281644480.2854@hadrien>
 <fa66fce2-e60e-1907-7c8b-fd9ceedb8086@web.de>
 <alpine.DEB.2.22.394.2104041357060.2958@hadrien>
 <addb2edb-98cb-2834-b1b9-7d44cacda965@web.de>
 <alpine.DEB.2.22.394.2104041419290.2958@hadrien>
 <b9f6aceb-7e68-303d-bd1e-d41a7992b58b@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1018762340-1617606541=:2981"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 05 Apr 2021 09:09:05 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 05 Apr 2021 09:09:02 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking support for compound expressions (according to
 #define directives)
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

--8323329-1018762340-1617606541=:2981
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Mon, 5 Apr 2021, Markus Elfring wrote:

> > Thanks for the simpler examples.
>
> Would you like to support another search pattern by the means of
> the semantic patch language?
>
>
> @display@
> identifier i =~ "^(?:[A-Z]+_){3,3}[A-Z]+", x;
> constant c =~ "\"";
> @@
> *#define i x c
>
>
> elfring@Sonne:~/Projekte/Coccinelle/janitor> spatch --parse-cocci show_define_usage6.cocci
> …
> minus: parse error:
>   File "show_define_usage6.cocci", line 5, column 13, charpos = 92
>   around = 'c',
>   whole content = *#define i x c

No.  You have to match the expression and then check it using python.  YOu
can write:

@@
identifier i;
expression e : script:python() { ... python code to ceck e };
@@

#define i e

julia
--8323329-1018762340-1617606541=:2981
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1018762340-1617606541=:2981--
