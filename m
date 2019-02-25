Return-Path: <SRS0=6Fm5=RA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E447C43381
	for <cocci@archiver.kernel.org>; Mon, 25 Feb 2019 23:23:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 931E420C01
	for <cocci@archiver.kernel.org>; Mon, 25 Feb 2019 23:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wBjXI4UT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931E420C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1PNN81S014010
          ; Tue, 26 Feb 2019 00:23:09 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A2EA57709;
	Tue, 26 Feb 2019 00:23:08 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D092176FD
 for <cocci@systeme.lip6.fr>; Tue, 26 Feb 2019 00:23:06 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1PNN5tK008826
 for <cocci@systeme.lip6.fr>; Tue, 26 Feb 2019 00:23:05 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BBECC20C01
 for <cocci@systeme.lip6.fr>; Mon, 25 Feb 2019 23:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551136984;
 bh=PfuyPuerfZe5H+b9h6ph42+aa6XG1CsM7deNtP/LItA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=wBjXI4UTlvanIVgWffooRc8MBEOjnpGOYbzA2/isetKyKHWlMwwfCcJkpA1NHsXgq
 7MVjpahQVpWMRipu6/Wk4HXqIJdaj8v4F0lPoTjk0Ug3fhL8/YgtryuFThfet22n8/
 ElDzazdP5bIHHoXF9HEd4ABNEdjsZ1gUQeofB42s=
Received: by mail-oi1-f175.google.com with SMTP id b4so8809191oif.6
 for <cocci@systeme.lip6.fr>; Mon, 25 Feb 2019 15:23:04 -0800 (PST)
X-Gm-Message-State: AHQUAuaqeK9mVlCtnES+bR3a35WynRbV0f3jxYkdKIu7cVQcOLepGvvW
 lEu1i5PnmGORk3rNAXujPsI1VgvRXA8PvoMz7vA=
X-Google-Smtp-Source: AHgI3IY6aGrqed7ZrJGdcJx+RiNj5qlmn2nGWsyo/js4SESokXTFmS5+QujGoOUZoP4drJTFM4/7qsJ1eQmVnPw4KTU=
X-Received: by 2002:aca:181a:: with SMTP id h26mr549853oih.72.1551136984099;
 Mon, 25 Feb 2019 15:23:04 -0800 (PST)
MIME-Version: 1.0
References: <CAOZdJXU3eTe7MS+_pb6ou4rXQFqM7P_ZYQAFd2F0P-aEGXVM7g@mail.gmail.com>
 <CAOZdJXWCvqVG52s3HiwH7e_yJ0ijeX41fGyv6hspXdY79wVMYw@mail.gmail.com>
In-Reply-To: <CAOZdJXWCvqVG52s3HiwH7e_yJ0ijeX41fGyv6hspXdY79wVMYw@mail.gmail.com>
From: Timur Tabi <timur@kernel.org>
Date: Mon, 25 Feb 2019 17:22:26 -0600
X-Gmail-Original-Message-ID: <CAOZdJXW=Zivu348-fCuSDUSFYTNeKVuQMectJ8_tH0V-CCfpRQ@mail.gmail.com>
Message-ID: <CAOZdJXW=Zivu348-fCuSDUSFYTNeKVuQMectJ8_tH0V-CCfpRQ@mail.gmail.com>
To: Timur Tabi <timur@kernel.org>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 26 Feb 2019 00:23:09 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 26 Feb 2019 00:23:05 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Octal constants confuse spatch
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

On Mon, Feb 25, 2019 at 5:06 PM Timur Tabi <timur@kernel.org> wrote:
> Sorry, bad copy-paste.  I meant
>
> #define FLD_SET_DRF(a, b, c, d, e)             1

Ok, now I found something weird.

If I put the #define on the top of the source file (test.c), it doesn't work.

But if I put it in a header file specified by --macro-file-builtins,
it does work.

So it seems to me that spatch is parsing the macros in the
--macro-file-builtins header file differently than the macros in the
source file itself.  That doesn't explain why it doesn't like 0080,
though.

Anyway, I seem to be unblocked for now, but this might be something to
look into.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
