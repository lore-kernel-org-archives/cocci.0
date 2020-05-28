Return-Path: <SRS0=FJ6B=7K=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023ABC433DF
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:25:19 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 741A020888
	for <cocci@archiver.kernel.org>; Thu, 28 May 2020 12:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NO/g7GNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741A020888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04SCPFuL027086;
	Thu, 28 May 2020 14:25:15 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 836D25D47;
	Thu, 28 May 2020 14:25:15 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3CFFD3E1D
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:25:14 +0200 (CEST)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:641])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04SCPCPs000608
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 14:25:13 +0200 (CEST)
Received: by mail-pl1-x641.google.com with SMTP id q16so11494567plr.2
 for <cocci@systeme.lip6.fr>; Thu, 28 May 2020 05:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zmkWlw6cjzbdMBQ4EEJvo+mhwEmnPJhxR/Fbo4eIk3E=;
 b=NO/g7GNHCyskJevgYt7XJx+1cRE8GGrdDZMKs8N9fMNSA3sUursVU9/P8wlbGu9TGk
 fZTZndEegwETVujKsj9uId3R4FN64V9trlbD4ymrl0n3nqCeTy8qKG1d4F+fln9/TDCi
 QQ/9zEOFRm5yup8wP6Fd291Hqi3zD1QijkxL9ncMbPV/Rz3yHImvBZt74oY+WTnU+z4m
 B8nT2X4256bFBPPk2wF6rCPzaktaL4MAL3VEj5HLooSAGSsAJmZtP6mMd5II4WxG2Bpz
 F1DT8TdeOh5sWfuaePDYLGBMy7aRLRYHtVyaxs7sHzZr8h77IbEY13P8Acx+AK2BZU4h
 BC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zmkWlw6cjzbdMBQ4EEJvo+mhwEmnPJhxR/Fbo4eIk3E=;
 b=BMBFVcyITneHh/DqEb7dT+lrGhdA4i0zlQR6Zq0JxcUO+h0eFoIspAyIKfsUmTwRQ8
 xhZwWP79C7WKsEGOYiwW9141Y0GQNbaslzH5baoi4LdAM4BezgtIUmbczmoqYvt53vRu
 wqPEZUYogGhLKmv5dixgJ47LtvZvASHw1WOG5B4boEgIcHtk52IdsRSQ0sahnI9qQ+Ct
 zixVXVxwOirvla48S997xhFGOJt7P8YWg4EAQF/5SDCaqL9UvQNrM3awYpap7Xj9EpWt
 K1SQutMShVuQjTfvhEWlZz3AkAQp3ADqHdde8p++AoCGUbexktJIap9PKsB3L74L7JMH
 6xmA==
X-Gm-Message-State: AOAM530oIJqDxgR1fn1Nd4GQ1l1ff6obhOe0V4idq0Fo2WrGIsidBJiD
 +6B0y1565vuOHIseZK5QyOHjYXJ5
X-Google-Smtp-Source: ABdhPJyEuiFGIK+jiJpBwmpySMoWEqzyP/bDMc/3Iss+XtYZaPi3VcJp58HgAdtZv/XPZkAxkcKlbQ==
X-Received: by 2002:a17:90b:fd4:: with SMTP id
 gd20mr3576098pjb.181.1590668711670; 
 Thu, 28 May 2020 05:25:11 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2183:e360:deba:7bf4:98ef:5568])
 by smtp.gmail.com with ESMTPSA id 1sm5722888pje.26.2020.05.28.05.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 05:25:11 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Thu, 28 May 2020 17:54:11 +0530
Message-Id: <20200528122428.4212-10-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
References: <20200528122428.4212-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 28 May 2020 14:25:15 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 28 May 2020 14:25:13 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 09/25] parsing_c: parser: Handle
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
index b795f3a0..684ee63e 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -1553,6 +1553,17 @@ decl2:
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
