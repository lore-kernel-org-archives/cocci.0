Return-Path: <SRS0=IHaO=HN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2915BC433DB
	for <cocci@archiver.kernel.org>; Thu, 11 Feb 2021 22:36:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 721AF64E3D
	for <cocci@archiver.kernel.org>; Thu, 11 Feb 2021 22:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721AF64E3D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11BMa0vS019312;
	Thu, 11 Feb 2021 23:36:00 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 02B0777AC;
	Thu, 11 Feb 2021 23:36:00 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 35CFE3B26
 for <cocci@systeme.lip6.fr>; Tue,  9 Feb 2021 15:57:44 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:836])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 119Evhbj009719
 for <cocci@systeme.lip6.fr>; Tue, 9 Feb 2021 15:57:43 +0100 (CET)
Received: by mail-qt1-x836.google.com with SMTP id b24so3353898qtp.13
 for <cocci@systeme.lip6.fr>; Tue, 09 Feb 2021 06:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:subject:message-id:mime-version:content-disposition;
 bh=hMooT85Sc5x+RmVMhcmxryJGpztQA5X0QVn3RQ2fkuI=;
 b=kLCAcDp2Lul/WQOwGgx/WnlqrC7AhyyILqIfzY3nNW7YZF/TPOlLc4ZNtdyyFBNlOh
 dLfuufcE6Est1hGxQKRdvMiTm3cKTYniGEpJrlrXe2ZW28I2P9DlaLJxmk8hh8yHfOUg
 k6kwX2zOilj6B/BSWFQHMdSMQneFRcSROfwo2j57Q46q81tZXXehJs0oXGMrUtsH9uGX
 aR8rjPzferyILKWdR0gGSE3UJQTafxiGp/CJoyvc1bnTzNOoxWdAXn276/lgUrcGS3p1
 60F25j0qLycspeZKGzvNST38n226fKWfYJq1m9evGiw/TbT66C8yYUysH9LkXqJjcAex
 YzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition;
 bh=hMooT85Sc5x+RmVMhcmxryJGpztQA5X0QVn3RQ2fkuI=;
 b=G4h8NBf0vE1f6TOQjSIFLb0Wd6FfZ/fKkFZFURq7xTnPpyI6QnqD3v65VaO4lDGpFy
 GUKjtbRBkGigER96pxcEUtFrNkurFS3QDnUqM6gkKF83HiQ4GOrBuy+cfDe30bxbmT6g
 bRBdF/Mev6V13msvdI94sF6swVqUD/hkLIVIgoCK/uunm//nIYtehYh38w3SFtoHTH6P
 b/Uk/TQU2iPqHMRUxeyUZOi0pHHCEuj7F998imknCWOgFz7UxWf4F2vORBuXdcatzth+
 YtTohRqp4NtuA931/BzJHrSLRDT1LC5M6qx8QSSO+7BHgD3KjeRa9O+esiopxDCCRHfY
 sN7A==
X-Gm-Message-State: AOAM530Q2MGjatPTFsk+LUXBqBD2gx6gMZkhlk/dD+A4WIzSBJtHnnzr
 W0jTsMRJnSi/KM2oH92bV3q2bevHwuk4uw==
X-Google-Smtp-Source: ABdhPJxhM11YsAMk1SRqS5o3Z1LbhNMbQMpzLv4hdtkuP9nFQf4eTUl5DV0m73V/5bpIQ6nfd47x+w==
X-Received: by 2002:ac8:4d0e:: with SMTP id w14mr10337164qtv.264.1612882662194; 
 Tue, 09 Feb 2021 06:57:42 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:6ccb:4144:540b:3bb6])
 by smtp.gmail.com with ESMTPSA id 196sm19713813qkl.4.2021.02.09.06.57.39
 for <cocci@systeme.lip6.fr>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Feb 2021 06:57:40 -0800 (PST)
Date: Tue, 9 Feb 2021 09:57:36 -0500
From: Taylor Blau <me@ttaylorr.com>
To: cocci@systeme.lip6.fr
Message-ID: <YCKi4Ca0RbcfZLRB@nand.local>
MIME-Version: 1.0
Content-Disposition: inline
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 11 Feb 2021 23:36:00 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 09 Feb 2021 15:57:43 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Thu, 11 Feb 2021 23:35:58 +0100
Subject: [Cocci] Missing package for Ubuntu 20.04 LTS?
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

The Git project recently noticed that our static analysis builds were
failing after upgrading to Ubuntu 20.04 due to being unable to find the
coccinelle package in the focal suite.

    https://lore.kernel.org/git/YCGrmsg8J7XT32TM@nand.local/

Searching for coccinelle [1] turns up hits in the xenial, bionic, and
groovy suites, but not the focal ones. This appears to have been
discussed on this list a couple of times without any conclusion.

Is there a planned release of coccinelle that will appear in the focal
suite?

Thanks,
Taylor

[1]: https://packages.ubuntu.com/search?keywords=coccinelle
[2]: http://archive.ubuntu.com/ubuntu/pool/universe/c/coccinelle/
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
