Return-Path: <SRS0=Yxto=OO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1AAC04EB9
	for <cocci@archiver.kernel.org>; Wed,  5 Dec 2018 18:00:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04CA82082B
	for <cocci@archiver.kernel.org>; Wed,  5 Dec 2018 18:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJVLy5mM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04CA82082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB5I0SOF004116
          ; Wed, 5 Dec 2018 19:00:28 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 907DB76DA;
	Wed,  5 Dec 2018 19:00:28 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DEA8E76D4
 for <cocci@systeme.lip6.fr>; Wed,  5 Dec 2018 19:00:26 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB5I0Pg8016301
 for <cocci@systeme.lip6.fr>; Wed, 5 Dec 2018 19:00:26 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5A90020879
 for <cocci@systeme.lip6.fr>; Wed,  5 Dec 2018 17:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544032194;
 bh=4z4NZcSDyN3XhDYBpgWpU41nO6DRzN9BXvlrps/AYSs=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=jJVLy5mMh3QcJ5m5IO0HLea3vFlynGTf5H6B1/C7+gBfQq+mVy6CSPJGHb2UJrrUn
 Cx8htxqbQoZGIZ4Lt8JZJ7n7JBCmh22KoBAxQkS3/QYGJ4Tp9wEV0Q3nyzaMXC8OZe
 PNxHXtM41mVb3iBViV0dfX+xx187oaIijZkRkMbo=
Received: by mail-oi1-f181.google.com with SMTP id y23so18315847oia.4
 for <cocci@systeme.lip6.fr>; Wed, 05 Dec 2018 09:49:54 -0800 (PST)
X-Gm-Message-State: AA+aEWYt3IuuwQdnhTWkE0tZ5cBZ/D9ijuBPjhA0EgUKBEcH7a3Bt6JF
 1dJ2Wuiw22PO6K4bQ34f2K9tFNlw8VQ9A8l7O88=
X-Google-Smtp-Source: AFSGD/XqBF0qyJbEO6mFRbpiBvfjoII7Vac8pZApPg5GVALeem4IxK7JkxIxir0/tkbUgQpotdsp7b+BbhsPV5pnn98=
X-Received: by 2002:aca:4d3:: with SMTP id 202mr16506163oie.345.1544032193691; 
 Wed, 05 Dec 2018 09:49:53 -0800 (PST)
MIME-Version: 1.0
References: <CAOZdJXVLMv-5_u1uOq6re+1O3vADsrTK0+J3Fat-XN4_2DEp4w@mail.gmail.com>
 <alpine.DEB.2.21.1811151327420.2372@hadrien>
 <CAOZdJXWD0L4Qwh2raJLF25Ax0=DR06vhfGWhpQVf804YQJ5jeA@mail.gmail.com>
 <alpine.DEB.2.21.1812042124260.2383@hadrien>
 <CAOZdJXXMTrXXEKta-M0uYq3EpjVaSz2++OT1GOB5HYmx5h_TgA@mail.gmail.com>
 <CAOZdJXUDY=D7mbCGTqyseq6nDsevAr9TFg9_utKnSQWPjH5a5g@mail.gmail.com>
 <alpine.DEB.2.21.1812050734520.2670@hadrien>
In-Reply-To: <alpine.DEB.2.21.1812050734520.2670@hadrien>
From: Timur Tabi <timur@kernel.org>
Date: Wed, 5 Dec 2018 11:49:16 -0600
X-Gmail-Original-Message-ID: <CAOZdJXU1k7y3PVqTeXfeSLSbhPuzsbPOUFYh-akVHFifMcOs=w@mail.gmail.com>
Message-ID: <CAOZdJXU1k7y3PVqTeXfeSLSbhPuzsbPOUFYh-akVHFifMcOs=w@mail.gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 05 Dec 2018 19:00:28 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 05 Dec 2018 19:00:26 +0100 (CET)
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

On Wed, Dec 5, 2018 at 12:47 AM Julia Lawall <julia.lawall@lip6.fr> wrote:
>
> > and now it works.  I don't know why I needed the +'s, but at least it
> > works now.  Thanks.
>
> This means that the rule only applies when there is at least one
> occurrence of the pattern in between the <+... ...+>.

Unfortunately, on some files, adding the + significantly slows down
the script.  It stalls for about 15-20 seconds a few times during
parsing.  Normally the while script takes about 1-2 seconds to run.  I
believe coccinelle is having trouble finding the functions because
some my source files abuse C macros.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
