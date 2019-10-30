Return-Path: <SRS0=bhL7=YX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D023CA9EAF
	for <cocci@archiver.kernel.org>; Wed, 30 Oct 2019 08:41:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A70F520856
	for <cocci@archiver.kernel.org>; Wed, 30 Oct 2019 08:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="oVufxpss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70F520856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9U8fLa9007851;
	Wed, 30 Oct 2019 09:41:21 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0F2F376F8;
	Wed, 30 Oct 2019 09:41:21 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 24DB174CD
 for <cocci@systeme.lip6.fr>; Wed, 30 Oct 2019 09:41:20 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9U8fJm3015829;
 Wed, 30 Oct 2019 09:41:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1572424858;
 bh=Zvh6PElDHOvLvzhTAFQmYtBoj7EBVf8dG1gdmzcc9Eg=;
 h=X-UI-Sender-Class:Subject:Cc:References:From:To:Date:In-Reply-To;
 b=oVufxpss10/MEg9GR7sMJabX3XIszFjeYUZ68TasNm0Amam+UZ4WbDLJvQHQYVfv4
 rEr6U0Oj/kqv+SfC4nYJJP5y0ubgT7lw74gvPy04gH/joZrR9KSSb5N+NN5U7XwBYy
 emiyXGz3EaxNQc/qgRplqdYSqj3WBWEn8srcPwo8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.104.79]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LxOQ2-1htOoC06zS-016yXx; Wed, 30
 Oct 2019 09:40:58 +0100
References: <201910301059095572036@zte.com.cn>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To: Zhong Shiqi <zhong.shiqi@zte.com.cn>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
Message-ID: <d457995b-fed3-d560-e6b3-b8fa4b0059a0@web.de>
Date: Wed, 30 Oct 2019 09:40:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <201910301059095572036@zte.com.cn>
Content-Language: en-US
X-Provags-ID: V03:K1:Plh1uJC1FphsuVWzEOoEvaOSNpyW7XB5MX+FxuNADIiNj4T4ANs
 5xjE01LENnlQ+yN0/CeoxB1rIxTs7zEWBTLpguE6v4T1L5sGSid95MCwsjaYN6J/cIPzUtS
 WJCZVCpjMgMXg4sThq2rFNhcjIblW6kFBAh7W+AMRyAvss9vGpnnOTV38crueLqESOXKfmR
 mN9QzRUUZP+DbaHzICBWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N1XjkKcbh9w=:Oo6JQjx3OCTrFdDGCudGln
 uxxiDYKmUBvgfmACwcKchSwewiZk4h/kDfNJiKNFhhSBPoxD921dZpXFEjKxeo67ShV3a1YWV
 d/aeORNFJB8FMzatFGKqLn4QTPZCYIBsLGtRBa2qCCgjIvXBoBdc3u5swjlPl7/5bpnVSoaQI
 OKpAZitFEHZPzSrkgxUkeZU0SNsc99J2WBmhsYgJbOQ/MFDUyrZxGN9E4Y3K8HtisArP2iht7
 ZVxywBDHJDO3vq+TUrZPIyWii3PNck4egmjhgMlXgfO+u4febT8nlCbWm4+IChAnVj/TbJ8PX
 nS80ike2va6LUorqZqmE2ctTs4giU+twRqWoBGL90N35fut0qU9uBRa2wBIWVYEA/zxNuF17D
 wHfAMs+ntrMy/nvo2kdkvV4n6ooWn9IeZhdArgNP5HUHxno+DuSdiveAAyz/muXHmcaKjvJfd
 mcVuy7KXUqIzZxIpZueOqWeyfLdbuPljpif79oUjSe8276pSLjzlcx/y0tHp6AxEGLE86YkfV
 Sptiabb9upLikYIrGlrWgPTht7ZDlK7otvVHKDgQu8kB0i0RCo/m2WKa+83gYI5y3cDTGjiIh
 TSd02Rd5GiSIBXGi3Kt9/2z8bfKsQWKXQdEfrALe6iKoO89UDtnRanZYeW4zp6letx8azhRM4
 OpKM/xAKX0tcwZv5/PlM1wEAbJvxyrnF1kv2Fv6mgAgMQd0jeLRD/de5N2npzfmBGBl6kaazo
 ThJNJ0JkqdLszRTWhPCtnW6tEJk0Pe9UkQq1EeM2Yqzx0l34a1R7KePjezpJgXKe9VjVQ8aQt
 2IbU0/70qnSitiQLoDnHWLCBeQRl5v8K6uAi/u3TM3+njz5YnOF5YDs3YJSpUsNt/BYJQoISu
 AQIrGjRlwYOaejcogDzUUFXdwFy+plxfvbVPklIL/vNaD5rUU0rmARrYi5Ls7MTbL1Ab1tvQp
 iO+IMEIFFzgattPfb6+GdceUmKpXWhbv05MBNIpdg9ZhZdU7PqXGaGouHEHV7m5au3efgKT8Z
 IvYlziQPf1XoOxFIpWu96XsJCkRUF6ogGZzEoUjC+ltFcUVAMa3hQL+b7Jcq4rfxYoXTJAg1S
 Pog21xAZKNPUIULFf3k2KtvKKJqAmO9H3GR60cTBkpGpwJ0RPcD4p2wbawqQVDUe1cRARUgW8
 VSpbXEO8veHJWW9V5b1zV8OOHSVjkS9D/ZVAI/zfVznl9AKWPkNt3PMzoYIVYeeCWjyyPvwG9
 RBRj3BpfPr6IJrjQ0tpmUu/4+ubc4PZPxisN8apYdqrpTQk9e6wxgvjCALoo=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 30 Oct 2019 09:41:21 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 30 Oct 2019 09:41:19 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>
