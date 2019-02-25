Return-Path: <SRS0=6Fm5=RA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30FFC43381
	for <cocci@archiver.kernel.org>; Mon, 25 Feb 2019 17:43:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7A020643
	for <cocci@archiver.kernel.org>; Mon, 25 Feb 2019 17:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAVEaCkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7A020643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1PHhBbZ019989
          ; Mon, 25 Feb 2019 18:43:11 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3CE237709;
	Mon, 25 Feb 2019 18:43:11 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0958B76FD
 for <cocci@systeme.lip6.fr>; Mon, 25 Feb 2019 18:43:09 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1PHh7I9012293
 for <cocci@systeme.lip6.fr>; Mon, 25 Feb 2019 18:43:07 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8220D20643
 for <cocci@systeme.lip6.fr>; Mon, 25 Feb 2019 17:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551116586;
 bh=UCvvfuBuHjf6g6aOC+8/Qv5EBq0W1s9g2IseGxdSJqU=;
 h=From:Date:Subject:To:From;
 b=NAVEaCkmiE9IUh3xkT8X7agKdxpFTpoYJMan9z/6F1yVoSytp0b7KanhBXFSo3XFP
 6mqr2Juf3injxoss0hn1S5rfBOrvmjs/bsO/KucUXQ0FZt/Re7vrJlacORmvhSPxrS
 DhX6LZjM8ejYMUA9B78Dj4eWItlX9y6xrpXz6/YU=
Received: by mail-ot1-f50.google.com with SMTP id z19so8613209otm.2
 for <cocci@systeme.lip6.fr>; Mon, 25 Feb 2019 09:43:06 -0800 (PST)
X-Gm-Message-State: AHQUAub+RDgTpjnnjPqr4e5t7Zmr2jsuU766E3+Gpgg8seTj8qWaCY+2
 WMjpsDkmJWQaPDf21ABu0M5X9pnQzqEo2ahHozw=
X-Google-Smtp-Source: AHgI3IYK0PEGevDUSKsfYHB8+ukV7cTh/3GMGGZfqxrx01lyGYZZxb0x9bbx4+nFjcdf7ApZ3UIG+lGTFt4b6HMpE2c=
X-Received: by 2002:a9d:6c96:: with SMTP id c22mr11559476otr.38.1551116585858; 
 Mon, 25 Feb 2019 09:43:05 -0800 (PST)
MIME-Version: 1.0
From: Timur Tabi <timur@kernel.org>
Date: Mon, 25 Feb 2019 11:42:29 -0600
X-Gmail-Original-Message-ID: <CAOZdJXX=_PaZWF07z6JRg-JrGWa9JYP_9Wr3dOKajA5ZopWi5Q@mail.gmail.com>
Message-ID: <CAOZdJXX=_PaZWF07z6JRg-JrGWa9JYP_9Wr3dOKajA5ZopWi5Q@mail.gmail.com>
To: cocci <cocci@systeme.lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 25 Feb 2019 18:43:11 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 25 Feb 2019 18:43:07 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] How to handle/ignore iterator macros?
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

I have lots of code that looks like this:

#define MY_ITERATOR(x, y)  for (x=0; x<y; x++)

MY_ITERATOR(v, 20)
{
    printf("%i\n", v);
}

Spatch chokes on this because it thinks MY_ITERATOR() should end with
a semicolon:

...
bad:          MY_ITERATOR(v, 20)
BAD:!!!!!     {
bad:               printf("%i\n", v);
...

I tried specifying "--undefined MY_ITERATOR", but that did nothing.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
