Return-Path: <SRS0=lWl4=PR=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78D1C43387
	for <cocci@archiver.kernel.org>; Wed,  9 Jan 2019 08:44:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AC1B2075C
	for <cocci@archiver.kernel.org>; Wed,  9 Jan 2019 08:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9V2GOUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC1B2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x098iULM005443
          ; Wed, 9 Jan 2019 09:44:30 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0751576F2;
	Wed,  9 Jan 2019 09:44:30 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 01DAD76E6
 for <cocci@systeme.lip6.fr>; Wed,  9 Jan 2019 09:44:27 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:329] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x098iQqN000294
 for <cocci@systeme.lip6.fr>; Wed, 9 Jan 2019 09:44:26 +0100 (CET)
X-pt: isis.lip6.fr
Received: by mail-ot1-x329.google.com with SMTP id 81so6036296otj.2
 for <cocci@systeme.lip6.fr>; Wed, 09 Jan 2019 00:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LnK+LfZk7g7KHacu7a6h/B+DXWbAQkudfn+xLG5QTNg=;
 b=q9V2GOUES60qYY2cmyohepufdI2FZ1GjulnxeLESK1d9cQGheNIwu+SofHT1/d21mZ
 Hhp6nf9elvxrgTghZtn+eUU8uEmEw01rkKauEizkICNH6ghd7Np9luO4PHO2Ql7MNbid
 X73ZvtbExXqoO98ej+PmLYeqU3uOpcde0l4XrCUlViRJUxGO4YgqdPjGd6KoDau8Ur4R
 eEIrNpzq4o9TGpQu05s5m1uuIIxha/XAJPwEE1t3cb7uCOexiKVR6u3TFMNm8OFVIJim
 UGjZKGV8uuV734bWwWA2H0RYtBQnM2I9T1PV06D97E/IeyxiGFq0ibUBQxKOvQZA54p1
 /UTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LnK+LfZk7g7KHacu7a6h/B+DXWbAQkudfn+xLG5QTNg=;
 b=uW5/f6BH2Ul2po1BIElrwP7oRlmN6JJbn0a1ieox15yUPN0zRhcV33+RDGhzud6fji
 +Av5RYqwyVvQG4v5/1rvyMIZblYy01ZkAZQ7VnXkE3xlZxVRu9a3zE5n0NbMkUu9k5ww
 D/rdTelXGbh8nis2g9f045QjIvYV3onvZ1HvCfV4vWxvunp6WZQBRWbArpQcWvWZN9+e
 fmRhU/jlETYqTUua+4nRfwguLkyVz8fSUYQG/F7/IuTkgEfohuFsVJKVce1/pIKtWqHS
 8QdI3J30nybF+BLttopP1RjKgaAHTm/Kr/j/IwOVJyf8Tv+puGLtP/6j8rrCZrffhOUs
 9JXQ==
X-Gm-Message-State: AJcUukeUIIq601ygUwGaFkLSI+dRcpLuSCPrYjfMxGZnjOfbIzP/xkHw
 A26ZwEShi5mTB56UvO7tcdvcDNUrR/6Lv3XbSOc=
X-Google-Smtp-Source: ALg8bN6IfenW7/wzYPCTwgo2aXScpPCR1fRssevfRXP3jBqCbCK1eIsw9gY22th00ihGJ7NpMGrRv0xOez+LdKbipB8=
X-Received: by 2002:a9d:b97:: with SMTP id 23mr3321800oth.109.1547023465803;
 Wed, 09 Jan 2019 00:44:25 -0800 (PST)
MIME-Version: 1.0
References: <CAAGQS2uda32aGO0vfPNUz8WGatfu8i0oM8dkf_aN9tsAUC1YLg@mail.gmail.com>
 <alpine.DEB.2.21.1901090904120.2752@hadrien>
In-Reply-To: <alpine.DEB.2.21.1901090904120.2752@hadrien>
From: Evan Zhao <tacingiht@gmail.com>
Date: Wed, 9 Jan 2019 16:44:13 +0800
Message-ID: <CAAGQS2u+vSa-m_LoOZKVAsry81AS6af=rRY06qOYD8K02WON_Q@mail.gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 09 Jan 2019 09:44:30 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 09 Jan 2019 09:44:26 +0100 (CET)
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

Thank you for your quick response,

I am a beginner for model checking.
I having been reading your papers and implement code for a while,
there are some more questions, will you please to answer them too?

there are three free vars type, free_vars, minus_free_vars, and
minus_nc_free_vars.
By reading your paper, I know that free vars are used to manage the
metavariables, but
what does those three do respectively?

Thank you again.

On Wed, Jan 9, 2019 at 4:09 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
>
> On Wed, 9 Jan 2019, Evan Zhao wrote:
>
> > Hi there,
> >
> > I am looking at a CTL formula generated by spatch with "--show-ctl-text",
> >
> > for example, for a cocci file like
> > @@
> > expression e,e1,e2;
> > @@
> >
> > if (e)
> > - GOTO(e1);
> > -else GOTO(e2);
> > + e1;
> > +else e2;
> >
> > it corresponding CTL formula is:
> >
> > CTL =
> > Let _r_0 = (EX^((TrueBranch v InLoop)) v EX^(EX^(FalseBranch))) in
> > ((_r_0 &
> > (Ex e1 .
> > ((Ex_ e . (Ex _v . if (e) )) &,
> > ((EX(FalseBranch) &, EX(After)) &,
> > ((EX((TrueBranch &, AX((Ex _v . GOTO(e1);)))) &,
> > EX((FalseBranch &,
> > AX(((Ex _v . else ) &, AX((Ex e2 . (Ex _v . GOTO(e2);))))))))
> > &, EX((After &, EX((Ex _v . _S1)))))))))
> > v
> > (!_r_0 &
> > (Ex e1 .
> > ((Ex_ e . if (e) ) &,
> > (EX(FalseBranch) &,
> > ((EX((TrueBranch &, AX((Ex _v . GOTO(e1);)))) &,
> > EX((FalseBranch &,
> > AX(((Ex _v . else ) &, AX((Ex e2 . (Ex _v . GOTO(e2);))))))))
> > &, EX(After)))))))
> >
> > and I noticed that
> > Let _r_0 = (EX^((TrueBranch v InLoop)) v EX^(EX^(FalseBranch))) in
> > is a fixed pattern, and I can track it at somewhere around the function of
> > do_between_dots in the module Asttoctl2, but I don't what it stands for.
> >
> > Cloud someone tell me what purpose it serves for?
>
> I think it is checking whether the added code is in an if branch in which
> case it wants to add {}.  I think that in your semantic patch it is not
> detecting that the then is just a replacement.  If this is what led you to
> look at the CTL in the first place, you may get a better result with
>
> if (e)
> - GOTO(
>   e1
> - )
>   ;
> else
> - GOTO(
>   e2
> - )
>   ;
>
> Then it should be able to see that the changes are just inside the
> existing branches, and so no {} adjustment is needed.
>
> julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
