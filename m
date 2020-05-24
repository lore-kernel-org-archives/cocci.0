Return-Path: <SRS0=Qcbb=7G=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE77C433E0
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 14:34:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E484720787
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 14:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="LvFnaqTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E484720787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OEY8rg013186;
	Sun, 24 May 2020 16:34:08 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E646A3DC8;
	Sun, 24 May 2020 16:34:07 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4FEA53D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 16:34:06 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OEY3NV007271
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 16:34:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590330839;
 bh=apnT6MjbxTilvwN4/77IoVVwmkl4FygGQ5C9YY2mV8E=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=LvFnaqTt9LOliyXxdwgmpoGUyw/l6etcBY23RWe7ktD6wjyzE0LLE0H1DzDLn+dAJ
 zZ+efsAElCp68tcbK6BgdLtcGVSxBH8/pde2zhfPY4rAaNXTDj9KbBl4qOjaLowLsq
 vciqec8kNTn+Du+glb80yKox5HKnbX4TdGyYszaw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.187.46]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MGARb-1jqwC02Uz9-00FFRP; Sun, 24
 May 2020 16:33:59 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <1d595042-0940-3056-5460-bffd58782fe2@web.de>
 <alpine.DEB.2.21.2005241405010.2429@hadrien>
 <a29f1f11-c12c-6b96-0ddc-09b9790fe9af@web.de>
 <alpine.DEB.2.21.2005241501560.2429@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c2f904cb-8fa0-49c7-f859-833e29ad89f9@web.de>
Date: Sun, 24 May 2020 16:33:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2005241501560.2429@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:n8qK9lNFeoDrtL0BPLPxS6ARRu2JCflBQUtFwbPyxpyCc5H8+wD
 mIJLNG7uRRrtvKH28069ZQabs0CBKs7Y16gt/IeD2tcDqt6d6F0fAt/HcI9rHQp1PVl5lgb
 xcTRpDSRaY3YGsXPCbpblTPshShzhNtE4HXFzlbB0opm9dBRRHTdw6RUBzfj99hNHVFcdMx
 VkhfoMmdRaeCv/o3cK0JQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:agdSek7LXMA=:vva2mSWLbWvGLhYf9zf5Pr
 lYmWHswR93+l0wO8Kac4hpmp+lWshwhBX8wYp7gv6R/ZsaZEVTimHui/J6K0F8sHOxi3gQs+9
 OaiehzIWD9QNcjetNAicDLgZbgJNrGFVCvHizTBvz3EjYemqFO0wyZ2isLMnnGtSEOv+NtFk/
 CP0aYmO5mwfoaJK2GRUmLv01vdT69wIcscBC37qHZW8hmm8nKKsU2rS+ktFizQvPx+o/zLK51
 aiJwccK2ezWiYXSEPO+nKAa59sjNxL7OsfTFh59kj+AYUcOXTK0NK0CAkSB95wZtbeXbzwmHT
 R1z4fS3Qe0LmQPD0dDKzJCo2e6h3kPZxdYlkx4jR3GRtE42n3ltXrnwWpfZvRoMd5i0rP3aox
 hgoPn95uUe1uGa/yZnj5ELlKriQI1KTanj9wG6SDMHnMGK76aAbpCDq1Dj8QWXmgQvJzdar0s
 OtoLSrClSqGtE3JX+igi7oJx0Kc5HR830RLLduxhYQ00HjM/rOvYMOh4veFVV0krLDMSNXopL
 G5CKkvElBAYaqIDND4d5At2NnjiZjwdGibZReSCvPx/Ug9LqKmzeR32nxIZD+A/58xF+HCHdP
 dbAYQ70JcYeRii8UyVOH52O1gMIPLU1NjGDLRceQJzANmoQDJFZ3H0NTi18KLciMQEdeotv3R
 IlWc/LiCABEQ7AZcwXKHWh9mRq/Rk+ZvodeXg+gyYsFLd6QOYbaI/jgI35pnasrKARJhUZshY
 vCoFbI2WXTZlR+QLPM5ssXsaRUo6RPP9EPVK1jXUKmLrsvm0878VbkhdaUF3ocMnOOhFbKiHY
 qRfeTX0svdorw70hf99/ZWtTu4Vy4p3Jie2Mp/ic1HlgDgJf41GF/b5LYhY4clk+2yd79lbNy
 Ka61N9BTUY1IFu7nNH1jx11go7jzguhIflVmn+lIOGNOqS8DegKsh64wbYhH+y14Xy/Gd0egR
 Xn3jz6Y45QXYkEe67hXcNxtP7yF23GD0v4+ir1RMyj99kPpbuoOjKZDK4R+1x6KDXTgcWCcAn
 8VSQ9aOSbUZiYpklu/XO90xgiMxat0gYO1Y8vFcnCNpyXbJHBMdEIPx/0f4/XLdCUNKIqurlJ
 Re7/P6xTHkzzbfpbuPXQuElH/eS4CALPrn66ny+uxu/dJMlzH7t6Xi4M8lU0naculCxGsOXpy
 l+PRU3cV9eAHf0lb4Yy3ezI8THfPBEUW6sTq/9hvE3yY8JvjZbnrmDEj6Crf7wcjQBNSwLDfG
 HpYg0n5U/aIX0a1W8
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 16:34:08 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 16:34:03 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Converting variable initialisations to later assignments
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

Pj4+PiAgOwo+Pj4+ICAuLi4gd2hlbiBhbnkKPj4+PiAgICAgIHdoZW4gIT0gUwo+Pj4+ICsrIFYy
ID0gRTsK4oCmCj4gSSBhbHJlYWR5IGFza2VkIGFib3ZlIHdoYXQgeW91IGV4cGVjdGVkIHRoZSAr
KyBjb2RlIHRvIGJlIGF0dGFjaGVkIHRvLgo+IEFsbCBhZGRlZCBjb2RlIGhhcyB0byBiZSBhdHRh
Y2hlZCB0byBzb21ldGhpbmcuCgpDYW4gdGhlIGNvbm5lY3Rpb24gdG8gdGhlIGRlc2lyZWQgc291
cmNlIGNvZGUgcG9zaXRpb24gYmUgYWNoaWV2ZWQgYWxzbwpieSB0aGUgYXBwbGljYXRpb24gb2Yg
dGhlIFNtUEwgZWxsaXBzaXMgdG9nZXRoZXIgd2l0aCBjb2RlIGV4Y2x1c2lvbnM/CgpEb2VzIHRo
ZSBDb2NjaW5lbGxlIHNvZnR3YXJlIGV4cGVjdCBhIG1vcmUgZXhwbGljaXQgcGxhY2Ugc2VsZWN0
aW9uCnNvIGZhcj8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2
LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
