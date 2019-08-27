Return-Path: <SRS0=PQQq=WX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EFCC3A5A3
	for <cocci@archiver.kernel.org>; Tue, 27 Aug 2019 14:31:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C0FD20828
	for <cocci@archiver.kernel.org>; Tue, 27 Aug 2019 14:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgD+0LjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0FD20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7REVB5E010303;
	Tue, 27 Aug 2019 16:31:11 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3A0757791;
	Tue, 27 Aug 2019 16:31:11 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D002B7788
 for <cocci@systeme.lip6.fr>; Tue, 27 Aug 2019 16:31:09 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:434] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7REV8xo006908
 for <cocci@systeme.lip6.fr>; Tue, 27 Aug 2019 16:31:08 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id y8so19026006wrn.10
 for <cocci@systeme.lip6.fr>; Tue, 27 Aug 2019 07:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:mime-version:content-disposition
 :user-agent; bh=V4lwubaND/jZPlb8DXTw1l2x/LtHu6HrmyQtd6aLZQM=;
 b=SgD+0LjVUQOTEfRKg6QIbD1JF17tBPFOjrguj/4DkLEWWvkvqtb4V5IkOS/LueUUWs
 QRmSYNchLpQ68I4r5gyY4We2h1H14bC4UBN7r3+4qOp+E8qvf5Zhdz+ehgX8eWP3BKGD
 DeZDTMdOoJ+GU4xLwNKnmDDNCfg1zFwSN0EHytKI0V7QUDCiKWkPgMeMtFhFY72Ieinz
 A/nO29+izZfasnCSur7UaT5SC/5ZPaHRIx2LAr6q2OlS5wrOYHpo0GUPiq5nwG65Sy//
 CFMm0pDHJQeagRe+QJmitIIcB7KBQ7s5cqwzT897qmr72LWX86cJ/TXxq6sQICYucBNp
 Foog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=V4lwubaND/jZPlb8DXTw1l2x/LtHu6HrmyQtd6aLZQM=;
 b=aFtlAHZWXLoXh1EkluqZjiAU2y6LsE9X2FBhuzPtUONkqSQOLcAMJPgCnssFL0qJ0B
 mmkAQtk93HEUD9flc0SKVqm5pPmGi/FjKKnEL42pZfO35ZadqgXw/CHWqKdw5gtrh99f
 6YLBVKUlj8plEzF69Qm7jy0FXfxScVl/hZuMvuCbRzsdvSiBaee4cma7yWfhvmxw5ky+
 oNTbQWjeGUWuuDdE1rVXhiAKBGm8TLIoYW0oAxxsN+Hs4JcFWiwV9fOO8iuvzR9gRhhO
 f8XOJ9jNGow/z5bckR/DcgHHnflg6q84vPC6+FvDJaR2PhKGOjTLW1vUEZITJpfBqp+d
 yafQ==
X-Gm-Message-State: APjAAAVcGDTJyA4qiAm8AeS5Eazq6J3ltdxlDUSSQ/0Xam8NSOl7EI1S
 0OsAPZO7i4m0648PB/oNuOQ=
X-Google-Smtp-Source: APXvYqynRSgccmBN2WIYrRG0/rnjd4PfaHFjW5ibSM0jKHHQWayG3aD0QUHwPFhGL1itF3Y6d81jqQ==
X-Received: by 2002:a05:6000:1603:: with SMTP id
 u3mr3573766wrb.286.1566916268454; 
 Tue, 27 Aug 2019 07:31:08 -0700 (PDT)
Received: from Nover ([161.105.209.130])
 by smtp.gmail.com with ESMTPSA id z1sm19415886wrp.51.2019.08.27.07.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2019 07:31:08 -0700 (PDT)
Date: Tue, 27 Aug 2019 16:30:42 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: cocci@systeme.lip6.fr
Message-ID: <20190827143039.GA19250@Nover>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 27 Aug 2019 16:31:12 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 27 Aug 2019 16:31:08 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] SmPL highlighting on GitHub and GitLab
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

Hello dear Coccinelle community,

Since a few hours ago, SmPL code is detected and highlighted on GitHub.
Examples [1, 2] are visible in the Linux repository.  Other repositories
should receive highlighting when they'll be updated (after a git push).
Highlighting on GitLab should follow if/when they update their Linguist
dependency.

This change follows an update to the Linguist library [3], used to detect
languages on GitHub and GitLab.  At the moment, all .cocci files are
detected as SmPL.  The grammar for highlighting [4] was written by John
Gardner and should also work for the Atom editor.  If you want to change
the color, aliases, or extensions associated with SmPL, we'd welcome pull
requests to Linguist and I'm confident John would too for the grammar!

Regards,
Paul Chaignon

1 - https://github.com/torvalds/linux/blob/master/scripts/coccinelle/api/d_find_alias.cocci
2 - https://github.com/torvalds/linux/blob/master/scripts/coccinelle/misc/boolreturn.cocci
3 - https://github.com/github/linguist
4 - https://github.com/Alhadis/language-etc/blob/master/grammars/smpl.cson
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
