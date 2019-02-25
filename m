Return-Path: <SRS0=6Fm5=RA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD4CC43381
	for <cocci@archiver.kernel.org>; Mon, 25 Feb 2019 20:39:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E85732083D
	for <cocci@archiver.kernel.org>; Mon, 25 Feb 2019 20:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0zE2z5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E85732083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1PKcp9F025640
          ; Mon, 25 Feb 2019 21:38:51 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CE6007709;
	Mon, 25 Feb 2019 21:38:51 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9DB9D76FD
 for <cocci@systeme.lip6.fr>; Mon, 25 Feb 2019 21:38:49 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1PKcmaR028505
 for <cocci@systeme.lip6.fr>; Mon, 25 Feb 2019 21:38:49 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E25B12084D
 for <cocci@systeme.lip6.fr>; Mon, 25 Feb 2019 20:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551127128;
 bh=oMJ6LokJjhdfU775QokEA9OZCb+FUjZEW2qYmB4PPv4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=k0zE2z5eKEduWxlsLUPQ1ejElP+lD0n2DGgrBvEsgD93NF8+PkFOCKNRHYFdPqAJY
 PVOo+OhFKUiBrGQd5gCzarwGTpVg0+WTe1QZ6cd1+6pKWEOh5fIb53GDE03xNtMKc8
 +UCTyO0F9rjvc8GfJ773U1fug8f3Y1934irHZ0Po=
Received: by mail-oi1-f181.google.com with SMTP id e7so8428095oia.8
 for <cocci@systeme.lip6.fr>; Mon, 25 Feb 2019 12:38:47 -0800 (PST)
X-Gm-Message-State: AHQUAubBL768WL6rQgCRwf5VZEEEgoLbajFNWKCD2SZVed82Jb4SuiG3
 aZYdGK5K1QdYyq71FeRKxxb3X8rsmTiz1a9bjV0=
X-Google-Smtp-Source: AHgI3IZcilANDrXCeRgiricQHqizYtP0iysA9I9Wnt+TBlYdK/iExYfk73oae44SDWmicpeBHe85XjVLOSHRbSL2VwQ=
X-Received: by 2002:aca:4790:: with SMTP id u138mr100194oia.135.1551127127254; 
 Mon, 25 Feb 2019 12:38:47 -0800 (PST)
MIME-Version: 1.0
References: <CAOZdJXX=_PaZWF07z6JRg-JrGWa9JYP_9Wr3dOKajA5ZopWi5Q@mail.gmail.com>
 <9b468560-a277-b43d-fee9-5d7ffad53635@mykolab.com>
In-Reply-To: <9b468560-a277-b43d-fee9-5d7ffad53635@mykolab.com>
From: Timur Tabi <timur@kernel.org>
Date: Mon, 25 Feb 2019 14:38:10 -0600
X-Gmail-Original-Message-ID: <CAOZdJXXv+uY7UeXK6aNrUWhZzvLZgsLh33rdtqEMY34J+05eTA@mail.gmail.com>
Message-ID: <CAOZdJXXv+uY7UeXK6aNrUWhZzvLZgsLh33rdtqEMY34J+05eTA@mail.gmail.com>
To: Michael Stefaniuc <mstefani@mykolab.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 25 Feb 2019 21:38:51 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 25 Feb 2019 21:38:49 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>, Timur Tabi <timur@kernel.org>
Subject: Re: [Cocci] How to handle/ignore iterator macros?
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

On Mon, Feb 25, 2019 at 1:52 PM Michael Stefaniuc <mstefani@mykolab.com> wrote:
>
> For cases like that I've added a define to my macro file to be used with
> --macro-file-builtins or --macro-file.

That works great, thanks!  I used this:

#define MY_ITERATOR(a,b) for (;;)
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
