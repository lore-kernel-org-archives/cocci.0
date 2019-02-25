Return-Path: <SRS0=6Fm5=RA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9563CC43381
	for <cocci@archiver.kernel.org>; Mon, 25 Feb 2019 23:07:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A6120684
	for <cocci@archiver.kernel.org>; Mon, 25 Feb 2019 23:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8jYqLZh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A6120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1PN7APU027476
          ; Tue, 26 Feb 2019 00:07:10 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 055467709;
	Tue, 26 Feb 2019 00:07:10 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C98FB76FD
 for <cocci@systeme.lip6.fr>; Tue, 26 Feb 2019 00:07:08 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1PN77cG005420
 for <cocci@systeme.lip6.fr>; Tue, 26 Feb 2019 00:07:08 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6D91020684
 for <cocci@systeme.lip6.fr>; Mon, 25 Feb 2019 23:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551136027;
 bh=KeSpmMoFtWqx9Tjkvkb3bFG2SqAwGrkcj/Fvee9AcRU=;
 h=References:In-Reply-To:From:Date:Subject:To:From;
 b=Y8jYqLZhSJ2XIcdMt/1EEinsm2KUmrZ/ygWNOuZ6ty3+GBd+445D25mkTM3Xa5GL6
 59plPXoyPq4MinKL6y2hO4p7jqvjqCdUQmtuOPxOx/EQdlWU++koG4FLW3KZw1hSj/
 80fCYhDsF9PoWdkE8huMF9q8S+ed5lr3utb1pfZ8=
Received: by mail-ot1-f49.google.com with SMTP id i5so9429905oto.9
 for <cocci@systeme.lip6.fr>; Mon, 25 Feb 2019 15:07:07 -0800 (PST)
X-Gm-Message-State: AHQUAuY62TuhqNi38Aaou31u9AmzCUbMhWOWq5PR1Dmf+nXxoKUwxLIN
 59HUFaNObKV8PlZ7ZSMadAT/z6MNOcprpad2MgY=
X-Google-Smtp-Source: AHgI3Ia2xyrQi+/cQU8uYsEE7PC6zDy7YoG+PvV3kwKxibBqVSHSkDfQbPk9OeOIXibXKyg48tWellUq1jTssxvP6WY=
X-Received: by 2002:a9d:6c96:: with SMTP id c22mr12373605otr.38.1551136026795; 
 Mon, 25 Feb 2019 15:07:06 -0800 (PST)
MIME-Version: 1.0
References: <CAOZdJXU3eTe7MS+_pb6ou4rXQFqM7P_ZYQAFd2F0P-aEGXVM7g@mail.gmail.com>
In-Reply-To: <CAOZdJXU3eTe7MS+_pb6ou4rXQFqM7P_ZYQAFd2F0P-aEGXVM7g@mail.gmail.com>
From: Timur Tabi <timur@kernel.org>
Date: Mon, 25 Feb 2019 17:06:30 -0600
X-Gmail-Original-Message-ID: <CAOZdJXWCvqVG52s3HiwH7e_yJ0ijeX41fGyv6hspXdY79wVMYw@mail.gmail.com>
Message-ID: <CAOZdJXWCvqVG52s3HiwH7e_yJ0ijeX41fGyv6hspXdY79wVMYw@mail.gmail.com>
To: cocci <cocci@systeme.lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 26 Feb 2019 00:07:10 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 26 Feb 2019 00:07:08 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
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

On Mon, Feb 25, 2019 at 4:56 PM Timur Tabi <timur@kernel.org> wrote:
> #define FLD_TEST_DRF(a, b, c, d, e)             1

Sorry, bad copy-paste.  I meant

#define FLD_SET_DRF(a, b, c, d, e)             1
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
