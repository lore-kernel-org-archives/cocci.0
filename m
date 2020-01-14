Return-Path: <SRS0=hNU7=3D=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D55C33CA9
	for <cocci@archiver.kernel.org>; Tue, 14 Jan 2020 00:02:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 685B72084D
	for <cocci@archiver.kernel.org>; Tue, 14 Jan 2020 00:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGWr9gor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 685B72084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00E01vUM023945;
	Tue, 14 Jan 2020 01:01:57 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E0F6B77E3;
	Tue, 14 Jan 2020 01:01:56 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DE08E771F
 for <cocci@systeme.lip6.fr>; Tue, 14 Jan 2020 01:01:55 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00E01t75006296
 for <cocci@systeme.lip6.fr>; Tue, 14 Jan 2020 01:01:55 +0100 (CET)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3256D2084D
 for <cocci@systeme.lip6.fr>; Tue, 14 Jan 2020 00:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578960114;
 bh=62W7IS1Z8YiMAjQSXn7BHg+tmWMB2gA7ECgnIim2yHM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=lGWr9gorpYBzodkxx9ZOHJvQUsnzqv98bzFSProgxSNdAnOmOH2RAQRN2b+DPlUKQ
 lVXuPwx2Sa9aSxCWcLhIHqCAH8E3FX7i/wjmEe/PW2Dig/SwPCkVy8EBgU81Ia9zbX
 SCEEWTJVuCpdyMEyti7vaqn/fAK8veoJ4gu+vKdE=
Received: by mail-qt1-f177.google.com with SMTP id w30so10800709qtd.12
 for <cocci@systeme.lip6.fr>; Mon, 13 Jan 2020 16:01:54 -0800 (PST)
X-Gm-Message-State: APjAAAUY+hoywekQG8TNWg2mlesD0UTZqceqV0CmW4qggzNgWTw67j7y
 p1Jos8fw4OtAFNmhsvHPn8d6X/mfjPUX4aE+pKs=
X-Google-Smtp-Source: APXvYqzDw785BHU4fkevjOJQFvKPzJqeHECYVR3/0nhLnPhlM2uMKUhzJReZp9wK/EpaTeJCGm+WwOBDPdKPuOF3PSU=
X-Received: by 2002:ac8:958:: with SMTP id z24mr1239044qth.40.1578960113434;
 Mon, 13 Jan 2020 16:01:53 -0800 (PST)
MIME-Version: 1.0
References: <CAOZdJXU4vhqzot5EEMZ_9jAdp-Be0TTyDS-uXJVPrGs2k=c7nA@mail.gmail.com>
 <alpine.DEB.2.21.2001132332060.2574@hadrien>
 <CAOZdJXWwKUPf_4oGk4G2j438n47fntf7J0AEJd7nFbg6+pR6Qw@mail.gmail.com>
 <alpine.DEB.2.21.2001140003030.2574@hadrien>
In-Reply-To: <alpine.DEB.2.21.2001140003030.2574@hadrien>
From: Timur Tabi <timur@kernel.org>
Date: Mon, 13 Jan 2020 18:01:16 -0600
X-Gmail-Original-Message-ID: <CAOZdJXUOe5mOSR7fgMgVv1kd4gdHXwALMGGYS9PjJepHDzpz-A@mail.gmail.com>
Message-ID: <CAOZdJXUOe5mOSR7fgMgVv1kd4gdHXwALMGGYS9PjJepHDzpz-A@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 14 Jan 2020 01:01:57 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 14 Jan 2020 01:01:55 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>, Timur Tabi <timur@kernel.org>
Subject: Re: [Cocci] Concatenating parameters into a string
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

On Mon, Jan 13, 2020 at 5:04 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
> It might be possible to use
>
> @@
> identifier a,b;
> fresh identifier x = a ## "_" ## b;
> @@
>
> - MACRO(a,b)
> + x

That worked, thanks.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
