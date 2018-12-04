Return-Path: <SRS0=Y1Te=ON=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEBEC04EB8
	for <cocci@archiver.kernel.org>; Tue,  4 Dec 2018 22:20:17 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 204C420834
	for <cocci@archiver.kernel.org>; Tue,  4 Dec 2018 22:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRVk+ZBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204C420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB4MJvcH001481
          ; Tue, 4 Dec 2018 23:19:57 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 568B776D4;
	Tue,  4 Dec 2018 23:19:57 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 43FA075E8
 for <cocci@systeme.lip6.fr>; Tue,  4 Dec 2018 23:19:55 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB4MJslJ024213
 for <cocci@systeme.lip6.fr>; Tue, 4 Dec 2018 23:19:54 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D493820850
 for <cocci@systeme.lip6.fr>; Tue,  4 Dec 2018 22:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543961994;
 bh=xwhY5LPTz6IjzpCjgEWnvC2NGoQpwBEL/xvYq8XNMxE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=kRVk+ZBAsZ0j1jpWsdCHSpPWXoWQssHuHKafWPTc2pb9TBtWZolUeWNoLadcu3QWr
 PhAJGe0PLv3UJVrbBl28UtyB8BEdcZj1Hmq+hE6sp5YwjrHkMA1muHI6VsEPn08WQv
 EL9TIfqUIEB2ZYeMekTg6qbVzIFYd2TTTQreXjt8=
Received: by mail-ot1-f47.google.com with SMTP id 32so16733478ota.12
 for <cocci@systeme.lip6.fr>; Tue, 04 Dec 2018 14:19:53 -0800 (PST)
X-Gm-Message-State: AA+aEWaYmUziaL9Y6gICiBuBEfxConjMQjW3cK044Qfgjjp/MC0b8EEO
 hSxL9AMoO5KjeyA4B+ASkfRWrsqWFmue346k1BM=
X-Google-Smtp-Source: AFSGD/XSTtnjA8NatuuvPNb8moLuRpZB801kpxRTVxKou44NKd8ECRWYvd4+/ar3ltsdViaGSMRVXBlfw6MnP/SHyoo=
X-Received: by 2002:a9d:4704:: with SMTP id a4mr14823936otf.325.1543961993163; 
 Tue, 04 Dec 2018 14:19:53 -0800 (PST)
MIME-Version: 1.0
References: <CAOZdJXVLMv-5_u1uOq6re+1O3vADsrTK0+J3Fat-XN4_2DEp4w@mail.gmail.com>
 <alpine.DEB.2.21.1811151327420.2372@hadrien>
 <CAOZdJXWD0L4Qwh2raJLF25Ax0=DR06vhfGWhpQVf804YQJ5jeA@mail.gmail.com>
 <alpine.DEB.2.21.1812042124260.2383@hadrien>
 <CAOZdJXXMTrXXEKta-M0uYq3EpjVaSz2++OT1GOB5HYmx5h_TgA@mail.gmail.com>
In-Reply-To: <CAOZdJXXMTrXXEKta-M0uYq3EpjVaSz2++OT1GOB5HYmx5h_TgA@mail.gmail.com>
From: Timur Tabi <timur@kernel.org>
Date: Tue, 4 Dec 2018 16:19:16 -0600
X-Gmail-Original-Message-ID: <CAOZdJXUDY=D7mbCGTqyseq6nDsevAr9TFg9_utKnSQWPjH5a5g@mail.gmail.com>
Message-ID: <CAOZdJXUDY=D7mbCGTqyseq6nDsevAr9TFg9_utKnSQWPjH5a5g@mail.gmail.com>
To: Timur Tabi <timur@kernel.org>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 04 Dec 2018 23:19:58 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 04 Dec 2018 23:19:54 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Can the current function name be passed to a Python
	snippet?
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

On Tue, Dec 4, 2018 at 4:02 PM Timur Tabi <timur@kernel.org> wrote:
> Based on what I've read, I need to add < > in order for spatch to run
> the rule multiple times within a function.  But if I change r4 to
> this:
>
> @r4 depends on rules@
> identifier func;
> expression x;
> constant char[] c;
> @@
> func(...) {
> <...
> NV_PRINTF2(x, c, ...)
> ...>
> }
>
> It doesn't work at all.

Ok, I changed it to

func(...) {
<+...
NV_PRINTF2(x, c, ...)
...+>
}

and now it works.  I don't know why I needed the +'s, but at least it
works now.  Thanks.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
