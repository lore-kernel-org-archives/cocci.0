Return-Path: <SRS0=z9nG=EQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDA0C388F7
	for <cocci@archiver.kernel.org>; Tue, 10 Nov 2020 15:11:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD59F207D3
	for <cocci@archiver.kernel.org>; Tue, 10 Nov 2020 15:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IEm5jSXs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD59F207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AAFBCRb027090;
	Tue, 10 Nov 2020 16:11:12 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 378127683;
	Tue, 10 Nov 2020 16:11:12 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C16D4454B
 for <cocci@systeme.lip6.fr>; Tue, 10 Nov 2020 16:11:10 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AAFB5m8029008
 for <cocci@systeme.lip6.fr>; Tue, 10 Nov 2020 16:11:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605021065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ytghYupO837DwYXnKDkhVhRyxudQhPK1XCV3mzM3uyw=;
 b=IEm5jSXsMX7Urkas7D5++MaA7vedmENeEA5M6yqeSPObqUri8+bJYGvfEbaX8wQc7XNRS4
 zri5P4iAhnSN+mKIpDsz6DqK72Pzc1CjYSKAIo9WYXhVrxeTrAo+82liULWPihFdVkHTeR
 WRMrjJza9Ecnd5byT4aZJSoFDmus9iY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-jV2FtNGbMhigscgnztZ4gw-1; Tue, 10 Nov 2020 10:11:03 -0500
X-MC-Unique: jV2FtNGbMhigscgnztZ4gw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63EC080474F;
 Tue, 10 Nov 2020 15:11:02 +0000 (UTC)
Received: from foo.home.annexia.org (ovpn-114-98.ams2.redhat.com
 [10.36.114.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A0B45C1C4;
 Tue, 10 Nov 2020 15:11:01 +0000 (UTC)
From: "Richard W.M. Jones" <rjones@redhat.com>
To: julia.lawall@inria.fr
Date: Tue, 10 Nov 2020 15:10:57 +0000
Message-Id: <20201110151058.82289-1-rjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=rjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 10 Nov 2020 16:11:12 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 10 Nov 2020 16:11:06 +0100 (CET)
Cc: cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH Python 10] bundles/pyml: Remove bindings for
	PyObject_As(Char|Read|Write)Buffer
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

Some more functions were deprecated/removed in Python 10,
breaking Coccinelle compiles.  It was reported by Fedora's
Python team here:

https://bugzilla.redhat.com/show_bug.cgi?id=1896393

I have fixed it by chopping out bindings for these
functions from the bundled pyml, and it compiles fine
for me with Python 10 now.

Rich.


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
