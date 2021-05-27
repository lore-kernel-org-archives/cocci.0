Return-Path: <SRS0=LaBa=KW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BCAC4707F
	for <cocci@archiver.kernel.org>; Thu, 27 May 2021 13:45:37 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4231E613AC
	for <cocci@archiver.kernel.org>; Thu, 27 May 2021 13:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4231E613AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 14RDjWmv022051;
	Thu, 27 May 2021 15:45:32 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CE74A7737;
	Thu, 27 May 2021 15:45:32 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4CFBA7648
 for <cocci@systeme.lip6.fr>; Thu, 27 May 2021 15:45:31 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:32e])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 14RDjTGx016545
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 27 May 2021 15:45:30 +0200 (CEST)
Received: by mail-ot1-x32e.google.com with SMTP id
 t10-20020a05683022eab0290304ed8bc759so213725otc.12
 for <cocci@systeme.lip6.fr>; Thu, 27 May 2021 06:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=96/B/w+YNxX0P64U03wZdHzqBVEcJlTY9SHGlSbAwAU=;
 b=OJiVOkWcNwe+Wh6p11YI8g8+68uyK+UBhsJduTZ8da8rmSU4zHr0Q7Gf5GfTtVjcgb
 2xnvf8lQEmLoWwAXyOx7vYQiIBCZLBra7BTFoHS4zRuHPhIYqNdsRxVQbmJnUq8lwudf
 4bH2H+8O7eu7xJ70XC4NZ6YqT2rHNZYAAUlYJKeSI7F5Eyx2Af3IR07eFjtqBXoD0G4N
 Y1t72IPPNrUzmTeQok6hdyODT1SZnuN4X9WQehguNJbC+QImu3xoeK6OdHI/DhrR5Of3
 QGv59w5AUvQE+QEQAJzVW8cck6bfvX+9pbcgycpXr3jtS0PdJZPkUnlNaOiJ15rXpled
 litg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=96/B/w+YNxX0P64U03wZdHzqBVEcJlTY9SHGlSbAwAU=;
 b=K9r1rYeQo1JkaGmZr6c/vgEcYBE+jQqkzAMvbWbKbHO7yAmSoVxuEyEMaBdGfrylTm
 UPFV1cvNYZopRhbUXZsSPEEWZyFeW8+C7PlibdEO02H+yvpXWPhDStEgxi/2janR1JnE
 0dFG3MAK/ufBQJcGVYYqyWtNJxIbKEt1OIB4X2KJ3kUVvDKI2ef6HLYCEbERTSfWD8qg
 gNHUndUxEryljMQegHgL3odqs2pfJZnSxboUMEM3RizC37ldiKvaCOPzulXSc8zZXtvx
 Pa0ElYtbzkMZPi4/5vVOSagq94tMhNJI7EKRR2Tkf/puC5lKDQ4YmBsqe3kI594ztuCm
 WjjQ==
X-Gm-Message-State: AOAM531pnW4qrnvM0radL5kZc+3HeNbZFFyI5WPmV1B9pJdART1XXYBO
 gKm0JlMyRDzQMvOHFbRHoFvQ/NaWpuDoWJmOWyh3dyOQqOmCdg==
X-Google-Smtp-Source: ABdhPJxlSuiXZ8xHG7cDfHjBs2wWOYj3dYvPQV6e411rAUMQe9irju7Wm+4RMBpW7Bbg3A9qEVFVF1I1osusDE8eCAk=
X-Received: by 2002:a9d:4115:: with SMTP id o21mr2894380ote.52.1622123129032; 
 Thu, 27 May 2021 06:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <CA+EHjTzCieJgFQOgiP5YQWurpV9dOj=bw+jF=GsTtum4vy67Ag@mail.gmail.com>
 <alpine.DEB.2.22.394.2105271224160.12673@hadrien>
 <alpine.DEB.2.22.394.2105271225320.12673@hadrien>
 <CA+EHjTyvwxsFgYAUtVbo3UdhNHaqvx6rPfGLDyFX_WPN1m=XRg@mail.gmail.com>
 <alpine.DEB.2.22.394.2105271305530.12673@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2105271305530.12673@hadrien>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 27 May 2021 14:44:52 +0100
Message-ID: <CA+EHjTwCjzn_gdY8VQs8D35tQ6-gSc6HTCdHC6TFvvKzohNagw@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 27 May 2021 15:45:33 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 27 May 2021 15:45:30 +0200 (CEST)
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

On Thu, May 27, 2021 at 12:44 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
> > @@
> > expression a, b;
> > identifier vcpu;
> > fresh identifier vcpu_ctxt = vcpu ## "_ctxt";
> > iterator name kvm_for_each_vcpu;
> > identifier fc;
> > @@
> > kvm_for_each_vcpu(a, vcpu, b)
> >  {
> > /* hop over any declarations */
> > + vcpu_ctxt = &vcpu->arch.ctxt;
> > <+...
> > fc(..., vcpu, ...)
> > ...+>
> >  }
> >
> > So I'm trying to add the line "vcpu_ctxt = &vcpu->arch.ctxt" after any
> > declarations, only if there's a function in that block that's using
> > vcpu. This works, but the vcpu_ctxt assignment is of course always
> > added first, before any declarations.
> >
> > Doing the following partially works, but it of course misses the case
> > where the function call with vcpu comes immediately after the
> > vcpu_ctxt assignment. Removing S2 altogether gives me a parse error.
> >
> > @@
> > expression a, b;
> > identifier vcpu;
> > fresh identifier vcpu_ctxt = vcpu ## "_ctxt";
> > iterator name kvm_for_each_vcpu;
> > identifier fc;
> > statement S1, S2;
> > @@
> > kvm_for_each_vcpu(a, vcpu, b)
> >  {
> >  ... when != S1
> > + vcpu_ctxt = &vcpu->arch.ctxt;
> >  S2;
> > <+...
> > fc(..., vcpu, ...)
> > ...+>
> >  }
>
> @@
> identifier f;
> statement S1,S2;
> @@
>
> f(...) {
> ... when != S1
> (
> + new_code
> S2
> ... when any
> &
> <+...
> fc(..., vcpu, ...)
> ...+>
> )
> }

I get a parse error when I try that (both copying it verbatim, or
adapting it to my code):

minus: parse error:
  File "test.cocci", line 18, column 0, charpos = 209
  around = '<+...',
  whole content = <+...

Thanks!
/fuad
>
> julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
