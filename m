Return-Path: <SRS0=BkxN=P7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A87C282C3
	for <cocci@archiver.kernel.org>; Wed, 23 Jan 2019 00:06:21 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B6B420856
	for <cocci@archiver.kernel.org>; Wed, 23 Jan 2019 00:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4LvugBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6B420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0N065ci006370
          ; Wed, 23 Jan 2019 01:06:05 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 53B8876F2;
	Wed, 23 Jan 2019 01:06:05 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 24B6076EA
 for <cocci@systeme.lip6.fr>; Wed, 23 Jan 2019 01:06:04 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0N061Ss016773
 for <cocci@systeme.lip6.fr>; Wed, 23 Jan 2019 01:06:02 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 68B5020856
 for <cocci@systeme.lip6.fr>; Wed, 23 Jan 2019 00:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548201960;
 bh=jYnXbsLaZwOmCnyHFirXmjR2ySL4WgeoMzqLO9hgkgs=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Q4LvugBMWciWB1FErVB/SPRI8VyxYYaMokzQcZJmcMpVVRmkvMGe7Z9i3X7fizH6S
 ez0Ot3LmxAIfu20AQHbxdoWV8qbEQELnJJESFahmGXqyNlyX0C7gWu27Ib8j2SNo5l
 w7p4RevF6zXrKGKooW8Q/vNtQVwD2T8i6PdLfOBE=
Received: by mail-oi1-f174.google.com with SMTP id a77so352192oii.5
 for <cocci@systeme.lip6.fr>; Tue, 22 Jan 2019 16:06:00 -0800 (PST)
X-Gm-Message-State: AJcUukeH/ZeUpsxQ1hwm7ETKIcBItYVdx/PDv+BsF0rJlD5ceHxx0z3N
 N/mOVXPCHnJytZzXqZgnUFWc+tehb26pdhTtv+M=
X-Google-Smtp-Source: ALg8bN6m4+CT8JblpDSgvOqULrqVdBLTObI5vboddlmXUqpAWUCIltsYNIoze9Ec9oxRtzJ8FugQUk9X5HJCbeft+A0=
X-Received: by 2002:aca:6b8c:: with SMTP id g134mr11347oic.135.1548201959754; 
 Tue, 22 Jan 2019 16:05:59 -0800 (PST)
MIME-Version: 1.0
References: <CAOZdJXXHJU3f4K-ECQjGs2WoE8XFMZDHL3bQ93ncewv_XCOSrg@mail.gmail.com>
 <alpine.DEB.2.21.1812182303590.2486@hadrien>
 <CAOZdJXUj5mZDHC+71N+mBQ98hpa4H7rbA1E3kkGzDgV_zFRobQ@mail.gmail.com>
 <alpine.DEB.2.21.1812190720480.2656@hadrien>
 <CAOZdJXUOQGdExeDDPbubiHpoGdUtC664zhhsWW1OJT4kd1zdPw@mail.gmail.com>
 <alpine.DEB.2.21.1901221942530.2519@hadrien>
In-Reply-To: <alpine.DEB.2.21.1901221942530.2519@hadrien>
From: Timur Tabi <timur@kernel.org>
Date: Tue, 22 Jan 2019 18:05:22 -0600
X-Gmail-Original-Message-ID: <CAOZdJXVwUs26YSmHXa75QeZ1ARkfBXaf=0HaapoaKGvP9Ux1vQ@mail.gmail.com>
Message-ID: <CAOZdJXVwUs26YSmHXa75QeZ1ARkfBXaf=0HaapoaKGvP9Ux1vQ@mail.gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 23 Jan 2019 01:06:05 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 23 Jan 2019 01:06:02 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>, Timur Tabi <timur@kernel.org>
Subject: Re: [Cocci] Positional parameter p1[0].file contains temporarily
 munged filename, not original
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

On Tue, Jan 22, 2019 at 12:44 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
>
> You can use List.hd (Coccilib.files()) in OCaml.  I guess some similar
> function exists for python.

Can you expand on that?  I took at look at
https://github.com/coccinelle/coccinelle/tree/master/python/coccilib,
which I presume is the coccilib that you're talking about.  I don't
see a files() anywhere in there.  I tried to instantiate the Location
object:

import coccilib
cocci = coccilib.Location()
print >>sys.stderr, cocci

But that just gave me:

Traceback (most recent call last):
  File "<string>", line 44, in <module>
AttributeError: 'module' object has no attribute 'Location'
Error in Python script, line 130, file "/home/ttabi/nv_printf.cocci":
Python failure

The "import" statement didn't fail, so I presume that coccilib is a
real library, but I think I'm calling it wrong.  My Python isn't good
enough to read a library implementation and know how to use it.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
