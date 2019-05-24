Return-Path: <SRS0=ZWNV=TY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F15C072B5
	for <cocci@archiver.kernel.org>; Fri, 24 May 2019 18:14:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C390B21773
	for <cocci@archiver.kernel.org>; Fri, 24 May 2019 18:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gghlY7AR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C390B21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4OIERFT006125;
	Fri, 24 May 2019 20:14:27 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B50F97752;
	Fri, 24 May 2019 20:14:27 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4C2C37747
 for <cocci@systeme.lip6.fr>; Fri, 24 May 2019 20:14:26 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4OIEPvB009430
 for <cocci@systeme.lip6.fr>; Fri, 24 May 2019 20:14:25 +0200 (CEST)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D164E21773
 for <cocci@systeme.lip6.fr>; Fri, 24 May 2019 18:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1558721664;
 bh=di1iqE1gljdRQyVK+4nw4gz64I4pJUaq2OMN3HgYK54=;
 h=From:Date:Subject:To:From;
 b=gghlY7ARP7yqZyYS1xZZDqPBBtQGBvPEGJKkzV/6+RbRB0gkQX/+sOyz0Y70jXIF6
 +SilhrQklJuloI/f3nHEMK3vB76nzezNBSEHQ2JxH1OSV9ZAzj08OfNYupdNT4P+gn
 CF39dAtrWfOr9bVo/dmKsUzRDy5z3m2t+jCAV3N0=
Received: by mail-oi1-f181.google.com with SMTP id q186so7725037oia.0
 for <cocci@systeme.lip6.fr>; Fri, 24 May 2019 11:14:24 -0700 (PDT)
X-Gm-Message-State: APjAAAWKzLJc0ycNOkTKgqPTN/+X9tIoXF6k3oAq4gQWRhWXoE15J9wH
 BJ3XgBHxSuI90XKNzlYDDE0ihOPnIII5AOxHWn4=
X-Google-Smtp-Source: APXvYqxoRmg1REmfng4FB79Gouq49bcKq4RDV+uv3bvZIbXz8WSvZYmpa546l8wq+oaSkfdZZUi9OlRMvIgbJLkOd9c=
X-Received: by 2002:aca:5147:: with SMTP id f68mr274499oib.72.1558721664234;
 Fri, 24 May 2019 11:14:24 -0700 (PDT)
MIME-Version: 1.0
From: Timur Tabi <timur@kernel.org>
Date: Fri, 24 May 2019 13:13:48 -0500
X-Gmail-Original-Message-ID: <CAOZdJXUYqKX6KEwzXqMR-Wq-gsdHOZzHu9O--5HD2gmb56O36g@mail.gmail.com>
Message-ID: <CAOZdJXUYqKX6KEwzXqMR-Wq-gsdHOZzHu9O--5HD2gmb56O36g@mail.gmail.com>
To: cocci <cocci@systeme.lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 May 2019 20:14:28 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 24 May 2019 20:14:25 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Checking if a line of code *does not* exist
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

I'm working on a new script that needs to add a NULL-pointer check if
one does not already exist.  For example:

x = (MYTYPE)MACRO(params);

should become

x = (MYTYPE)MACRO(params);
if (!x) {
    do_something;
}

My problem is that I want coccinelle to add the if-check only if it
doesn't already exist.  So currently I have this:

@@
type T;
expression x;
@@
x = (T)MACRO(...);
+if (x == NULL)
+{
+    status = ERROR;
+    goto exit;
+}

How do I make sure that these lines are not added if they already
exist?  I need to check for "if (x == NULL)" and "if (!x)" variants.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
