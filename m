Return-Path: <SRS0=PnfW=3F=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF19C33CB1
	for <cocci@archiver.kernel.org>; Thu, 16 Jan 2020 13:43:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0889220748
	for <cocci@archiver.kernel.org>; Thu, 16 Jan 2020 13:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="eo9ew7/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0889220748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00GDh0qf009092;
	Thu, 16 Jan 2020 14:43:00 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DD3B177F5;
	Thu, 16 Jan 2020 14:42:59 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0F5DB77E5
 for <cocci@systeme.lip6.fr>; Thu, 16 Jan 2020 14:42:58 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00GDgrWG007657
 for <cocci@systeme.lip6.fr>; Thu, 16 Jan 2020 14:42:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1579182171;
 bh=NHwhfK2RKLbezT2KFoVNX4H0hrSGTiUTLIE4Thycr80=;
 h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
 b=eo9ew7/5Xr6WbzvKO8kMswoFXHSaHog6WxnlDni/ajqf1Nz+T8fu9WAczk+PIWgNl
 fTj4DAO5bhH0A+jMo5JQyfKO+FYFfohbI3qndheAamknnbvT5+LF53t/0iWK5AaJmB
 eS2rCACWPleVwe28ziuosrdeBbdnodXgfQsQb0CM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.6.163]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LlsUC-1jRQEt2Nwe-00ZSvS; Thu, 16
 Jan 2020 14:42:51 +0100
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>, cocci@systeme.lip6.fr
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <41117fb8-0a18-1292-b321-076aae4a75f1@web.de>
Date: Thu, 16 Jan 2020 14:42:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:3t7NekCEz0IAwv9cFfBJC7OglqDasTfcKSCExp7UysH6LI0pyPY
 MDu/1GE8tMXBD9+7YSp+Dh27ehG5Nzwe9FtU+Sa7dYTulHVBadA85L/pwOC4k/mNMXjSipo
 aFdYe2yCH5Y1CY41nEAv79wEswPPS1eoi9sIY0O880MFp6NoU4WATvOpqYz3hQDffCQtwnU
 Hb9cOgh+tPFg7Ut+/KjGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UnUWziM/1iA=:7b6DJaQjagrZpbI9MazMjt
 wHHSRa5YRPhmL177nxiLweLfZFeIZOYJp5xmcliC6FfXSVkx5ZZH2+0dWPZt7QA/z5jTNSQsL
 qtUspkBcqLNX7yej88fKSkDdmmHCGtWS5AqPkv+1dapnZfE06NMDqG0rBK3eB3H67pg7ztg9S
 jaDUZ5IL5NCMXwWY9awoxdQa4a3FgJ9Tf2ORc+fWAVrvtMOjQ1bi4Yr458RVYK1ar1uki2joE
 6zg3JrNxTOY4GGqySh9mgcC3loE7RbcXZpiPBaGFi4qbKziHyehnTEWkMQty/AIIF3HqDwF3B
 1sqpTzWwvDpCgyMVnMH0uLcoX1GXd+a+imvAdil20Tds/oY81e0IgoT4C5o6l5qrqeJI4JsO8
 pDrlLOSnLu3L4z9Dj6XVsXBmSXrrwk6ydtLhtYBcNAd2TKenYtOb7pIHolR88kFZUiwtRYkmP
 u9v3b48IwBQyZHAi30V6Jdjepww3dBzbPQgvQoM9yeVL7oSn5k5RRYmgXBU2SShQ+OYgRdrUK
 2Bc4tbmOuyInBCWsdWDnbVjoq+ABvgHigOZFxwNGEqAWZ/NahcEzqA+L0KOZQx1WjsSK+NR3A
 DOQmKJSIMTAD4ZQvVKz/chFSSZrddbFj229uRIMYEbK7p9xuWCsntP0oUwZ9dHQrmf/kGWa6j
 Y1VFEM40tcw86Ww4NhPqLVQXrsZ6PR21b5kcuZvhKcgZ0RrLpgOWLLwuux0B2lzt/LMVPFlKm
 PNq+t+jQKb/9/3bX3ZEDp0TvNYOqnGjKa4KyzT3LgZDIHJqqQWjJRUD2gYbEh8yb+MBW1f5ZV
 B0QiTLCiFsYkYC3GJHe/B+rap7DMQcm95BW6b0gzudhlT6D7EhJlFTtX9mFCS1BKtr/jgcBEa
 t6XuC13qJHLMMDu0mr/KaHaTmFmkH7Dcmo0S3WzmcspKKzGxwTRiZAfJnx8vBXbEUH4uu9tf/
 Kuj472vUrgwzmdx2lfRSfHlwlqJmJCVPzw1IoZ6BJjkwSq5fBBy1/Qon/s1jG7mjZW8qc8/DH
 dGc3CaaWEC73Gkl+kvjTEly17HgIb485wWGOGvNfXqelBMbhc17Vo8AqZXo0ZDfvD9ry1lu0F
 VrUDdl7+u7uwZQcNqJ+1cjbpF6tP3Vo0ykfoYO711M0mHXnBvm4XwkLuWkCAcHtriuPaDjwzr
 obKc97TP/+K3frkTb4LOFKbjyZQeeU48G8JTij71F+lVUBSXv66t3aN3GvagHz6xC0roGbA8P
 P9eBGZcvvMjkznDRoaePJ9VdV9cWl1UHB0QcH+8LRwfPmSdPIZ2pxJa3Ah9A=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 16 Jan 2020 14:43:00 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 16 Jan 2020 14:42:53 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Cocci] [PATCH 2/2] tests: Add test case for * const *
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

4oCmCj4gKysrIGIvdGVzdHMvcHRyY29uc3RwdHIucmVzCj4gQEAgLTAsMCArMSwzIEBACj4gK3Zv
aWQgbWFpbigpIHsKPiArCWNvbnN0IGNoYXIgKmNvbnN0ICp5Owo+ICt9CgpBY2NvcmRpbmcgdG8g
d2hpY2ggY29kaW5nIHN0eWxlIHNob3VsZCBzdWNoIGEgdGVzdCByZXN1bHQgYmUgaW50ZXJwcmV0
ZWQ/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRw
czovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
