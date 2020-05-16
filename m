Return-Path: <SRS0=NPBS=66=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74655C433E0
	for <cocci@archiver.kernel.org>; Sat, 16 May 2020 08:47:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D19EA206D4
	for <cocci@archiver.kernel.org>; Sat, 16 May 2020 08:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzJoVFuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19EA206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04G8kYSg009755;
	Sat, 16 May 2020 10:46:34 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A56B23E6B;
	Sat, 16 May 2020 10:46:34 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E44213DC8
 for <cocci@systeme.lip6.fr>; Sat, 16 May 2020 10:16:51 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:52f])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04G8GpcZ020300
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 16 May 2020 10:16:51 +0200 (CEST)
Received: by mail-ed1-x52f.google.com with SMTP id d16so4139944edq.7
 for <cocci@systeme.lip6.fr>; Sat, 16 May 2020 01:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=zMbWyv7IF9CUNe2o572KIxZs9nZ+dnXnfKf7yeeynlw=;
 b=PzJoVFuTpmqBiIJfSUOiBVvtxoXRwH5awdmh7aGCy6SKknc/YSpUmtBKCbIUfUEd8U
 NSTZx5Pzfpr6zVHuGr235Z4qZK1xG6hYdEDEq+hw9lOTE3nIlCpqUVt5CmnxzqMLlu9b
 QVh8ihTJw1wsMi2JUStROrSNByWj6NJ+VEUPFM+rTump9xwnN83/Ct/Jkte1WSuZnTkF
 qkIPwkbtWg0r7uaQvM5Bo4+eub3QXy1oYYIiTC7DmuhngCW4/4gNaiELXg1HicOwEwmk
 zh9hZLpoxAYwEZ7dRHlBXzWv1oGb83hgUPplYgz9B1MQopdf6st9kJScjaWaG4ucrPdi
 eKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=zMbWyv7IF9CUNe2o572KIxZs9nZ+dnXnfKf7yeeynlw=;
 b=HHMVRt1Hxnj2zibcyVn4PG+bZLEDgAoTd+F3iEgaGW2nXrE0w8I5Ury4ZsnNDVFp54
 FRDXPnGHhv4A/JBRCB1HnOE2444vOj7OtsNyX/0oo/AV+chBXany2gZWPv3XLYzuWoD3
 s5+VaAvutmfaeTd2n0yYp8L/4qPMKXKtVVEEd/YlXzDTcSazNAGpEDbYFBmYHWbAHXJu
 MPK+t39fyne5HgycNldjiirM0vnZPHHgspdxsTXLpVvhMZrqjMmHIm0cUdoYbhTE3pyv
 FRdg1lk4RHwkcPncI4nKk2KbkC1xuMmSc9F7b0CAZVbv6/Y+hYj0qCuzKrMWFQCDO+Ji
 SgVA==
X-Gm-Message-State: AOAM532SQiTCH9xcZ/K/OJT1rGF55D6uuCFYwJFTpU0uFgRAJ5VT54z8
 viXLHRHk9JGH4ZXcet6UROgyZII42GsKqs48cJmO+M71
X-Google-Smtp-Source: ABdhPJz8cY3B5kjhf6nSbZQv/jLBjeTp6gMp7Bxb8rYMOYtHpiJXEDAy3ITR66A/HHOOX7tdQ3WdPUbDNQjf5UVvVYc=
X-Received: by 2002:a05:6402:4d5:: with SMTP id
 n21mr5014574edw.49.1589617010985; 
 Sat, 16 May 2020 01:16:50 -0700 (PDT)
MIME-Version: 1.0
From: Chuhong Yuan <hslester96@gmail.com>
Date: Sat, 16 May 2020 16:16:41 +0800
Message-ID: <CANhBUQ2Bqxwk3o8w22L8yvSK+VWbf-WTSiaf8v9kbsqSv2VwAA@mail.gmail.com>
To: cocci@systeme.lip6.fr
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 16 May 2020 10:46:35 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sat, 16 May 2020 10:16:51 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Sat, 16 May 2020 10:46:32 +0200
Subject: [Cocci] How to match function calls in macros?
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

Hi all,
I want to write a script to match function calls in macros
but I don't know how to do that.
Here is an example:

#define __INIT_WORK(_work, _func, _onstack)     \
    do {     \
        static struct lock_class_key __key; \
        \
        __init_work((_work), _onstack); \
        (_work)->data = (atomic_long_t) WORK_DATA_INIT(); \
        lockdep_init_map(&(_work)->lockdep_map,
"(work_completion)"#_work, &__key, 0); \
        INIT_LIST_HEAD(&(_work)->entry); \
        (_work)->func = (_func); \
    } while (0)

In this example, I want to match function calls
like __init_work() and lockdep_init_map() in this macro.
So how to implement this by Coccinelle?

Thanks,
Chuhong
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
