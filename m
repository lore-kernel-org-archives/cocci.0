Return-Path: <SRS0=gsjE=T3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7974C04AB3
	for <cocci@archiver.kernel.org>; Mon, 27 May 2019 12:07:21 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 444252147A
	for <cocci@archiver.kernel.org>; Mon, 27 May 2019 12:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vmu4WPwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444252147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4RC75NP018515;
	Mon, 27 May 2019 14:07:05 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E9815774E;
	Mon, 27 May 2019 14:07:04 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B6D827747
 for <cocci@systeme.lip6.fr>; Mon, 27 May 2019 14:06:02 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:432] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4RC62vA004519
 for <cocci@systeme.lip6.fr>; Mon, 27 May 2019 14:06:02 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id f8so16712663wrt.1
 for <cocci@systeme.lip6.fr>; Mon, 27 May 2019 05:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:mime-version:subject:message-id:date:to;
 bh=de7BSxFaFJki0dxq0ITYfi+rtJeDDvZwp8kwZ5lapEc=;
 b=Vmu4WPwmTtnO57F29CY7uys6A++H+vsQM0NoEFRSuvpgv1FXG61W4umleT69sn8enc
 VFbOO27TQibJCRhOFwcjTz5IGRs5HdXWP63g4i1Z4/Wy/hBswES8QHWIbUQ4cvv+YkYk
 5mYIDsVdMi0jYtapnXMb3G7jX1xmTxBw7kxoZaunkwU/xZqBNDFJnIGZSwVIgbgGRkqq
 iiLhQEkdPetSVMkiZdS8KSHXZdGSzqG9SUcK2fqdjjmzibL7nZ00Dp5Ao12fFp+Iq0ZN
 7vbluHLRldx1dwyVMXfSn8PgZ2UYkD99SSzEVwK78xICY1HvfBrY8DqPenZEEUfRm+Yx
 Xo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:mime-version:subject:message-id:date:to;
 bh=de7BSxFaFJki0dxq0ITYfi+rtJeDDvZwp8kwZ5lapEc=;
 b=izKegRUwEeBoIDNFEvrhit0t+nbQHppckeVAg5CPi+yR69d8u+0oGMB70Bjn+zCckH
 Y05x3AKQOi9WkLCXumQV8Uyh3UIyWYnXDI2Z2/QDx1xjQyCX4uzMDgZRL7heHgRgZNVB
 vkGo6FYX3fYKq/V2IA/wWY0XBw4MAefQEJnB+lS7ZgNKz7O4vqAGZ7sBmGf+BM1go60C
 f8T3MgE+fH71WOzRI8XjsP9mDeGE4ZZ3z8MGY8BU1Vx3S4GIbkFGF3DqrfTgl2VNHYsr
 zl2o8pDjdDcHzZar1HK3t94SQhwP4VU9v8wVRM06xZMSng8X1YDtL09cbkCl9Fow4bQx
 svAg==
X-Gm-Message-State: APjAAAVjhzvhaL59HV8tvKdFkPkbz/APiNJfNkKDyNBBgE6XOuTM2qfE
 zw58x8HtwTqjPkqwSPUI0m1ewng1
X-Google-Smtp-Source: APXvYqz/Mqfle7eKuC2DF6rQXf5eln0aYssOdY+S8oO8oQNhUSCRkFnmIWgcqVE4sK3u4UbAbUlowQ==
X-Received: by 2002:a5d:6249:: with SMTP id m9mr12178687wrv.270.1558958761646; 
 Mon, 27 May 2019 05:06:01 -0700 (PDT)
Received: from dyn-25bf.mip.uni-hannover.de (ip47.173.mip.uni-hannover.de.
 [130.75.173.47])
 by smtp.gmail.com with ESMTPSA id o8sm26002210wra.4.2019.05.27.05.05.59
 for <cocci@systeme.lip6.fr>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 May 2019 05:06:00 -0700 (PDT)
From: Lennart Glauer <lennart.glauer@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Message-Id: <246F5E26-E77D-4283-9927-952D07BA42BF@gmail.com>
Date: Mon, 27 May 2019 14:05:59 +0200
To: cocci@systeme.lip6.fr
X-Mailer: Apple Mail (2.3445.104.11)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 May 2019 14:07:05 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 27 May 2019 14:06:02 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Mon, 27 May 2019 14:07:03 +0200
Subject: [Cocci] Question: Removing a function argument
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
Content-Type: multipart/mixed; boundary="===============1849262065=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr


--===============1849262065==
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_EAD82846-C8AE-405A-A680-805E71CE25C8"


--Apple-Mail=_EAD82846-C8AE-405A-A680-805E71CE25C8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hello all,

I=E2=80=99m interested in using Coccinelle.
Currently I=E2=80=99m playing with the example =E2=80=9ERemoving a =
function argument":
http://coccinelle.lip6.fr/docs/main_grammar016.html#sec24 =
<http://coccinelle.lip6.fr/docs/main_grammar016.html#sec24>

