Return-Path: <SRS0=7xt2=AI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E9CC433E0
	for <cocci@archiver.kernel.org>; Sat, 27 Jun 2020 08:46:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2529F20857
	for <cocci@archiver.kernel.org>; Sat, 27 Jun 2020 08:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Xx8aBxuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2529F20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05R8k0Go018295;
	Sat, 27 Jun 2020 10:46:00 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 044B57773;
	Sat, 27 Jun 2020 10:46:00 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 228BA3BAB
 for <cocci@systeme.lip6.fr>; Sat, 27 Jun 2020 10:42:43 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05R8ggRi011783
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Sat, 27 Jun 2020 10:42:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1593247362;
 bh=FOHh2fdt3V3+vsVbWq85rqcSMRRFbAdlhEpEK11mhuM=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=Xx8aBxuMCrGoq5FjW+gZV+7N5iR3uyxhI+MxTMN+c9GOLXzu/FVoerkyo9q28o8dG
 3yWpjfVJ0vo0nyFkQk7LqeZVj16L4ANotRchtSugjOGI8zgr/Qdh9WiYyH6c1qHZnY
 5ILPMt9dgk5a/NjcFXWV89fy0PCXdkBPcw70hxFs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.65.31]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lhvpu-1j2LHU0LxK-00nDK3 for
 <cocci@systeme.lip6.fr>; Sat, 27 Jun 2020 10:42:42 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <172cbee0-f070-89db-af01-52b10bf659ce@web.de>
Date: Sat, 27 Jun 2020 10:42:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:YoYRyXA1JFJoV1JNbbawfYEIDLmF1Gv/QS87q+Lv4RlECT+mvT/
 yPI+09JsHFMs3nNThiZFfI3I2iSTqo95jQ9PgqldByAe4Vo2Oot9Up6TZG0HFVhFq+46e2R
 jB3Ts13h+wwGtzBq37Q0oRJ579k5xHxZcYPk9jQHHkbzgxEGzkqyfOCAhhiiS0La7zv2bTW
 k7HySZKSG518/wXjfuvWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+3u+4gVDmT0=:ycD0olKo/SjbeZ2FLotyP/
 19HBFk/+Uz9C5AojulBuubTsH6Uc6NxvUsh5IjDpYpq3ILwpwIh7xup00veeTEvnSMG9FHw19
 RL3ovRsInnMq23MeCHR6E7+TZGkCwwp8jfT4u/x9s7u+o7c0n2gcq7Sffi3/SKaVWrvW4GHuv
 pSYUJIBKiRP8jGeasJaCiUoS7lbFO8uNOW2g5XBPRIaYs6XJo4OZ3fJ5knxyi3pyuJLMRgVL8
 VDhSDFOiYXR+jSz6mlxWXChxQzt38nF6+1f2Im9gQ7+gYY8lgzaHdqv6nDeUIp0tnWgeLnmwj
 arppMKFNLxKKRiKsPY6YFKKFpGCT+aSgnaiXnAo56bU0Hte6LXtgOUk168ImuQSX81X9glbUi
 pC4tcSrdXMLHAAdsPOYrXhs07jYSvBnWpW+MPXe5fC/LHpFgDtm6ovZR56rHHupdpdL6UBtbZ
 mHAuecAWqSjpqlkp1FQ/19pu7TjokFX5KB2SXbsVxIn4EfA+3kUPdNAnBayZUgKyStwu+zFen
 GY/iYYg/sXFIqKk0Mj32/A0oZXlfgpcXRgqpEPhXL54M0vtKPrdaZIlaAWIjdtXjarclG7P66
 Yg0R8pjOFrmDKCT1oBZ01j/tq5IUaOinzKEC9Nad4pY2K44tRKBlWjY/yuG6/+37E6cxRP4l/
 Vexuz7XKc1HxDa3fP0iRTbl631GLjMakHe80qD4R1vDYmbeWQzPiG7XxMlSN3/HSb0GYBjIji
 7XmFooUsJhkpi6dL1KeMYjWWXoXa+mfrBTRSs7WX2uuOHee1+BuvE/p9kVNS0w9UkrjSfxCtk
 evc98J0bIEu/qQhF1I06PCL99LNdqRgHBKicneVoLanGQ45CTwnfBTJqeJPy/y83nY1InFAqX
 LmjzFmQ6xN6AIDzTXVrqGxbQ58YRvZJGJl7VtUnlkcS/HEaIV5e5t31ytpuFYBWZUJCeiP8Rc
 xSDlKpZ1LbWacnyoUKPol0wsgtVJq9qdbGQDZIGF8PNlL2b+AEFeYX/tAKPFSdtVpkZPJJmDv
 G1lKKyRloZJAH8q9mZDLdG0mriyigTqEmI9MyJ7XZSQcjoYUvzaDQCTp4ds1fJ9S6U5tiMtEL
 NOATfvmpHFzsoDfy+vM94beica24JZV93bLn1Sg1Ndj0SIURCzVvX+yLDmvIXzs1QdT4GqlnE
 lDna0kvi3chIlOkGpSW99+/1NPXsZqlRWdUMXgZFN1m/N7hDcxtOyshRk+mp6Myct/eLQmNWn
 4NtYJTGBmyWD2v7WT
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 27 Jun 2020 10:46:00 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 27 Jun 2020 10:42:42 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sat, 27 Jun 2020 10:45:58 +0200
Subject: [Cocci] Checking data processing results for a special SmPL
	disjunction
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

