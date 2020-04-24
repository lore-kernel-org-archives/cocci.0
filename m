Return-Path: <SRS0=cw0N=6I=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20512C2BA1A
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:19:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 933A020774
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 09:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Llo2AcDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 933A020774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03O9J7vG028713;
	Fri, 24 Apr 2020 11:19:07 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C191D7827;
	Fri, 24 Apr 2020 11:19:07 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 67E777815
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:19:06 +0200 (CEST)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:441])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03O9J4Wi009248
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 11:19:05 +0200 (CEST)
Received: by mail-pf1-x441.google.com with SMTP id d184so4528710pfd.4
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 02:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s+AcX5825VBIdlBbtw9jwikYvEvBRgXbpwVmNkVuuh4=;
 b=Llo2AcDjr/r5wde+HpBRM2B/ksMMmQhfqPpFEWuPRXtZXkYhppUHzWfSsQmqi9GwhY
 Vlcl/Ztqn2O7YkAdISVjI52z6P1f/zuEhGTKfGPcjiroD+7XoNs9gubkC4ZUZpY5xPjU
 ipSuqpHtcSD4IOyFRIvtcB50rX7pwNkNnFpEV9tSxNYf/FPR448u7bPiNs60DLBExZSw
 6nQOXVnxkdiAG6lYXqBzIr4bHWdjoVGX0I53KoFi7dTpe7yFPPDLjmQeyzErTdvl8ak+
 /wxZmbbioykv6iB5IQISPd86YI2/mg2g5PxNCuOlN4i/0dXhllsmGk41ctm949k5NcFM
 fIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s+AcX5825VBIdlBbtw9jwikYvEvBRgXbpwVmNkVuuh4=;
 b=Z4G/HOi3L6MqwzopHSPE6QQbowbxpfmyet/V7NhQ2/qbBl9aESjab+SZE+he8q2Oh0
 vzddECTxEtGsEEXBZdOOjzDk51fDWftpjrN+OFpusc6FiR1x8gFbP/dpOcfQ8y7tWpDv
 WeQmLQM0cqD349ax4aOLtNE6HyNc5X8fSn4dCDvWfyVNuvE3pIXah8VgSbYa8jGV/vX1
 aCPNUG8FiNJkl2qV3cUCtOoVZ7jPsoLnA8u23QiOoFhJFtG7aPKkRMLhdi8quiTmxb34
 brCyVGmkRZjBGi4xSBxRVtz42nNZCYHFdOWowF6pcNetL9XhQBzIu9c5V3S+W9Ee02+8
 5Eyw==
X-Gm-Message-State: AGi0PuZiklaclc+RAdTEVhKtGc+CItb5CQsGHrvBLZ3UOCK9l825BB9T
 2FTd6oR+uSC5h9tjseDUv0H19gW0AzA=
X-Google-Smtp-Source: APiQypKZKlZ2BfCdMjzhfBBDgWWGKEq/naMo/kFWGt5tH9C8zFfp0gTEEZP0u8iLCcbIaRltbwUpfA==
X-Received: by 2002:a62:e50f:: with SMTP id n15mr8147696pff.22.1587719943899; 
 Fri, 24 Apr 2020 02:19:03 -0700 (PDT)
Received: from localhost.localdomain ([1.38.216.60])
 by smtp.gmail.com with ESMTPSA id c80sm5043933pfb.82.2020.04.24.02.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 02:19:03 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 24 Apr 2020 14:47:45 +0530
Message-Id: <20200424091801.13871-10-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
References: <20200424091801.13871-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 Apr 2020 11:19:07 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 24 Apr 2020 11:19:05 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [RFC PATCH 09/25] parsing_c: parser: Handle
	struct/union/enum end attributes
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

As per GCC's C grammar, the struct-or-union-specifier and enum-specifier
have the following productions:

   struct-or-union-specifier:
     struct-or-union attribute-specifier-sequence[opt] gnu-attributes[opt]
       identifier[opt] { struct-contents } gnu-attributes[opt]

   enum-specifier:
     enum gnu-attributes[opt] identifier[opt] { enumerator-list }
       gnu-attributes[opt]
     enum gnu-attributes[opt] identifier[opt] { enumerator-list , }
       gnu-attributes[opt]

Add a production to the decl2 rule of Coccinelle's C parser to handle
the end attributes here (i.e. gnu-attributes after the } ). This parses
the following C code from Linux v5.6-rc7:

  drivers/net/wireless/broadcom/b43legacy/b43legacy.h

	struct b43legacy_iv {
		__be16 offset_size;
		union {
			__be16 d16;
			__be32 d32;
		} data __packed;
	} __packed;

  drivers/scsi/myrs.h:

	enum myrs_cmd_opcode {
		MYRS_CMD_OP_MEMCOPY		= 0x01,
		MYRS_CMD_OP_SCSI_10_PASSTHRU	= 0x02,
		MYRS_CMD_OP_SCSI_255_PASSTHRU	= 0x03,
		MYRS_CMD_OP_SCSI_10		= 0x04,
		MYRS_CMD_OP_SCSI_256		= 0x05,
		MYRS_CMD_OP_IOCTL		= 0x20,
	} __packed;

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parser_c.mly | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
index 8def5f0d..99ceb359 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -1554,6 +1554,17 @@ decl2:
                 },[]],
                 ($2::iistart::snd storage))
      }
+ | decl_spec end_attributes TPtVirg
+     { function local ->
+       let (returnType,storage) = fixDeclSpecForDecl (snd $1) in
+       let iistart = Ast_c.fakeInfo () in
+       DeclList ([{v_namei = None; v_type = returnType;
+                   v_storage = unwrap storage; v_local = local;
+                   v_attr = fst $1; v_endattr = $2;
+                   v_type_bis = ref None;
+                },[]],
+                ($3::iistart::snd storage))
+     }
  | decl_spec init_declarator_list TPtVirg
      { function local ->
        let (returnType,storage) = fixDeclSpecForDecl (snd $1) in
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
