Return-Path: <SRS0=lWl4=PR=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80525C43387
	for <cocci@archiver.kernel.org>; Wed,  9 Jan 2019 08:58:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB7E6206BB
	for <cocci@archiver.kernel.org>; Wed,  9 Jan 2019 08:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/LZ4GRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7E6206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x098wcX1021537
          ; Wed, 9 Jan 2019 09:58:38 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id ACD6D76F2;
	Wed,  9 Jan 2019 09:58:38 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 88F4F76E6
 for <cocci@systeme.lip6.fr>; Wed,  9 Jan 2019 09:58:37 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:235] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x098wa6s004198
 for <cocci@systeme.lip6.fr>; Wed, 9 Jan 2019 09:58:36 +0100 (CET)
X-pt: isis.lip6.fr
Received: by mail-oi1-x235.google.com with SMTP id t204so5700531oie.7
 for <cocci@systeme.lip6.fr>; Wed, 09 Jan 2019 00:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8hT6Os9+Tag+3ZHxQJiLi3GeurzUtPLRVyeJFGpiWxs=;
 b=W/LZ4GRT7Qrj4a1TGyun/RAr/q31sNorG0FbBqwemYBcFUlb2EBPL65P3cDWszB8ii
 EhqN2KLk7QY6L2volJjlsv+dDmwDR+I5GeRFkpmaB/T0cx0jgUbWr4GiqkZXlxnrxzmx
 R6Z2XwEWA2EtBlfaSroA3eHKOP6vbfP8ppYyFbqVb15A2umdx1+DeGEQDMRBDijbTuRa
 eL0SLVBNJANwCohnHBn/7W6FTFyeqXO/4OmaQsTsg8GFJIxJeomQhwfsRYENvwgbFkwM
 Cn5/P3f+ogFrSS2gC/7bi77DIRjEdPPK5tl/BjakhC3ROUfas5j1ZmCGVZQbOEmydaUl
 ITjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8hT6Os9+Tag+3ZHxQJiLi3GeurzUtPLRVyeJFGpiWxs=;
 b=gXVOM6JDilSVv4bRHHBe4WQ+a1j2oU085vbGoUzsh0P0zoI5ywt4TD6ARAxsOrg8VU
 RBftiOGrmH+eQaJ/JS7DnJMsb8FLpPjBwTjPVIMw9G1IfUjAl/HbEewSnP6ow82pQYsv
 fG9tK/hY2b79jz03lkjObotnbCiHn54ABJTBBt/e9KXrO3rRSQp9b+wNqWBBQKbOoxxd
 mwfCMYI9SLSHDi97WLU4sSZ4jwLFtGhDnpd0ijSrQh2wE58R1DyhToeymUpG1fP07K4j
 C6jYoI6GMSP9EwGp5XES3owg2u5yXnx/WD/edlX1wLr8jsyMgDRKPoLkyLLj3V2BSpOY
 u49A==
X-Gm-Message-State: AJcUukfuRCoQCleP1vACoF50e7B/bte/Fg9leaMRO3upKCJQbJgzrgE1
 WDRhmamxAVx8o4sZcTAE6psIhp3+lovtTZmEyk4Ntxzz
X-Google-Smtp-Source: ALg8bN57F7fHG7GT1TjtmPMEeLQVpBKAbx22usYYpfC4LcGjVn8tG0SxWW0cf80xBootVxD3ER38PHEvq0jkcgkuMhk=
X-Received: by 2002:aca:de03:: with SMTP id v3mr3439678oig.152.1547024315724; 
 Wed, 09 Jan 2019 00:58:35 -0800 (PST)
MIME-Version: 1.0
References: <CAAGQS2uda32aGO0vfPNUz8WGatfu8i0oM8dkf_aN9tsAUC1YLg@mail.gmail.com>
 <alpine.DEB.2.21.1901090904120.2752@hadrien>
 <CAAGQS2u+vSa-m_LoOZKVAsry81AS6af=rRY06qOYD8K02WON_Q@mail.gmail.com>
 <alpine.DEB.2.21.1901090948120.2752@hadrien>
