Return-Path: <SRS0=PnfW=3F=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC93AC33CB1
	for <cocci@archiver.kernel.org>; Thu, 16 Jan 2020 10:45:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8522077B
	for <cocci@archiver.kernel.org>; Thu, 16 Jan 2020 10:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBCZDkus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8522077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00GAjUaU024852;
	Thu, 16 Jan 2020 11:45:30 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D661577E5;
	Thu, 16 Jan 2020 11:45:30 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B6FA7771F
 for <cocci@systeme.lip6.fr>; Thu, 16 Jan 2020 11:45:29 +0100 (CET)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:441])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00GAjOUA017404
 for <cocci@systeme.lip6.fr>; Thu, 16 Jan 2020 11:45:24 +0100 (CET)
Received: by mail-pf1-x441.google.com with SMTP id q8so10024077pfh.7
 for <cocci@systeme.lip6.fr>; Thu, 16 Jan 2020 02:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=myF5TN/7ur/WUYuYxuyA6SqDr8NqYTmAOXQeQUpziIg=;
 b=nBCZDkus0IUdF35V5zeH+7cyEkvYJqGYtOBx+NsB0lyUFtVC0iWiGpd/yjNkwNs2tq
 QQxBbuZvf0GtFVYKlb8Pxr4lUvA6xPfWn1+XQRNRj3PaqT5vBY6E7lvEH//X80+6aYzP
 oTR1le3tt9rgz4GB8VCkTT2HyF9VqX5bXUiqZe9QlyUXyvldQ+K0eOZjS0b+kym0nj3z
 kn3jz+pdy16Mx7tS6jSHwn8g1n4rZantkOypU7gW9wsXDs7ZQS+ZTx5ATOXZYUjnx+HY
 hU06oFNebgIpirlPR7EFE0igVTRCyr27frsePGc0eA6bi4IbL7bHvGnUkybp3WTIKP4p
 L62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=myF5TN/7ur/WUYuYxuyA6SqDr8NqYTmAOXQeQUpziIg=;
 b=f8Sba9tmX+adiGw/yWCMtKbjqKd2qV3xgCnEDK0DUBpdJs4wLFMSO+ON2gfrU5rU4X
 C/6ln2iNnmGoVUhDDkbTIAk/4jU6nAUKLC8952zZg3X3B9jo6vFKnODzCJMw4ih3u7Of
 TB+FWUynOwwGTeIFWyjeksdK1/+wkCN643iazrybMPn1/LfWOlWeNqr2gHntd05TGHjD
 OSa1dFyPdw/IufvEfU21vQWyhd320oL3UlfjsrOLgCFZXyYLjrZqW+bEE1Yim4B9mrnK
 +yAh/hjuf0YwQJU59peX8f0fxsoN+WWU6t4x85en/aiXxET3ZQgRw4Ce/HY/ZJSHrPIK
 qGRg==
X-Gm-Message-State: APjAAAUyCUXWCWaWLJ50nyKRATvO/ixueSfF0VZc1uIM2dZXdH85D+cB
 iTYrIgHV8UFvmewvwsrBSWR1KRxV
X-Google-Smtp-Source: APXvYqyZQx69I9NcKcWF1Qgu7oR/P7vhMeaDo3F4nxpKOQR999jbdIdvDh8IRy5Ltsv1jlHZuRKckQ==
X-Received: by 2002:a63:6c03:: with SMTP id h3mr36473536pgc.19.1579171523436; 
 Thu, 16 Jan 2020 02:45:23 -0800 (PST)
Received: from localhost.localdomain
 ([2402:3a80:1677:7d6f:b2c8:b07a:d4f3:9a2c])
 by smtp.gmail.com with ESMTPSA id a69sm25948799pfa.129.2020.01.16.02.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 02:45:23 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Thu, 16 Jan 2020 16:14:46 +0530
Message-Id: <20200116104448.15539-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200116051843.3328-1-jaskaransingh7654321@gmail.com>
References: <20200116051843.3328-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 16 Jan 2020 11:45:31 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 16 Jan 2020 11:45:24 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 0/2] cocci: Add space for tokens after *
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

The Pointer cases in pp_type_with_ident_rest and pp_type_left of
pretty_print_c.ml sometimes do not add a necessary space, if there
exist tokens after the *.

Create changes necessary for adding this space and add a test case
for * const *.

 parsing_c/pretty_print_c.ml |    4 ++++
 tests/ptrconstptr.c         |    3 +++
 tests/ptrconstptr.cocci     |    7 +++++++
 tests/ptrconstptr.res       |    3 +++
 4 files changed, 17 insertions(+)


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
