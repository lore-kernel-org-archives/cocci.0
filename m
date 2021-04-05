Return-Path: <SRS0=Nj+g=JC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8EFC433B4
	for <cocci@archiver.kernel.org>; Mon,  5 Apr 2021 07:54:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABE5F6139B
	for <cocci@archiver.kernel.org>; Mon,  5 Apr 2021 07:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE5F6139B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 1357sY3Z022574;
	Mon, 5 Apr 2021 09:54:34 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 488473CA1;
	Mon,  5 Apr 2021 09:54:34 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EF4EC3C26
 for <cocci@systeme.lip6.fr>; Mon,  5 Apr 2021 09:54:31 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 1357sV7c009367
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 5 Apr 2021 09:54:31 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AC70/9aPUP6xMCMBcTgqjsMiAIKoaSvp033AA?=
 =?us-ascii?q?0UdtRRtJNvGCn8e1k/gBkTPygjAdWHYv8OrwWpWoa3Xa6JJz/M0tLa6vNTOJhE?=
 =?us-ascii?q?KEJJxvhLGD/xTOACv7n9QttptIV4hbJJnOAUNhjcD8iTPWL/8FzMOc+K6lwcfS?=
 =?us-ascii?q?pk0NcShQZ6tt7xh0B2+geyUcLjVuP4YzF5aX+6N8ywaIRHJ/VKmGOkU=3D?=
X-IronPort-AV: E=Sophos;i="5.81,306,1610406000"; d="scan'208";a="501566779"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Apr 2021 09:54:31 +0200
Date: Mon, 5 Apr 2021 09:54:31 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <8561006e-7dc6-0f62-ecf0-c93146976925@web.de>
Message-ID: <alpine.DEB.2.22.394.2104050953290.2981@hadrien>
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
 <alpine.DEB.2.22.394.2104050907270.2981@hadrien>
 <8561006e-7dc6-0f62-ecf0-c93146976925@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1426433447-1617609271=:2981"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 05 Apr 2021 09:54:34 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 05 Apr 2021 09:54:31 +0200 (CEST)
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

--8323329-1426433447-1617609271=:2981
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Mon, 5 Apr 2021, Markus Elfring wrote:

> >> @display@
> >> identifier i =~ "^(?:[A-Z]+_){3,3}[A-Z]+", x;
> >> constant c =~ "\"";
> >> @@
> >> *#define i x c
> >>
> >>
> >> elfring@Sonne:~/Projekte/Coccinelle/janitor> spatch --parse-cocci show_define_usage6.cocci
> >> …
> >> minus: parse error:
> >>   File "show_define_usage6.cocci", line 5, column 13, charpos = 92
> >>   around = 'c',
> >>   whole content = *#define i x c
> >
> > No.  You have to match the expression and then check it using python.
>
> I find this view improvable.
>
> I would like to avoid the repetition of parsing efforts as much as possible.
> Under which circumstances can replacement lists be taken better into account?

Why does my suggestion involve a repetition of parsing effort?  You want
to use a regexp.  I'm asking you to put the regexp in a python function.

julia
--8323329-1426433447-1617609271=:2981
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1426433447-1617609271=:2981--
