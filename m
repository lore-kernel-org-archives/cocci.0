Return-Path: <SRS0=dzya=O4=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEE3C43387
	for <cocci@archiver.kernel.org>; Wed, 19 Dec 2018 00:40:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF3ED20869
	for <cocci@archiver.kernel.org>; Wed, 19 Dec 2018 00:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZU0Ex1BZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3ED20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBJ0eZVK028592
          ; Wed, 19 Dec 2018 01:40:35 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C8086740A;
	Wed, 19 Dec 2018 01:40:35 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4BD393A55
 for <cocci@systeme.lip6.fr>; Wed, 19 Dec 2018 01:40:34 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBJ0eWF8004038
 for <cocci@systeme.lip6.fr>; Wed, 19 Dec 2018 01:40:32 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B70E421873
 for <cocci@systeme.lip6.fr>; Wed, 19 Dec 2018 00:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545180031;
 bh=qqEJZ8SgxMmiJN2M+5Ce9R2jnymO+ydZqgwxOiwA3bM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ZU0Ex1BZX3xYh0wZMU2govDK8tb8zNubxLFxz6r50xN+lsQg2c5zRT6rGE+xYkPcL
 6/i/CVVTqwCKmUTAgBlHnb1fXhaZ1D3Bc/prNZtd/2oyNj0vWPXLtq8MWrPOJdvcdH
 R+M3kAiER3wOOLZKdvfLT3fWznYR/lHJNBYlZmiU=
Received: by mail-oi1-f169.google.com with SMTP id y1so241235oie.12
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 16:40:31 -0800 (PST)
X-Gm-Message-State: AA+aEWZBfVTTp8oYrnoTEBR/QNVcyszegH9KeEu1Qa7Hhj4yYd45M0kO
 8VKTEUqy5QftKRbTpaypHexPs9wkMsY0xAA+tC8=
X-Google-Smtp-Source: AFSGD/VWcAzU6eFTQO1GoecdjJszF+KJdA4ai05AtKel1Af+HP5NSrEIiX7GNzej31rcaxfzOIJFAF8XLx/JZfebco0=
X-Received: by 2002:aca:3209:: with SMTP id y9mr8581071oiy.198.1545180031046; 
 Tue, 18 Dec 2018 16:40:31 -0800 (PST)
MIME-Version: 1.0
References: <CAOZdJXXHJU3f4K-ECQjGs2WoE8XFMZDHL3bQ93ncewv_XCOSrg@mail.gmail.com>
 <alpine.DEB.2.21.1812182303590.2486@hadrien>
In-Reply-To: <alpine.DEB.2.21.1812182303590.2486@hadrien>
From: Timur Tabi <timur@kernel.org>
Date: Tue, 18 Dec 2018 18:39:53 -0600
X-Gmail-Original-Message-ID: <CAOZdJXUj5mZDHC+71N+mBQ98hpa4H7rbA1E3kkGzDgV_zFRobQ@mail.gmail.com>
Message-ID: <CAOZdJXUj5mZDHC+71N+mBQ98hpa4H7rbA1E3kkGzDgV_zFRobQ@mail.gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 19 Dec 2018 01:40:36 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 19 Dec 2018 01:40:33 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>, Timur Tabi <timur@kernel.org>
Subject: Re: [Cocci] Positional parameter p1[0].file contains temporarily
 munged filename, not original
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

On Tue, Dec 18, 2018 at 4:08 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
> When you make a change in a file, Coccinelle subsequently works on a file
> in /tmp for the changed part.  The line numbers are also not reliable.  It
> is better to collect this information before making any changes.

I've noticed that the line number is not reliable.  I guess the only
reliable piece of information is the function name.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
