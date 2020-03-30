Return-Path: <SRS0=3ETz=5P=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6B0C43331
	for <cocci@archiver.kernel.org>; Mon, 30 Mar 2020 06:11:54 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79CA62073B
	for <cocci@archiver.kernel.org>; Mon, 30 Mar 2020 06:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="CqUJaiP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CA62073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02U6BZCS017148;
	Mon, 30 Mar 2020 08:11:35 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5E4287750;
	Mon, 30 Mar 2020 08:11:35 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DF2AA7544
 for <cocci@systeme.lip6.fr>; Mon, 30 Mar 2020 08:11:30 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02U6BSV5017534
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 30 Mar 2020 08:11:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1585548669;
 bh=rgIa5/nptwT7LW3zkCGWC3qahXqpFaUN9hmXv9q+G24=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=CqUJaiP6x2RXnejGpqcS2Oy8NYCVuq1Iqw793d0+QW7EfEJzqPUL+EEGqpQn5ArSi
 l7dJL50gyj+wkVUZ1mJTea6+hnuqnq1h04t7x6lvDtizDqfGfGrxb6OLOK3dGgjXXF
 bJigZb+Swmu+a3+83TnVWrrVIfe+bkhTdNyp5hRM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.71.255]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lp712-1ioyev1628-00et4w; Mon, 30
 Mar 2020 08:11:09 +0200
To: Michel Lespinasse <walken@google.com>, Coccinelle <cocci@systeme.lip6.fr>,
        linux-mm@kvack.org
References: <20200327225102.25061-1-walken@google.com>
 <20200327225102.25061-6-walken@google.com>
 <bc2980d7-b823-2fff-d29c-57dcbc9aaf27@web.de>
 <CANN689H=tjNi=g6M776qo8inr+OfAu8mtL5xsJpu4F=dB6R9zA@mail.gmail.com>
 <3c222f3c-c8e2-660a-a348-5f3583e7e036@web.de>
 <CANN689HyS0dYWZw3AeWGBvN6_2G4hRDzjMJQ_adHMh0ZkiACYg@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <2c74e465-249d-eeb8-86fe-462b93bfe743@web.de>
Date: Mon, 30 Mar 2020 08:10:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CANN689HyS0dYWZw3AeWGBvN6_2G4hRDzjMJQ_adHMh0ZkiACYg@mail.gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:zUr3lJ/NPVppiTc4eF5XDZJW52v9k/vHwHHOk2FuiNQ0rJzPPWt
 2vBRciOC1nvzY/uJlZz5H+IYA0h4qmZMk0pEomkS8TWhq5mjLLzlfdV/LQGLnFYkZ+PWAul
 I3EJdMGqI4d1ABmM2aMI+8xtq7m7KbNn36DyVIyvrjHntNrSty6UXFYZRkemL9MHtZjFtY/
 6MmYsW1Fdzi4Qp1qcvAGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NGEqitKj0HI=:pw68C8GodtwkdXTWt4mvfL
 9MYwWAkqqjQIgj6Joq59O4m6h4s2niWE2eF2YSSc//gP3r1YneF2zNxcO9vUnwfnrjbKnx+eq
 J1vRaWb88lZ7YKaQsmd/Evt/ry7VK8wL76Iy0AXqQBctNs9bc7Y7GV4rzc4IzQZ+0ELF22qqn
 hs6+B9vrkgXGSGRqe9Zp2AxQB/oy45xiJTR/KrfFhP8lKjXKYmcRwjy+yS2lWkn6EOG5RUjlR
 78RRRYiLLXtorIfqkjunIUpnoRMmjJ82VKGktEUt1SRcMVgEDSJgrpWdgmoUvu1F47/Ihnukv
 8bhxH3brT7VvIbRWV3eS539nvjCBfHrpLaykcO5bnGdC25LNpN6iVA2Wto3PvYy4poAmw6/Cr
 m5lJdvfT1QhVkwP4iM4MxxIDngYnjlOWFhUrOa1fAbwhpPmmDvM95s/IvtuTHIRG23h6jg/bj
 EQNZxoNxsZ3/IKU/+bnANBKv2cpEgHSWzeKM901hrd+ScrzWyV/k8UKzIaChnBVosg0V+DGrY
 hHH1JvO/mqTkkYSnvMA5jr9+eVo/83hv190B/gY5w2bNhvHcBjABxl8IKHbW5s4yEafUrC4AB
 DZ4DR2504OoP7pX70CK9lI4UHIB6Qu/UZNpmCLI+KBxZQHOmalk+SyfR6VSjWynyFGzU38X95
 sIUIhVGCT3B3/RbU/dmFR8zOjCm6sh/Ntjr+qNSVWgzAHfZI9wxdJilCZnvEgzfl0PKo3/nxu
 HtnLKZFOCBo6/J76hwZc91IDsYe5pVvdDTp4FmypMAz85G7fPxHOeFWacgSUPM/wqwHYOBj/T
 oz/n5gmK3H7QKi7VOhDT8l3BNkxRejpuG0fMu8cVVCm9z2R47WgWbJaL4ZWBbHL+iBpYULybD
 /6+pPUwyqDREApfjL7lQ5vGgFuwXIMx3u0DBiiqxdxZNLs10StA1uEY9BSoNa0lfLf3HqbFe3
 aFzhEerRibEUmWPfKWHien2RV+TcxogKXl9QjAVs46nX7RYAEeA3eTc8xUL0xneB7AX7h5dzZ
 RmM1RaJgM6Wysj5ilbbm1CSzNeLrbQWtJcoTuwznYCJS3f+EOjdetQYkLXP4L7lY1VqB0oJkI
 zG+npcXZB/xNGslqnR6DZbEB9+w8lOulazyCaSvCduRjoT85Ky0Noifv+EgyA4U6JBDlns7Bt
 O135SsbxlawarCo4H8Fy26Sarx6bjFvCj49NXOMMbkC4kPLLwBNGyz+W6dIgPWUl4pHisKMAK
 kOT1Js4+CLeJE6YDR
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 30 Mar 2020 08:11:35 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 30 Mar 2020 08:11:28 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Davidlohr Bueso <dave@stgolabs.net>, Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>, LKML <linux-kernel@vger.kernel.org>,
        Liam Howlett <Liam.Howlett@oracle.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>, Ying Han <yinghan@google.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [Cocci] [v3 05/10] mmap locking API: Improving the Coccinelle
	software
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

