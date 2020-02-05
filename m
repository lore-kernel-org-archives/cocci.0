Return-Path: <SRS0=pTva=3Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84176C352A2
	for <cocci@archiver.kernel.org>; Wed,  5 Feb 2020 13:04:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21A27218AC
	for <cocci@archiver.kernel.org>; Wed,  5 Feb 2020 13:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qkZaJOs1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A27218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 015D3uK6029816;
	Wed, 5 Feb 2020 14:03:56 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7B302772B;
	Wed,  5 Feb 2020 14:03:56 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C6CDC7718
 for <cocci@systeme.lip6.fr>; Wed,  5 Feb 2020 14:03:54 +0100 (CET)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:544])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 015D3rwF026843
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 5 Feb 2020 14:03:54 +0100 (CET)
Received: by mail-pg1-x544.google.com with SMTP id z124so926251pgb.13
 for <cocci@systeme.lip6.fr>; Wed, 05 Feb 2020 05:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vRF0BUgGDS22Q7Mf+gFVNCWsGmQAC8EV74GME1B2LTo=;
 b=qkZaJOs1E3zcrSHMrSdmvNUb7TYNF71HkWFOfvOPw09FzI4FGQef2Y32n6kkLSnug6
 ME5692GQt4hKUMQDIh6bjl6NPztVI5K94AgtV704VZgUchRr0SedvBlgUvRfDwnIRvje
 r1CJ71U4E2G1l8SaQ9tXvPux/5u5OE+272Fqbt4HjcsNEwc+BPrHuIDHiVLsFy5vr2aZ
 YFqpk0yoBGW5p0IUymSCIY/PFYsmxXjtO2/rwPkhAw0wAd0UeX9q21Sp7g9IV+i7d3hP
 SHg6Y9W2/utWF1iILBs0ObKzULGst+1tB1+9xPzXcfWRYDwQPfE5+NqdTiASt7tVSIYw
 1kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vRF0BUgGDS22Q7Mf+gFVNCWsGmQAC8EV74GME1B2LTo=;
 b=WZs+ghyOGk988q/1bJJM3qyfqaM2gXCWsUPdWgBbHJ9f5zjVm3ukmCbJJlwBc2iXwS
 Tf2nQv/5FDxKsgBwLNmWSQ6T+MsgE77VSIcR+tmERjL0dS6nPYVyxtNFOn3MiXU8y9zY
 +gOlENWB0i9IFnEs8AjpajfrZuSPwWYRF1lTH4nHfRXF3ReGfIrea918jslRoZGCHHF8
 HlsDyefd45xWrHvxvFf/sy7aY1sF+Lb5VKXQ+I7QJpPt1cg7JkfgiMaztyzqlEURk/RE
 8jm0XuWvHUsVwi6/IZ3Juj4fgdAlCOQq+4xHZxzer0uC/KtGmRopb3ckVkGn2MAhjrRQ
 gBEA==
X-Gm-Message-State: APjAAAUYxzqZ8CNTFaF0P7UQjnDoBpRSxhX3grYy5q7Oo65n/K3ei0LH
 sZQTfT2rKYBOrswburWeNXVjfL2s+/Y=
X-Google-Smtp-Source: APXvYqzZb3QsqhyiUY3XOg48gvZlJJOVhilvJuYQaA9LpOQoA3tKrSJUe/IL9LaKcS0rsSCfBmONow==
X-Received: by 2002:a63:e04a:: with SMTP id n10mr35898354pgj.341.1580907832410; 
 Wed, 05 Feb 2020 05:03:52 -0800 (PST)
Received: from localhost.localdomain ([2405:204:30e:4a31:b268:7a3:7dc6:f288])
 by smtp.gmail.com with ESMTPSA id
 q6sm28137098pfh.127.2020.02.05.05.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 05:03:52 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Wed,  5 Feb 2020 18:33:25 +0530
Message-Id: <20200205130327.6812-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 05 Feb 2020 14:03:57 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 05 Feb 2020 14:03:54 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 0/2] cocci: Align the C AST and Cocci AST for pointer
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

This series is to address the type matching problem in Coccinelle.

Patch 1/2 is for aligning the C and Cocci AST so that
pointer to const pointer and its variants can be matched.

Patch 2/2 consists of a test case for matching a pointer to
const pointer and its variants.

 parsing_c/parser_c.mly      |    4 ++--
 parsing_c/pretty_print_c.ml |    6 ++++--
 tests/constptr.c            |    7 +++++++
 tests/constptr.cocci        |   19 +++++++++++++++++++
 tests/constptr.res          |    7 +++++++
 5 files changed, 39 insertions(+), 4 deletions(-)


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
