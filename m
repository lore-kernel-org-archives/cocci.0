Return-Path: <SRS0=gowI=T5=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F5DC28CC0
	for <cocci@archiver.kernel.org>; Wed, 29 May 2019 19:34:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43EE624105
	for <cocci@archiver.kernel.org>; Wed, 29 May 2019 19:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2HKKs75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43EE624105
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4TJY8Yf002144;
	Wed, 29 May 2019 21:34:08 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EE3817762;
	Wed, 29 May 2019 21:34:07 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 502EC7756
 for <cocci@systeme.lip6.fr>; Wed, 29 May 2019 21:34:06 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4TJY55S017559
 for <cocci@systeme.lip6.fr>; Wed, 29 May 2019 21:34:05 +0200 (CEST)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1116724108
 for <cocci@systeme.lip6.fr>; Wed, 29 May 2019 19:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1559158444;
 bh=YzwIHFsS9s50dg6k1amZo6t6wXqUp4bPk4ZMRueYD5Q=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=K2HKKs75V+HK5RMY+BOuqgM8izKIdPTsyrnsZyLU55ReH5ZFHbYr2Mx85TSl0Z0ee
 Bifq2knRJqFyPLJga/sfZ5KNXjL7TVHO/lVbX4N70ZKs19UFYEtXxKwu43+DKCSI/M
 PSgubj0jn9y6GjZS0BzcnLFDIoUUd91YX+vg+X/U=
Received: by mail-ot1-f50.google.com with SMTP id j49so3207144otc.13
 for <cocci@systeme.lip6.fr>; Wed, 29 May 2019 12:34:04 -0700 (PDT)
X-Gm-Message-State: APjAAAX4XQYUpIqn1x1lT3b5s0fpjr41x5LT4qnGElmHMbBk1WQWWFFd
 4rnsMR+fUyQn3IJNMMtS21JZRtmlpL6C1Uw1Uyc=
X-Google-Smtp-Source: APXvYqzbH27JUON5JaEtrc+qFrG//QWWf7ePQn5Kh3EhN91WgKyW5FSAGuZJobpw1P+GEhJYYLilk32xzL/FrkavZC0=
X-Received: by 2002:a9d:4d0c:: with SMTP id n12mr7488500otf.305.1559158443451; 
 Wed, 29 May 2019 12:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAOZdJXUYqKX6KEwzXqMR-Wq-gsdHOZzHu9O--5HD2gmb56O36g@mail.gmail.com>
 <alpine.DEB.2.21.1905242147210.2514@hadrien>
 <CAOZdJXXV0a7VgRvLcYvzLZrPzVNsr6+WAxf4e6HDsE+U59zShA@mail.gmail.com>
 <alpine.DEB.2.21.1905242211550.2514@hadrien>
In-Reply-To: <alpine.DEB.2.21.1905242211550.2514@hadrien>
From: Timur Tabi <timur@kernel.org>
Date: Wed, 29 May 2019 14:33:26 -0500
X-Gmail-Original-Message-ID: <CAOZdJXUK1BvbfrG2KTW4r-36A115izB+cYwuaAQ8xTmu5WMHHA@mail.gmail.com>
Message-ID: <CAOZdJXUK1BvbfrG2KTW4r-36A115izB+cYwuaAQ8xTmu5WMHHA@mail.gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 29 May 2019 21:34:08 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 29 May 2019 21:34:05 +0200 (CEST)
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

On Fri, May 24, 2019 at 3:12 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
> You can't just put the header of an if.  You have to put the whole thing:
>
> if (x == NULL) S1 else S2

Ok that works.

Can the (|) expressions be nested?  I'm trying to match multiple
possibilities, and I can't really get them to work.  I need to match
multiple macro names (MACRO1, MACRO2, etc), and the typecast before
the macro call is optional (but should be preserved), and it should
ignore lines that already have a null-pointer check after them.

I came up with this, but it doesn't work:

@@
identifier func;
fresh identifier label = func ## "_exit";
type T;
expression x;
statement S;
@@
func(...) {
<+...
(
 x =
 (
  (T)
 |
 )
 (MACRO1|MACRO2|MACRO3)
 (...);
 if (x == NULL) S
|
 x =
 (
  (T)
 |
 )
 (MACRO1|MACRO2|MACRO3)
(...);
+if (x == NULL)
+{
+    status = ERROR;
+    goto label;
+}
)
...+>
}

I get:

minus: parse error:
  File "/home/ttabi/boardobj.cocci", line 14, column 1, charpos = 135
  around = '|',
  whole content =  |
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
