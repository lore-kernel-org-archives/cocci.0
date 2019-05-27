Return-Path: <SRS0=gsjE=T3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AEEC04AB3
	for <cocci@archiver.kernel.org>; Mon, 27 May 2019 13:33:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E682075E
	for <cocci@archiver.kernel.org>; Mon, 27 May 2019 13:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="tB0dcq7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E682075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4RDX5vO005486;
	Mon, 27 May 2019 15:33:05 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5692A774E;
	Mon, 27 May 2019 15:33:05 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B5A207747
 for <cocci@systeme.lip6.fr>; Mon, 27 May 2019 15:33:03 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:42f] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4RDX11F025084
 for <cocci@systeme.lip6.fr>; Mon, 27 May 2019 15:33:01 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id r7so16943421wrr.13
 for <cocci@systeme.lip6.fr>; Mon, 27 May 2019 06:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linbit-com.20150623.gappssmtp.com; s=20150623;
 h=to:from:subject:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=tuL65VBZu5tyz2z0RZiVPxnW4ScI47VpRUDqVilDPBw=;
 b=tB0dcq7Khlrd5SMGURa6jG47NZuSg5y4Vcwd6B7B4V70TyQigkW8Ila/io7lWPxOyU
 B4+M6u/S9uI3cVRs5/K16n7x3p1+g34hNw8WjAXYs4rdc9kF28vd+6UbuYmd9C1qNaSx
 HY9l+2vHhnW77/iLR6YlQbkS8NzpMku1VgY9oU/Dj1ZzXKgBvx5x+wqYExBfU6Qqo253
 855bQfLp+zZrr/h+lTM2ZdpMS3oSj5lBhJx7BUHBvFNTqQ9I7ITJe6Dc3i7b5cJE+ygp
 5c1O35d6dgFuRUK768+NHBihWvZuoXORh/b9WcRgvWWE9Wp1iCzzEeDwDEqL8n/c8DyB
 cbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=tuL65VBZu5tyz2z0RZiVPxnW4ScI47VpRUDqVilDPBw=;
 b=QDYeUTPCedTyTqMK26X07d1YSqfOwcnNmRlTIh63QSmq2TYGNLdSThlzX3/bVXWLS7
 2dPEuBwf6zKOLAx9Oh9HXoR33AvIXd0pKOnzxoiSyxDtO5iED43E+fgMu6Z50Zw1S+WG
 2+JqD5aw2SYJ/SK/ZlvmJVAejOZTKkZhn4Mt/JkRiNxRhVvBVgq4nQIMbW7aLiWI6Fp7
 O+zCogwTBrmUPNKbS2LQ6iHdgaIw/jp/ICYfXO/sAQg4RaVw46KYwh6qnNddikC/0Mn6
 3c6kx6SIS4cLkytFK0RkWGoeqmPW1GUcKFFihM3++Y7JF/oxUHaAu74v/IJRqxV364HR
 01Ag==
X-Gm-Message-State: APjAAAX4pxmqzjebdaApnMECgHNCm88o3PBQEMaiG7fHRbmzDvmeohAh
 ismRkwK4z+c2UIXE+5oNcnFWYBo5ZMA=
X-Google-Smtp-Source: APXvYqx/7ZhIL/ZcWxKTKVo4x44HhqkmtdawBuPzmPfzZLBFFyI0ID2su+3j0GddU1NwVSYv5LsXnw==
X-Received: by 2002:adf:eb09:: with SMTP id s9mr16114715wrn.127.1558963981384; 
 Mon, 27 May 2019 06:33:01 -0700 (PDT)
Received: from ?IPv6:2001:858:107:1:7191:e1d1:bfdb:e25?
 ([2001:858:107:1:7191:e1d1:bfdb:e25])
 by smtp.gmail.com with ESMTPSA id x4sm11807308wrn.41.2019.05.27.06.33.00
 for <cocci@systeme.lip6.fr>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 May 2019 06:33:00 -0700 (PDT)
To: cocci@systeme.lip6.fr
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
Message-ID: <28b6ede5-cc25-c6be-8526-c291988d208a@linbit.com>
Date: Mon, 27 May 2019 15:32:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 May 2019 15:33:05 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 27 May 2019 15:33:01 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] Are types re-evaluated between subsequent rules?
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

Hi,

I'm having trouble understanding coccinelles behaviour here. Consider 
the following C code and cocci rules:


#include <stdio.h>

int x;

int main(int argc, char **argv)
{
     f(x);
}


@@
identifier x;
@@
- int x;
+ int *x;

@@
int *x;
@@
- f(x)
+ g(x)



Since I read on some slides[0] that "Later rules see the results of 
earlier rules", I would assume that this would pick up the type change 
introduced by the first rule and replace f by g because it now has an 
"int *" parameter. However, spatch merely outputs the patch to change 
the type of x. If I change the type of the "expected" x in rule 2 to 
"int", cocci picks it up correctly.

Am I missing something?


[0]: 
http://events17.linuxfoundation.org/sites/events/files/slides/part1.pdf, 
page 43

--
Regards,
Christoph
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
