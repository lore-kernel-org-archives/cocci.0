Return-Path: <SRS0=LaBa=KW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6DDC47089
	for <cocci@archiver.kernel.org>; Thu, 27 May 2021 10:55:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76C3F611CD
	for <cocci@archiver.kernel.org>; Thu, 27 May 2021 10:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C3F611CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 14RAtpjt006121;
	Thu, 27 May 2021 12:55:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B14D27737;
	Thu, 27 May 2021 12:55:51 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 62FD97648
 for <cocci@systeme.lip6.fr>; Thu, 27 May 2021 12:55:49 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:236])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 14RAtlbK014345
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 27 May 2021 12:55:48 +0200 (CEST)
Received: by mail-oi1-x236.google.com with SMTP id j75so324256oih.10
 for <cocci@systeme.lip6.fr>; Thu, 27 May 2021 03:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rDUvFQomBr7QeA2PbF2rjPzpkLhwdSOkvZwltn0ac+4=;
 b=s5pboFV91q4aPrwkbtu7f/TmtMldNC03PXphooV6DlnvMSm6ommudjRIDnQGJ5kr23
 9LiWq2OW7enDeTZX+8Z4ncogPZSj2A80aj+70tQ8tTRzZ92z0D7mYXSre02I7u79Ync9
 bCEKOuOeiS+8VVTfwKKUm0gF3Vzy3IAL9spb+AVL74uu5l/bT50tBtkgQvtGW/Hjy4iD
 TYG+aeMlhHOoDmkikzwh6IgXtrbDp2RYhmyd+DOpyOPm7kmvnlWXuHpP/dQb6DxY55YZ
 nNxEr8n/CVx+XNolf326QxYdDh12N79Jb2L8aHihzLdIgtVsOlSQk0KzsfTY40nPLcQP
 eG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rDUvFQomBr7QeA2PbF2rjPzpkLhwdSOkvZwltn0ac+4=;
 b=U3HhQ8F0UvrlYaRwD5GIGa0soX/5v58AguTdAxYB1Otv8PJn3Yrs74PLCGKvn1ew7L
 nwRZpzD2ruRTsf9T2/GqINb89bKKhM2JnklZTZtbLhHeYyjFJTuTG1ibz7RNGWJVYdvn
 wMpSoWYWcsdla6ecys1LIkrotIerKOkNVdNdZwtZJU7WdbgpOQ9E0d9OUiHw34wJOqAd
 EqmBI7QvUNJjWOfF+qYK1+eGHLnHEmLaiAQ6N+fld/N3vhq/BM0DjYFQ0CW+Ify4O9d0
 RL6KM2Kg4WMRF73STDLSs5rLCAmlh9mo6j3He1Lazkdd3HTydoxsQC9nhgQit6mV8zRQ
 31gw==
X-Gm-Message-State: AOAM532H7wYWgREm1+WSxlhh3Ifdj7o7cvM01gOt5t5pfQDdyI0TfY6a
 oUB48Z94P20DRvjqtlkezd9F4r/r9uC5PUUkgTQmt8ijOaEMWQ==
X-Google-Smtp-Source: ABdhPJxkcHzBrzLCmSp8lJspr8A452j95FTRZYUHWyZw8HeL2alMAJq/KV8DL2oaNgZHLoX2gBEfyyFZ9hGi019BZlY=
X-Received: by 2002:aca:4244:: with SMTP id p65mr4936178oia.8.1622112947093;
 Thu, 27 May 2021 03:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <CA+EHjTzCieJgFQOgiP5YQWurpV9dOj=bw+jF=GsTtum4vy67Ag@mail.gmail.com>
 <alpine.DEB.2.22.394.2105271224160.12673@hadrien>
 <alpine.DEB.2.22.394.2105271225320.12673@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2105271225320.12673@hadrien>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 27 May 2021 11:55:10 +0100
Message-ID: <CA+EHjTyvwxsFgYAUtVbo3UdhNHaqvx6rPfGLDyFX_WPN1m=XRg@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 27 May 2021 12:55:52 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 27 May 2021 12:55:48 +0200 (CEST)
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

On Thu, May 27, 2021 at 11:26 AM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Thu, 27 May 2021, Julia Lawall wrote:
>
> >
> >
> > On Thu, 27 May 2021, Fuad Tabba wrote:
> >
> > > Hi,
> > >
> > > I'm trying to write a semantic patch that would add a new line to a
> > > function, but would like that line to come after all local variables
> > > (if any) have been declared. For example (distilled from what I am
> > > actually trying to accomplish):
> > >
> > > @@
> > > identifier f, s;
> > > @@
> > > f(..., struct mystruct *s, ...) {
> > > /* after any variable declarations*/
> > > + x = s->x;
> > >  ...
> > >  }
> > >
> > > I would like it to patch as follows:
> > >
> > > int function(struct mystruct *s) {
> > > + x = s->x;
> > > return 0;
> > > }
> > >
> > > as well as
> > >
> > > int function(struct mystruct *s)
> > > {
> > > int y;
> > > + x = s->x;
> > > return 0;
> > > }
> > >
> > > or
> > >
> > > int function(struct mystruct *s)
> > > {
> > > int y, z = 10;
> > > float f;
> > > + x = s->x;
> > > return 0;
> > > }
> > >
> > > Any suggestions on how I could do that?
> >
> > @@
> > @@
> >
> > f(...) {
> > ... when != S
> > + new_code
> > S
> > ... when any
> > }
>
> Sorry, that was not quite right.  The first S should be S1 and the second
> S should be S2, ie they should be different.  S1 and S2 should be
> statement metavariables and f should be an identifier metavariable.

Thanks Julia. That works for my distilled example, but teaches me a
lesson not to assume that the parts I've omitted aren't relevant. :)
Here's the actual semantic patch I'm trying to write, and I can't get
that quite to work:

@@
expression a, b;
identifier vcpu;
fresh identifier vcpu_ctxt = vcpu ## "_ctxt";
iterator name kvm_for_each_vcpu;
identifier fc;
@@
kvm_for_each_vcpu(a, vcpu, b)
 {
/* hop over any declarations */
+ vcpu_ctxt = &vcpu->arch.ctxt;
<+...
fc(..., vcpu, ...)
...+>
 }

So I'm trying to add the line "vcpu_ctxt = &vcpu->arch.ctxt" after any
declarations, only if there's a function in that block that's using
vcpu. This works, but the vcpu_ctxt assignment is of course always
added first, before any declarations.

Doing the following partially works, but it of course misses the case
where the function call with vcpu comes immediately after the
vcpu_ctxt assignment. Removing S2 altogether gives me a parse error.

@@
expression a, b;
identifier vcpu;
fresh identifier vcpu_ctxt = vcpu ## "_ctxt";
iterator name kvm_for_each_vcpu;
identifier fc;
statement S1, S2;
@@
kvm_for_each_vcpu(a, vcpu, b)
 {
 ... when != S1
+ vcpu_ctxt = &vcpu->arch.ctxt;
 S2;
<+...
fc(..., vcpu, ...)
...+>
 }

Thanks again,
/fuad

> julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
