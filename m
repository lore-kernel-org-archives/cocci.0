Return-Path: <SRS0=K+oe=SJ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48742C10F0E
	for <cocci@archiver.kernel.org>; Sun,  7 Apr 2019 21:28:31 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6304F2070D
	for <cocci@archiver.kernel.org>; Sun,  7 Apr 2019 21:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=mykolab.com header.i=@mykolab.com header.b="cBFYtq/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6304F2070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mykolab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x37LSGZl005935
          ; Sun, 7 Apr 2019 23:28:16 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B70307704;
	Sun,  7 Apr 2019 23:28:16 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 42C007631
 for <cocci@systeme.lip6.fr>; Sun,  7 Apr 2019 23:28:15 +0200 (CEST)
Received: from mx.kolabnow.com (mx.kolabnow.com [95.128.36.40])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x37LSDq6028566
 for <cocci@systeme.lip6.fr>; Sun, 7 Apr 2019 23:28:14 +0200 (CEST)
X-pt: isis.lip6.fr
Received: from localhost (unknown [127.0.0.1])
 by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 6D2E63167
 for <cocci@systeme.lip6.fr>; Sun,  7 Apr 2019 23:28:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mykolab.com; h=
 content-language:content-type:content-type:mime-version:date
 :date:message-id:subject:subject:from:from:received:received
 :received; s=dkim20160331; t=1554672492; x=1556486893; bh=eg9mCT
 1k9WTM3jXewB9lykQ9ztF3Puny1ieP3uFd6ns=; b=cBFYtq/JmK7PiW4FU2rksM
 HrlTpRDoqCg/0TbzIws3yYa3C7stVeDdPUndIGyR0isk41qonlfIAnZZOO1SoOQ/
 mPUAER+wc1Nmjp+Xvdsg+1Dqd1h0RHyRks0cHkJabhFi+L6qtAGRXCwggtKuube+
 StucGvxsCg3xOQo8FCiDBD67YH44CkL2XKIKEO9ZAAK4sWG6jZs87d+ZbYJKjIvm
 Klz3vIt0xAGhUFpUABKndK+5y+ZYqExihhSmnWGIVwds0+AWe3YMsfN14TFJPInp
 JDmANM43Ilf/tWt/2zkbMwdPtx9LFLe40BxAzh6p9jyAx7EC/SuK8L02WN0iRq3c
 xAxeLanAVTWX5Hn5I8B6jRgqhPyrEw7uVB+1eg8MFIq57Tavwxc1XFnNVtus7Sie
 qFl7uvA7PIWqS5pjiLWX9f24FmcfTzDnn/Flf+H0qPk3Iwi/7CUFwqcpetueLTX4
 9+lTZiRpvMQbEMjnvIUQ0BbuQF3CX56js1yc9r077IVvYcWTFFu5nXfebpDolJg6
 W9h/KPjY59221s0Y44vhuS65MCc4wJI02mXlFU5o4kpZStyMQs9hp7jeBPBzJ5Ek
 ZaJ1/BnOb2dloQWa7kNQ5S/LHcktxanZRJJEIZsfLa1icYUdzshXTNFRkcqBrSyN
 EtpWb9Xfo0/yYmdpEnlNQ=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OBkY2O91LQhN for <cocci@systeme.lip6.fr>;
 Sun,  7 Apr 2019 23:28:12 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
 by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 3C3B83163
 for <cocci@systeme.lip6.fr>; Sun,  7 Apr 2019 23:28:12 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
 by int-mx001.mykolab.com (Postfix) with ESMTPS id 287B53AB
 for <cocci@systeme.lip6.fr>; Sun,  7 Apr 2019 23:28:12 +0200 (CEST)
To: Coccinelle <cocci@systeme.lip6.fr>
From: Michael Stefaniuc <mstefani@mykolab.com>
Openpgp: preference=signencrypt
Message-ID: <6ab872a3-d236-50d6-4627-64ff981c89ce@mykolab.com>
Date: Sun, 7 Apr 2019 23:28:01 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------796DBCAF3BFD4B15907B77FE"
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 07 Apr 2019 23:28:17 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 07 Apr 2019 23:28:14 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Type propagation of unknown field types in arithmetic
	operations
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

This is a multi-part message in MIME format.
--------------796DBCAF3BFD4B15907B77FE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello,

I've run into a new set of false positives in my quest to remove casts
to self:

If the type of a field is unknown then the cast to int will be kept
  (int)s->unknown

But if that field is involved in an arithmetic operation with a numeric
constant and the result gets casted to int then the cast gets
erroneously removed:
  (int)(s->unknown / 1000)

That happens only for fields as a the cast will be kept in for variables:
  (int)(unknown / 1000)

Also if the type of the field is known and doesn't matches then the cast
is correctly kept.

Test case is attached.


thanks
bye
     michael




--------------796DBCAF3BFD4B15907B77FE
Content-Type: text/plain; charset=UTF-8;
 name="selfcast.cocci"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="selfcast.cocci"

QCBkaXNhYmxlIGRyb3BfY2FzdCBACnR5cGUgVDsKVCBFOwpAQAotIChUKQogICAgIEUK
--------------796DBCAF3BFD4B15907B77FE
Content-Type: text/x-csrc;
 name="type.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="type.c"

struct _sk {
    int i;
    long l;
};

int foo(int i, long l, bar b, struct _sk *sk, struct _su *su)
{
    int tmp = (int)i;
    tmp += (int)(i / 1000);
    tmp += (int)l;
    tmp += (int)(l / 1000);
    tmp += (int)b;
    tmp += (int)(b / 1000);
    tmp += (int)sk->i;
    tmp += (int)(sk->i / 1000);
    tmp += (int)sk->l;
    tmp += (int)(sk->l / 1000);
    tmp += (int)su->l;
    tmp += (int)(su->l / 1000);
    return tmp;
}

--------------796DBCAF3BFD4B15907B77FE
Content-Type: text/x-patch;
 name="type.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="type.diff"

--- type.c
+++ /tmp/cocci-output-10499-bbfa36-type.c
@@ -5,17 +5,17 @@ struct _sk {
 
 int foo(int i, long l, bar b, struct _sk *sk, struct _su *su)
 {
-    int tmp = (int)i;
-    tmp += (int)(i / 1000);
+    int tmp = i;
+    tmp += (i / 1000);
     tmp += (int)l;
     tmp += (int)(l / 1000);
     tmp += (int)b;
     tmp += (int)(b / 1000);
-    tmp += (int)sk->i;
-    tmp += (int)(sk->i / 1000);
+    tmp += sk->i;
+    tmp += (sk->i / 1000);
     tmp += (int)sk->l;
     tmp += (int)(sk->l / 1000);
     tmp += (int)su->l;
-    tmp += (int)(su->l / 1000);
+    tmp += (su->l / 1000);
     return tmp;
 }

--------------796DBCAF3BFD4B15907B77FE
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--------------796DBCAF3BFD4B15907B77FE--
