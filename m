Return-Path: <SRS0=17+G=QX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D113C43381
	for <cocci@archiver.kernel.org>; Sat, 16 Feb 2019 08:34:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B245A222D0
	for <cocci@archiver.kernel.org>; Sat, 16 Feb 2019 08:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B245A222D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1G8YCTf026779
          ; Sat, 16 Feb 2019 09:34:12 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2CED076FA;
	Sat, 16 Feb 2019 09:34:12 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 28C4976F4
 for <cocci@systeme.lip6.fr>; Sat, 16 Feb 2019 09:34:11 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1G8Y9j5028357
 for <cocci@systeme.lip6.fr>; Sat, 16 Feb 2019 09:34:09 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.58,376,1544482800"; d="scan'208";a="296376402"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Feb 2019 09:34:09 +0100
Date: Sat, 16 Feb 2019 09:34:08 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <10281c5d-8b32-0a02-17ae-20bf86f8dc65@web.de>
Message-ID: <alpine.DEB.2.21.1902160933350.3212@hadrien>
References: <201902161504357846572@zte.com.cn>
 <10281c5d-8b32-0a02-17ae-20bf86f8dc65@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1058747191-1550306049=:3212"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 16 Feb 2019 09:34:12 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sat, 16 Feb 2019 09:34:09 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, kernel-janitors@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Wen Yang <yellowriver2010@hotmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr, Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: Re: [Cocci] [v5] coccinelle: semantic code search for
	missingput_device()
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

--8323329-1058747191-1550306049=:3212
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sat, 16 Feb 2019, Markus Elfring wrote:

> > Thanks, We will change it to something like this:
> > In a function, for a local variable obtained by of_find_device_by_node()
>
> How do you think about another wording approach?
>
> 1. Precondition:
>    It will be checked where the return value is stored from
>    a call of the function “of_find_device_by_node”.
>
> 2. The source code search will be continued with …
>
>
> > Thank you, but a local variable is necessary.
>
> Would you like to take additional storage possibilities for a safer
> analysis approach into account?
>
> Is the restriction “local” really sufficient when such a pointer
> could be copied to other variables?

I've lost track of the original semantic patch, but perhaps it needs a

when != e1 = e

julia

>
>
> >> Can it happen that on other function will perform the desired reference release?
> >
> > Thanks.
> > Because the information of this local variable is not passed to the external function,
> > this situation does not exist.
>
> Will copied pointers matter here?
>
>
> > But it's over 80 characters.
>
> Long string literals can be accepted because of error message search concerns
> around a tool like “grep”.
>
>
> >> Will any more advanced error diagnostics be eventually developed?
> >
> > Hello, we are just doing the practical work in this field.
>
> Are you aware of additional software design options from computer science
> and existing analysis tools?
>
>
> > We also hope that it can support cross-function/cross-file/data stream analysis
> > and other functions.
>
> This functionality will need further clarification.
>
>
> > We are also analyzing the principle and code implementation of coccinelle,
> > hoping to contribute a little.
>
> I am curious on how this situation will evolve further.
>
> Regards,
> Markus
>
--8323329-1058747191-1550306049=:3212
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1058747191-1550306049=:3212--
