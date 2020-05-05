Return-Path: <SRS0=zNwH=6T=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCAFC47247
	for <cocci@archiver.kernel.org>; Tue,  5 May 2020 09:59:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90A16206B9
	for <cocci@archiver.kernel.org>; Tue,  5 May 2020 09:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cilium-io.20150623.gappssmtp.com header.i=@cilium-io.20150623.gappssmtp.com header.b="ooBGbKp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A16206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cilium.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0459xGJP024268;
	Tue, 5 May 2020 11:59:16 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2990A775A;
	Tue,  5 May 2020 11:59:16 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 371A43E6B
 for <cocci@systeme.lip6.fr>; Tue,  5 May 2020 11:59:15 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:42f])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0459xETj010964
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 5 May 2020 11:59:14 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id i10so1950921wrv.10
 for <cocci@systeme.lip6.fr>; Tue, 05 May 2020 02:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cilium-io.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=7NIUTERwrvDKFhVggje2Rp2xGHeL22wL3xfJx0e0EEg=;
 b=ooBGbKp4VT+HN+12T6TY+4iGi7dQjzwxodlNiaTbt/RWoNyt8c5hMRkDQRb5/mM/1U
 uah/bW8xI2HHRftiw2Us0QAXRp5eqqjCwzKNWtfrsm+SRuzFcgUCwk5gGYmjXJGoBmS5
 TN9h3ot+Cyg7UX1IFA6PtINkl1+7uc9uDd8OrcwYhhBySfRXeAiBSoixbjLAj1lEYERU
 0GYEmlGxUKEkoHyIEZYM6brzcEbrn5WvukixClk05FGVkn6p7Ydme+sPTybE9j2AY8+9
 9Bc9cGXcCKXhnR5X15NiT+P0AGHueGKI59ZSGbdqMP8pp8XlY3OqSJeChBVxHW97b4Px
 lYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=7NIUTERwrvDKFhVggje2Rp2xGHeL22wL3xfJx0e0EEg=;
 b=Jk4oPp9W5KQrxIci1Lavg+ROO6GSsFc6HhcvxLF6HkizrZJub0wVcgya4k5cgqOD9z
 YcHRhIe85MMj2SZs2ggqwOHOfCu/snp1j+eCPB4W+PZ7qZlYgKQk9CVKCafuWBq/skKn
 JZNfmBzvlVkn9+hquiG7fMHl4GKY7d5xaxdqUKvVGqVQGd8PeJMZWLo9HXzyj/FvH03w
 iSSLwrPRKEu+L8cAIZGdJBm1wsvI/k77I6WKqfJ3gorNCNxaDHveyFQbKZR6yueY0ZXt
 Uwo0qas1dHJTKI4v/8Qszc04IckvUnd/27vos7aDEw4WsO7+zAT2wtSzMRy73/ZNGj/r
 JKOA==
X-Gm-Message-State: AGi0Pub2hQyFtJc1AYZIzmEnXzcQYVc+L227KdF2G5kLc1UJiQTgN9mc
 vskn0IkcXVRl03FnUuNTpQrTWwl/MSg/
X-Google-Smtp-Source: APiQypJ39T0u4oFQIOzMkD9lbdnzNk1JxgAf4+f/g1Wx3dQDT29sSy6AOP/bkGBHPlmCa+O1ssRUSw==
X-Received: by 2002:a5d:4b90:: with SMTP id b16mr3051066wrt.16.1588672753921; 
 Tue, 05 May 2020 02:59:13 -0700 (PDT)
Received: from Mem ([145.136.49.157])
 by smtp.gmail.com with ESMTPSA id t2sm3096521wmt.15.2020.05.05.02.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 02:59:13 -0700 (PDT)
Date: Tue, 5 May 2020 11:59:12 +0200
From: Paul Chaignon <paul@cilium.io>
To: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <20200505095911.GA7247@Mem>
References: <b6c5ae24-f24c-a0d5-796a-8e9cbd17a7d6@web.de>
 <20200429190733.GA5695@Mem>
 <72cb854f-912b-4c34-a526-be7b584e8fd8@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <72cb854f-912b-4c34-a526-be7b584e8fd8@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 05 May 2020 11:59:16 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 05 May 2020 11:59:14 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Exit with non-zero status
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

On Wed, Apr 29, 2020 at 09:50:21PM +0200, Markus Elfring wrote:
> >> I suggest to handle the desired search result counter
> >> by an other data processing interface.
> >> How would you like to treat program execution failures otherwise?
> >
> > I'm trying to run SmPL programs as part of a CI pipeline, so execution
> > failure and (buggy) code pattern not found really mean the same in
> > the end: a human needs to take a look :-)
> 
> I imagine that such a look can occasionally made a bit more convenient.
> 
> 
> > I understand that is not a common use case
> 
> Can such a software application become more popular?

As far as I understand, if it's not more popular to use Coccinelle in
CIs right now it's because of (1) false positives for some rules, and
(2) the little reliance of the Linux community on CIs.

We rely heavily on CI and probably wouldn't use Coccinelle in the long
term if we couldn't enable it in CI. Without CI, developers and
reviewers would likely forget to execute semantic patches.

So CI use seems to become more popular (even in low-level projects), but
it's not like this exit status issue is a blocker to use Coccinelle in
CI. For the record, I enabled Coccinelle in our CI (GitHub Actions)
yesterday and worked around that issue with the following script:

  make -C bpf/ coccicheck | tee /tmp/stdout
  exit $(grep -c "[prefix of warning messages]" /tmp/stdout)

> 
> 
> > and I'm fine using a workaround.
> 
> We have got different views around preferable solutions.
> How many information would you like to put into an exit code so far?

Please see above script. I currently exit with number of failures, but
having just 0 (success) and 1 (fail) statuses would be enough.

> 
> 
> > Just wanted to check I wasn't missing something obvious.
> 
> Further possibilities should probably be clarified further,
> shouldn't they?
> 
> Will the usage of additional data structures become more interesting?

Not sure I understand the question. What data structures?

Cheers,
Paul
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
