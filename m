Return-Path: <SRS0=gowI=T5=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCB5C28CC0
	for <cocci@archiver.kernel.org>; Wed, 29 May 2019 21:00:44 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA29E241C3
	for <cocci@archiver.kernel.org>; Wed, 29 May 2019 21:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hii7cJhG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA29E241C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4TL0U1n017170;
	Wed, 29 May 2019 23:00:30 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B2D517762;
	Wed, 29 May 2019 23:00:30 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 88FFF7756
 for <cocci@systeme.lip6.fr>; Wed, 29 May 2019 23:00:28 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4TL0QEo028833
 for <cocci@systeme.lip6.fr>; Wed, 29 May 2019 23:00:27 +0200 (CEST)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com
 [209.85.167.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F0B26241C3
 for <cocci@systeme.lip6.fr>; Wed, 29 May 2019 21:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1559163626;
 bh=fB8o9zCi0F+Q+xdwFsrfLaNZXXhAkPf1XxDvuF1A0P4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Hii7cJhGHgOZOEAz7D5zBzjxBjapr0SnvRr+GiqeHmw8SiFeTWTVa3Tn4leRYQA3E
 PMvnyTQi/tz4unHuotjs3YyB8KfBoU9VlPNChQbdRyw1VISN/8+w5zjxLu/DmGQ93d
 dF3nlwcwjZIYEBaJOsNHdAAF2aUzIlY0gEyW4BjE=
Received: by mail-oi1-f172.google.com with SMTP id 203so3218172oid.13
 for <cocci@systeme.lip6.fr>; Wed, 29 May 2019 14:00:25 -0700 (PDT)
X-Gm-Message-State: APjAAAW1j7hVJEXD3nRev33WfXx4vsR9lCyFpjNHZYvKw0xCVrQGTvWs
 uYUyx2GLL11DztqDLTMqmv/0K3S1VtzwZozieuk=
X-Google-Smtp-Source: APXvYqxbwoZ2qeYGC6USxszNBy6iYObcxPJn/0UJNkb0m6jreX8zV5cIEIoa2jAj7iwNT45jvp0k60X1NwXc2HpI4lY=
X-Received: by 2002:aca:b607:: with SMTP id g7mr99217oif.35.1559163625336;
 Wed, 29 May 2019 14:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAOZdJXUYqKX6KEwzXqMR-Wq-gsdHOZzHu9O--5HD2gmb56O36g@mail.gmail.com>
 <alpine.DEB.2.21.1905242147210.2514@hadrien>
 <CAOZdJXXV0a7VgRvLcYvzLZrPzVNsr6+WAxf4e6HDsE+U59zShA@mail.gmail.com>
 <alpine.DEB.2.21.1905242211550.2514@hadrien>
 <CAOZdJXUK1BvbfrG2KTW4r-36A115izB+cYwuaAQ8xTmu5WMHHA@mail.gmail.com>
 <CAOZdJXX_if3sa_qrVRPF-wpwEmM-_Yb=45gr+ZF==PUA3B79dA@mail.gmail.com>
 <fad7175b0c56154744004ef4a6ad248c@lip6.fr>
In-Reply-To: <fad7175b0c56154744004ef4a6ad248c@lip6.fr>
From: Timur Tabi <timur@kernel.org>
Date: Wed, 29 May 2019 15:59:48 -0500
X-Gmail-Original-Message-ID: <CAOZdJXVd9cc4LdDmrC3=dUUEa=KqYWj6gesd=y9tNk6pUTuLMw@mail.gmail.com>
Message-ID: <CAOZdJXVd9cc4LdDmrC3=dUUEa=KqYWj6gesd=y9tNk6pUTuLMw@mail.gmail.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 29 May 2019 23:00:31 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 29 May 2019 23:00:27 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>, Timur Tabi <timur@kernel.org>
Subject: Re: [Cocci] Checking if a line of code *does not* exist
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

On Wed, May 29, 2019 at 3:31 PM Julia Lawall <Julia.Lawall@lip6.fr> wrote:
> The + code has to be adjacent to some - or context code.  So you may
> need to duplicate some   code in the different branches of the
> disjunction.

So you're saying that the context code can't be a disjunction?

I broke my script up into two rules, and it works now.  It's not
really that elegant, but it works.  Thanks.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
