Return-Path: <SRS0=43Z/=6Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F85C54E4B
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:08:55 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE1520720
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ns+maKkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE1520720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BA8hsY024097;
	Mon, 11 May 2020 12:08:43 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8D0E03E6B;
	Mon, 11 May 2020 12:08:43 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3A5CE3DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:08:42 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1043])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BA8e83020664
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:08:41 +0200 (CEST)
Received: by mail-pj1-x1043.google.com with SMTP id hi11so7617156pjb.3
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CNxRdEPW7QUn5zzPjSnEIhrS6dlbepskoBKaR1q3VWc=;
 b=Ns+maKkwcXy6E+mD7riPiMPIdNyliLal/ib4IosMJsbx2gtRreFqW/Neb7NNptNyIy
 CrMhcAvCfYqWTS7h0QfgPq3oZcXvktAWX8KF0zvMWYvPTG+HosPus80XJCC2EyIADGmF
 AL9hnXfc0/ntYLaIFLB02TMbNltoZb2rLMg8QUUPuXvumuY4p+TQ/kbT2KwIbCmIp4A1
 kMKfe5olQBwLInmcHmPmLAqhxq4684aluvBum9RRaz8ZqRy7e5TtiaX8ruxv/tskhoBw
 t8GFoFqFLuzj9H5Cf0b1BeyYCAmjPxFofMFXvSKgpEHYTM2bFNjfzqxWIm7a36xjaDqq
 tuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CNxRdEPW7QUn5zzPjSnEIhrS6dlbepskoBKaR1q3VWc=;
 b=FRnoz1HKN+By/rOAx2rVG8Gwf+Pi9FK7stUvPA76jPpQaunGxHXc/M8FAEfqKWsm9u
 4u8kWiMglNoGiEmGWsUK53WBaGrSiA279fasbP3+VyNsMBVIsfccJkQY/DNVlqAau5sV
 +eQIdzueWJpQmIKR6HLtXwwrRhuwTpYvyCSrKUv38t+pONMiaGvFyzNBwU5PlF941yI0
 cN7O9Fj6m3T2b6kAdmQejAJAaGtvypZ4v1vaYEWda6BBa0VihMPOpeyaNga2/dhcWA1J
 8iXL5e6PLpeXoq/Og0MGIgnzPNTPR7EWld0r6kfF4l+UubsygHSPxrbicCIAt87tUowC
 ARlA==
X-Gm-Message-State: AGi0PuZjx3zRQVQ2GWjN5uNfaejlcMWpOBR+oHCfwZnnmszcW1fhuFby
 M+V0oZgDFiiQXpWt2oas6xvQtLDdXLE=
X-Google-Smtp-Source: APiQypIRq6AueBKrZdNosE7voZobnXRbBffIX7jTfERBttF+h5Zd4TJ/Vz3ktQNYsJtSU1EAVrMV6A==
X-Received: by 2002:a17:902:b40b:: with SMTP id
 x11mr14485899plr.174.1589191719791; 
 Mon, 11 May 2020 03:08:39 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 o99sm9772994pjo.8.2020.05.11.03.08.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:08:39 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:36:59 +0530
Message-Id: <20200511100715.19819-17-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
References: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:08:43 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:08:41 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 16/32] parsing_cocci: pretty_print_cocci: Print
	cast attributes
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

Cast attributes are added to the SmPL AST. Reflect these changes in
pretty_print_cocci.ml by printing these attributes.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/pretty_print_cocci.ml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/parsing_cocci/pretty_print_cocci.ml b/parsing_cocci/pretty_print_cocci.ml
index 7628882b..2ace0b44 100644
--- a/parsing_cocci/pretty_print_cocci.ml
+++ b/parsing_cocci/pretty_print_cocci.ml
@@ -249,8 +249,10 @@ let rec expression e =
       expression exp; mcode print_string pt; ident field
   | Ast.RecordPtAccess(exp,ar,field) ->
       expression exp; mcode print_string ar; ident field
-  | Ast.Cast(lp,ty,rp,exp) ->
+  | Ast.Cast(lp,ty,attr,rp,exp) ->
       mcode print_string_box lp; fullType ty; close_box();
+      (if not (attr = []) then print_string " ");
+      print_between print_space (mcode print_string) attr;
       mcode print_string rp; expression exp
   | Ast.SizeOfExpr(sizeof,exp) ->
       mcode print_string sizeof; expression exp
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
