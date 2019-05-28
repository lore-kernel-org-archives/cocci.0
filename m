Return-Path: <SRS0=r7AM=T4=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38517C04AB6
	for <cocci@archiver.kernel.org>; Tue, 28 May 2019 23:08:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 866E120989
	for <cocci@archiver.kernel.org>; Tue, 28 May 2019 23:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+3xbxhO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866E120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4SN8aoP023982;
	Wed, 29 May 2019 01:08:36 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A4F827756;
	Wed, 29 May 2019 01:08:36 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DE12C774E
 for <cocci@systeme.lip6.fr>; Wed, 29 May 2019 01:08:34 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4SN8Yne007423
 for <cocci@systeme.lip6.fr>; Wed, 29 May 2019 01:08:34 +0200 (CEST)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3E71620989
 for <cocci@systeme.lip6.fr>; Tue, 28 May 2019 23:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1559084913;
 bh=OYywMqTsACw+zwe/Xl7JCIq1FGisTh0csPAs5RTEhcQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=h+3xbxhONeXrN4WOdBJXzOzmEUIZG0s9la7M7BCktcDEgFuHg+5XorkEub678F3/+
 Jldcq/nue0MfgXAA04h+RoknaIwpnykIJKtAzZULvsVdBIA9FgWoRSpr+tJBPI/UOB
 PhNp+R5wQQD3AqJKvOcGMY46q1hSe/REULlqgz/w=
Received: by mail-ot1-f41.google.com with SMTP id j49so99362otc.13
 for <cocci@systeme.lip6.fr>; Tue, 28 May 2019 16:08:33 -0700 (PDT)
X-Gm-Message-State: APjAAAVPZqJKWFeOh9scmWIVFQWoSnnJPK/Yxe9sajIaMpwsuMXjJlj4
 hI/X/5ytbE+VYYVtCJWAMJDbFtfi2cB6+kUJwEw=
X-Google-Smtp-Source: APXvYqwxxZzBMleQe/B5z+DZrLChU+WQ83I830tzMx0knoqGTVT64PgPbTvZKZWD/G1x333Uanw2LgR9ILHjKSgTOw0=
X-Received: by 2002:a9d:6c06:: with SMTP id f6mr995647otq.185.1559084912632;
 Tue, 28 May 2019 16:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAOZdJXVuNYEkFOiUWYq0GbqRUfuTNV35FGt7EViSSq6AqAY2-A@mail.gmail.com>
 <alpine.DEB.2.21.1905281811270.2487@hadrien>
In-Reply-To: <alpine.DEB.2.21.1905281811270.2487@hadrien>
From: Timur Tabi <timur@kernel.org>
Date: Tue, 28 May 2019 18:07:56 -0500
X-Gmail-Original-Message-ID: <CAOZdJXXZkOQ8wv9TBhRWaeGKeGg1e_Mao_Vi-6jKbvDEK2=ATA@mail.gmail.com>
Message-ID: <CAOZdJXXZkOQ8wv9TBhRWaeGKeGg1e_Mao_Vi-6jKbvDEK2=ATA@mail.gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 29 May 2019 01:08:37 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 29 May 2019 01:08:34 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>, Timur Tabi <timur@kernel.org>
Subject: Re: [Cocci] Controlling where braces are located?
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

On Tue, May 28, 2019 at 5:12 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
>
> Try --smpl-spacing.  You will need to make all the spacing in the semantic
> patch in the way that you want it to appear in the generated code.

I got weird results with that:

+                if (p == NULL)
+{
+                    status = ERROR;
+                    goto func_exit;
+                }

I tried inserting tab characters before the { in my script, but it
didn't do anything.  The { line is flush-left, and the rest of the
lines are indented properly.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
