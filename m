Return-Path: <SRS0=6Fm5=RA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0D1C43381
	for <cocci@archiver.kernel.org>; Mon, 25 Feb 2019 19:52:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 358432084D
	for <cocci@archiver.kernel.org>; Mon, 25 Feb 2019 19:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=mykolab.com header.i=@mykolab.com header.b="GoM5BPnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358432084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mykolab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1PJqKUM027852
          ; Mon, 25 Feb 2019 20:52:20 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C2A937709;
	Mon, 25 Feb 2019 20:52:20 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1589A76FD
 for <cocci@systeme.lip6.fr>; Mon, 25 Feb 2019 20:52:19 +0100 (CET)
Received: from mx.kolabnow.com (mx.kolabnow.com [95.128.36.42])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1PJqIiP006945
 for <cocci@systeme.lip6.fr>; Mon, 25 Feb 2019 20:52:18 +0100 (CET)
X-pt: isis.lip6.fr
Received: from localhost (unknown [127.0.0.1])
 by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 04FC043F30;
 Mon, 25 Feb 2019 20:52:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mykolab.com; h=
 content-transfer-encoding:content-language:content-type
 :content-type:in-reply-to:mime-version:date:date:message-id:from
 :from:references:subject:subject:received:received:received; s=
 dkim20160331; t=1551124337; x=1552938738; bh=aaiUloXXZGIxGVFadCs
 OOUBii+jiHF6+wMrrITrNu6s=; b=GoM5BPnPr74PtGkmd4PYFexR/4LDpANQaW4
 m0La3gFtuV+N5JDcwPnz6z3PC9NqqLIK7RN4MgZXkUZYD9s8tygGAG6/HQ708Be2
 Fbe5wbVfihsTztVfp1huholn88TYlOrhP97BOT2lBkvA8oCPwipRwG3Jjn7xmAcw
 hy7zP1+zBvtLytosL5FXjAHJ4qgwuJYYfQffhgCFYyaGrPYazaBgVSraJc2q2SQ9
 ZBiACAFM0nrBnqrf2HsRpF0jFW0H41CSnY0S8yPK4HZFXTLY0qAtBAmIU/AOO/kb
 OkL9j+GfdgWdVKyUrZvxVW3mUkKHKHwlnqdgGqWffCN4gxotpMA5wofRjpmipVXn
 N0mWXiO7lr52XQDXhLTByzrDNl4R7tLwMWk+CfsB5q0izlukt7e+CgANipi24CAK
 jYedysfWWr1cJXjOhiDQdIuBOSl261DnMrPx7Mlm8WPalfoGnC/3mOqXfYQ5lF8K
 1zz452LQDgesrmi083IuCeb31ehEw9v6OTwJx3TcQdFgSL28PUeJqGWT2zb6q7t0
 CuYfwRp0sje1FoaAqNlA/riLCTKOtrxqHKwiHoYmV9Dkd9qxg6NphVb5OorBlOA0
 UCzgiDj1fElN00WW/v3xPx/PFEjVr93TMO55DRZ2/keGNgSu4NtAMDhcNCdKMfZd
 MErjgh4A=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HDVl-XxsrJNm; Mon, 25 Feb 2019 20:52:17 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
 by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 62A5843F2D;
 Mon, 25 Feb 2019 20:52:17 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
 by int-mx002.mykolab.com (Postfix) with ESMTPS id 25AA22720;
 Mon, 25 Feb 2019 20:52:16 +0100 (CET)