It works well with drivers/atm/firestream.c,
but if the definition of the function and the call are in two different =
files it doesn=E2=80=99t work anymore.
It seems that the reference =E2=80=9Erule1.fn=E2=80=9C doesn=E2=80=99t =
work across files?
I created a minimal testcase (see attachment).
Is there any way to make this work?

best regards
Lennart Glauer


--Apple-Mail=_EAD82846-C8AE-405A-A680-805E71CE25C8
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_1EAAEE23-D083-4E93-A3B5-C59BCB2163BE"


--Apple-Mail=_1EAAEE23-D083-4E93-A3B5-C59BCB2163BE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D"">Hello=
 all,<div class=3D""><br class=3D""></div><div class=3D"">I=E2=80=99m =
interested in using Coccinelle.</div><div class=3D"">Currently I=E2=80=99m=
 playing with the example =E2=80=9ERemoving a function =
argument":</div><div class=3D""><a =
href=3D"http://coccinelle.lip6.fr/docs/main_grammar016.html#sec24" =
class=3D"">http://coccinelle.lip6.fr/docs/main_grammar016.html#sec24</a></=
div><div class=3D""><br class=3D""></div><div class=3D"">It works well =
with drivers/atm/firestream.c,</div><div class=3D"">but if the =
definition of the function and the call are in two different files it =
doesn=E2=80=99t work anymore.</div><div class=3D"">It seems that the =
reference =E2=80=9Erule1.fn=E2=80=9C doesn=E2=80=99t work across =
files?</div><div class=3D"">I created a minimal testcase (see =
attachment).</div><div class=3D"">Is there any way to make this =
work?</div><div class=3D""><br class=3D""></div><div class=3D"">best =
regards</div><div class=3D"">Lennart Glauer</div><div class=3D""><br =
class=3D""></div><div class=3D""></div></body></html>=

--Apple-Mail=_1EAAEE23-D083-4E93-A3B5-C59BCB2163BE
Content-Disposition: attachment;
	filename=patch.cocci
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="patch.cocci"
Content-Transfer-Encoding: 7bit


@ rule1 @
identifier fn;
identifier irq, dev_id;
typedef irqreturn_t;
@@

irqreturn_t fn (int irq, void *dev_id)
{
    ...
}

@@
identifier rule1.fn;
expression E1, E2, E3;
@@

 fn(E1, E2
-  ,E3
   )

--Apple-Mail=_1EAAEE23-D083-4E93-A3B5-C59BCB2163BE
Content-Transfer-Encoding: 7bit
Content-Type: text/html;
	charset=us-ascii

<html><body style="word-wrap: break-word; -webkit-nbsp-mode: space; line-break: after-white-space;"><head><meta http-equiv="Content-Type" content="text/html; charset=us-ascii"></head><div></div></body></html>
--Apple-Mail=_1EAAEE23-D083-4E93-A3B5-C59BCB2163BE
Content-Disposition: attachment;
	filename=testA.c
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="testA.c"
Content-Transfer-Encoding: 7bit

#include "testA.h"

irqreturn_t foo(int irq, void *dev_id)
{
    return 0;
}

--Apple-Mail=_1EAAEE23-D083-4E93-A3B5-C59BCB2163BE
Content-Transfer-Encoding: 7bit
Content-Type: text/html;
	charset=us-ascii

<html><body style="word-wrap: break-word; -webkit-nbsp-mode: space; line-break: after-white-space;"><head><meta http-equiv="Content-Type" content="text/html; charset=us-ascii"></head><div></div></body></html>
--Apple-Mail=_1EAAEE23-D083-4E93-A3B5-C59BCB2163BE
Content-Disposition: attachment;
	filename=testA.h
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="testA.h"
Content-Transfer-Encoding: 7bit

#ifndef TESTA_H
#define TESTA_H

typedef int irqreturn_t;

irqreturn_t foo(int irq, void *dev_id);

#endif

--Apple-Mail=_1EAAEE23-D083-4E93-A3B5-C59BCB2163BE
Content-Transfer-Encoding: 7bit
Content-Type: text/html;
	charset=us-ascii

<html><body style="word-wrap: break-word; -webkit-nbsp-mode: space; line-break: after-white-space;"><head><meta http-equiv="Content-Type" content="text/html; charset=us-ascii"></head><div></div></body></html>
--Apple-Mail=_1EAAEE23-D083-4E93-A3B5-C59BCB2163BE
Content-Disposition: attachment;
	filename=testB.c
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="testB.c"
Content-Transfer-Encoding: 7bit

#include <stdlib.h>

#include "testA.h"

int main(void)
{
    return foo(0, NULL, NULL);
}

--Apple-Mail=_1EAAEE23-D083-4E93-A3B5-C59BCB2163BE
Content-Transfer-Encoding: 7bit
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv="Content-Type" content="text/html; charset=us-ascii"></head><body style="word-wrap: break-word; -webkit-nbsp-mode: space; line-break: after-white-space;" class=""><div class=""></div></body></html>
--Apple-Mail=_1EAAEE23-D083-4E93-A3B5-C59BCB2163BE--

--Apple-Mail=_EAD82846-C8AE-405A-A680-805E71CE25C8--

--===============1849262065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============1849262065==--
