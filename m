Return-Path: <SRS0=Yxto=OO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E02C04EB9
	for <cocci@archiver.kernel.org>; Wed,  5 Dec 2018 23:28:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C051020879
	for <cocci@archiver.kernel.org>; Wed,  5 Dec 2018 23:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuQrZxDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C051020879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB5NSEhw006058
          ; Thu, 6 Dec 2018 00:28:15 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 96AFC76DA;
	Thu,  6 Dec 2018 00:28:14 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2B1D576D4
 for <cocci@systeme.lip6.fr>; Thu,  6 Dec 2018 00:28:12 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB5NSBfA010917
 for <cocci@systeme.lip6.fr>; Thu, 6 Dec 2018 00:28:11 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4CD7C2133F
 for <cocci@systeme.lip6.fr>; Wed,  5 Dec 2018 23:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544052490;
 bh=QKaEkLKUD9HbiUAd7aelL9PO5oRnZ/5uMkKqz6TqpLQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=UuQrZxDoUWzmsu2/cC2ej5zw1v/90/NwdT0sPzEjyqf3evJCyqYmI+lwi84yTd2F6
 jcGM/JRJvnE4kUESgQzQVeIqcad+qTzrm43cdGQpLhZCOyLnXotkAJNG4bwT3auT2t
 Y4bQfgbSGxghxqUucY3lFcKQ3a1BNygI1HLdZHAo=
Received: by mail-ot1-f46.google.com with SMTP id w25so20313582otm.13
 for <cocci@systeme.lip6.fr>; Wed, 05 Dec 2018 15:28:10 -0800 (PST)
X-Gm-Message-State: AA+aEWalyHBVlJPGztRtgbKeBeW7dEopWBpig4cTaTDXz6Y5hNAg+hOl
 +qC4UyIX/KDm1HPj9BEGqly5wZPBsCOF5ep+Z/w=
X-Google-Smtp-Source: AFSGD/WDZ5zmj6FX3id4fe+2HIAFHyMaC7i1IRdagtRPMFh7wZIHO8KX88hHLre1tvtnyAVWAnlefhO6u5m/VmYZAjM=
X-Received: by 2002:a9d:7001:: with SMTP id k1mr15674361otj.173.1544052489563; 
 Wed, 05 Dec 2018 15:28:09 -0800 (PST)
MIME-Version: 1.0
References: <CAOZdJXVLMv-5_u1uOq6re+1O3vADsrTK0+J3Fat-XN4_2DEp4w@mail.gmail.com>
 <alpine.DEB.2.21.1811151327420.2372@hadrien>
 <CAOZdJXWD0L4Qwh2raJLF25Ax0=DR06vhfGWhpQVf804YQJ5jeA@mail.gmail.com>
 <alpine.DEB.2.21.1812042124260.2383@hadrien>
 <CAOZdJXXMTrXXEKta-M0uYq3EpjVaSz2++OT1GOB5HYmx5h_TgA@mail.gmail.com>
 <alpine.DEB.2.21.1812050732260.2670@hadrien>
 <CAOZdJXX+0cVy0zC7xVgf2EE-YrP+qU_6QWJA_uhhiCqhbgAD7A@mail.gmail.com>
 <CAOZdJXUxWV+v5UanQXRVLpOJbxA27a_zitCeUdW4uJaqX0jWgQ@mail.gmail.com>
In-Reply-To: <CAOZdJXUxWV+v5UanQXRVLpOJbxA27a_zitCeUdW4uJaqX0jWgQ@mail.gmail.com>
From: Timur Tabi <timur@kernel.org>
Date: Wed, 5 Dec 2018 17:27:32 -0600
X-Gmail-Original-Message-ID: <CAOZdJXWnjAPwrvWEO58fa8O28jf8YC+yt0b46Oi3TYhXazYzJQ@mail.gmail.com>
Message-ID: <CAOZdJXWnjAPwrvWEO58fa8O28jf8YC+yt0b46Oi3TYhXazYzJQ@mail.gmail.com>
To: Timur Tabi <timur@kernel.org>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 06 Dec 2018 00:28:15 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 06 Dec 2018 00:28:11 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Can the current function name be passed to a Python
	snippet?
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

On Wed, Dec 5, 2018 at 1:11 PM Timur Tabi <timur@kernel.org> wrote:
>
> Never mind, I now understand how the @p1 is supposed to be used.  I
> have it working now.

I spoke too soon, I'm getting a weird error:

rule starting on line 232: already tagged token:
C code context
File "/tmp/cocci_small_output-22474-8398df.c", line 43, column 23,
charpos = 1216
  around = '"init_PllId: Error programming clock.  Stopping script.\n"',
  whole content =                        "init_PllId: Error
programming clock.  Stopping script.\n");

Line 232 is the "depends on rule" in this snippet:

// Get rid of the function name at the beginning of the string
@script:python s4@
c << r4.c;
c2;
p1 << r4.p1;
@@
import re

f = p1[0].current_element
coccinelle.c2 = re.sub('"%s[: ]*' % f, '"', c, 1)

@depends on rules@
expression x;
constant char[] r4.c;
identifier s4.c2;
@@
NV_PRINTF2(x,
-c
+c2
,...);
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