Subject: Re: [Cocci] [v4] coccicheck: Support search for SmPL scripts within
 selected directory hierarchy
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

Pj4gUGxlYXNlIHJlY29uc2lkZXIgYWxzbyB0aGUgc2VjdGlvbiDigJxVc2luZyBDb2NjaW5lbGxl
IHdpdGggYSBzaW5nbGUgc2VtYW50aWMgcGF0Y2jigJ06Cj4+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL0RvY3Vt
ZW50YXRpb24vZGV2LXRvb2xzL2NvY2NpbmVsbGUucnN0P2lkPWY4NzdiZWU1ZWEwYjU2YzM5Y2Qw
YTI0M2UxMTNhNTc3YjVhNGVmOTIjbjE1MQo+Cj4gQ291bGQgd2UgYWRkIG5ldyBsaW5lcz8KClll
cywgb2YgY291cnNlLgoKCj4gSG93IGFib3V0IHRoZSBmb2xsb3dpbmc/CgpJIHN1Z2dlc3QgdG8g
aW1wcm92ZSB0aGUgY2FzZSBkaXN0aW5jdGlvbiBmb3IgdGhlIG1ha2UgKGFuZCBlbnZpcm9ubWVu
dCkKdmFyaWFibGUg4oCcQ09DQ0nigJ0gYWxzbyBieSBhZGp1c3RpbmcgdGhlIGRvY3VtZW50IG91
dGxpbmUuCiogRW1wdHkgc3RyaW5nCiogRGlyZWN0b3J5IHNlbGVjdGlvbgoqIEZpbGUgbmFtZSBz
cGVjaWZpY2F0aW9uCgpTZWUgYWxzbzoKaHR0cHM6Ly9kb2N1dGlscy5yZWFkdGhlZG9jcy5pby9l
bi9zcGhpbngtZG9jcy91c2VyL3JzdC9xdWlja3N0YXJ0Lmh0bWwjc2VjdGlvbnMKCgo+IFRoZSBv
cHRpb25hbCBtYWtlIHZhcmlhYmxlIENPQ0NJIGNhbiBiZSB1c2VkIHRvIHNlYXJjaCBTbVBMIHNj
cmlwdHMgaW4gYQo+IGRpcmVjdG9yeS4gSW4gdGhhdCBjYXNlLCB0aGUgdmFyaWFibGUgbXVzdCBi
ZSBpbml0aWFsaXplZCB3aXRoIHRoZSBuYW1lIG9mCgrigKYgaXQgc2hvdWxkIGJlIHNldCB0byDi
gKYKCgo+IGRpcmVjdG9yeSBjb250YWlucyBTbVBMIHNjcmlwdHMuCgphIGRpcmVjdG9yeSB3aGlj
aCBjb250YWlucyBzY3JpcHRzIGZvciB0aGUgc2VtYW50aWMgcGF0Y2ggbGFuZ3VhZ2UuCgpSZWdh
cmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3Rl
bWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
