Return-Path: <SRS0=hedW=KV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA61C2B9F7
	for <cocci@archiver.kernel.org>; Wed, 26 May 2021 10:52:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC34D613F1
	for <cocci@archiver.kernel.org>; Wed, 26 May 2021 10:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC34D613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 14QAqJrr014297;
	Wed, 26 May 2021 12:52:19 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7A6C17737;
	Wed, 26 May 2021 12:52:19 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C24393E3B
 for <cocci@systeme.lip6.fr>; Wed, 26 May 2021 12:52:17 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:535])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 14QAqFPA009075
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 26 May 2021 12:52:16 +0200 (CEST)
Received: by mail-pg1-x535.google.com with SMTP id j12so613732pgh.7
 for <cocci@systeme.lip6.fr>; Wed, 26 May 2021 03:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=TkVz6k0cP03gO+kRJUp/qKlakcOzNqR7lnUbHRFojnw=;
 b=HtBUxLwt8agOu2qCZDTpsgowmYQJJrveIc+Y8NIL1zRlRYRTozETmUR44BxreWgtSP
 8vzL5hCKZQBcfLWr6yIxjIsg/3zwsHkzQnK/e+Cu67P8gtD/Qj6g3d7aqwX/MqNBeAvv
 SIsKl0LYtxKYnWUiWunnnsRFHjXq3vn1Jwq+oQixHhflc8OPLLJEDFyEoofNJJCjqs8p
 gvQUye1pxMC3gulXxwoQcKdQ8MKvv3iB7BjWx0XBT6+/4jZ8ymdtVuXQY3N+mrlID0In
 bCwI0TUR5k4imuVEfM2jSrd5i9ix+YQlGX/zutmy2GCdiBFKgI2HxXqaiFOygJkbH6a2
 75QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=TkVz6k0cP03gO+kRJUp/qKlakcOzNqR7lnUbHRFojnw=;
 b=oBfFriXlM4NhDxpF4GQvE34jT94rc/G7rzyUaDhTtMPEr4ArovQm+1g3jGE2yeHoBK
 J56gUvK/EAaTQmHJC2lZ42TUn44r1ixxG9PNr7jWyIdLHlNwUsXVSIg4DQyCjnQHeWpU
 LWvUkBynTUZ0slKEqP7nAljSTD4Y4VNiHTvPVrBskhJmVRBJk96j2wEjVt7D8TMvJCFd
 gesAAkwg9x/JI1UAKD0z7YEfV1iA1/mch2mwjOnobV4Q6XLoFO+YgBzqc/ZqJag2jdHB
 TfqeqQcr0bRaouL80DXTnvTDheCYWUPq/kpYXA7xlCbqKiKuadnDOPwYgkA2WygP2Nz4
 rB+w==
X-Gm-Message-State: AOAM532NI6lNrRkclRDFw3zKnQUh8hWtfz81a4Piz2cpTcIOWXwRhJMY
 crOMu/C87ADHNgo8PMpV3ec=
X-Google-Smtp-Source: ABdhPJxo4cxT/39iL2mtCQ2oBbZQcsH1neBc7H+MnCxHjgpb5QiVy58tI0f313no2MfdtXfye+3srw==
X-Received: by 2002:a05:6a00:1a8b:b029:28e:7b62:5118 with SMTP id
 e11-20020a056a001a8bb029028e7b625118mr34684316pfv.49.1622026334440; 
 Wed, 26 May 2021 03:52:14 -0700 (PDT)
Received: from adolin ([49.207.210.55])
 by smtp.gmail.com with ESMTPSA id k21sm16190222pgb.56.2021.05.26.03.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 03:52:14 -0700 (PDT)
Date: Wed, 26 May 2021 16:21:46 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: julia.lawall@inria.fr
Message-ID: <cover.1622024972.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 26 May 2021 12:52:20 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 26 May 2021 12:52:16 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH 0/2] Add "use-patchdiff" option
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

This patchset adds a feature to enable Coccinelle
to only check all those files in a directory which were
modified. It parses all the files obtained from the
output of "git diff" and checks them against the specified
cocci script.

An example for passing the "use-patchdiff" option is:

	spatch -D report --sp-file for_each_child.cocci --use-patchdiff drivers/gpu

One thing to note while using the command is that while it can be
invoked outside the target project directory, an absolute path
to the target folder should be specified in such cases as.

Sumera Priyadarsini (2):
  parsing_cocci: Add feature to check only modified files
  docs: manual: Add option description in spatch_options

 Makefile                        |   2 +-
 docs/manual/spatch_options.tex  |   5 ++
 enter.ml                        |  17 +++--
 globals/flag.ml                 |   2 +-
 globals/flag.mli                |   2 +-
 ocaml/coccilib.mli              |   1 +
 parsing_cocci/get_constants2.ml |   1 +
 parsing_cocci/patch_diff.ml     | 118 ++++++++++++++++++++++++++++++++
 parsing_cocci/patch_diff.mli    |   9 +++
 9 files changed, 148 insertions(+), 9 deletions(-)
 create mode 100755 parsing_cocci/patch_diff.ml
 create mode 100644 parsing_cocci/patch_diff.mli

-- 
2.31.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
