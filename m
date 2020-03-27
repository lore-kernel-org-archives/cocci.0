Return-Path: <SRS0=pejK=5M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC10C43331
	for <cocci@archiver.kernel.org>; Fri, 27 Mar 2020 07:23:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69EC220663
	for <cocci@archiver.kernel.org>; Fri, 27 Mar 2020 07:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="lZNXOZdu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EC220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02R7MmIh002849;
	Fri, 27 Mar 2020 08:22:48 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A7D9D780C;
	Fri, 27 Mar 2020 08:22:48 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3CEC33B63
 for <cocci@systeme.lip6.fr>; Fri, 27 Mar 2020 08:22:42 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02R7Mf3h016868
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Fri, 27 Mar 2020 08:22:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1585293742;
 bh=OqID+F5YKqstqG67ktpJoRYJWxSZEEncWCl+pS0xRtg=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=lZNXOZdutg/NKDCHLOS3+qqczGppbjdCYSRcuC79VYe4nbfB8W6fWPKlchV4FSg1U
 wSAyn2aUTMHTBrwHAy3Jfj31Rl51fFdyAc6m/KFX3NnJ7qr2rqOGfrzwMab+NVP261
 A/28hyah8A1HFRdCrFpdctPA+ku39yUmHJjNzShc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.164.253]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MQL8O-1io3uM2BYK-00ThUp; Fri, 27
 Mar 2020 08:22:22 +0100
To: Michel Lespinasse <walken@google.com>, linux-mm <linux-mm@kvack.org>
References: <20200327021058.221911-1-walken@google.com>
 <20200327021058.221911-5-walken@google.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d780d91f-43fa-b2ec-1a08-80013b153a56@web.de>
Date: Fri, 27 Mar 2020 08:22:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200327021058.221911-5-walken@google.com>
Content-Language: en-US
X-Provags-ID: V03:K1:+9VyvwMgnr/si6fFBrSdG8XdHyJkDGUeqdpG/LNSAb323/uph+Q
 6UopwmGwrgakZX1OEC5jEFf7mxpJxp3Re9pFZT3AKIKLGXt2itbydJ+TFLPoYfszcPSX+7X
 rpb4lc1YdOO0wcPaJnEQL+gON2BS96wgXuurZmdh0bTuX3gGPagPooCee05rA1QgFt6sqi9
 IXaA2P21CWTakb0s2XzyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S7USi327yaU=:LTfeStMAsNHmJiEDSDtMlY
 noMw8mlC1xi8usaOQog1trXub876tfUtyGo/dL43AdzmJt9HtX1kKmK9npB3zX/qWMfa//JcD
 uVsYZLxVPzkurGlAGJzKvqwigDTwSykkpOOwu9WaClYR041+W9Z1yR9GBf1/MOZOAob554hyl
 Wa9nThXDHCD5mZ+7CwZ0ZdFeX5gY7+8A0hrqCAgoPZYBv0i6/cTrk1pRKaknVlv8E0q6Gc0oj
 kOzmdXjv+1L8RdFc6Y446rGLXlhnt7u4auO9Xc6q6wI8V0x/O+BcqdWU3n3gM7f5pM9q84Zyu
 GndwIKWpXvC3E6afX5oLA6KkoFNs6d1O40GfRdAhzTRpd+EgkvPD9A73tUc1rUttloYu0WY/0
 PagbTeLrpC2Smc35GLZxAzx0ZYfAYrKaIAu9qWr3UU5+6wddcpp6Rd8rEjMNn9j/RZtatAw7i
 yxkv1GZhFP03aPH20OXnswDDKi1wgeNz/W58BG7ycOBouydCM4YYYaLpBK4rdd+4ah6gANf08
 gJpXRmPYpdZkv6h7Pnu89FkGBdqWpJmZqUv97C+Hm0fVKYvxpXDYuA7K5MELI0xUvk5qEKDek
 re9aXEtjOe+B5b1YPBud7rmTU4/01nopa6QuDp/2YlMetPkGHo0WluFIylyuap9coYZefx7Db
 SZScIUUrVbEmampfxpA63tj0wobgNzhe/+899IDLNqowA3tXX0wGrISOfQLi2Le0zASlsc2K5
 cUC63Fb1heNHD2SsY/Hg+pTfZ7jCFSlNIoWyo8LY0vKMR2ICQOFiOUkVLZuUl7UHyTMjJcDk1
 /tJa/BI7jf+eIbmYciv9PORF9lD3y/1XXf/tnIjjKGFrMTY+hYG1ZLIY54N2/p2MmfLktRsuw
 0PlGK5nIWliCtozMDR8TxPxUxlsmBen14TkgD1dLPRaRM83Hyry12rAqkaqxJeZGW0VWdYUTU
 C5+lddFPWj2yMr1T1UDNIJJ8EastfjKWgxC6ElELGfZwE8oAy3rkLalU5dgaXSNwy8uMjUW+V
 PHUHEVHMkOu/MkIOalfvLltNu7Jhlc8TNXqyMHEbUGdTsjrXrmKdNhkDJ3jWnmCS99ZB8zUfY
 AQLUPQj+miqLe3g+04ifWP4+8sfuRPVM0MChDt8K3zM6rAFDGo+7c4Bp4n4FbiDbm/07MupUS
 wYtO5+WeJp5iAuBUAW4rIGsTVCW4rkfJ1DgYWEJlv5HtU6jJzycgydYvqJFeRoLO3ZHKaVaqu
 NdCqijGXDWpOKrCoO
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 27 Mar 2020 08:22:49 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 27 Mar 2020 08:22:41 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Davidlohr Bueso <dave@stgolabs.net>, Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>, LKML <linux-kernel@vger.kernel.org>,
        Liam Howlett <Liam.Howlett@oracle.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>, Ying Han <yinghan@google.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Coccinelle <cocci@systeme.lip6.fr>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [Cocci] [PATCH v2 04/10] mmap locking API: use coccinelle to
 convert mmap_sem rwsem call sites
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

