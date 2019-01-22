Return-Path: <SRS0=An1N=P6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A067C282C3
	for <cocci@archiver.kernel.org>; Tue, 22 Jan 2019 19:32:31 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2D02085A
	for <cocci@archiver.kernel.org>; Tue, 22 Jan 2019 19:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="APaQ7+HR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2D02085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0MJWFJJ013423
          ; Tue, 22 Jan 2019 20:32:15 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7C94776F2;
	Tue, 22 Jan 2019 20:32:15 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8FE4D76EA
 for <cocci@systeme.lip6.fr>; Tue, 22 Jan 2019 20:32:13 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0MJWCPl013578
 for <cocci@systeme.lip6.fr>; Tue, 22 Jan 2019 20:32:13 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2AA222085A
 for <cocci@systeme.lip6.fr>; Tue, 22 Jan 2019 19:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548185532;
 bh=E/Cufag0TlDhFQh/O7KhK8szcwBk2xrAKkbdHjrfQew=;
 h=From:Date:Subject:To:From;
 b=APaQ7+HR1VAgmwQgwDlbvPB5dI44NUI7E1BF+kxKko5tFHGivHrqpKiJWx5xe0SPE
 msr0WzvyA5Ne2n3nfE8cxiiYL0gLft5MgpsjtxGRhvWYxVarHO5P/pQ6aa9AlrqMsq
 7kR2aIzLlnT5bUfiTyvO69Tf+S+mDS5V1RZny04M=
Received: by mail-ot1-f43.google.com with SMTP id u16so24733087otk.8
 for <cocci@systeme.lip6.fr>; Tue, 22 Jan 2019 11:32:12 -0800 (PST)
X-Gm-Message-State: AJcUuke26zHYsmMwNc+7RsSJ0IQjncT1Lbt9ljsOyJL3iH5y7r7+vIqc
 ss9i2P+2x0mSOroZvUwyHeGlAqo6iQwQLvf/eSY=
X-Google-Smtp-Source: ALg8bN7kyMF07amNrR56TJfGyEMsK+mPZTYsVgG3E+UABEv9hm7SjSm8F7KbTYGCHCwIoZFjUK+xrrCJiJn4LfDqJ68=
X-Received: by 2002:a9d:7001:: with SMTP id k1mr21841012otj.173.1548185531479; 
 Tue, 22 Jan 2019 11:32:11 -0800 (PST)
MIME-Version: 1.0
From: Timur Tabi <timur@kernel.org>
Date: Tue, 22 Jan 2019 13:31:35 -0600
X-Gmail-Original-Message-ID: <CAOZdJXUhfSskY8+i3Juf8t4-obp9nu=c0CXriNbPBoGj6ZMeVQ@mail.gmail.com>
Message-ID: <CAOZdJXUhfSskY8+i3Juf8t4-obp9nu=c0CXriNbPBoGj6ZMeVQ@mail.gmail.com>
To: cocci <cocci@systeme.lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 22 Jan 2019 20:32:15 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 22 Jan 2019 20:32:13 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Fatal exception in spatch when #include file does not exist
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

Let's say I have these files:

dir1/dir2/dir3/file1.h
dir1/dir2/dir4/dir5/file2.c

In file2.c, I have this include statement:

#include "../../dir3/file1.h"

This works if I compile the file when I'm in the dir5 directory.

However, if I am in the dir4 directory and do this:

spatch ... ./dir5/file2.c

I will get this error:

Fatal error: exception Sys_error("../../dir3/file1.h": No such file or
directory")

which is technically true, but so what?  Does spatch actually try to
read the contents of file1.h?  If not, why does it care whether the
file exists?  And why doesn't it just ignore the #include line?
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
