Return-Path: <SRS0=02ua=7V=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FB8C433E0
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 12:20:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 122A22074B
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 12:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIUAfM63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122A22074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 058CKrJF006430;
	Mon, 8 Jun 2020 14:20:53 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B1A227783;
	Mon,  8 Jun 2020 14:20:53 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 827AB44A7
 for <cocci@systeme.lip6.fr>; Mon,  8 Jun 2020 14:20:52 +0200 (CEST)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:444])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 058CKokx003559
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 8 Jun 2020 14:20:51 +0200 (CEST)
Received: by mail-pf1-x444.google.com with SMTP id 64so1613749pfv.11
 for <cocci@systeme.lip6.fr>; Mon, 08 Jun 2020 05:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NUHy8/ZD3/5DB3SagOLVHSDA2Gz3iOMx1TRgvgm8zm8=;
 b=lIUAfM638IJKndbvpf1I7Yn+LtWXZWOvffQYObnlxKzpkRO21F5+PFf8BInaOuKni4
 0Htl+8366xEehLlwNwHgGJEzRrYJAkH28e6z3NGSurqRVzSwvb5rqL0C3uTDT+UMl/0Q
 MErXTu9HjlaVrvEppJahCbxHP9BT64XrD2PLoMdn37MX9Wvqzjx5Cy7Ku2QKzOGiimp5
 SDmBuhW/fTU+jblZIcuuKNhnxKC2YcvvqM2NTFciB7fpAuYG4tt1uMwQP71NO/KG2YSA
 UTTnPn6SXH33gVHdEoCM+oZNXtY1ljmpK5/rutLKW4o3k0J2LqC5fyJ4SIgoJxPf9IY1
 sGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NUHy8/ZD3/5DB3SagOLVHSDA2Gz3iOMx1TRgvgm8zm8=;
 b=DpMBOS3n7t/+3MQOumvQYiPgGwlGAE/gYVwzAqizQn6aNh0oW7lD66FARDg+3F1HLJ
 Tp2Syg2/qF9jNEum3DSQ5CJtnkQ3cBvpxEnIm9ZM2LDiRfJd3CHCH7lqkrgxkFw7ogkR
 COUEaByN/B5Wr9Fv7SuC8XDGj2r3en/0VfFCOEpHKX7C3IpDwf77fUYql4nC4TlRgqdl
 6Pv7GzYjqG7kCDLAFn7/Fl9kkzcXJjITHhBAacqfVjuhr+P13zXCK23cVAO1OnX/1xxM
 zh1hPapUDxXAuocE3TsFIoI24UTTvl/yXDOMNaAwDVlgTYsFTgrgoChRejRJxXyxUE6e
 PJaA==
X-Gm-Message-State: AOAM5304dmqLl57Xc12ky/nt2wdiZWqq7IFfdw80c3f1jz2zE9fscMEq
 /POnuZvVh83Q4DL8jT+Vkc4BKwyG
X-Google-Smtp-Source: ABdhPJwOFZbHxZHeDDWa3YUg7Pgfc9KmDVhvD3dyKGdLQvvKT2Xa34IZtAEhJRdM5g4f9HDlMk7xMQ==
X-Received: by 2002:a63:7788:: with SMTP id
 s130mr19482086pgc.182.1591618850044; 
 Mon, 08 Jun 2020 05:20:50 -0700 (PDT)
Received: from localhost.localdomain
 ([2402:3a80:1863:7add:d8e9:7114:e8b0:51a9])
 by smtp.gmail.com with ESMTPSA id i5sm15747657pjd.23.2020.06.08.05.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 05:20:49 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon,  8 Jun 2020 17:50:33 +0530
Message-Id: <20200608122037.28019-1-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 14:20:53 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 08 Jun 2020 14:20:52 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 0/4] parsing_c: parser: Add end_attributes_opt rule
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

Patches for improving the C parsing of attributes[1] introduced a lot
redundant code in the C parser. This patch series resolves this by adding
a rule for optional end attributes and merging the redundant code
together.

[1]
[PATCH v2 00/25] cocci: Improve C parsing of attributes
https://lore.kernel.org/cocci/20200528122428.4212-1-jaskaransingh7654321@gmail.com/

Jaskaran Singh (4):
      parsing_c: parser: Add end_attributes_opt rule
      parsing_c: parser: Use end_attributes_opt in decl2
      parsing_c: parser: Use end_attributes_opt in field_declaration
      parsing_c: parser: Use end_attributes_opt in cpp_other

 parser_c.mly |   96 +++++------------------------------------------------------
 1 file changed, 9 insertions(+), 87 deletions(-)



_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