PiBUaGlzIGNoYW5nZSBjb252ZXJ0cyB0aGUgZXhpc3RpbmcgbW1hcF9zZW0gcndzZW0gY2FsbHMg
dG8gdXNlIHRoZSBuZXcKPiBtbWFwIGxvY2tpbmcgQVBJIGluc3RlYWQuCj4KPiBUaGUgY2hhbmdl
IGlzIGdlbmVyYXRlZCB1c2luZyBjb2NjaW5lbGxlIHdpdGggdGhlIGZvbGxvd2luZyBydWxlczoK
CldvdWxkIHlvdSBsaWtlIHRvIGFwcGx5IG9ubHkgYSBzaW5nbGUgU21QTCBydWxlIGhlcmU/CgoK
PiAvLyBzcGF0Y2ggLS1zcC1maWxlIG1tYXBfbG9ja19hcGkuY29jY2kgLS1pbi1wbGFjZSAtLWlu
Y2x1ZGUtaGVhZGVycyAtLWRpciAuCgpDb21tYW5kIHBhcmFtZXRlcnMgbGlrZSDigJwtLWpvYnMg
OCAtLWNodW5rc2l6ZSAx4oCdIGNhbiBiZSBhbHNvIGhlbHBmdWwKZm9yIGEgcGFyYWxsZWwgZXhl
Y3V0aW9uIG9mIHRoZSBkZXNpcmVkIHNvZnR3YXJlIHRyYW5zZm9ybWF0aW9uLgoKSSBzdWdnZXN0
IHRvIGNvbnNpZGVyIGFub3RoZXIgcG9zc2liaWxpdHkgZm9yIGEgYml0IG9mIGZpbmUtdHVuaW5n
IGluIHRoZSBzaG93bgpTbVBMIHNjcmlwdCBpZiB5b3Ugd291bGQgZXZlbnR1YWxseSBjYXJlIGZv
ciBuaWNlciBydW4gdGltZSBjaGFyYWN0ZXJpc3RpY3MKZm9yIHRoZSBhcHBsaWNhdGlvbiBvZiBz
dWNoIGEgU21QTCBkaXNqdW5jdGlvbi4KSG93IGRvIHlvdSB0aGluayBhYm91dCB0byBvcmRlciB0
aGUgZWxlbWVudHMgYWNjb3JkaW5nIHRvIGEgcHJvYmFibGUKZnVuY3Rpb24gY2FsbCBmcmVxdWVu
Y3k/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRw
czovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
