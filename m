Return-Path: <SRS0=pejK=5M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF54C43331
	for <cocci@archiver.kernel.org>; Fri, 27 Mar 2020 18:24:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D00EA20716
	for <cocci@archiver.kernel.org>; Fri, 27 Mar 2020 18:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIQZbTiI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00EA20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02RIO5Bg013644;
	Fri, 27 Mar 2020 19:24:05 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A76CD7812;
	Fri, 27 Mar 2020 19:24:05 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 03D7D780C
 for <cocci@systeme.lip6.fr>; Fri, 27 Mar 2020 19:19:41 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:331])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02RIJdO0013125
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 27 Mar 2020 19:19:40 +0100 (CET)
Received: by mail-ot1-x331.google.com with SMTP id c9so10699449otl.12
 for <cocci@systeme.lip6.fr>; Fri, 27 Mar 2020 11:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=Zvu0IcolkeOnzMqADYZjSRIfVhhD/AJiAn/BStFVhRY=;
 b=jIQZbTiIEu/oqNPv1yskCEkmDIEhvd1CbjWwmAG6qpf52QKir2gxx6uniOvPoUUIMe
 yi9aJr5IxHKLzAaWjSiLLa0SXhyUgc8RMK9rSnzafcwHhvIud+XnYyESQvFWFAjsIqfq
 AR+Aw3BDJx6EwTK1SIYklHBqpL5bA4hlXAVJzJAJRyqvsQ+Lj8PG+aBRZK4s3az68TrY
 udFfKcGqm+hAsl12hngI8nfgP/r8qH7WPm/x4m7ruawb1aPox3UGj96TerhJ7AfdkvCR
 MzicmmYVnqMnppi192bhWBgHezBbgpRPJsiQUvfHqoTjwlsu8wr8gxbhOl2KFuM4Hbhq
 +PoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=Zvu0IcolkeOnzMqADYZjSRIfVhhD/AJiAn/BStFVhRY=;
 b=YKbgJBS93GE247+/JMgYLL2HftSbFSuTspuF2C5MmSs9S3ezrbSLJQuSD48hX5n9SG
 gfZwDUciZV9YS8k8UfVZw2bEUHTx7HmHXlcikFmDA6dNidK3SaQtRsKDo6EklwADo8K7
 QVU/Kyvq6zWuZ7o8teC8C+hksFPMK3CKobA/2bNAplv3NwXGjzte3FzhFQpeFdzUjXWO
 eU/iAlUkT+S+enOqW8nahTZARFm71/GgSg9gFRXsCWYgsfr0b8iI7qoYC+mZSBjiRCkg
 MQkgxI6uitlB+5E1g+8RRJtCg7BxZkg3d0S+hTCePJ85PsdHgzhsE1azfQlmbIqG+9z6
 7A/w==
X-Gm-Message-State: ANhLgQ3a9nTe0NjrEK7y9iQl7p5VLIxsFBZ06LFmVrWSo+tLGsFaZKiP
 mKVgdkCiQ2LVXSqm0GS7QjHnh9NIzoD4wrsHuq3bxqyyzg==
X-Google-Smtp-Source: ADFU+vtVrPnBezn76Iz7F+6SSR1FWIi1NbRDKs/w5yOD844dcMUMWj3qGrmAcOA49Z/P+8UJJ7yQ25J/FgKhViUO7DY=
X-Received: by 2002:a9d:6b02:: with SMTP id g2mr11541232otp.340.1585333178464; 
 Fri, 27 Mar 2020 11:19:38 -0700 (PDT)
MIME-Version: 1.0
From: George McCollister <george.mccollister@gmail.com>
Date: Fri, 27 Mar 2020 13:19:27 -0500
Message-ID: <CAFSKS=NXVUcp1KwpidZoFTfyUCmh+8ij2njaGZ7g6h9LvEiYrA@mail.gmail.com>
To: cocci@systeme.lip6.fr
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 27 Mar 2020 19:24:06 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 27 Mar 2020 19:19:40 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Fri, 27 Mar 2020 19:24:04 +0100
Subject: [Cocci] using cocci to switch to formatted log/print function
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

Hello,

I'm working with an old code base that makes excessive use of the
following sort of construct:

char display[128];

...

snprintf(display, sizeof(display), "example log message %d", i);
log_buffer(level, strlen(display)+1, display);

I'd like to replace this mess with a single call to a function named
log_formatted(). This involves moving the format string and arguments
passed to snprintf into the log_formatted() call, removing snprintf
call and (here's where it gets a bit tricky) remove the buffer if it
isn't used for anything else.

I have this all working with the following script with the caveat that
running it on moderately complicated source files makes it never
finish (after an hour or so the spatch process crashes with a stack
overflow error).
I've tried --no-loops which seem to speed things up but complicated
source files still result in it never finishing.

@r1@
type T;
identifier disp;
expression level;
expression list prnt;
@@

{
... when any
(
T disp[...];
|
T disp[...]="";
)
<+...
  snprintf(disp, sizeof(disp), prnt);
... when != disp
- log_buffer(level, strlen(disp)+1, disp);
+ log_formatted(level, prnt);
...+>
}

// Only remove the display variable and snprintf if there are no
// other references to the variable.

@r2 depends on r1@
type r1.T;
identifier r1.disp;
expression list r1.prnt;
@@

{
... when any
(
- T disp[...];
|
- T disp[...]="";
)
<+... when != disp
- snprintf(disp, sizeof(disp), prnt);
...+>
}


Any suggestions on changes to my script that would make this work on
lengthy source files would be greatly appreciated!

Thanks,
George McCollister
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
