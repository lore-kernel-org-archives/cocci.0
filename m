Return-Path: <SRS0=aura=Q2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C49CC43381
	for <cocci@archiver.kernel.org>; Tue, 19 Feb 2019 20:13:13 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E022E206BA
	for <cocci@archiver.kernel.org>; Tue, 19 Feb 2019 20:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QO2F03pu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E022E206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1JKCnR5005754
          ; Tue, 19 Feb 2019 21:12:49 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4BFE3770E;
	Tue, 19 Feb 2019 21:12:49 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 81B0176FB
 for <cocci@systeme.lip6.fr>; Tue, 19 Feb 2019 21:12:47 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1JKCjBd024849
 for <cocci@systeme.lip6.fr>; Tue, 19 Feb 2019 21:12:46 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 75F7E206BA
 for <cocci@systeme.lip6.fr>; Tue, 19 Feb 2019 20:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550607164;
 bh=HDtlzL5AW74Gh1A2HBcxKOMfBWV+eW0psDW2flOJd7M=;
 h=From:Date:Subject:To:From;
 b=QO2F03pu46ctywZ2kolChiVfdATge5QKotHu/CkGeHemT1KY4ViE8UZ4ddg2SoyFE
 X45U0/DBBHNeJHj+nzS3d6E6JAlLVUuO1hLl+q/KY8U9hvRmXrmv1M+ToT1Y64hUVW
 fXjvsHg6AHdcjXVr0Ipq7zIwKh+Gj5jbGAaT1+Rc=
Received: by mail-ot1-f44.google.com with SMTP id 98so36559169oty.1
 for <cocci@systeme.lip6.fr>; Tue, 19 Feb 2019 12:12:44 -0800 (PST)
X-Gm-Message-State: AHQUAuZPCoCM6ymVwaUWJgT16em2zuAUCy0gPyScuW43JKB1RJfEnOBV
 KFc7P0ktjluT72DiyUt7hlX+7YKbnf9P/PDnc1k=
X-Google-Smtp-Source: AHgI3IZ5zBQJnGFmjDpVIZOCcCk8isAl1OVIuXGMj8kYZJrUbwdX8U8e0b4X2uBjTdSjxoVicyW2291G4fleLXI9VNk=
X-Received: by 2002:aca:52cc:: with SMTP id g195mr3728747oib.99.1550607163807; 
 Tue, 19 Feb 2019 12:12:43 -0800 (PST)
MIME-Version: 1.0
From: Timur Tabi <timur@kernel.org>
Date: Tue, 19 Feb 2019 14:12:07 -0600
X-Gmail-Original-Message-ID: <CAOZdJXVQgSvUa-yy=b8M0_P+YRARWtQ+r=YCPWKT2ByLV01frA@mail.gmail.com>
Message-ID: <CAOZdJXVQgSvUa-yy=b8M0_P+YRARWtQ+r=YCPWKT2ByLV01frA@mail.gmail.com>
To: cocci <cocci@systeme.lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 19 Feb 2019 21:12:50 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 19 Feb 2019 21:12:46 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Specifying that an expression is a string constant?
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

The following rule fails with an error on the last line:

@rule3@
expression x, y, z;
@@
-DBG_PRINT_STRING_VALUE(x, y, z);
+NV_PRINTF2(x, y "0x%x\n", z);

Presumably, cocci doesn't know that "y" is a string constant and so
the resulting expression is valid.  I'm guessing that I need to
specify that "y" is a string constant, but even after reading
http://coccinelle.lip6.fr/docs/main_grammar.html, I can't figure out
what that could be.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
