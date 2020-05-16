Return-Path: <SRS0=NPBS=66=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BBDC433E0
	for <cocci@archiver.kernel.org>; Sat, 16 May 2020 12:27:10 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DA6820671
	for <cocci@archiver.kernel.org>; Sat, 16 May 2020 12:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtUMX1JD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA6820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04GCQtYb004973;
	Sat, 16 May 2020 14:26:55 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3443B3E6B;
	Sat, 16 May 2020 14:26:55 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EAD9A3DC8
 for <cocci@systeme.lip6.fr>; Sat, 16 May 2020 14:26:53 +0200 (CEST)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:643])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04GCQrkb020869
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 16 May 2020 14:26:53 +0200 (CEST)
Received: by mail-ej1-x643.google.com with SMTP id x20so4586114ejb.11
 for <cocci@systeme.lip6.fr>; Sat, 16 May 2020 05:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GDIYpLEU05pMoxe1RgcGZY+D4/QCXlQxWcr1Mw9yTo4=;
 b=DtUMX1JDKxCK+hNFoSyTTdmpYv7VF6r7svay+IVyushz/201AK7u25kZ/jWblgT4rb
 sTjKsVv2WAzB29iEr1SjbhAea9adZ+QOhIxxPMVKO3Zgh8Y68OWHkQdMgRTmtxzLSB6O
 cNIhgQs1dko8H6ARzzhIVLNtNlJouJ0XttxJ/RXvJcFVrxotbwbVsDSoGeJRGD5ByPha
 Aq0x20EE46zAjoENnKCO6ij0u42eJzLLhjlyRG+pLJAdZg0Sj/PcD1TbRpRNsXqsPUup
 ZkUEy5Tm1uI85M1k/EnBL6OlA+VUPglcVh3oT5aYVtZBITPbBlJlNaUBUdp5uZsg3na6
 e4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GDIYpLEU05pMoxe1RgcGZY+D4/QCXlQxWcr1Mw9yTo4=;
 b=GCzGRTJRon++ZJUQJ4IN9NnQ5NWc+XKW2i2IrmFi9GRaw2oPa78NLEDe4Z6Zn4HZ68
 tA37mV21PzskmApyiEHk2mKM6ori5t5ohqYH2GdswcOULn5xI+XXyFAoukpS6GM2AZPE
 TXQZUnrMinWgZaMuDpddpB6Cciokt0XOKX/tn665qxjoWu+nMZD4Uw8B+0CpVTXUrF0o
 EFOeEP5PPCCLyVOOXhHyTPTvGQZRWiyFBA2ODFQF7NhnPBXrUYg4LK5JPs/wxASX7Bn0
 2eBGi3gCcCNiLrpBaoiO+30xd/2E9bXEhhpWnrxz+EdbzAqGunPOkvOZYGQ7m8iJCnGG
 Q0PA==
X-Gm-Message-State: AOAM531aW0t+QBi8md8BlNAy/PBDCF/oyIHLhKCZMaP/JxHemHQM8QG1
 OE5uW0Oshg1Mc+ltX8UNIxPn35R3E+bu/8WlvEg=
X-Google-Smtp-Source: ABdhPJyrLUiOFpSKPe/EVzzThl2372kCUWWvCVDoBXHXapNbZfCSCLu1eIt41h+jQlyfkKsVH1WhzEH8rLDiKaCwVmA=
X-Received: by 2002:a17:906:eda3:: with SMTP id
 sa3mr6984580ejb.253.1589632013115; 
 Sat, 16 May 2020 05:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <CANhBUQ2Bqxwk3o8w22L8yvSK+VWbf-WTSiaf8v9kbsqSv2VwAA@mail.gmail.com>
 <alpine.DEB.2.21.2005161047430.2573@hadrien>
In-Reply-To: <alpine.DEB.2.21.2005161047430.2573@hadrien>
From: Chuhong Yuan <hslester96@gmail.com>
Date: Sat, 16 May 2020 20:26:42 +0800
Message-ID: <CANhBUQ3YaJnVZwy2+Fo42Naa04wQiBnEO6cm-rGE05=rZp0XKw@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 16 May 2020 14:26:55 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sat, 16 May 2020 14:26:53 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] How to match function calls in macros?
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

On Sat, May 16, 2020 at 4:49 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Sat, 16 May 2020, Chuhong Yuan wrote:
>
> > Hi all,
> > I want to write a script to match function calls in macros
> > but I don't know how to do that.
> > Here is an example:
> >
> > #define __INIT_WORK(_work, _func, _onstack)     \
> >     do {     \
> >         static struct lock_class_key __key; \
> >         \
> >         __init_work((_work), _onstack); \
> >         (_work)->data = (atomic_long_t) WORK_DATA_INIT(); \
> >         lockdep_init_map(&(_work)->lockdep_map,
> > "(work_completion)"#_work, &__key, 0); \
> >         INIT_LIST_HEAD(&(_work)->entry); \
> >         (_work)->func = (_func); \
> >     } while (0)
> >
> > In this example, I want to match function calls
> > like __init_work() and lockdep_init_map() in this macro.
> > So how to implement this by Coccinelle?
>
> I would suggest to take your file and run spatch --parse-c on the file.
> If you find BAD or bad in front of the lines of this code then the problem
> is that the code is not being parsed.  I suspect that the # is the
> problem.
>

I have run parse-c and it says the example file is perfect.

> Normally, Coccinelle will match code inside of macro definitions, but only
> if it is able to parse the macro definition, and the ability to parse
> macro definitions is somewhat limited.
>

My expression is not very clear.
I want to know which macros have function calls and what functions do they call.
So I wrote a script like this:

- #define mac(...) ... f(...) ...

But it does not work on the example.

> julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
