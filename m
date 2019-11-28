Return-Path: <SRS0=sp25=ZU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF9CC432C0
	for <cocci@archiver.kernel.org>; Thu, 28 Nov 2019 02:12:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 002222154A
	for <cocci@archiver.kernel.org>; Thu, 28 Nov 2019 02:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzuEc5uW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002222154A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAS2BshA003777;
	Thu, 28 Nov 2019 03:11:54 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3D30A77D4;
	Thu, 28 Nov 2019 03:11:54 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EC5D477D2
 for <cocci@systeme.lip6.fr>; Thu, 28 Nov 2019 03:11:52 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:433] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAS2Bqb8024403
 for <cocci@systeme.lip6.fr>; Thu, 28 Nov 2019 03:11:52 +0100 (CET)
Received: by mail-wr1-x433.google.com with SMTP id a15so29131546wrf.9
 for <cocci@systeme.lip6.fr>; Wed, 27 Nov 2019 18:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=d41GZRAZ3k25dWuwOmU3YGMGYkPlQClOhM6H2Lm9Ydg=;
 b=QzuEc5uWqMgXKajZKGyMHk2/QlwfOCf5Y/V4rkXAfNxKtIfTX8Aeju+qDKwCjygdYq
 KiDzgzTNn9+d7DtB8FWPZruOiHboUKO6UKsAVi0A4gXLQVIs+fBdWZ2Tn9GwNWChHQIV
 IErVUO4Rt4bbfvJcMqUv/ocjtrrd4Nq8iatDsqjkiYNSY2lElLu/NremGyodWxRc/x5I
 uotQfk8cqgEyMhR3Qy7bfpvOC8wPdnIAqcWZ3sM0DHPFRTk6IaL5M/BsHePOVWY0IczE
 cmOuHZuGUBjUVPBVQvPiUMD67mxH8y5/wzJPdkofYbg5CgC6hHdfPU4+YTd+SN2CkYZ5
 z6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=d41GZRAZ3k25dWuwOmU3YGMGYkPlQClOhM6H2Lm9Ydg=;
 b=kXnM2Bgg0kPDNW5J+ZyuHim/5uo9VxnQy2ZqFQPn5vqm3Stzt9YflguV3EXuQPQ4zD
 gPy7K1PjL9kDv2Gr5lQ7gn1HXDhKcROa86DEaTVH2HlvK2nbX3uLVtQSvZE1RGjZ5F/t
 DJZyaJNU7EGMq631gYNF4JXAJbWppj86la8Gb8y2KirqgbVojXnLPD6TqnEmB8eSL1ic
 b5dG022L8KNJZ0TrU/BQV5npfTNXiq00yzsPVWKYc6o1HzrL53dpNc34Y3mBGqnLi6KM
 DTp1bNnBIQwWTBrcKNvZsVBxAWCEwJZXgcDp5FKp3Ym8o4J5h5Bl8XWzy/3fQfF/Rv7b
 OmeA==
X-Gm-Message-State: APjAAAXMbKVD+BcKDr7a4GlM+LduVhcXpS498Xt7J05W9odEaOyj1kzn
 929ZB4OQK2FFXCVhmsHAIIIyC8+UlldnohSnwIDxSq7Q
X-Google-Smtp-Source: APXvYqwc+1xioIYANa3Mc0vV0ZlyQ4WvTe3GM0821skWJRLWcqC5+V2vvbsPlI5nZ6+Y8hkRg2+n5tTxiZmA/kHPFK0=
X-Received: by 2002:a5d:608e:: with SMTP id w14mr10582971wrt.256.1574907111749; 
 Wed, 27 Nov 2019 18:11:51 -0800 (PST)
MIME-Version: 1.0
From: Strace Labs <stracelabs@gmail.com>
Date: Thu, 28 Nov 2019 00:11:15 -0200
Message-ID: <CABvP5W1W=p1-n_831VaiJyNsHrepFS0CNJSDQqmfPkrC1rx=Ww@mail.gmail.com>
To: cocci@systeme.lip6.fr
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 28 Nov 2019 03:11:55 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 28 Nov 2019 03:11:52 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] Replacing printf/format calls based on the data-type
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
Content-Type: multipart/mixed; boundary="===============0717094578=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============0717094578==
Content-Type: multipart/alternative; boundary="000000000000f33fd405985ea2b0"

--000000000000f33fd405985ea2b0
Content-Type: text/plain; charset="UTF-8"

Hi,

I am working on a semantic patch for replacing specific format string token
based on the used data-type.
so, I have several calls of my_printf() and some special macros pointing to
them around my code.

