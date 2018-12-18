Return-Path: <SRS0=6akS=O3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06420C43387
	for <cocci@archiver.kernel.org>; Tue, 18 Dec 2018 21:36:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48E6A21871
	for <cocci@archiver.kernel.org>; Tue, 18 Dec 2018 21:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8XfoVce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E6A21871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBILafjh020946
          ; Tue, 18 Dec 2018 22:36:41 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9338B740A;
	Tue, 18 Dec 2018 22:36:41 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C718A3A55
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 22:36:39 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBILacnO028477
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 22:36:39 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9C30A21871
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 21:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545168997;
 bh=d1IJkdlh4H4yOtDPYxu238y/HiiguVF9lF1HN/ohDBM=;
 h=From:Date:Subject:To:From;
 b=P8XfoVce7dFM1pccy07w/3GPNkK/pN9ev84oPZRkVMbHgCLbCTeEZfMq/DG8MfIOR
 rWvOp1AGaDXRHEqrfDCU1iMuc7nzQeVGy8BuirOFX8ihcNIYlpm0UzvTnEwP++FBu6
 u0DgeXxRdPkwF/ohbXPP97ICPQQve3pTQnZ5ox9w=
Received: by mail-ot1-f50.google.com with SMTP id 81so17151140otj.2
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 13:36:37 -0800 (PST)
X-Gm-Message-State: AA+aEWZiTt/+QKBSgP+ru21lLEepvuapLpJX+blqjSSm+1JvLTuEiGtA
 fztN90tzHMEmiRALujwCzvZ1tjtWGn5FJKF73do=
X-Google-Smtp-Source: AFSGD/X6R2fSMHzniMZhMOepbnKaiPGD3zSbm3XTtpt8xyuaIl1EeGE6gfj15R10BfokRhRO1hJBJAsEEgyvOowWhpo=
X-Received: by 2002:a9d:67cf:: with SMTP id c15mr9205739otn.38.1545168996946; 
 Tue, 18 Dec 2018 13:36:36 -0800 (PST)
MIME-Version: 1.0
From: Timur Tabi <timur@kernel.org>
Date: Tue, 18 Dec 2018 15:36:00 -0600
X-Gmail-Original-Message-ID: <CAOZdJXXHJU3f4K-ECQjGs2WoE8XFMZDHL3bQ93ncewv_XCOSrg@mail.gmail.com>
Message-ID: <CAOZdJXXHJU3f4K-ECQjGs2WoE8XFMZDHL3bQ93ncewv_XCOSrg@mail.gmail.com>
To: cocci <cocci@systeme.lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 18 Dec 2018 22:36:42 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 18 Dec 2018 22:36:39 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Positional parameter p1[0].file contains temporarily munged
 filename, not original
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

I added this line to my Python code:

    print >>sys.stderr, 'Warning: missing \\n on line %s in %s' %
(p1[0].line, p1[0].file)

and this is what it prints:

Warning: missing \n on line 813 in
/tmp/cocci_small_output-11011-b5932b-grgf100.c

So it looks like spatch is copying the file to the /tmp directory
before processing it.  Is there any way to get the original file name,
grgf100.c?
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
