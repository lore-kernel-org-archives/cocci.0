Return-Path: <SRS0=31i8=53=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621BAC2BA19
	for <cocci@archiver.kernel.org>; Sat, 11 Apr 2020 18:51:14 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F5DA20732
	for <cocci@archiver.kernel.org>; Sat, 11 Apr 2020 18:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="gbOHcMuu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5DA20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03BIou7C010040;
	Sat, 11 Apr 2020 20:50:56 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5DDC17818;
	Sat, 11 Apr 2020 20:50:56 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7188F7816
 for <cocci@systeme.lip6.fr>; Sat, 11 Apr 2020 20:50:55 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03BIosaf004754
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Sat, 11 Apr 2020 20:50:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1586631054;
 bh=quEWjexCoz6kTleqIjd81PgcFieb2inE9EJo8+8uP9Q=;
 h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
 b=gbOHcMuurKf0u5Ga3avFXz9K5WscHPSekwG79+eEKQcNZ0qaSF6eno85ExyWAY/50
 5HHTYEKsmquiEd/8azbZVGVqhQGnSYQMdFo8Bn4zfFbbucR60GJyy9yWl5o42n82/c
 /g86NNo3rAhxdjIxew/y2bJcJFZ5GJna7YyEtF3s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.23.162]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LnjFb-1imu0I3HMV-00hxtj; Sat, 11
 Apr 2020 20:50:53 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <146360ce-9cfb-e6f5-1601-fa95460c2cd5@web.de>
 <alpine.DEB.2.21.2004101712080.3039@hadrien>
 <f0b37f45-5144-a1c5-3f52-5bfbb6f3635f@web.de>
 <alpine.DEB.2.21.2004111600560.2369@hadrien>
 <fcbca1d9-7375-b488-54b2-a3934b90c6ed@web.de>
 <alpine.DEB.2.21.2004112036270.2369@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <68a7b3ed-6e7c-b6dd-e665-f6359385e454@web.de>
