Return-Path: <SRS0=Ekfz=33=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B331AC2D0B1
	for <cocci@archiver.kernel.org>; Fri,  7 Feb 2020 06:10:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DE0520726
	for <cocci@archiver.kernel.org>; Fri,  7 Feb 2020 06:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUCItdEo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE0520726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 01769txP025927;
	Fri, 7 Feb 2020 07:09:55 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 87F0777EF;
	Fri,  7 Feb 2020 07:09:55 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 862FE772B
 for <cocci@systeme.lip6.fr>; Fri,  7 Feb 2020 07:09:54 +0100 (CET)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:541])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 01769qJR011243
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 7 Feb 2020 07:09:53 +0100 (CET)
Received: by mail-pg1-x541.google.com with SMTP id b9so552952pgk.12
 for <cocci@systeme.lip6.fr>; Thu, 06 Feb 2020 22:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WXvCAuGoQP5htG9+fAp1LyL2Dhtbc3v/kIql9co2TdQ=;
 b=AUCItdEog9QbsXtbePS9JgG/C47z72vyMgzGdkwBDWb52m5JdKGYsBhOo2aUbc/Tt5
 7rpjAgrmQ4qbSOIqelDtCAaICzJ3BCWMpZwYisz5d9NPzgXE6CXa98dEZBMEVnlN0rx3
 QjaQGZulfbrs3gJJPWutgGJmJTbsvqZrRXreSI03VAwQ+4v3eW6PcZ6IqRy57fr/QtO1
 vqqCPdSaPsyBnYa83oERiyd6JPwiSJ08w7yeP1bm93hG9XcwKwQvtvqLytBvsdsOzHXf
 qgc9HtRuZ9CfGZwEl/xqNzVKXvTQ5wbb5RveI+QETGp2E7PFmUltuMTOX4d6PmVWEFe2
 nYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WXvCAuGoQP5htG9+fAp1LyL2Dhtbc3v/kIql9co2TdQ=;
 b=YvtKxTdtR8PyhWNl9ejDJb2JQyWiEVBHC9MfPFPcNqNj4/5iAvzCyqFGz5ucbkNfL1
 UzDaBrEBlSFBnvb7NUb/Rt9eoyYsj5HUBfFqx/LzthJa/56btdidEg9K0RVpVpMUHpyw
 8WMIcKmnwl0xdjyXMaOL+CZcf93deMiMhDsFHGXQ/KqMW4uiJTiPsmCaJASraTJ79pOx
 uqWIR40Yv+By1l4VCMhLj2Pl1bk/aCj9oms9UvNwbrYbNRsxejs9gG4uknDiUEptVmQQ
 s6ASmfd0P/EXgh2wLD2PTJpzGk8v0t0o5vH66dFq4bH0+5ZjKykGzaebSQLt+EeZzc71
 fD8w==
X-Gm-Message-State: APjAAAXRbV131IyVzQ84E3s4SfFoXy3XSd+mtu1q3usrM1WO9KyjVP5V
 iR6gPxjRekse8CqMBU1Usf7Ume8J
X-Google-Smtp-Source: APXvYqztBrS8ObO1kvBTYbkUnW+FVscKdol8AzQhNt8FBImZQcxCoKNQaSBjp63msi6Pr1lV9HOKyA==
X-Received: by 2002:a63:2782:: with SMTP id n124mr7819216pgn.188.1581055791961; 
 Thu, 06 Feb 2020 22:09:51 -0800 (PST)
Received: from localhost.localdomain ([2405:204:30e:4a31:b268:7a3:7dc6:f288])
 by smtp.gmail.com with ESMTPSA id
 b130sm1243438pga.4.2020.02.06.22.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 22:09:51 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri,  7 Feb 2020 11:39:36 +0530
Message-Id: <20200207060938.9531-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200205130327.6812-1-jaskaransingh7654321@gmail.com>
References: <20200205130327.6812-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 07 Feb 2020 07:09:55 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 07 Feb 2020 07:09:54 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 0/2] cocci: Align the C AST and Cocci AST for
	pointer
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

Changes in v2:
--------------
- Change body and subject of Patch 2/2 as per suggestion of Markus
  Elfring.

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
