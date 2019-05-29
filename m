Return-Path: <SRS0=gowI=T5=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E00C28CC0
	for <cocci@archiver.kernel.org>; Wed, 29 May 2019 20:27:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0463C24168
	for <cocci@archiver.kernel.org>; Wed, 29 May 2019 20:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xfnWXX9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0463C24168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4TKQt6X015122;
	Wed, 29 May 2019 22:26:55 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9B0E27762;
	Wed, 29 May 2019 22:26:54 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 93E2A7756
 for <cocci@systeme.lip6.fr>; Wed, 29 May 2019 22:26:51 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4TKQosp008965
 for <cocci@systeme.lip6.fr>; Wed, 29 May 2019 22:26:50 +0200 (CEST)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1496724156
 for <cocci@systeme.lip6.fr>; Wed, 29 May 2019 20:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1559161610;
 bh=sotf0agJjN/6XTnJWfZk/abBMIFYdarZwrV9DlUHdFY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=xfnWXX9lqYrga2tGuGItIfEJWzgsVXo6dthtMqoWxQe3WziXbHFWULf4H0VLEgk5z
 Jf+R2xKyKrcWLLe7OOM/0bSpVgQNnir4peIUG1tfyKbtAGvbll2oLPPFGH8FiGfPcG
 nXHC6hbOVYGnaMvSY4+nBlJFZPppXWjLXvsl5r40=
Received: by mail-ot1-f43.google.com with SMTP id i2so2422039otr.9
 for <cocci@systeme.lip6.fr>; Wed, 29 May 2019 13:26:50 -0700 (PDT)
X-Gm-Message-State: APjAAAUHWI0VjIkSye13H6aT5OQmtYD0nuQDDPPhUSTJmCeHkYi7eVqB
 Hjp4P9E0wFJIPAzzISxe0fURy9NZ/M0pqA3CZug=
X-Google-Smtp-Source: APXvYqyyYnzbEeNV0w7y02mornzEXFGHy7SiYWDcEdIrcecwU4lzxmm993ujmvySU2OPXkvHYse/4YAhP2xAGhQ5dzM=
X-Received: by 2002:a9d:5c19:: with SMTP id o25mr52741050otk.176.1559161609461; 
 Wed, 29 May 2019 13:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAOZdJXUYqKX6KEwzXqMR-Wq-gsdHOZzHu9O--5HD2gmb56O36g@mail.gmail.com>
 <alpine.DEB.2.21.1905242147210.2514@hadrien>
 <CAOZdJXXV0a7VgRvLcYvzLZrPzVNsr6+WAxf4e6HDsE+U59zShA@mail.gmail.com>
 <alpine.DEB.2.21.1905242211550.2514@hadrien>
 <CAOZdJXUK1BvbfrG2KTW4r-36A115izB+cYwuaAQ8xTmu5WMHHA@mail.gmail.com>
In-Reply-To: <CAOZdJXUK1BvbfrG2KTW4r-36A115izB+cYwuaAQ8xTmu5WMHHA@mail.gmail.com>
From: Timur Tabi <timur@kernel.org>
Date: Wed, 29 May 2019 15:26:12 -0500
X-Gmail-Original-Message-ID: <CAOZdJXX_if3sa_qrVRPF-wpwEmM-_Yb=45gr+ZF==PUA3B79dA@mail.gmail.com>
Message-ID: <CAOZdJXX_if3sa_qrVRPF-wpwEmM-_Yb=45gr+ZF==PUA3B79dA@mail.gmail.com>
To: Timur Tabi <timur@kernel.org>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 29 May 2019 22:26:55 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 29 May 2019 22:26:51 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
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

On Wed, May 29, 2019 at 2:33 PM Timur Tabi <timur@kernel.org> wrote:
> minus: parse error:
>   File "/home/ttabi/boardobj.cocci", line 14, column 1, charpos = 135
>   around = '|',
>   whole content =  |

I did some reading of the documentation and came up with this.  I
think it's in improvement, but it still doesn't work.

@@
identifier func;
fresh identifier label = func ## "_exit";
type T;
expression x;
statement S;
@@
func(...) {
<+...
 x =
(
 (T)
 \(MACRO1\|MACRO2\|MACRO3\)
|
 \(MACRO1\|MACRO2\|MACRO3\)
)
 (...);
(
 if (x == NULL) S
|
+if (x == NULL)
+{
+    status = ERROR;
+    goto label;
+}
)
...+>
}

This gives me:
21: no available token to attach to

So it looks like the "\(MACRO1\|MACRO2\|MACRO3\)" isn't correct, but I
don't see what's wrong with it.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
