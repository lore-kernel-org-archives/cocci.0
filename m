Return-Path: <SRS0=An1N=P6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DDEC282C3
	for <cocci@archiver.kernel.org>; Tue, 22 Jan 2019 18:37:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07F8021726
	for <cocci@archiver.kernel.org>; Tue, 22 Jan 2019 18:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gez+qqbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F8021726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0MIbGrw024759
          ; Tue, 22 Jan 2019 19:37:17 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CDCC276F2;
	Tue, 22 Jan 2019 19:37:16 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2D54F76EA
 for <cocci@systeme.lip6.fr>; Tue, 22 Jan 2019 19:37:15 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0MIbDnF023867
 for <cocci@systeme.lip6.fr>; Tue, 22 Jan 2019 19:37:13 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 895E9217D6
 for <cocci@systeme.lip6.fr>; Tue, 22 Jan 2019 18:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548182232;
 bh=mSRDH7hjtGLwJ5C/U8LXIA1e82OL2gcl9N4n/AgQSjc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Gez+qqbtyreU34WCUJFwCjJJ+uC2q3JaDwNuDoEcizONllPB/1sVSnNjodDGgNUw/
 B046Wba9Ygw4ih79o+HyHPy7d312lgXK68O/xxQRmDGjhhcbEkAJC3z0wCmYS9nP1e
 m4MRA75OEN1fZNz8pyN3Z2DgiZFFFa8UMQToTDBw=
Received: by mail-ot1-f47.google.com with SMTP id v23so24559075otk.9
 for <cocci@systeme.lip6.fr>; Tue, 22 Jan 2019 10:37:12 -0800 (PST)
X-Gm-Message-State: AJcUukeFIdExRWVljttMfHQ8WMlDuoq7vUyWCLNGp2RBvWAyPYiWGEWR
 w27tFYhWKEHMEKQ+Jb8OV4BVwuVbRfZocSFMcAw=
X-Google-Smtp-Source: ALg8bN5WBiggIYiXc21AvUDoPJ2GrOP/jimWLLr1RVztlagxYhe4x6xtWLTR/ZJDpwpJJ4hCjrscx7oVn+s7r2Zcm5g=
X-Received: by 2002:a9d:491e:: with SMTP id e30mr3613031otf.131.1548182231859; 
 Tue, 22 Jan 2019 10:37:11 -0800 (PST)
MIME-Version: 1.0
References: <CAOZdJXXHJU3f4K-ECQjGs2WoE8XFMZDHL3bQ93ncewv_XCOSrg@mail.gmail.com>
 <alpine.DEB.2.21.1812182303590.2486@hadrien>
 <CAOZdJXUj5mZDHC+71N+mBQ98hpa4H7rbA1E3kkGzDgV_zFRobQ@mail.gmail.com>
 <alpine.DEB.2.21.1812190720480.2656@hadrien>
In-Reply-To: <alpine.DEB.2.21.1812190720480.2656@hadrien>
From: Timur Tabi <timur@kernel.org>
Date: Tue, 22 Jan 2019 12:36:34 -0600
X-Gmail-Original-Message-ID: <CAOZdJXUOQGdExeDDPbubiHpoGdUtC664zhhsWW1OJT4kd1zdPw@mail.gmail.com>
Message-ID: <CAOZdJXUOQGdExeDDPbubiHpoGdUtC664zhhsWW1OJT4kd1zdPw@mail.gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 22 Jan 2019 19:37:17 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 22 Jan 2019 19:37:14 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Positional parameter p1[0].file contains temporarily
 munged filename, not original
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

On Wed, Dec 19, 2018 at 12:22 AM Julia Lawall <julia.lawall@lip6.fr> wrote:
>
> Before you change a given function, everything is reliable.  Afterwards,
> only the function name and the column start and end would be reliable.

Is there any way you can enhance spatch so that it correctly remembers
the real name of the file that it's modifying, not just the mangled
temporary file name?
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