To: Timur Tabi <timur@kernel.org>
References: <CAOZdJXX=_PaZWF07z6JRg-JrGWa9JYP_9Wr3dOKajA5ZopWi5Q@mail.gmail.com>
From: Michael Stefaniuc <mstefani@mykolab.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mstefani@mykolab.com; prefer-encrypt=mutual; keydata=
 mQGiBEBzHYsRBACu8uw/xP4j/RYT/HBhw46jwNx9tJaHUADksKmmNRMVnpAX768sVFOMz+rO
 4Zfx0pGoaMrfw5yCh3v+fwh7hh8mMutZ6HmtOZho10hd/Kp+1JSpFDVP5b92ATr2Yexd+SXz
 jSbCDGLjGGpPWEEtNzu4UhdRwIIymdQqVTx6aCvscwCgvsbD+M9kmUWdToQI/H6QYsNBmukD
 /iPmBemMiw69xBzH+pLCpfdlnundj/ZXXdUO86Br6reg9q5m5Vv4ClyTHMIXcd6Dnm43S2Z9
 OvCDwtBMm+Hu5H89/B6E0NSyknn7CMciD3bLklFGQl4isyF+6Gnd5MTr1cM1Pm0EtYmCAdhK
 +h9SW2NWnPQOr2b3KRrn6rFRumTqA/0YDv8IvVRQZjv9DqK4YP7/va7GGUJHS44ksPyHuQXI
 gZVvHgE5ntSjBeUULoTk6vY55JTdgj3w2BdW9zvjUD9O7kDCf/sx74YvInw3bHsTDo4C7mr3
 QPWIVHKF63dElZwTNL+W0pzwDi6nBnu6RGpiQgI6gktIE13ySF1HjoKAjbQ1TWljaGFlbCBT
 dGVmYW5pdWMgKGVuYyBwd2Qga2V5KSA8bXN0ZWZhbmlAcmVkaGF0LmNvbT6IXwQTEQIAHwQL
 BwMCAxUCAwMWAgECHgECF4AFAlNET0gFCRw3Mz0ACgkQ0ei8kcpE1VFHMgCgtPjwlA34jJ2F
 a1TPymfo6IGo9y4Anj05IAwUKKSPJez3LojfovAYMEryuQINBFNETU8BEAD2GkRuwYIX8RZt
 rxtlr5m3mVvxeW4k+Zq7LfFDJ4tGFDDIQAGWPK1RfljVjvPSPxzsoj+KynXnIqw9e6PoSNg3
 tDMQaKvaLpzAKRUZIRJrIdCNuXQxvVI6Jxgg3GVbFider//67y+8rBJE5+QZp5zaIS4ifm90
 9NnHtOvr0ddJ1r26IwOo8/Pyg7y+bTN/Xuu5qr/zOeTcdJMtaQ2kbBh3IU2FSRGvUZTG9UNg
 aU54KKX7+Zu3cziEK87r89Y1fZTr0rZfdQNaUwivxHY4nOXN+EAFl3mfaHnYIsdSDG3mqza8
 RgoqLJpOGvl0JVlyYI9jgOvi05q+kFzGlZj1raAgnImzXh3p2se1sxUuXrmYkQt9b9OrFiCf
 XYuWEVgNoW6qpmzYHkjOGBcATANhv9JBoNbMQEsg7oeyeCZzI3se8yXkif89NLB3MmLFHcPV
 ui8Pv/6Y9/MAHq6ohM7AVJtOKt21jsb8R+Me3k5BoHkdU3iUAviScLKqiR5v5eL084gZtijv
 2ZgGfw1bNcX3y7VYsw5omvw042uGxzA76tm9hRjxDKK9OA/GAtkv20gusA4fZXUSuy7RRJ8N
 T7U24WD4lRLCBjkNnV4izQHr9qwM6I/5/jP8mguRSL7HguxBLcyL7ZQ01aQALcc43v/p5Vw4
 96b3Et/nZrVw04xtwwvuhQARAQABiE8EGBECAA8CGwwFAlNET6oFCQlmA9sACgkQ0ei8kcpE
 1VGjvgCfWX5kaF0YptgUFItMH6U8kA6vnRsAoJkVZPLvJDyYi4TiEaZXyk+3DKPf
Message-ID: <9b468560-a277-b43d-fee9-5d7ffad53635@mykolab.com>
Date: Mon, 25 Feb 2019 20:52:06 +0100
MIME-Version: 1.0
In-Reply-To: <CAOZdJXX=_PaZWF07z6JRg-JrGWa9JYP_9Wr3dOKajA5ZopWi5Q@mail.gmail.com>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 25 Feb 2019 20:52:21 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 25 Feb 2019 20:52:18 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] How to handle/ignore iterator macros?
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

On 2/25/19 6:42 PM, Timur Tabi wrote:
> I have lots of code that looks like this:
> 
> #define MY_ITERATOR(x, y)  for (x=0; x<y; x++)
> 
> MY_ITERATOR(v, 20)
> {
>     printf("%i\n", v);
> }
> 
> Spatch chokes on this because it thinks MY_ITERATOR() should end with
> a semicolon:
> 
> ...
> bad:          MY_ITERATOR(v, 20)
> BAD:!!!!!     {
> bad:               printf("%i\n", v);
> ...
> 
> I tried specifying "--undefined MY_ITERATOR", but that did nothing.
For cases like that I've added a define to my macro file to be used with
--macro-file-builtins or --macro-file.
But I'm working on Wine so have to use my own macro file anyway so I'm
not relying on the one that comes with coccinelle.

bye
	michael
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
