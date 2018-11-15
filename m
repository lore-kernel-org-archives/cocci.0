Return-Path: <SRS0=DNKl=N2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF57C43441
	for <cocci@archiver.kernel.org>; Thu, 15 Nov 2018 20:59:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0203620858
	for <cocci@archiver.kernel.org>; Thu, 15 Nov 2018 20:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1NMUbbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0203620858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wAFKwkrh016514
          ; Thu, 15 Nov 2018 21:58:46 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DEECC76D2;
	Thu, 15 Nov 2018 21:58:45 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2CCDC76CB
 for <cocci@systeme.lip6.fr>; Thu, 15 Nov 2018 21:58:44 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wAFKwfXs022103
 for <cocci@systeme.lip6.fr>; Thu, 15 Nov 2018 21:58:42 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A7BC520858
 for <cocci@systeme.lip6.fr>; Thu, 15 Nov 2018 20:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1542315520;
 bh=frmfoMH615MpzhdDkrO1XnroJU7RtnF734cP1oyrcfs=;
 h=From:Date:Subject:To:From;
 b=B1NMUbbK3labfEZZDtYi0uhdj6EFFt8IYoP90DSTPRztTFSc3b2TfJu5NFTV9Rcqn
 0s1XQbgbYv6+CXGIUDJCC8GfQuUPjAkPWrdFt5vIu8pWZ3cfzZBOExPz234tE2MhnX
 TZMqiqA4ZAjHgA8e+hRRg4JOlE2sMOpnU1W5Ol3A=
Received: by mail-oi1-f175.google.com with SMTP id 192-v6so17948536oii.6
 for <cocci@systeme.lip6.fr>; Thu, 15 Nov 2018 12:58:40 -0800 (PST)
X-Gm-Message-State: AGRZ1gIvIhARp+VxRVQb1ndQR1eDTActMeEkDKIXSJvVc5uTHHBkT0sz
 o2KJ0ZX62oFCvdhmZsbNyAcaTJxvWcnRQ76rAdk=
X-Google-Smtp-Source: AJdET5dHoH2K94ThkoJHlx+rMqxgO0FyjUXx1Y1BdbeORE2UBVnAuw/8u1q3Y+yoNZIFdVanWnQTkfTSG/JspGMhMiM=
X-Received: by 2002:aca:3208:: with SMTP id
 y8-v6mr4314630oiy.198.1542315520025; 
 Thu, 15 Nov 2018 12:58:40 -0800 (PST)
MIME-Version: 1.0
From: Timur Tabi <timur@kernel.org>
Date: Thu, 15 Nov 2018 14:58:03 -0600
X-Gmail-Original-Message-ID: <CAOZdJXVLMv-5_u1uOq6re+1O3vADsrTK0+J3Fat-XN4_2DEp4w@mail.gmail.com>
Message-ID: <CAOZdJXVLMv-5_u1uOq6re+1O3vADsrTK0+J3Fat-XN4_2DEp4w@mail.gmail.com>
To: cocci <cocci@systeme.lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 15 Nov 2018 21:58:46 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 15 Nov 2018 21:58:42 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Can the current function name be passed to a Python snippet?
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

Is it possible for a Python code snippet to be passed the name of the
current function?  I already have Python code in my .cocci file that
cleans up the text of some string literals.  I want to add more code
that removes the current function name from the beginning of a string
literal.  So for instance, If I have

void myfunc(void)
{
...
    NV_PRINTF("myfunc: xxx\n");

I want to replace the NV_PRINTF line with:

    NV_PRINTF("xxx\n");

To do that, the Python code would need to given "myfunc" as a
parameter of some kind.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
