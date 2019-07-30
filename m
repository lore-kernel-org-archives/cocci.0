Return-Path: <SRS0=Pi+n=V4=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53A7C32751
	for <cocci@archiver.kernel.org>; Wed, 31 Jul 2019 11:14:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2562206B8
	for <cocci@archiver.kernel.org>; Wed, 31 Jul 2019 11:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxCR4iI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2562206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6VBEO8t008457;
	Wed, 31 Jul 2019 13:14:25 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D413B779C;
	Wed, 31 Jul 2019 13:14:24 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 953DD768E
 for <cocci@systeme.lip6.fr>; Tue, 30 Jul 2019 16:43:56 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:52b] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6UEhuDR026029
 for <cocci@systeme.lip6.fr>; Tue, 30 Jul 2019 16:43:56 +0200 (CEST)
Received: by mail-ed1-x52b.google.com with SMTP id p15so62767699eds.8
 for <cocci@systeme.lip6.fr>; Tue, 30 Jul 2019 07:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=c3fPoyH7pzwX5dEMWrQHtgHz/du/HA+9jfXKq1PHLzY=;
 b=sxCR4iI2U0e+TPnpU+nAguYOLfpvT0BdJX60j5a9+XwbImIRV/oFwan0LZrmu+lFJh
 4+hmSFTu60vqjx/q44V3aRhy5vkkqFGpzv/zoTP+Gp3WODBEWdPZxkzOhCj6dBkqYkUK
 y1wxGBZBpROg7wn707c1rMgzOAzD+TQ47e4kjZYnFUb3k++M43r9JariUrZ75WLSqokF
 7Qfx9pzfT3C9MUuGGIddb72uyXFGOW/ME4yPNiecOAnFn5Qr7RQu23MMUGYhOFrRXPm7
 g+K1Gqj1UPqAuFaxu9wcMMG6FSRBpSDaYCs5EHlhdVZ/GHyOfENjaWI6kK68HVu1ia0K
 tWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=c3fPoyH7pzwX5dEMWrQHtgHz/du/HA+9jfXKq1PHLzY=;
 b=iz2ef/mpXipG2prFjo02Ndu6sGwgcF+vMH3qH+LHDqm3EjhtXyogJIN2H6TjVuJoaw
 ipuJuHHdsnr98Gv1qH95zD2FKjNMbM5dzSIufypDwPNLHNmSu/ezAPhJzZ123d58vYjC
 Q0ZnUoogRFWG30vzyKXSIztp3cGHP5WNO7V4PqoJRs3FHfkcFcy2J66gBoLCVM5Pe1Un
 f7/NEHrDzAh0ruvjwg1znuaPcDiOCsojnWi1tyPRaPsOowtIFbmr8QtLbz9aYE+IoogE
 9tEyLcs1Or4dCtx+b+xYeihEspGvA607uXh06+Vwff3FDJAp/8ba/gOhg3t57LDzPVJ7
 4enw==
X-Gm-Message-State: APjAAAV0bb5dHr9nDd4CQobZIpU9A1fMBDgktr6lQoeTyf88GTNrEOXD
 IJkuuRADE8nzvz6pIjmdz3Y0fUYkH6M+EIco2+wOVtii
X-Google-Smtp-Source: APXvYqwx260OF8+2o4+DcdDENJgD28A3p98oJyOcVT+NcPjkA4WoMukQ2GERTA++sPe9HQKuSXPrA7IPDT4iuIqJH74=
X-Received: by 2002:a17:906:8317:: with SMTP id
 j23mr76903558ejx.51.1564497835852; 
 Tue, 30 Jul 2019 07:43:55 -0700 (PDT)
MIME-Version: 1.0
From: Chuhong Yuan <hslester96@gmail.com>
Date: Tue, 30 Jul 2019 22:43:46 +0800
Message-ID: <CANhBUQ0Rc5Q=R6Ufc=UEmLe4d0emQz4Cv+VsoA_7v=mHBY_LuQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 31 Jul 2019 13:14:25 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 30 Jul 2019 16:43:56 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Wed, 31 Jul 2019 13:14:24 +0200
Subject: [Cocci] How to match all conditions in if-else if blocks?
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
I want to write a script to match a pattern of conditional statement.
However, I find that I can only match the first "if" in the block.
The script is like this:
fn(...) {
...
- f(arg1, arg2, arg3)
...
}
where f returns the condition check result.

But when I apply to source code like this:
if (f(a1, a2, a3)) {
...
} else if (f(a4, a5, a6)) {
...
}
I find it can only match f(a1, a2, a3).
So how to fix this problem?

Thanks,
Chuhong
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