In-Reply-To: <alpine.DEB.2.21.1901090948120.2752@hadrien>
From: Evan Zhao <tacingiht@gmail.com>
Date: Wed, 9 Jan 2019 16:58:24 +0800
Message-ID: <CAAGQS2smXW3jzS2gPnz-uNjoM7X3pqWE2dHp7Gj2CwQxmJLmfw@mail.gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 09 Jan 2019 09:58:38 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 09 Jan 2019 09:58:36 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] A question about a part of a CTL formula
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

Thank you for the clarification.

On Wed, Jan 9, 2019 at 4:50 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
>
> On Wed, 9 Jan 2019, Evan Zhao wrote:
>
> > Thank you for your quick response,
> >
> > I am a beginner for model checking.
> > I having been reading your papers and implement code for a while,
> > there are some more questions, will you please to answer them too?
> >
> > there are three free vars type, free_vars, minus_free_vars, and
> > minus_nc_free_vars.
> > By reading your paper, I know that free vars are used to manage the
> > metavariables, but
> > what does those three do respectively?
>
> free variables would be all metavariables referenced by a rule.
> minus_free_vars would be the ones used in the matching part of the rule (-
> annotated code or unannotated code).
> nc means no constraint.  One can put a constraint on a metavariable, for
> example to say that one position should be different than a previously
> identified position.  The no constraint variables are the ones thatare
> found directly on the matching code, and not in the constraints.
>
> julia
>
> >
> > Thank you again.
> >
> > On Wed, Jan 9, 2019 at 4:09 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
> > >
> > >
> > >
> > > On Wed, 9 Jan 2019, Evan Zhao wrote:
> > >
> > > > Hi there,
> > > >
> > > > I am looking at a CTL formula generated by spatch with "--show-ctl-text",
> > > >
> > > > for example, for a cocci file like
> > > > @@
> > > > expression e,e1,e2;
> > > > @@
> > > >
> > > > if (e)
> > > > - GOTO(e1);
> > > > -else GOTO(e2);
> > > > + e1;
> > > > +else e2;
> > > >
> > > > it corresponding CTL formula is:
> > > >
> > > > CTL =
> > > > Let _r_0 = (EX^((TrueBranch v InLoop)) v EX^(EX^(FalseBranch))) in
> > > > ((_r_0 &
> > > > (Ex e1 .
> > > > ((Ex_ e . (Ex _v . if (e) )) &,
> > > > ((EX(FalseBranch) &, EX(After)) &,
> > > > ((EX((TrueBranch &, AX((Ex _v . GOTO(e1);)))) &,
> > > > EX((FalseBranch &,
> > > > AX(((Ex _v . else ) &, AX((Ex e2 . (Ex _v . GOTO(e2);))))))))
> > > > &, EX((After &, EX((Ex _v . _S1)))))))))
> > > > v
> > > > (!_r_0 &
> > > > (Ex e1 .
> > > > ((Ex_ e . if (e) ) &,
> > > > (EX(FalseBranch) &,
> > > > ((EX((TrueBranch &, AX((Ex _v . GOTO(e1);)))) &,
> > > > EX((FalseBranch &,
> > > > AX(((Ex _v . else ) &, AX((Ex e2 . (Ex _v . GOTO(e2);))))))))
> > > > &, EX(After)))))))
> > > >
> > > > and I noticed that
> > > > Let _r_0 = (EX^((TrueBranch v InLoop)) v EX^(EX^(FalseBranch))) in
> > > > is a fixed pattern, and I can track it at somewhere around the function of
> > > > do_between_dots in the module Asttoctl2, but I don't what it stands for.
> > > >
> > > > Cloud someone tell me what purpose it serves for?
> > >
> > > I think it is checking whether the added code is in an if branch in which
> > > case it wants to add {}.  I think that in your semantic patch it is not
> > > detecting that the then is just a replacement.  If this is what led you to
> > > look at the CTL in the first place, you may get a better result with
> > >
> > > if (e)
> > > - GOTO(
> > >   e1
> > > - )
> > >   ;
> > > else
> > > - GOTO(
> > >   e2
> > > - )
> > >   ;
> > >
> > > Then it should be able to see that the changes are just inside the
> > > existing branches, and so no {} adjustment is needed.
> > >
> > > julia
> >
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
