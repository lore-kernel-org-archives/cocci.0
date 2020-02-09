Return-Path: <SRS0=c99d=35=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF5AC2BA83
	for <cocci@archiver.kernel.org>; Sun,  9 Feb 2020 17:35:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2398820714
	for <cocci@archiver.kernel.org>; Sun,  9 Feb 2020 17:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2398820714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 019HZDkY025178;
	Sun, 9 Feb 2020 18:35:13 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A05F7772F;
	Sun,  9 Feb 2020 18:35:13 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 95F9F7718
 for <cocci@systeme.lip6.fr>; Sun,  9 Feb 2020 18:35:11 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 019HZBNw003229
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 9 Feb 2020 18:35:11 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.70,422,1574118000"; d="scan'208";a="435149675"
Received: from abo-105-123-68.mrs.modulonet.fr (HELO hadrien) ([85.68.123.105])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Feb 2020 18:35:10 +0100
Date: Sun, 9 Feb 2020 18:35:10 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>
In-Reply-To: <beb17020cc87be2d0e63edc0a897a4c0c2975b27.camel@gmail.com>
Message-ID: <alpine.DEB.2.21.2002091834431.3430@hadrien>
References: <20200209153452.11837-1-jaskaransingh7654321@gmail.com>
 <20200209153452.11837-4-jaskaransingh7654321@gmail.com>
 <alpine.DEB.2.21.2002091747430.3430@hadrien>
 <beb17020cc87be2d0e63edc0a897a4c0c2975b27.camel@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 09 Feb 2020 18:35:13 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 09 Feb 2020 18:35:11 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: "linux-kernel-mentees@lists.linuxfoundation.org"
 <linux-kernel-mentees@lists.linuxfoundation.org>,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v4 3/3] tests: Add test case to match const
 pointer variants
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



On Sun, 9 Feb 2020, Jaskaran Singh wrote:

> On Sun, 2020-02-09 at 17:48 +0100, Julia Lawall wrote:
> > On Sun, 9 Feb 2020, Jaskaran Singh wrote:
> >
> > > Pointer to const pointer and its variants would not match
> > > previously.
> > > Add a test case for matching these types.
> > >
> > > Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
> > > ---
> > >  tests/constptr.c     |  7 +++++++
> > >  tests/constptr.cocci | 19 +++++++++++++++++++
> > >  tests/constptr.res   |  7 +++++++
> > >  3 files changed, 33 insertions(+)
> > >  create mode 100644 tests/constptr.c
> > >  create mode 100644 tests/constptr.cocci
> > >  create mode 100644 tests/constptr.res
> > >
> > > diff --git a/tests/constptr.c b/tests/constptr.c
> > > new file mode 100644
> > > index 00000000..13fe064c
> > > --- /dev/null
> > > +++ b/tests/constptr.c
> > > @@ -0,0 +1,7 @@
> > > +int main()
> > > +{
> > > +	const char * const * id;
> > > +	const char * * const * id;
> > > +	const char * const * * id;
> > > +	const char * const id;
> >
> > As far as I can see in the Linux kernel, there is no space between
> > two *s,
> > and there is no space before an identifier.
> >
>
> Well, the test isn't replacing the type here. It's just replacing the
> ident as per the matches. So I guess the spaces are preserved as in the
> C file.
> When replacing the type like say
> -t x;
> +t y;
> Spaces are not added between the stars or the ident.

Yes, I agree.

>
> Sorry if I'm missing something. Do you mean that the C file/res file
> should conform to the Linux style?

I think it would be nicer if it did.

julia

> Cheers,
> Jaskaran.
>
> > julia
> >
> > > +}
> > > diff --git a/tests/constptr.cocci b/tests/constptr.cocci
> > > new file mode 100644
> > > index 00000000..29f0aa96
> > > --- /dev/null
> > > +++ b/tests/constptr.cocci
> > > @@ -0,0 +1,19 @@
> > > +@ r0 @
> > > +identifier id;
> > > +@@
> > > +const char * const *
> > > +- id
> > > ++ id1
> > > +;
> > > +const char * * const *
> > > +- id
> > > ++ id2
> > > +;
> > > +const char * const * *
> > > +- id
> > > ++ id3
> > > +;
> > > +const char * const
> > > +- id
> > > ++ id4
> > > +;
> > > diff --git a/tests/constptr.res b/tests/constptr.res
> > > new file mode 100644
> > > index 00000000..0af4de9a
> > > --- /dev/null
> > > +++ b/tests/constptr.res
> > > @@ -0,0 +1,7 @@
> > > +int main()
> > > +{
> > > +	const char * const * id1;
> > > +	const char * * const * id2;
> > > +	const char * const * * id3;
> > > +	const char * const id4;
> > > +}
> > > --
> > > 2.21.1
> > >
> > >
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
