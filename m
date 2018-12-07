Return-Path: <SRS0=vlGS=OQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6043EC07E85
	for <cocci@archiver.kernel.org>; Fri,  7 Dec 2018 18:18:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7DCE2083D
	for <cocci@archiver.kernel.org>; Fri,  7 Dec 2018 18:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhZubk/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DCE2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB7IHxJE001640
          ; Fri, 7 Dec 2018 19:18:00 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BF73876D6;
	Fri,  7 Dec 2018 19:17:59 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id ACF7576D4
 for <cocci@systeme.lip6.fr>; Fri,  7 Dec 2018 19:17:58 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB7IHvC4018005
 for <cocci@systeme.lip6.fr>; Fri, 7 Dec 2018 19:17:58 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 39AF42083D
 for <cocci@systeme.lip6.fr>; Fri,  7 Dec 2018 18:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544206677;
 bh=wMLYQQfPqT4evWqw81+d+tNpYRdVKBnORp7e20y6IFM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ZhZubk/xQADSBCkxU/v/2ghm628120y1SlK3PTdABtadAR7IfCsHgBNVYONGkWx7I
 3EhDMK2AETEikk6Gno6wkLNh/VlRUyvg174lBIBGuCxTLO4U2wUW0oTHYx8k2rwqfl
 4en3pXqDQbKM9cE0aSvVtLs7CUSZ696f7R7gWKMc=
Received: by mail-ot1-f53.google.com with SMTP id i20so4673606otl.0
 for <cocci@systeme.lip6.fr>; Fri, 07 Dec 2018 10:17:57 -0800 (PST)
X-Gm-Message-State: AA+aEWZru9ZHDhLVs+P2jiREtQYBwVi0gZo9G5NYiDx6O3PsbjB9awkj
 E446unmT25D8MjwAVQgfUrV/HPJEo2U6KG+6vNg=
X-Google-Smtp-Source: AFSGD/WpLn7+sV6W6sDmys0dPz8p+j5iUNaqlJZr/kLfBXpQ/xX6hg6lp37QpKeC4Z+bUqsC+fNelrl3oc1oF9D4vhQ=
X-Received: by 2002:a9d:7c1:: with SMTP id 59mr2308851oto.191.1544206676577;
 Fri, 07 Dec 2018 10:17:56 -0800 (PST)
MIME-Version: 1.0
References: <CAOZdJXW9XmFAPbhiSsejhFZ+9me=kHc25A-Qk0e=CrCnkkFuhw@mail.gmail.com>
 <alpine.DEB.2.20.1812071837160.20798@hadrien>
 <CAOZdJXX-_cVVTdvird2amhKRD-ywDgCxJopwof4ZovjU2zS-Yw@mail.gmail.com>
 <alpine.DEB.2.20.1812071855470.20798@hadrien>
In-Reply-To: <alpine.DEB.2.20.1812071855470.20798@hadrien>
From: Timur Tabi <timur@kernel.org>
Date: Fri, 7 Dec 2018 12:17:19 -0600
X-Gmail-Original-Message-ID: <CAOZdJXUVc0Z0z-VmDCnjNknyeCRiebvYd2K9ePRk5qEPyzWg+Q@mail.gmail.com>
Message-ID: <CAOZdJXUVc0Z0z-VmDCnjNknyeCRiebvYd2K9ePRk5qEPyzWg+Q@mail.gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 07 Dec 2018 19:18:00 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 07 Dec 2018 19:17:58 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Fatal error: exception File
 "engine/ctlcocci_integration.ml", line 361,
 characters 4-10: Assertion failed
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

On Fri, Dec 7, 2018 at 11:56 AM Julia Lawall <julia.lawall@lip6.fr> wrote:
> I guess you run Coccinelle on a complete directory?  If so, does the
> assert cause everything to crash, or only the treatment of the given file?

Only that file crashes.  I changed that line to remove the ##, but it
didn't fix anything.  So I just commented out the entire macro and now
spatch works on that file.

Considering the unique nature of this code, I'm not sure that there's
anything to fix.  It would be nice if the normal error reporting was
more accurate, since I typically need to use --debug or not
--control-flow just to find the offending line in my C files.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
