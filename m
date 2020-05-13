Return-Path: <SRS0=ftTc=63=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB50C2D0F8
	for <cocci@archiver.kernel.org>; Wed, 13 May 2020 07:30:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86E57205ED
	for <cocci@archiver.kernel.org>; Wed, 13 May 2020 07:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWRx6W1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E57205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04D7U96p016586;
	Wed, 13 May 2020 09:30:09 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 400B27559;
	Wed, 13 May 2020 09:30:09 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1F3063DC8
 for <cocci@systeme.lip6.fr>; Wed, 13 May 2020 09:30:08 +0200 (CEST)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:544])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04D7U66q018674
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 13 May 2020 09:30:07 +0200 (CEST)
Received: by mail-pg1-x544.google.com with SMTP id j21so7401217pgb.7
 for <cocci@systeme.lip6.fr>; Wed, 13 May 2020 00:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zSfbyX5r9kKigKF1re6aCmb7I64eRlSnc/rXxdxVCoI=;
 b=pWRx6W1li4PaG1lpEBYZvLdYs7ecG2XArFvTx/iud6iIKzQd578GRoEeblfg/dk5MK
 t8YHCNlQEsfvOWCnt44mMtMytDROJ1+3bnS5hNIfBAbCwE6vrwivn3NT4AlF+Ozm4qj4
 1/1uIAYjostQtw5yqaAg6HHUR3++RkVm7ERGkqi+cCROdGKRHHQRb4kQfZ9SPz904wKp
 vo7FhO4XevgsXSYnJPuh+C0yVdL3MY/RQCZGZd3+Gdmx8iTVQGNtnXoPKZMsbT6+3mpo
 X7H+j49ODzVyj5pi6voNlPUoGDPQePIYwq2witNzYQMZPlJUEEBPR92NLOUTF6xEYMLY
 a4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zSfbyX5r9kKigKF1re6aCmb7I64eRlSnc/rXxdxVCoI=;
 b=UfuXV+c7I1c2G+B0RriY5tsYy57BxMYjgupBcoqG4Lpmx8X6UX4iBY5IJ/6wcSXSEj
 /qc9bwMq2wT6VCMqxjIYcMNQ6eac3iyhOrnw+Gs/HLeN+CWhJHbJKWdW89sS4+xmsKzh
 wuuZ6tj/kTTX/CO8ytaUyTkezHLMKXfluWqwg7uYCCt0aH4nc48vPTG2CXQSuCA7IE6q
 nOjmCVpdN+HaA4d54TJTkL/evHTGnVU6rDSetvB6DCZ6Wokg8GBbu44oRO5GsHSn/Xn6
 h0iClY+W2kyuAYvRCROHxkMzmDHgYfSfUxvXY1p3EY7McaDMM3EAxb+gt/BNkU87OCFP
 CDhg==
X-Gm-Message-State: AGi0PuabbPAYovgAVLqIvJYGn46UBQV1ExbUkSEIKKbCoC/zrK7Em20Z
 rqOGxeEpCCCjhhGb5TekbYKITGYDrmM=
X-Google-Smtp-Source: APiQypKxOKKezC9LSqoQNMq8pfb8WqigTi3QpWP4cDtN8ORzmT+N6Q29QlwObpPI/KIj1eBTghBmQg==
X-Received: by 2002:a62:6186:: with SMTP id
 v128mr24091199pfb.185.1589355005643; 
 Wed, 13 May 2020 00:30:05 -0700 (PDT)
Received: from localhost.localdomain ([1.38.219.254])
 by smtp.gmail.com with ESMTPSA id n9sm14852828pjt.29.2020.05.13.00.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 00:30:05 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Wed, 13 May 2020 12:59:49 +0530
Message-Id: <20200513072951.3453-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 13 May 2020 09:30:09 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 13 May 2020 09:30:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 0/2] parsing_cocci: Fix struct pointer funcall
	regression
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

This series is a fix in response to the following bug report:

https://www.mail-archive.com/cocci@systeme.lip6.fr/msg07332.html

The following commit:

	c280375635f62dfbe052709e4e47a82140d32ce5

Introduces a regression in the following SmPL use case:

	@@
	struct s *x;
	@@

	x->func();

Where x is a pointer to a struct and func is a function belonging to
said struct. The faulty commit mislabels func as a function prototype
due to a missing case in the function-prototype-detection match ladder.

Enclosed in this patch series is a fix for this and a corresponding test
case.

Jaskaran Singh (2):
      parsing_cocci: parse_cocci: Fix struct pointer funcall regression
      tests: Add test case for struct pointer function call

 parsing_cocci/parse_cocci.ml |    1 +
 tests/structptr_func.c       |    5 +++++
 tests/structptr_func.cocci   |   12 ++++++++++++
 tests/structptr_func.res     |    6 ++++++
 4 files changed, 24 insertions(+)



_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