SGVsbG8sCgpJIGhhdmUgdHJpZWQgYW5vdGhlciB0aW55IHNjcmlwdCB2YXJpYW50IG91dCBmb3Ig
dGhlIHNlbWFudGljIHBhdGNoIGxhbmd1YWdlCihhY2NvcmRpbmcgdG8gdGhlIHNvZnR3YXJlIGNv
bWJpbmF0aW9uIOKAnENvY2NpbmVsbGUgMS4wLjgtMDAxMzEtZzY3NWI5Njcw4oCdKS4KCkBkaXNw
bGF5QApleHByZXNzaW9uKiBwb2ludGVyOwppZGVudGlmaWVyIHJlc3VsdDsKdHlwZSB0OwpAQAog
dCByZXN1bHQgPSA8Ky4uLgooICAgICAgICAgICBzaXplb2YoKihwb2ludGVyKSkKfAoqICAgICAg
ICAgICAqKHBvaW50ZXIpCikgICAgICAgICAgIC4uLis+OwoKCmVsZnJpbmdAU29ubmU6fi9Qcm9q
ZWt0ZS9MaW51eC9uZXh0LXBhdGNoZWQ+IHNwYXRjaCB+L1Byb2pla3RlL0NvY2NpbmVsbGUvamFu
aXRvci9zaG93X2ludGVyZXN0aW5nX2Rpc2p1bmN0aW9uLTIwMjAwNjI3LmNvY2NpIGRyaXZlcnMv
YmFzZS9yZWdtYXAvcmVnbWFwLmMK4oCmCkBAIC0xMjYzLDcgKzEyNjEsNiBAQCBFWFBPUlRfU1lN
Qk9MX0dQTChkZXZtX3JlZ21hcF9maWVsZF9mcmVlCiBzdHJ1Y3QgcmVnbWFwX2ZpZWxkICpyZWdt
YXBfZmllbGRfYWxsb2Moc3RydWN0IHJlZ21hcCAqcmVnbWFwLAogCQlzdHJ1Y3QgcmVnX2ZpZWxk
IHJlZ19maWVsZCkKIHsKLQlzdHJ1Y3QgcmVnbWFwX2ZpZWxkICpybV9maWVsZCA9IGt6YWxsb2Mo
c2l6ZW9mKCpybV9maWVsZCksIEdGUF9LRVJORUwpOwoKIAlpZiAoIXJtX2ZpZWxkKQogCQlyZXR1
cm4gRVJSX1BUUigtRU5PTUVNKTsKCgpOb3cgSSB3b25kZXIgd2h5IHN1Y2ggYSBkaWZmIGh1bmsg
aXMgZ2VuZXJhdGVkLgpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9kcml2ZXJzL2Jhc2UvcmVnbWFwL3JlZ21hcC5j
P2lkPTk1YjJjM2VjNGNiMTY4OWRiMjM4OWMyNTFkMzlmNjQ0OTBiYTY0MWMjbjEyNTQKaHR0cHM6
Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjUuNy4yL3NvdXJjZS9kcml2ZXJzL2Jhc2UvcmVn
bWFwL3JlZ21hcC5jI0wxMjYxCgpJIGV4cGVjdGVkIHRoYXQgdGhlIGZpcnN0IGVsZW1lbnQgaW4g
dGhlIHNob3duIFNtUEwgZGlzanVuY3Rpb24Kc2hvdWxkIGV4Y2x1ZGUgZGlzcGxheXMgZm9yIHRo
ZSB1c2FnZSBvZiB0aGUgb3BlcmF0b3Ig4oCcc2l6ZW9m4oCdLgpJcyBteSB1bmRlcnN0YW5kaW5n
IHN0aWxsIGluY29tcGxldGUgYWxzbyBmb3IgdGhpcyBzb2Z0d2FyZSBiZWhhdmlvdXI/CgpSZWdh
cmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3Rl
bWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
