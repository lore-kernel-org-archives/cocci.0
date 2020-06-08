Return-Path: <SRS0=02ua=7V=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27C9C433E0
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 12:20:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B8C12074B
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 12:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gx4E4GWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8C12074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 058CKvPm018888;
	Mon, 8 Jun 2020 14:20:57 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 302CC7783;
	Mon,  8 Jun 2020 14:20:57 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 93E4644A7
 for <cocci@systeme.lip6.fr>; Mon,  8 Jun 2020 14:20:55 +0200 (CEST)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:541])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 058CKsdN004712
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 8 Jun 2020 14:20:54 +0200 (CEST)
Received: by mail-pg1-x541.google.com with SMTP id d10so8683323pgn.4
 for <cocci@systeme.lip6.fr>; Mon, 08 Jun 2020 05:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fSK2B+hLSgYiVV+I2Y1lJ4NYKoBsUNBdl8adOpxXfoM=;
 b=Gx4E4GWJBWIBEkmbI4Ttk/o7sW0G7uCg+mqTarU+OdhDJaZV7uxKBwkuDh4uxmQm1y
 9Ik0IJr3clWL/oX6Y1F2Rhp20NN8fcG5D+awd6kYbn3SzCE3674qfXXD3QJMBuF1hmdd
 U6g+dvaY7QTK9icXwNlM7MA8jj2pAl8k6/F2M/YuPTUt/Be932oYQ4z/E1wqAgOVcnYH
 IbAybsZzsYWfEcrZ5zlj2MF6ycKbMTHW2lylR/q7hfeY6jsLVrPAgET5aWNlOR4khKKZ
 0Uy5s9GMSt97nfpmveinud0K2fNOHSytC2D0ALa70wgy/tPSLf76xo1eF/njzBZ30eZo
 UnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fSK2B+hLSgYiVV+I2Y1lJ4NYKoBsUNBdl8adOpxXfoM=;
 b=Cpsao5kiehg+7ffScAFzCeITgsvyQrIrR+sseLNcyot00Lz60hLYA0wb3S/sJqHfRC
 0B0k+qjf4HdT+aznQoyQ+03rZm4/1cgZYVyf5FcNoaOY8tiCLfwaEcJIsTLdLwiYRaDi
 jv7cPpSpe6v2AJGOGvzF4TC4p+k8+CvjgJ0F02kKyFD67SNIXLZnN7T31iWiQb9J/qbx
 ysGiPeq+UdCPq9CNeSqqmyD2454GCW5Xf29TN5QhmdK8mcaPXhp0Fqz/kiXswU9IksTJ
 t44Pa0Z4/elZPIPCNN3ifCPaOTKMi/gk54wCKv4PUyFSBGV3cGFU9ujw5yQpR+Oyg/qv
 AMIg==
X-Gm-Message-State: AOAM530Q5iTWtd7u3xwdH5EUnRoU4TU7WcPZjXjvk3vMmz4V1H87j4jl
 79/ouJ4l+0TpfNUxB1Zmn+5QclTV
X-Google-Smtp-Source: ABdhPJzoQqDH2Mf3SRzOajFfM0XalI3D1XIysA6EN4vZjugw4o0jqs5maXDXfjlaLyoD06Pi3VeZFg==
X-Received: by 2002:aa7:9e50:: with SMTP id z16mr19969329pfq.118.1591618853328; 
 Mon, 08 Jun 2020 05:20:53 -0700 (PDT)
Received: from localhost.localdomain
 ([2402:3a80:1863:7add:d8e9:7114:e8b0:51a9])
 by smtp.gmail.com with ESMTPSA id i5sm15747657pjd.23.2020.06.08.05.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 05:20:52 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon,  8 Jun 2020 17:50:34 +0530
Message-Id: <20200608122037.28019-2-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200608122037.28019-1-jaskaransingh7654321@gmail.com>
References: <20200608122037.28019-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 14:20:57 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 08 Jun 2020 14:20:55 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 1/4] parsing_c: parser: Add end_attributes_opt rule
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

A lot of redundant code is introduced in the C parser due to additional
productions for end attributes. Add an end_attributes_opt rule to
resolve this.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/parser_c.mly | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
index effd0727..78407844 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -2542,6 +2542,10 @@ end_attribute_list:
 
 end_attributes: end_attribute_list { $1 }
 
+end_attributes_opt:
+ | end_attributes { $1 }
+ | /*(* empty *)*/ { [] }
+
 comma_opt:
  | TComma {  [$1] }
  | /*(* empty *)*/  {  []  }
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
