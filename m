Return-Path: <SRS0=SNdx=PM=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD2AC43387
	for <cocci@archiver.kernel.org>; Fri,  4 Jan 2019 21:58:19 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41C932087F
	for <cocci@archiver.kernel.org>; Fri,  4 Jan 2019 21:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v9HcC79j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C932087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x04Lw6Qf013710
          ; Fri, 4 Jan 2019 22:58:06 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8DA9576E0;
	Fri,  4 Jan 2019 22:58:06 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B07BB76DE
 for <cocci@systeme.lip6.fr>; Fri,  4 Jan 2019 22:58:04 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x04Lw3RP008524
 for <cocci@systeme.lip6.fr>; Fri, 4 Jan 2019 22:58:04 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 86E422087F
 for <cocci@systeme.lip6.fr>; Fri,  4 Jan 2019 21:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546639082;
 bh=fnG8uxiOQJOOe9zWWjojlzim672QpLFjQUsBG5PoMLI=;
 h=From:Date:Subject:To:From;
 b=v9HcC79jQyLI6ncY4eNSvUjbfFfNqIGX8+f5bWkxXn9XEZIAafi5p8JQVPrCEZ+Ym
 tTm0w5jO7eQW+9PimnChyBZJCUzzoayEbFFUCoBNobMBoNBZRfb6z8MEZcvj/VgHxn
 p7rxVgGtIiVxs3CosIVmbAu+mXaqQx+3POFMuLTk=
Received: by mail-oi1-f179.google.com with SMTP id v6so31506417oif.2
 for <cocci@systeme.lip6.fr>; Fri, 04 Jan 2019 13:58:02 -0800 (PST)
X-Gm-Message-State: AJcUukc1nh3C2WdF1s6mat89Bol5GocQl99lzpmZnFoIQtSQGSo2zuBP
 lyK2QW+7onVlFMm5SRcbPvnVxtmchA9/zc7vSlo=
X-Google-Smtp-Source: ALg8bN7DZSVynG5LUoZCOvPTwNQkA/o8KCnK4GW1GVsmG1QN99/icjwyA8o20XjTmnMsvBa4thC5Wni5oAuP8HRhlbg=
X-Received: by 2002:aca:ad53:: with SMTP id w80mr2042035oie.148.1546639081847; 
 Fri, 04 Jan 2019 13:58:01 -0800 (PST)
MIME-Version: 1.0
From: Timur Tabi <timur@kernel.org>
Date: Fri, 4 Jan 2019 15:57:25 -0600
X-Gmail-Original-Message-ID: <CAOZdJXWUhEcm8HgJFE2L1dqgMRX51X+LF=b=Obzj55pU4gc3QA@mail.gmail.com>
Message-ID: <CAOZdJXWUhEcm8HgJFE2L1dqgMRX51X+LF=b=Obzj55pU4gc3QA@mail.gmail.com>
To: cocci <cocci@systeme.lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 04 Jan 2019 22:58:07 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 04 Jan 2019 22:58:04 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Can I pass a variable from a Python script in one rule to
 another rule in the same .cocci file?
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

In one rule, I have some Python code that parses a string literal to
see what it looks like.  If I detect a specific pattern, then I want
another rule (that has no Python code) to act differently.

More specifically, if a string literal passed as a parameter to
DBG_PRINTF() starts with "NVRM: ", then I want my script to replace
DBG_PRINTF with NV_PRINTF.  This works today.

If the string does not begin with "NVRM:", however, then I want
DBG_PRINTF changed to NV_PRINTF_EX instead.

If this can't work, an alternative would be to create a second script
that handles DBG_PRINTF to NV_PRINTF_EX.  However, it would need to
abort the change if the Python script detects that NVRM: doesn't
exist.  So is there a way for Python to return a value that says,
"Woah, stop and undo everything you just did!"
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