Date: Sat, 11 Apr 2020 20:50:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2004112036270.2369@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:rjTh5agn/934d5UnjO55LElfS5Qez9s4w2Aenai5NP5FtgQJNUb
 3eDpt6KGeipERae8qb0d3Jhfq8Ne230PUyDJbbf+7gA5fgPayPgpmNBOZPxn2+xanFFceWC
 eF2lqTUkQ36Ouo7ae2ALiFop8VSwrR9UMuZrPvYvWMWm4t540bVs6VuAorty2EF4tjKTlTH
 +dXx9HicqNV7E1VWcCjBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fqdWXorbPjE=:zLQoBlt6glxf7/XVxFSUX3
 //f6tUvsy7Y1SnFnsRTN9+sYCR8WtrgjnESbmILkhGfESnN2KfJ+5N9wPks/9H1qQ2sdXt/Uy
 1Vwx2mYjTmUNOpos32BJS/8wys7Ti02FgQsji7OeXlJcXxsvUF/VgazDRN+x84CZkTxB359fN
 GjHUXsFEVwNxOEma9ZQ5MaDEi+95Q3iacmwagKSdRz+g2H3LUkSrBsrOJTNeizVDZHVOB/wGk
 tUoubmKfwN+fjRCFQ40y99y2C8HFvsxb9EqkY719pgAefhQZ8RS0eSCLdyigeYIErfPbJYMhG
 38xszolzWo20FH7LnVT6OCjINP9tCUhFGG9wZKC+WZUgZOrhmSGNPmn00Jk5+v2DUrWczvpYk
 19cG4TG9iKzAjDgoMXIA9G5KGnwGomqh7864d5hOGTsfS4VS3yth81xrONv3uxjLiinibJtcK
 HuwUFobF/q5HQbfXoIXXKYaIQRmU9n4QRYALO+cjd5YVnNrI/wUuRhewjWr4tSFth8fJtpVRs
 IdjWeuhPUrb1rBv/j3jFiQkXf05xDVt3e/gyEqLw80GONSovvIiLnfilTlGKgdXvCNHGl9xPt
 +y8jQGhVzrRcWtyRxWJLmM71PuX0I8KrZw/lrRCeb1Gzf43tK69LJxFPvONKRVnUgm35C5/Qx
 hytLrlWsSDHW9IISWQCNVI5q0THzosYG/JxzabQNu7VRUjoL4woWrPGw8SVXwuJ4SGW7e0QsM
 jDei9ePbK+/bF+OYtK3scZcBkNx60GFzkzVMNFWNc5c6lj1DkrAv2byloPze4uZnB9XBNFGWI
 rvNiMvX99oXpm0vjfNsdv0qFxmeVMGfbPMDMCua6oVP7EIkcWahiaUaPTJnhDN2+EqOLUSjVf
 NnH33sPlCvyPZcMWgEgxnvMe4myAbgB3OZtjDVBZMEn2dELrCAQJ3WtwPI+yiQfw/uUdYW4gH
 U/sj4Aim0wDyIvn/xRYpPv5ZcPWkSBgCed5mWHB/ImISc/GZ/6XjBcaguwsc1Wcxpg9R5VRs6
 G5lZV64PNfQdJ++jOEBdmcdE78q9ZlgtrIwum4Vl7eooKns6/nN+ngSzy/qE0FEI66QwoMs8M
 Ld7oKa9iq5w6/+w2RrpynnCg3uPdOg9z+Yeq/O2j3D5w/0b38H7F+Xxkzp4sKYpFqKxHE9MYt
 1YPm9/hT8VYM+Da+yOIsGIgmetGNZwo0wvGHrLNwJ7XVpkEWjVzPiQC3e8zc/xhMrvlbNu0Wi
 veZhdOeNIZRw6t5uk
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 11 Apr 2020 20:50:56 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 11 Apr 2020 20:50:55 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Reporting variations of condition checks according to
 function calls
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

Pj4gSSBob3BlIHRoYXQgYW5vdGhlciBjbGFyaWZpY2F0aW9uIGNhbiBiZSBhY2hpZXZlZCBhbHNv
IGZvciB0aGUgc29mdHdhcmUKPj4gYmVoYXZpb3VyIG9mIHRoZSBmb2xsb3dpbmcgc291cmNlIGNv
ZGUgYW5hbHlzaXMgYXBwcm9hY2guCj4KPiBJIGRvbid0IHJ1biBjb2RlIHRoYXQgaW52b2x2ZXMg
ZGF0YWJhc2VzLgoKSSBmaW5kIHRoZSBoYW5kbGluZyBvZiBoaWdoZXIgbGV2ZWwgZGF0YSBzdG9y
YWdlIHJlbGV2YW50IGFuZCB1c2VmdWwKYWxzbyBmb3Igc3VjaCBhIHNvZnR3YXJlIHRlc3QuCgoK
PiBJZiB5b3UgYmVsaWV2ZSB0aGF0IHRoZXJlIGlzIGEgcHJvYmxlbSB3aXRoIHRoZSBzZW1hbnRp
YyBwYXRjaCwKPiB5b3UgaGF2ZSB0byBtYWtlIGEgc21hbGwgdmVyc2lvbiB0aGF0IGlsbHVzdHJh
dGVzIHRoZSBwcm9ibGVtLgoKTXkgU21QTCBzY3JpcHQgZXhhbXBsZSBzZWVtcyB0byB3b3JrIGFz
IGV4cGVjdGVkIChpbiBwcmluY2lwbGUpCmlmIEkgb21pdCB0aGUgZWxzZSBicmFuY2ggZnJvbSB0
aGUgU21QTCBydWxlcyDigJxmaW5kMeKAnSBhbmQg4oCcY2hlY2sx4oCdLgoKUmVnYXJkcywKTWFy
a3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2Np
IG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYu
ZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
