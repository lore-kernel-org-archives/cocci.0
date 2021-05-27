Return-Path: <SRS0=LaBa=KW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AEEC47089
	for <cocci@archiver.kernel.org>; Thu, 27 May 2021 11:31:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A3E4613AF
	for <cocci@archiver.kernel.org>; Thu, 27 May 2021 11:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3E4613AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 14RBVDPe007718;
	Thu, 27 May 2021 13:31:13 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 38B597737;
	Thu, 27 May 2021 13:31:13 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DD4D37648
 for <cocci@systeme.lip6.fr>; Thu, 27 May 2021 13:31:10 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:229])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 14RBV6DV017318
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 27 May 2021 13:31:07 +0200 (CEST)
Received: by mail-oi1-x229.google.com with SMTP id w127so401116oig.12
 for <cocci@systeme.lip6.fr>; Thu, 27 May 2021 04:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=na6KBx8TLqLknRA37bF1H/7uSlLXMLo0xGDoWsTY0e4=;
 b=AveRv5ZYqKZvYnSn+VsrWWPJfcn1oHMpWo1uBie9W00H6lCHDfsj3K7r0fXgutbZX9
 +81e11M1sQl4kV96ugzJz1+V0vqGya3qbNvVeg9z9G2ebuBJQZA4q6j5u65safooCX7n
 FLPqb/ES/Y51uuHEmadEym+bjZtulLZdh/CoKcSgFDtdzG9M4heHRPhdBs1ArogTo3wL
 Uo+j46IUpD8HtIajIlF92J6d+vz1diEtkodY2Hc5RTDIpTmJUmaAObD+foYgi5nxPTp3
 T+pl9SM0/boMOliRDXUHnta1XjFv9QQXk5g6bnnxkK+oTYBKqJGkmifCcLyLWi/0Isa8
 OaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=na6KBx8TLqLknRA37bF1H/7uSlLXMLo0xGDoWsTY0e4=;
 b=BWpi1asZsn59M6PMsSNjdBs0/JVt+PjcGUl9NwUXGOxIHvgQC/DLrUQ5ld6O98QGm5
 R+8/bH9rxiplV0u35Djtz7Nd4MIY5XpLxckcOvPVyAAGHR9tQVxQa9x8Ovexaiy+P0vq
 FY62uw3ZP72j4lGYQAJ4n1eu18YqtBOeaIXt18Ik0geBrwZ8nHj9MN9hdTtEoNpNAP1g
 9GT+PYdmA5lfsPIYNFbEBINMzeYPMLzWoLZsB2OM7FtfqoYXp24UhMb9uZbg5WmZYr0A
 xj9UQZaueZ3T1awnRGdko9bwp59a+GIi/90gc6z78bRZ2/F6PzgkRFyUjiyEOAz/uj5r
 A62g==
X-Gm-Message-State: AOAM530JvJW+7AWGYa/HNdOamWQ56bUWsLUoC6jWNztAz5zqdh2xWIuc
 5IJpicvBX7G6V/6W3xkxuOSEaBZtqQy6nlGhegLhsg==
X-Google-Smtp-Source: ABdhPJxtpm+Q0Xq5T2cS889+h/Ngc8EM2CpVX2C/oUQhJsBDMnHxLwmi7YrzTkjAZ2QeDQBNk5P6WBB1igEGcstmoQc=
X-Received: by 2002:a05:6808:b22:: with SMTP id
 t2mr5011376oij.67.1622115065780; 
 Thu, 27 May 2021 04:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <CA+EHjTzCieJgFQOgiP5YQWurpV9dOj=bw+jF=GsTtum4vy67Ag@mail.gmail.com>
 <alpine.DEB.2.22.394.2105271224160.12673@hadrien>
 <alpine.DEB.2.22.394.2105271225320.12673@hadrien>
 <CA+EHjTyvwxsFgYAUtVbo3UdhNHaqvx6rPfGLDyFX_WPN1m=XRg@mail.gmail.com>
In-Reply-To: <CA+EHjTyvwxsFgYAUtVbo3UdhNHaqvx6rPfGLDyFX_WPN1m=XRg@mail.gmail.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 27 May 2021 12:30:29 +0100
Message-ID: <CA+EHjTxNYeokQCjWojiGCHzSB1ph_5M8BRH7xrY4Z+euyFZJRw@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 27 May 2021 13:31:14 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 27 May 2021 13:31:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Adding a line to a function after all variable
	declarations
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

On Thu, May 27, 2021 at 11:55 AM Fuad Tabba <tabba@google.com> wrote:
>
> On Thu, May 27, 2021 at 11:26 AM Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> >
> >
> > On Thu, 27 May 2021, Julia Lawall wrote:
> >
> > >
> > >
> > > On Thu, 27 May 2021, Fuad Tabba wrote:
> > >
> > > > Hi,
> > > >
> > > > I'm trying to write a semantic patch that would add a new line to a
> > > > function, but would like that line to come after all local variables
> > > > (if any) have been declared. For example (distilled from what I am
> > > > actually trying to accomplish):
> > > >
> > > > @@
> > > > identifier f, s;
> > > > @@
> > > > f(..., struct mystruct *s, ...) {
> > > > /* after any variable declarations*/
> > > > + x = s->x;
> > > >  ...
> > > >  }
> > > >
> > > > I would like it to patch as follows:
> > > >
> > > > int function(struct mystruct *s) {
> > > > + x = s->x;
> > > > return 0;
> > > > }
> > > >
> > > > as well as
> > > >
> > > > int function(struct mystruct *s)
> > > > {
> > > > int y;
> > > > + x = s->x;
> > > > return 0;
> > > > }
> > > >
> > > > or
> > > >
> > > > int function(struct mystruct *s)
> > > > {
> > > > int y, z = 10;
> > > > float f;
> > > > + x = s->x;
> > > > return 0;
> > > > }
> > > >
> > > > Any suggestions on how I could do that?
> > >
> > > @@
> > > @@
> > >
> > > f(...) {
> > > ... when != S
> > > + new_code
> > > S
> > > ... when any
> > > }
> >
> > Sorry, that was not quite right.  The first S should be S1 and the second
> > S should be S2, ie they should be different.  S1 and S2 should be
> > statement metavariables and f should be an identifier metavariable.
>
> Thanks Julia. That works for my distilled example, but teaches me a
> lesson not to assume that the parts I've omitted aren't relevant. :)
> Here's the actual semantic patch I'm trying to write, and I can't get
> that quite to work:
>
> @@
> expression a, b;
> identifier vcpu;
> fresh identifier vcpu_ctxt = vcpu ## "_ctxt";
> iterator name kvm_for_each_vcpu;
> identifier fc;
> @@
> kvm_for_each_vcpu(a, vcpu, b)
>  {
> /* hop over any declarations */
> + vcpu_ctxt = &vcpu->arch.ctxt;
> <+...
> fc(..., vcpu, ...)
> ...+>
>  }
>

I managed to get it done by doing it in two steps; first using the
original semantic patch I had, then using yours essentially to move
the line I added.

Thanks again!
/fuad
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
