Return-Path: <SRS0=ZWNV=TY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041C0C072B5
	for <cocci@archiver.kernel.org>; Fri, 24 May 2019 13:19:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B49A2075E
	for <cocci@archiver.kernel.org>; Fri, 24 May 2019 13:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="0Az09CU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B49A2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4ODImYK015294;
	Fri, 24 May 2019 15:18:48 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E35E77752;
	Fri, 24 May 2019 15:18:47 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C36737747
 for <cocci@systeme.lip6.fr>; Fri, 24 May 2019 15:18:45 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:334] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4ODIjZE028989
 for <cocci@systeme.lip6.fr>; Fri, 24 May 2019 15:18:45 +0200 (CEST)
Received: by mail-ot1-x334.google.com with SMTP id i2so8629702otr.9
 for <cocci@systeme.lip6.fr>; Fri, 24 May 2019 06:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linbit-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to;
 bh=v/6Hot+TRWQt57MjlYynxxu0Fj5qGq8KCq5VC/FRfyE=;
 b=0Az09CU9dYUMmnW6QvDSKH83Yu6aL1BrCnp4sDpb/oZ8Wlshi7BAf+j3evOvrPvzCl
 8fof+zDXio+UN3UhcQNAEeK3NEYfUzxaBKLtssBFc8ky9FvlYjzF0rQ9IHMq98wWErRd
 EjkVM8218mBRAssS4ttTkCCOMN45XJvdQHbTUTn0ufCZPB4SuwOdEOcUtskPMlyn6i0N
 TqMdX+ov7apwAAUSiz5ontyfwS8QdwzfwcljKZR3fkxboy3LlijhPpPuwiE6vJm0pTlM
 3d+WIxrGzUpNirnoNtlKr1ebxq/bAyjPT7XfAZYncIwcjvmYtz3tjWqZM1zK4SGThJQc
 lyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=v/6Hot+TRWQt57MjlYynxxu0Fj5qGq8KCq5VC/FRfyE=;
 b=DVyTld/BbdaSB7z13H8hOanE5pwcCIsWI4dgupICep/maS5aTiPtW55b5HD/OCzEid
 WA/TMsBL+6S0YoVC5EsaiXylP+rRJa6qriIGfJooMwVN3RwF2a48iphqPBncAd/kt9BQ
 jeKcxFE8idaRCFXctpLCdm1utx6OxftTRmZM7wpEufGPdsyY5jeTkCQm4f89+ELxYfDr
 PhHqql3BhPstUaZt8RV14RtRwvYwzTymfzTv4YXDeOfXqRUnK3l+1jD5zK6SDkKR06EB
 LC+9ed68ljHGGwvJTfQrdSWZiT7BVTs/qRxdafYhCgfoByDSQndcS5TKDN1qgwPslwX3
 AmnQ==
X-Gm-Message-State: APjAAAVvRwyw5XoAZxvzlWv5TQYwLn43/LI+VgOEIN+Y+ujxkYOWkgGy
 mmbOjti7nQXFcWpgSt4ZvN/kxknBAZi/qMQXaYzlS5KXXeQ=
X-Google-Smtp-Source: APXvYqw1lYeheb7rUhqWAR4VD+UE3bmn08a7QkLCn9WswWS+KOBgqM8xcz8l2W3U7rrAmOQtfgv1KUbdsmCaM/R4Fy4=
X-Received: by 2002:a9d:3b84:: with SMTP id k4mr44523224otc.27.1558703924381; 
 Fri, 24 May 2019 06:18:44 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Date: Fri, 24 May 2019 15:18:33 +0200
Message-ID: <CADC+RAzMNspm03FhGGQEDTsAMkQecjo_A930_SvsraKBpzu_bQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 May 2019 15:18:48 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 24 May 2019 15:18:45 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] "depends on" per file
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

Hi,

I'm trying to replace a function with a one-liner, where the one-liner
has a dependency on a header file that the function doesn't.
Now I want to include said header file iff it isn't already included
in the affected file.
In more concrete terms, this is my script:


@ find_linux_dcache_h @
@@
 #include <linux/dcache.h>

@ replace_simple_positive @
expression den;
@@
- simple_positive(den)
+ (den->d_inode && !d_unhashed(den))

@ add_linux_dcache_h depends on !find_linux_dcache_h && ever
replace_simple_positive @
@@
 #include <...>
+ #include <linux/dcache.h>


So far so good, (almost) works just fine. The issue is that if the
rule gets matched in one file, it will include the header in every
other file as well, because the "depends on ever" clause is satisfied.
Is there a way to tell coccinelle "apply this rule to file X, but only
if another rule matched in the same file"?

--
Regards,
Christoph
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
