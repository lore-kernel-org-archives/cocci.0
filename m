Return-Path: <SRS0=Utcs=WY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1A7C3A5A1
	for <cocci@archiver.kernel.org>; Wed, 28 Aug 2019 07:41:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 037AD20679
	for <cocci@archiver.kernel.org>; Wed, 28 Aug 2019 07:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjbHSQeO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 037AD20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7S7fPGp025718;
	Wed, 28 Aug 2019 09:41:25 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0C32E778B;
	Wed, 28 Aug 2019 09:41:25 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 598E374B3
 for <cocci@systeme.lip6.fr>; Wed, 28 Aug 2019 09:41:23 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:334] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7S7fMxL028765
 for <cocci@systeme.lip6.fr>; Wed, 28 Aug 2019 09:41:22 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id l2so1729327wmg.0
 for <cocci@systeme.lip6.fr>; Wed, 28 Aug 2019 00:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9Kc/QtOglJyyKPtMseaM892SwjvFkHGx5ikeAomWudA=;
 b=VjbHSQeOZ5bph3IU+tDfKQURviV+meKkug1+xPdIulVD63LlFKxqb3Zr21qyJLWiVz
 viDWGcAvMe9+dGru4U/mCflxtLaEm61iSPI4gej41ZAoxKtzK36dlA9tIki5VEPm8hZH
 cQg8Ru/vqXcJrlHaTRNMAruooiajGFlqRglh2iRemIT+dA+x8aISmGNYZi7XWRysiON+
 CcSJ+JGLk7r5JutZa4smXN/A118gW5j0le3uoY3uej7IY1fQy8Bs8KPTtEhqtZwYMIgW
 aOATh68BpCDLbYixhDXKZtl4pEHQMbCRSyasDfqrUwnE/m08YDxVF+acEBSbtJ2llcYj
 rLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9Kc/QtOglJyyKPtMseaM892SwjvFkHGx5ikeAomWudA=;
 b=cCzh1bBjFkivCaKlOr+PV67mxladKnpBEgKVa6ancXWNeqONu9lrAnONWKlwh6sEaZ
 LUZsTqmk6t2o1r5Xl6L0vcWuPfoOspXlFIZWZoD3FQZpF80RelkKjQA8KCRBjVyvxtfj
 LLXu5bi5lF3Y9KqihgBZmXWq46u74Eyh63Fw90dmZPIkerhicNOZ+McPuCrehUDb4wd/
 Uyis0GAcf0blOGWJAkyXkXCo1owB6IB5jWlzYcoOvx7UBqynrEBjxo6J3EZGSqG7lWdM
 1czi7He0L0ZMPaFnI4lBwZgBtQnUcoawnnMce/Qg4HoaL5uqpQi4lzZeTlj/KLSQYyQO
 mjpQ==
X-Gm-Message-State: APjAAAUmgaRXGKTCfCjPCRW5l4AZlCzpDDmYXS1X8mAfywcU/qLNkvK4
 tEXeYLZwSsu5xO4/Iwjd//8=
X-Google-Smtp-Source: APXvYqx1OB5LeBwCXkgxOln5fIuYuGOpJISGCROmTSm8ve1v9Y2Nf2ZHgLIAc9i+qRxvXqQMPwmGKQ==
X-Received: by 2002:a1c:cf83:: with SMTP id f125mr3040942wmg.8.1566978081830; 
 Wed, 28 Aug 2019 00:41:21 -0700 (PDT)
Received: from Nover ([161.105.209.130])
 by smtp.gmail.com with ESMTPSA id p69sm1839653wme.36.2019.08.28.00.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 00:41:21 -0700 (PDT)
Date: Wed, 28 Aug 2019 09:40:56 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Message-ID: <CAO5pjwTz-_YoQrMOyrY-6yX-kmp1cif35WDFYO676Rm9-3BAAg@mail.gmail.com>
References: <20190827143039.GA19250@Nover>
 <alpine.DEB.2.21.1908272238360.2475@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908272238360.2475@hadrien>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 28 Aug 2019 09:41:25 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 28 Aug 2019 09:41:22 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: John Gardner <gardnerjohng@gmail.com>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] SmPL highlighting on GitHub and GitLab
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

On Tue, Aug 27, 2019 at 10:44:43PM +0800, Julia Lawall wrote:
>
>
> On Tue, 27 Aug 2019, Paul Chaignon wrote:
>
> > Hello dear Coccinelle community,
> >
> > Since a few hours ago, SmPL code is detected and highlighted on GitHub.
> > Examples [1, 2] are visible in the Linux repository.  Other repositories
> > should receive highlighting when they'll be updated (after a git push).
> > Highlighting on GitLab should follow if/when they update their Linguist
> > dependency.
> >
> > This change follows an update to the Linguist library [3], used to detect
> > languages on GitHub and GitLab.  At the moment, all .cocci files are
> > detected as SmPL.  The grammar for highlighting [4] was written by John
> > Gardner and should also work for the Atom editor.  If you want to change
> > the color, aliases, or extensions associated with SmPL, we'd welcome pull
> > requests to Linguist and I'm confident John would too for the grammar!
>
> Wow, thanks for this!
>
> However, I don't see anything for [1], only for [2].

Are you sure?  I just checked again and I see it for both.  Maybe a
caching issue?

>
> As far as I can see, the - code has a background and the + code does not.
> Is there a reason for that?

All three signs (-, +, and *) should have a background color (red, green,
and orange respectively).  The green background (#f0fff4) is very light
however, so it may not be visible depending on your screen configuration.

>
> It could also be good to use a different color for the * code; I've been
> using purple.
>
> I also use blue for the @@s and black for the metavariable declarations,
> but I find your color choices rather appealing in this case.
>
> If there are no further color suggestions on the list, I will look into
> how to make a pull request.

I should clarify I haven't chosen the colors.  John did, to some extent.
Grammars used by GitHub associate "scopes" to tokens (in an imperfect way,
using regular expressions).  Colors are then associated to each scope by
GitHub through CSS [1].  So grammar authors have a limited control over
the colors.

It might still be possible to change the colors to your preferences.  I've
cc'ed John who might be better able to help you.  He also pointed me to
the mapping of scopes to available colors [2] he derived some time ago.

1 - https://github.com/primer/github-syntax-light
2 - https://github.com/github/linguist/pull/4568#issuecomment-513739638

>
> Thanks!
>
> julia
>
> >
> > Regards,
> > Paul Chaignon
> >
> > 1 - https://github.com/torvalds/linux/blob/master/scripts/coccinelle/api/d_find_alias.cocci
> > 2 - https://github.com/torvalds/linux/blob/master/scripts/coccinelle/misc/boolreturn.cocci
> > 3 - https://github.com/github/linguist
> > 4 - https://github.com/Alhadis/language-etc/blob/master/grammars/smpl.cson
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