Pj4gSG93IHdpbGwgY29ycmVzcG9uZGluZyBzb2Z0d2FyZSBkZXZlbG9wbWVudCByZXNvdXJjZXMg
ZXZvbHZlPwo+Cj4gSSBkb24ndCB0aGluayBJIHVuZGVyc3RhbmQgdGhlIHF1ZXN0aW9uLCBvciwg
YWN0dWFsbHksIGFyZSB5b3UgYXNraW5nCj4gbWUgb3IgdGhlIGNvY2NpbmVsbGUgZGV2ZWxvcGVy
cyA/CgpJIGhvcGUgdGhhdCBtb3JlIGRldmVsb3BtZW50IGNoYWxsZW5nZXMgd2lsbCBiZSBwaWNr
ZWQgdXAuCgpUaGUgY29kZSBmcm9tIGEgbWVudGlvbmVkIHNvdXJjZSBmaWxlIGNhbiBiZSByZWR1
Y2VkIHRvIHRoZSBmb2xsb3dpbmcKdGVzdCBmaWxlLgpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1
Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9hcmNoL3g4Ni9r
dm0vbW11L3BhZ2luZ190bXBsLmg/aWQ9NzExMTk1MWI4ZDQ5NzNiZGEyN2ZmNjYzZjJjZjE4YjY2
M2QxNWI0OCNuMTIyCgovLyBkZWxldGVkIHBhcnQKc3RhdGljIGlubGluZSBpbnQgRk5BTUUoaXNf
cHJlc2VudF9ncHRlKSh1bnNpZ25lZCBsb25nIHB0ZSkKewojaWYgUFRUWVBFICE9IFBUVFlQRV9F
UFQKCXJldHVybiBwdGUgJiBQVF9QUkVTRU5UX01BU0s7CiNlbHNlCglyZXR1cm4gcHRlICYgNzsK
I2VuZGlmCn0KLy8gZGVsZXRlZCBwYXJ0CgoKQXBwbGljYXRpb24gb2YgdGhlIHNvZnR3YXJlIOKA
nENvY2NpbmVsbGUgMS4wLjgtMDAwMjktZ2E1NDliOWYw4oCdIChPQ2FtbCA0LjEwLjApCgplbGZy
aW5nQFNvbm5lOn4vUHJvamVrdGUvQ29jY2luZWxsZS9Qcm9iZT4gc3BhdGNoIC0tcGFyc2UtYyBw
YWdpbmdfdG1wbC1leGNlcnB0MS5oCuKApgooT05DRSkgQ1BQLU1BQ1JPOiBmb3VuZCBrbm93biBt
YWNybyA9IEZOQU1FCuKApgpwYXJzZSBlcnJvcgogPSBGaWxlICJwYWdpbmdfdG1wbC1leGNlcnB0
MS5oIiwgbGluZSAyLCBjb2x1bW4gNDEsIGNoYXJwb3MgPSA1NwogIGFyb3VuZCA9ICd1bnNpZ25l
ZCcsCuKApgpCQUQ6ISEhISEgc3RhdGljIGlubGluZSBpbnQgRk5BTUUoaXNfcHJlc2VudF9ncHRl
KSh1bnNpZ25lZCBsb25nIHB0ZSkK4oCmCk5CIHRvdGFsIGZpbGVzID0gMTsgcGVyZmVjdCA9IDA7
IHBicyA9IDE7IHRpbWVvdXQgPSAwOyA9PT09PT09PT0+IDAlCm5iIGdvb2QgPSAxLCAgbmIgcGFz
c2VkID0gMSA9PT09PT09PT0+IDEwLjAwJSBwYXNzZWQKbmIgZ29vZCA9IDEsICBuYiBiYWQgPSA4
ID09PT09PT09PT4gMjAuMDAlIGdvb2Qgb3IgcGFzc2VkCgoKSG93IHdvdWxkIHlvdSBsaWtlIHRv
IGltcHJvdmUgdGhlIGFmZmVjdGVkIHNvZnR3YXJlIGFyZWFzPwoKUmVnYXJkcywKTWFya3VzCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxp
bmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFp
bG1hbi9saXN0aW5mby9jb2NjaQo=
