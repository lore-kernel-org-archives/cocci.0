Return-Path: <SRS0=6akS=O3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDB0C43387
	for <cocci@archiver.kernel.org>; Tue, 18 Dec 2018 16:58:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AF7E217D9
	for <cocci@archiver.kernel.org>; Tue, 18 Dec 2018 16:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF7E217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBIGvmhi022875
          ; Tue, 18 Dec 2018 17:57:49 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DB98C740A;
	Tue, 18 Dec 2018 17:57:48 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E99873A55
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 17:57:46 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBIGvSid002730
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 17:57:28 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.56,368,1539640800"; d="scan'208";a="360912516"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Dec 2018 17:54:27 +0100
Date: Tue, 18 Dec 2018 17:54:21 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Max <msuraev@sysmocom.de>
In-Reply-To: <372cf517-11cb-3021-fc5b-219b26022493@sysmocom.de>
Message-ID: <alpine.DEB.2.20.1812181749390.2886@hadrien>
References: <0c0bf80c-56bd-6560-12b8-97a4b1b89963@sysmocom.de>
 <alpine.DEB.2.21.1812130724080.2458@hadrien>
 <346d748c-c073-7567-5547-23ec8a47c9b6@sysmocom.de>
 <alpine.DEB.2.21.1812132057380.2465@hadrien>
 <28194663-42c4-83b6-4a21-545408fd7e12@sysmocom.de>
 <alpine.DEB.2.20.1812181716490.2886@hadrien>
 <372cf517-11cb-3021-fc5b-219b26022493@sysmocom.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1854678447-1545152061=:2886"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 18 Dec 2018 17:57:49 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Tue, 18 Dec 2018 17:57:28 +0100 (CET)
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

--8323329-1854678447-1545152061=:2886
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 18 Dec 2018, Max wrote:

> I see. Yes,  --all-includes did the trick for me, thank you.
>
> Although I'm still have to update struct fields in addition to struct
> name and it seems like I'm using typedef in a wrong way.
>
> For example:
>
> _______________________
>
> @@
> @@
> struct
> - old_addr
> + new_address
>
> @@
> identifier a;
> typedef new_address;
> @@
> new_address a;
> - a.len;
> + a.length;

I don't understand what you are trying to do here.  typedef new_address;
is find for indicating that new_address is a typedef.  Ie you have
somewhere said:

typedef ... new_address;

new_address a; will then match a declaration where the type of the
declared variable is new_address.  But I don't understand - a.len;.
First, this is only going to match a statement that comes right after the
variable declaration.  Second, a.len; is a very strange statement, because
it doesn't do anything.

Maybe you want:

@@
typedef new_address;
new_address a;
@@
- a.len
+ a.length

That is, a should be a metavariable representing an expression of the
given type, and then you want to replace a len field by length.

You could also write the change as:

a.
-len
+length

julia

>
> _______________________
>
> This does not cause field updates although first part (names) works.
>
> Using 'typedef struct new_address' instead gives "meta: parse error".
>
> Using 'old_addr' instead of 'new_address' in 2nd part doesn't make any
> difference.
>
> The len/length are pretty generic names used in multiple structs. How do
> I instruct Coccinelle to make replacement only for identifiers which
> belong to a particular struct type (or pointer to it)?
>
> Is there some specific metaver syntax related to structs which I haven't
> found yet?
>
> 18.12.18 17:19, Julia Lawall пишет:
> >
> > By default, Coccinelle only includes the headers that have the same name
> > as the .c file.  Ie for foo.c, it considers that foo.h is prbably
> > important, and thus worth the often large extra runtime cost to take into
> > account.
> >
> > If you want more aggressive inclusion of headers, you need --all-includes
> > (the headers explicitly mentioned in the .c file) or --recursive-includes
> > (headers included by other headers).
> >
> > julia
>
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
--8323329-1854678447-1545152061=:2886
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1854678447-1545152061=:2886--
