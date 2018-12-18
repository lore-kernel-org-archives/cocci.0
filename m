Return-Path: <SRS0=6akS=O3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDB4C43387
	for <cocci@archiver.kernel.org>; Tue, 18 Dec 2018 16:19:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D140421841
	for <cocci@archiver.kernel.org>; Tue, 18 Dec 2018 16:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D140421841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBIGJC53007326
          ; Tue, 18 Dec 2018 17:19:12 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0480F740A;
	Tue, 18 Dec 2018 17:19:12 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 56F053A55
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 17:19:10 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBIGJ8gv018352
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 17:19:08 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.56,368,1539640800"; d="scan'208";a="360906557"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Dec 2018 17:19:08 +0100
Date: Tue, 18 Dec 2018 17:19:02 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Max <msuraev@sysmocom.de>
In-Reply-To: <28194663-42c4-83b6-4a21-545408fd7e12@sysmocom.de>
Message-ID: <alpine.DEB.2.20.1812181716490.2886@hadrien>
References: <0c0bf80c-56bd-6560-12b8-97a4b1b89963@sysmocom.de>
 <alpine.DEB.2.21.1812130724080.2458@hadrien>
 <346d748c-c073-7567-5547-23ec8a47c9b6@sysmocom.de>
 <alpine.DEB.2.21.1812132057380.2465@hadrien>
 <28194663-42c4-83b6-4a21-545408fd7e12@sysmocom.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-570319453-1545149943=:2886"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 18 Dec 2018 17:19:12 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Tue, 18 Dec 2018 17:19:08 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] struct replacement
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

--8323329-570319453-1545149943=:2886
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 18 Dec 2018, Max wrote:

> That almost works: both function parameters and variable declarations
> are updated in .c files but the function prototypes in .h are ignored.
>
> I call it as follows:
>
> spatch --in-place --sp-file struct.spatch -I include --dir src
>
> The source code from 'src' is updated but header files in 'include' are
> not affected.
>
> Specifying multiple dir doesn't work: "ignoring all but the last
> specified directory".
>
> Adding --include-headers doesn't do what I hoped it would.
>
> Using top-level directory doesn't help as well: .c in multiple sub-dirs
> are processed but .h are not.
>
> Reading docs so far revealed no way to update function definition in
> both .c and .h at the same time.
>
> Does spatch have to be called in some special way for this to work? Or
> .spatch file should have some particular syntax so it would affect both
> .c and .h simultaneously?

By default, Coccinelle only includes the headers that have the same name
as the .c file.  Ie for foo.c, it considers that foo.h is prbably
important, and thus worth the often large extra runtime cost to take into
account.

If you want more aggressive inclusion of headers, you need --all-includes
(the headers explicitly mentioned in the .c file) or --recursive-includes
(headers included by other headers).

julia


>
> 13.12.18 21:01, Julia Lawall пишет:
> >
> > If this is to be a function prototype, the parameter should be surrounded
> > with commas.  If there is no comma before or after the parameter
> > declaration, Coccinelle will take care of doing the right thing.
> >
> > But actually your rule should be:
> >
> > @@
> > @@
> >
> > struct
> > -   old_thing
> > +   new_thing
> >
> > Then it will just change the type whereever it occurs.
> >
> --
> - Max Suraev <msuraev@sysmocom.de>       http://www.sysmocom.de/
> =======================================================================
> * sysmocom - systems for mobile communications GmbH
> * Alt-Moabit 93
> * 10559 Berlin, Germany
> * Sitz / Registered office: Berlin, HRB 134158 B
> * Geschaeftsfuehrer / Managing Directors: Harald Welte
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
--8323329-570319453-1545149943=:2886
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-570319453-1545149943=:2886--