e.g: part of my code.
.....
struct mydata *m;
struct mydata h;
.....
my_printf("%s", m->name);
.....
my_printf("%s", h.name);
.....
my_printf("whatever id %d following the string %s\n", id, m->name);
....
Macro_to_my_printf("Hey id %d, let's see %s\n", id, h.name);
.....
Macro2_to_my_printf(fd, "Hey id %d, let's see %s\n", id, m->name);
.....

My current humble *.cocci

$ cat fix-my_printf.cocci
@r1_heap@
struct mydata *SMD;
format F =~ "s";
@@
-my_printf("%@F@", SMD->name);
+my_printf("%m", SMD);

@r1_stack@
struct mydata SMD;
format F =~ "s";
@@
-my_printf("%@F@", SMD.name);
+my_printf("%m", &SMD);
$

But, I can match only with partial content as can be seen below.

$ spatch --partial-match --sp-file fix-my_printf.cocci
sample-format-string.c | egrep "^(\+|-)"
HANDLING: sample-format-string.c
diff =
HANDLING: /Volumes/Users/jpereira/Devel/Sandbox/sample-format-string.c
diff =
--- /Volumes/Users/jpereira/Devel/Sandbox/sample-format-string.c
+++
/var/folders/ld/6tg9c6qj4fx4c85q26mcqrsh0000gn/T/cocci-output-24659-130f86-sample-format-string.c
- my_printf("%s", m->name);
+ my_printf("%m", m);
- my_printf("%s", h.name);
+ my_printf("%m", &h);
$

Anyone could give me a light about how to proceed to match the entire
".....string format..." ?

Thanks in advance,

--000000000000f33fd405985ea2b0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I am working on a semantic patch fo=
r replacing specific format string token based on the used data-type.</div>=
<div>so, I have several calls of my_printf() and some special macros pointi=
ng to them around my code.</div><div><br></div><div>e.g: part of my code.</=
div><div>.....</div><div>struct mydata *m;<br></div><div>struct mydata h;<b=
r></div><div>.....</div><div>my_printf(&quot;%s&quot;, m-&gt;name);</div><d=
iv>.....<br>my_printf(&quot;%s&quot;, <a href=3D"http://h.name" target=3D"_=
blank">h.name</a>);</div><div>.....<br>	my_printf(&quot;whatever id %d foll=
owing the string %s\n&quot;, id, m-&gt;name);<br></div><div>....</div><div>=
<div>Macro_to_my_printf(&quot;Hey id %d, let&#39;s see %s\n&quot;, id, <a h=
ref=3D"http://h.name" target=3D"_blank">h.name</a>);<br></div><div>.....</d=
iv><div>Macro2_to_my_printf(fd, &quot;Hey id %d, let&#39;s see %s\n&quot;, =
id, m-&gt;name);<br></div><div></div></div><div>.....<br></div><div><br></d=
iv><div>My current humble *.cocci</div><div><br></div><div>$ cat fix-my_pri=
ntf.cocci<br>@r1_heap@<br>struct mydata *SMD;<br>format F =3D~ &quot;s&quot=
;;<br>@@<br>-my_printf(&quot;%@F@&quot;, SMD-&gt;name);<br>+my_printf(&quot=
;%m&quot;, SMD);<br><br>@r1_stack@<br>struct mydata SMD;<br>format F =3D~ &=
quot;s&quot;;<br>@@<br>-my_printf(&quot;%@F@&quot;, SMD.name);<br>+my_print=
f(&quot;%m&quot;, &amp;SMD);<br>$</div><div><br></div><div>But, I can match=
 only with partial content as can be seen below.</div><div><br></div><div>$=
 spatch --partial-match --sp-file fix-my_printf.cocci sample-format-string.=
c=C2=A0| egrep &quot;^(\+|-)&quot;<br>HANDLING: sample-format-string.c<br>d=
iff =3D<br>HANDLING: /Volumes/Users/jpereira/Devel/Sandbox/sample-format-st=
ring.c<br>diff =3D<br>--- /Volumes/Users/jpereira/Devel/Sandbox/sample-form=
at-string.c<br>+++ /var/folders/ld/6tg9c6qj4fx4c85q26mcqrsh0000gn/T/cocci-o=
utput-24659-130f86-sample-format-string.c<br>- 	my_printf(&quot;%s&quot;, m=
-&gt;name);<br>+ 	my_printf(&quot;%m&quot;, m);<br>- 	my_printf(&quot;%s&qu=
ot;, <a href=3D"http://h.name" target=3D"_blank">h.name</a>);<br>+ 	my_prin=
tf(&quot;%m&quot;, &amp;h);<br>$<br></div><div><br></div><div>Anyone could =
give me a light about how to proceed to match the entire &quot;.....string =
format...&quot; ?</div><div><br></div><div>Thanks in advance,</div></div>

--000000000000f33fd405985ea2b0--

--===============0717094578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============0717094578==--
