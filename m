Return-Path: <SRS0=Y1Te=ON=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88D6C04EB8
	for <cocci@archiver.kernel.org>; Tue,  4 Dec 2018 22:57:37 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 820772082B
	for <cocci@archiver.kernel.org>; Tue,  4 Dec 2018 22:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JV0tEuta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 820772082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB4MvL7i024661
          ; Tue, 4 Dec 2018 23:57:21 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2DAC176D4;
	Tue,  4 Dec 2018 23:57:21 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C9AF475E8
 for <cocci@systeme.lip6.fr>; Tue,  4 Dec 2018 23:57:19 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB4MvIPY000714
 for <cocci@systeme.lip6.fr>; Tue, 4 Dec 2018 23:57:19 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5509E2081C
 for <cocci@systeme.lip6.fr>; Tue,  4 Dec 2018 22:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543964238;
 bh=EplzghDXx/RNfzjvEJYh8qxr1fLBl+bu5juAAJ5RC4Q=;
 h=From:Date:Subject:To:From;
 b=JV0tEutauNvl4vFgRQyEKdlg5D9LV+U/FTigGtCiRB4gnkjRZJYYNcFQMTGP4brlN
 V0qmTO5fbZ3W9p/IVKarXWYwdrH4Za0HE9pAXR6rILEi23uwvqNysG4+0d57T7V9Ji
 jB37/fccbylgGnvf/bhQUmJihYoTP+hqbAsXM15w=
Received: by mail-ot1-f45.google.com with SMTP id f18so16826910otl.11
 for <cocci@systeme.lip6.fr>; Tue, 04 Dec 2018 14:57:18 -0800 (PST)
X-Gm-Message-State: AA+aEWb4PgqnwvP2E2o+T+LQdtO8LDJVL+iKKFPuSZqPJNm1yv4E1/R/
 7wAYPQOrisPO6oCxge0yjY6EeXy+sBZFNHoLL7o=
X-Google-Smtp-Source: AFSGD/W1dQOBEBy+Z2hzyHhi3rC+WkBvqGOtejtH+fTbEAxeUOO6+yJ8fKp8fPvYMhOPKbX6f6QeVnJEf9R+sUH4RSg=
X-Received: by 2002:a9d:491e:: with SMTP id e30mr14658342otf.131.1543964237666; 
 Tue, 04 Dec 2018 14:57:17 -0800 (PST)
MIME-Version: 1.0
From: Timur Tabi <timur@kernel.org>
Date: Tue, 4 Dec 2018 16:56:41 -0600
X-Gmail-Original-Message-ID: <CAOZdJXXqgro7gn6ZkX=1CCN=22U1NF=_S-mAgPsgZmC4HV-+GQ@mail.gmail.com>
Message-ID: <CAOZdJXXqgro7gn6ZkX=1CCN=22U1NF=_S-mAgPsgZmC4HV-+GQ@mail.gmail.com>
To: cocci <cocci@systeme.lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 04 Dec 2018 23:57:22 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 04 Dec 2018 23:57:19 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] warning: line 202: should __func__ be a metavariable?
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

I have some rules and Python code that removes __FUNCTION__ as a
parameter in a call to a function.  That all works great.  I now want
it to remove __func__ in exactly the same way.  So I copy/pasted my
rules and just changed __FUNCTION__ to __func__, but spatch complains:

warning: line 202: should __func__ be a metavariable?
warning: line 218: should __func__ be a metavariable?
warning: line 229: should __func__ be a metavariable?

I don't even know what this means.  Here is one rule that fails:

// Look for NV_PRINTF2 calls that have __func__ as the first parameter
@r2b depends on rules@
constant char[] c;
expression x;
@@
NV_PRINTF2(x, c, __func__, ...)

// Get rid of __func__ at the beginning of the string
@script:python s2b@
c << r2b.c;
c2;
@@
import re
coccinelle.c2 = re.sub('%s[: ]*', '', c, 1)

@depends on rules@
expression x;
constant char[] r2b.c;
identifier s2b.c2;
@@
NV_PRINTF2(x,
-c, __func__
+c2
,...);
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
