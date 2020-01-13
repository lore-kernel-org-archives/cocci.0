Return-Path: <SRS0=PsQ7=3C=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D54C33CA9
	for <cocci@archiver.kernel.org>; Mon, 13 Jan 2020 23:04:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A11207FF
	for <cocci@archiver.kernel.org>; Mon, 13 Jan 2020 23:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A11207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00DN4b63018056;
	Tue, 14 Jan 2020 00:04:37 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AD78077E3;
	Tue, 14 Jan 2020 00:04:37 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0FCAF771F
 for <cocci@systeme.lip6.fr>; Tue, 14 Jan 2020 00:04:37 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00DN4abw013793
 for <cocci@systeme.lip6.fr>; Tue, 14 Jan 2020 00:04:36 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.69,430,1571695200"; d="scan'208";a="431165260"
Received: from abo-154-110-68.mrs.modulonet.fr (HELO hadrien) ([85.68.110.154])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Jan 2020 00:04:36 +0100
Date: Tue, 14 Jan 2020 00:04:36 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Timur Tabi <timur@kernel.org>
In-Reply-To: <CAOZdJXWwKUPf_4oGk4G2j438n47fntf7J0AEJd7nFbg6+pR6Qw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2001140003030.2574@hadrien>
References: <CAOZdJXU4vhqzot5EEMZ_9jAdp-Be0TTyDS-uXJVPrGs2k=c7nA@mail.gmail.com>
 <alpine.DEB.2.21.2001132332060.2574@hadrien>
 <CAOZdJXWwKUPf_4oGk4G2j438n47fntf7J0AEJd7nFbg6+pR6Qw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 14 Jan 2020 00:04:38 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 14 Jan 2020 00:04:36 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Concatenating parameters into a string
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


On Mon, 13 Jan 2020, Timur Tabi wrote:

> On Mon, Jan 13, 2020 at 4:33 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> > Sorry, I don't follow what you are trying to do here.  Could you send an
> > example of the desired before after C code?  I see what you have above,
> > but I don't see the connection to the rule you have tried to write.
> >
> > I have the feeling that you will want to use some python code to do
> > something with the ##s, but I'm not sure.
>
> I'm hoping to avoid Python.
>
> I'm basically trying to recreate the ## feature of C macros.  For
> example, given:
>
> #define MACRO(a, b)   a##b
>
> I'm looking for a cocci script that replaces
>
>    x = 1 << MACRO(HELLO, _THERE);
>
> with
>
>   x = 1 << HELLO_THERE;

It might be possible to use

@@
identifier a,b;
fresh identifier x = a ## "_" ## b;
@@

- MACRO(a,b)
+ x

julia

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
