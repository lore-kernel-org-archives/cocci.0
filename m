Return-Path: <SRS0=TTUf=7S=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F97C433E1
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 13:44:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09AB5206E6
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 13:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHN7rrXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AB5206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 055DilLf028604;
	Fri, 5 Jun 2020 15:44:47 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B4EDD7567;
	Fri,  5 Jun 2020 15:44:47 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 336363F9A
 for <cocci@systeme.lip6.fr>; Fri,  5 Jun 2020 15:44:46 +0200 (CEST)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:644])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 055DiiPF002547
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 5 Jun 2020 15:44:45 +0200 (CEST)
Received: by mail-pl1-x644.google.com with SMTP id bg4so3661375plb.3
 for <cocci@systeme.lip6.fr>; Fri, 05 Jun 2020 06:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mM0yEkzigxdxEBTLGKgE+cLixX23avYYOLyrqBoWtNw=;
 b=EHN7rrXH+n6NJOiBwQ9BJvdnDnS7AfK/R+UKibVs6iE0Ub+oPyp+kCBqDuS73mzoQO
 +i2C9im0YE7dKhZNTmRugcM0WxwsRX+EY4jjtubCQruYjQKIKqwjW2V6mdmAc7fYxcBD
 tKi1jTSrBaiucLE+ndKtZiRrnsepWvsTFvRF1O4ODfh3JlJjIjT49++698eIH5ZviMv6
 KSAirShnLDqKT04gDuca+5lESkZFWwptDXsymJpngliSKMiYwhjhGgSnY1C4u2WpS5jx
 AzzFYOMYrYykcM3PPs+WVECBJwrHc/MvIAy+jlmOZRcdzCfcAT5cyP3j0Ap/ACYFnjHr
 YVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mM0yEkzigxdxEBTLGKgE+cLixX23avYYOLyrqBoWtNw=;
 b=AHM3ro2YM6DlhMkhHLpPmgsDbJ2LxYgQMGj+f7iNLnUtixzs0pie2bb51Ui459k1Qy
 mjGxRdxJezNCHtYydcevG3FlfugaxcINg3z6V9H57nqrNOtpjoPtQskV/t3iL3IoBcNC
 oXAeO/yiwEZs/GNtxgM+5ccxz25rEb5uvIDXys8JA1aPUJyir/V2nuguZ1gxD4HXuZaE
 zMckJoL/fBbbHqed/sGUJkYSzp4dVmKPV6JAvVZ58Np3eKpCceJ146iJmNKfEzqKyF16
 Tl7AQ5G2DEWun+6q70vFXZbckDyEzbwE2d6jjCINYQJjtiBiMhe+UAfFLHNhxbsRr5Ws
 OHMw==
X-Gm-Message-State: AOAM531lk+Nt9DcEjRgNS4Mf97j72cbKw87cVeqs9Akd6/EMGmI/I+wv
 Xhf9EGiDDpJR4j9edka6IWQgFaFOYLg=
X-Google-Smtp-Source: ABdhPJwEq9LltdJj89b9nPUZaDgiKosPSHexCQubgcmbf5dcVTdoOldEh7OtS2GRrsDd92PiMI+IuQ==
X-Received: by 2002:a17:902:bf46:: with SMTP id
 u6mr9778921pls.302.1591364683517; 
 Fri, 05 Jun 2020 06:44:43 -0700 (PDT)
Received: from localhost.localdomain ([1.38.221.125])
 by smtp.gmail.com with ESMTPSA id w186sm7861353pff.83.2020.06.05.06.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 06:44:43 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri,  5 Jun 2020 19:13:18 +0530
Message-Id: <20200605134322.15307-11-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200605134322.15307-1-jaskaransingh7654321@gmail.com>
References: <20200605134322.15307-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 05 Jun 2020 15:44:47 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 05 Jun 2020 15:44:45 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v4 10/14] parsing_c: parser: Handle
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
 parsing_c/parser_c.mly | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
index 5b7e1faf..3412c34e 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -1542,16 +1542,16 @@ abstract_declaratort:
 /*(*************************************************************************)*/
 
 decl2:
- | decl_spec TPtVirg
+ | decl_spec end_attributes_opt TPtVirg
      { function local ->
        let (returnType,storage) = fixDeclSpecForDecl (snd $1) in
        let iistart = Ast_c.fakeInfo () in
        DeclList ([{v_namei = None; v_type = returnType;
                    v_storage = unwrap storage; v_local = local;
-                   v_attr = fst $1; v_endattr = Ast_c.noattr;
+                   v_attr = fst $1; v_endattr = $2;
                    v_type_bis = ref None;
                 },[]],
-                ($2::iistart::snd storage))
+                ($3::iistart::snd storage))
      }
  | decl_spec init_declarator_list TPtVirg
      { function local ->
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
