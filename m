Return-Path: <SRS0=PEvY=IQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9290C433E6
	for <cocci@archiver.kernel.org>; Thu, 18 Mar 2021 18:19:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E091C64F1D
	for <cocci@archiver.kernel.org>; Thu, 18 Mar 2021 18:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E091C64F1D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xteddy.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12IIJbZp007254;
	Thu, 18 Mar 2021 19:19:37 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E335A77CD;
	Thu, 18 Mar 2021 19:19:36 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 64CF25DC3
 for <cocci@systeme.lip6.fr>; Thu, 18 Mar 2021 19:19:35 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:329])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12IIJYJT013132
 for <cocci@systeme.lip6.fr>; Thu, 18 Mar 2021 19:19:34 +0100 (CET)
Received: by mail-ot1-x329.google.com with SMTP id
 g8-20020a9d6c480000b02901b65ca2432cso6082055otq.3
 for <cocci@systeme.lip6.fr>; Thu, 18 Mar 2021 11:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xteddy-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TYNakGTPquo8aXpjNIhEudilkwZE05CouyogomB1bwI=;
 b=gZXSTX+IZTEn530l/fzS62w2LkE1+PyY8QTPRpStPqavNLRlHwYjMEsOEN1+iV8dmf
 svU+bmEeaqPbrMvia4MgCqgNq+UvMMSvctpFgrN0VUxGUOunch77pEq97B+XStGQG1Sr
 lAHmysZ10RhlDun/PmOvQIAUQEyvAMHE4n7wJj6IAcpB4J7ziE8daTZZ1uCoqnQtMpDi
 fm9zAoYIzcRgQsp6ss34bidtBsY7ZcML+V1enNgcUn+M1lMox/TaNLKqcE36Oq+9D9Fy
 0Y61PGcRbjmJt35Ki8sRiKvjANSfFFK7PRDp5Rakh6U2dzLltpcurX3OD1oZqju58c0q
 Ihgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TYNakGTPquo8aXpjNIhEudilkwZE05CouyogomB1bwI=;
 b=DhK1IsmMdBUUIBKukykmYtwoyu072LcT1d/309dF231nCErD/TcQJVLyM+CXGbkLXw
 T4vGjh/FqyCRXflnPUfcyjWdm95WeBzHBk4nsTRRBFnTn6kiKZ91bQaDosyAqJPvEdaw
 wcR3LI8x09HT/lXXkdy82Syby9gPa0tJFBudDpUyONEnGSd4DOAne0kn44JUN8uUwqe6
 fkMG6Hc5NTS/TOaTapxdpMpDNIT7CJMTWyV/rYDqpJJzJr99Q3kXpqvGU4J3bvtr2t8Q
 +bd+f5IvzjnZJDXh08tv4VbfoTr8Rlm51KRyoNTPdHgkkvzdG9DG1VFVBFPixBpdaYDZ
 g/VQ==
X-Gm-Message-State: AOAM533FveEuGK0+x8xuqXa0GxnL46J+fa8KjkhSNSLe6IknCISz1UyC
 FYJY2plUDunHwC8Yl6Kb3sFjD0bWcjvvHu+a65fw3A==
X-Google-Smtp-Source: ABdhPJwiZNGnS8Rxkc38CbnarZPqjWphg1/ohEyJmDYkxRpz2BVKxCgDyVnnT+x/vq4rU9p379xXOiMcp9gH0tUaF9E=
X-Received: by 2002:a9d:798a:: with SMTP id h10mr8376452otm.170.1616091573779; 
 Thu, 18 Mar 2021 11:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAOhcEPbTH-oTTn1OUkgoYf2GaBKaCYjwpWuhrdNRkNQ0uZ_r4A@mail.gmail.com>
 <20210314061001.GA993@kunai> <alpine.DEB.2.22.394.2103141016010.2986@hadrien>
 <CAOhcEPZx4tNocG4TJvQKg_6e6kyJPbWGtj52TaGhJqHD36ZfYw@mail.gmail.com>
 <CALogXGW1-EbJo4_8HhtWbv02aYWgKpMwJeXuDasrsZ2HPDVJhg@mail.gmail.com>
 <alpine.DEB.2.22.394.2103160820280.2872@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2103160820280.2872@hadrien>
From: Thomas Adam <thomas@xteddy.org>
Date: Thu, 18 Mar 2021 18:19:18 +0000
Message-ID: <CAOhcEPbxcy7eZ_kXTWiC_u7EX_VPo56xKTu9g6nS1OwDLp+4zQ@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 18 Mar 2021 19:19:37 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 18 Mar 2021 19:19:34 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Replacing a struct member with a function call
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

Hi all,

Thanks for your help.  This is now resolved!

Kindly,
Thomas

On Tue, 16 Mar 2021 at 07:20, Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Mon, 15 Mar 2021, Mansour Moufid wrote:
>
> > On Sun, Mar 14, 2021, 20:43 Thomas Adam <thomas@xteddy.org> wrote:
> >       Hello,
> >
> >       I can see I was as clear as mud with my explanation -- apologies
> >       for
> >       that, so let me try again.
> >
> >       In my original example:
> >
> >       struct monitor {
> >           struct {
> >               int width;
> >               int height
> >           } virtual;
> >       };
> >
> >       ... the members width and height aren't required any more, as
> >       they're
> >       actually computable generically, and don't belong in that
> >       struct.
> >       Instead, I have separate functions which can provide those
> >       values.
> >
> >       So where I have in code, statements such as:
> >
> >       struct monitor *m = this_monitor();
> >       int foo = m->virutal.width;
> >
> >       I want to be able to substitute "m->virtual.width" with a
> >       function
> >       call "get_width()" -- which does not involve "struct monitor" at
> >       all.
> >       Indeed, the semantic patch I'm trying to apply now looks like
> >       this:
> >
> >       @@
> >       struct monitor *m;
> >       @@
> >
> >       - m->virtual.width;
> >       + get_width();
> >
> >       ... and although spatch doesn't tell me of any errors, when I
> >       run it
> >       over my codebase, no modifications are made.  So clearly I'm
> >       still
> >       doing something wrong.
> >
> >
> > Remove the semi-colons. ;)
>
> Good catch :)
>
> julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
