Return-Path: <SRS0=6akS=O3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C995C43387
	for <cocci@archiver.kernel.org>; Tue, 18 Dec 2018 18:02:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB6921873
	for <cocci@archiver.kernel.org>; Tue, 18 Dec 2018 18:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnACXtnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB6921873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBII1tQ6011724
          ; Tue, 18 Dec 2018 19:01:55 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3F8D8740A;
	Tue, 18 Dec 2018 19:01:55 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0FD563A55
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 19:01:54 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBII1r4w019327
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 19:01:53 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3FE2721871
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 18:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545156112;
 bh=OpV3I1n05lCTbwZl+Szdq/ZYjHKJJc8e4mwhW6Mo5hY=;
 h=From:Date:Subject:To:From;
 b=dnACXtnBhOzWgiFdFpIppi1KY7q4C4tRNoVOpalo/tfwwmSEBzM8HIOTXmSAU7tcf
 GFv/4YVWgBIzS9Q6kK6bhFxf5O83yIbb6eXfDfNl4m4txCUHBez2ME/i6AmSm63ReF
 g9hidV3TFZjx0ahLxbzE7QEpnjTpUheKtyrnIEXI=
Received: by mail-ot1-f45.google.com with SMTP id k98so16545577otk.3
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 10:01:52 -0800 (PST)
X-Gm-Message-State: AA+aEWYxiUzdy5pvFi0Ci2llujeJqPDpq3+d2CNhTSZ1IuJoNA2Ve0Vr
 2PZnJLbVvZbvAL9EsWP8RZOV17UuRZ7M5LMpz9k=
X-Google-Smtp-Source: AFSGD/VFsT8dafl1S8dbBW2XlPpinhtqCtMcHvOseYS3EPG/Qq5hcWcf2sEjT935xI05s9QFwYM4YjNTS6Qx7uZvbg4=
X-Received: by 2002:a9d:67cf:: with SMTP id c15mr8748809otn.38.1545156111602; 
 Tue, 18 Dec 2018 10:01:51 -0800 (PST)
MIME-Version: 1.0
From: Timur Tabi <timur@kernel.org>
Date: Tue, 18 Dec 2018 12:01:15 -0600
X-Gmail-Original-Message-ID: <CAOZdJXUtZzyvw1-N6DhRwTRWfKhZCC025WGgZvbMLj0nS9FVvw@mail.gmail.com>
Message-ID: <CAOZdJXUtZzyvw1-N6DhRwTRWfKhZCC025WGgZvbMLj0nS9FVvw@mail.gmail.com>
To: cocci <cocci@systeme.lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 18 Dec 2018 19:01:55 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 18 Dec 2018 19:01:53 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Determining the second line indent amount?
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

I want to write a Python script that will word-wrap long literal
strings.  In order to do that properly, I need to know how many spaces
the parameter is indented, so that I can guarantee that the string is
wrapped at column 80.  Is that information available?

Coccinelle puts long strings on their own line (in my case, it's
always the second parameter), so I think all I will need is the indent
amount that Coccinelle uses for multi-line function calls, not any
specific parameter.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
