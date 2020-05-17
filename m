Return-Path: <SRS0=PP4e=67=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EA3C433E0
	for <cocci@archiver.kernel.org>; Sun, 17 May 2020 00:16:54 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 205E120709
	for <cocci@archiver.kernel.org>; Sun, 17 May 2020 00:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xteddy-org.20150623.gappssmtp.com header.i=@xteddy-org.20150623.gappssmtp.com header.b="IUPDoPrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205E120709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xteddy.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04H0Goj3010740;
	Sun, 17 May 2020 02:16:50 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 86AE43E6B;
	Sun, 17 May 2020 02:16:50 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C27F53DC8
 for <cocci@systeme.lip6.fr>; Sun, 17 May 2020 02:16:48 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:436])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04H0GmUt024272
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 17 May 2020 02:16:48 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id v12so7576840wrp.12
 for <cocci@systeme.lip6.fr>; Sat, 16 May 2020 17:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xteddy-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:subject:message-id:mime-version:content-disposition;
 bh=Dyfm9g62CGpB0BLvfvBFVvS9Saqsr/iaFsIZsAsbfQA=;
 b=IUPDoPrD5rzX3xj7fYTORozKMMLqgjF7g2lbsq1oCu17OK8VPvSyhviFEa8U2RNtQP
 VceiaVm0yk/htcln9dJLhSnZkbTDxUG+RYmsjNJvUFLWu7AiZoSuxXMDnrxWvUxsNVZt
 bZIFCABVMSWQuD8wE5oFp+GM9HasOEykTe1RKgqJQfscfPF4/WCXZKeyn48htyq7QYNu
 iuYnbKVmE/srtYvnTsGCor35kmXkSw3WKZrkjluB4yyKRp9ZJ9xWtShyZ0epqYrd+q87
 u4CfgVSfLoRbRPSJiBlylEihkU/6hJvEnH9OgKe8NZaqUm8cYUjOemZniL42k8Ugq01J
 8Q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition;
 bh=Dyfm9g62CGpB0BLvfvBFVvS9Saqsr/iaFsIZsAsbfQA=;
 b=W35rvh2g+uafxCRgpmLJeC/dWB2ieJQYKRJ8BuyJKLUPZZJhhHOTDoQu9ptPtoU/ZO
 7OOn1qPT3Z9M5vgD7QkYETEigo41nzUA2+hxAXXsdT4PcR/SQ5ZOtBRJ10iif1mtevY2
 9XBAlLG4FOHr/UgTAlVa7zQicBB7cnmKmFWtkD9v/wjFgaJxOiRi1vb9TO+j+XACq+et
 Z/lPn+s3rygHa4pTWmCEbzDCnPKdtsOJgjgBcLmpUaXNZRqNEQIpTpLgRzDHkuOAzjW9
 CeT5hDVVUWze0DB2Nn1v3Z/6k7Dz5VdH0LfIHD+PntsLEuZ/ilNL+/HVjIJuwKkk3COK
 OCxw==
X-Gm-Message-State: AOAM533/jDr4zToAgI13Ib2OKj+MGPpNGMwGfukGc5w2ynSUNA6AysmP
 ttQI8WGXO+EDfzDfFkSRkKZA1IdppdeKrQ==
X-Google-Smtp-Source: ABdhPJzS5W+w2fc93KfVq2H0N1uYHm1iKp7kayniAYVCTFTDUfVln4lEnibNAtApnwhHd1JEqNFtwg==
X-Received: by 2002:adf:e74a:: with SMTP id c10mr11975871wrn.109.1589674607856; 
 Sat, 16 May 2020 17:16:47 -0700 (PDT)
Received: from debian (88-105-78-135.dynamic.dsl.as9105.com. [88.105.78.135])
 by smtp.gmail.com with ESMTPSA id
 z12sm7858421wmc.6.2020.05.16.17.16.47 for <cocci@systeme.lip6.fr>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2020 17:16:47 -0700 (PDT)
Date: Sun, 17 May 2020 01:16:46 +0100
From: Thomas Adam <thomas@xteddy.org>
To: cocci@systeme.lip6.fr
Message-ID: <20200517001646.gtobyv6jea5bugfr@debian>
MIME-Version: 1.0
Content-Disposition: inline
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 17 May 2020 02:16:50 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 17 May 2020 02:16:48 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] Using cocci to mangle function arguments
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

I have a situation where I'm trying to use Coccinelle to both rename one
function to another, and at the same time modify the number of arguments.

I have a function called:

    func_old(ERR, "func_name", "%s message", charstring);

Which is therefore variadic.  In terms of argument ordering func_old() takes:

  1.  log-level type
  2.  the calling function
  3.  A variadic string

I'm wanting to replace func_old() with func_new() such that it looks like
this:

    func_new("%s: %s message", __func__, charstring);

Hence, func_new() reduces the number of arguments to just one -- a format
string, and variadic arguments.

My question is how would I go about trying to get coccinelle to help me
translate this?  Is this even possible?  I have tried:

@@
expression O1, O2, O3
@@

- func_old(O1, O2, O3, ...);

But I don't know how to convert what would be O2 to '__func__'.  When calling
func_new(), there is no explicit O2 parameter from func_old(), it should be
part of the format string, hence:

+ func_new("%s: ...", __func__, O3);

I suspect I might be stretching coccinelle's abilities in trying to craft new
parameters, but I thought I'd ask.

Apologies if this is convoluted.  If I can help answer any additional
questions, or if something's not clear, let me know.

TIA!

Thomas
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
