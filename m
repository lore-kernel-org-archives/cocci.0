Return-Path: <SRS0=j8Co=YT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3495BCA9EB9
	for <cocci@archiver.kernel.org>; Sat, 26 Oct 2019 14:14:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB24206DD
	for <cocci@archiver.kernel.org>; Sat, 26 Oct 2019 14:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="sYWbBDzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB24206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9QEDLGI025574;
	Sat, 26 Oct 2019 16:13:21 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F335577BB;
	Sat, 26 Oct 2019 16:13:20 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 41C6D77B4
 for <cocci@systeme.lip6.fr>; Sat, 26 Oct 2019 16:13:19 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9QEDI8h025484;
 Sat, 26 Oct 2019 16:13:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1572099178;
 bh=4TX9IoVt02UjctuLRVcYz2uZPBenhwfAGXWjWXCWIyY=;
 h=X-UI-Sender-Class:Cc:References:Subject:From:To:Date:In-Reply-To;
 b=sYWbBDzlH+FENo6oHworMEhP5RrV+NQt2IeFZXgtJRrcV1sImqp4V2CKhiNJ6ALeQ
 Q19GuZ1FybT3FkvblmwPBg+FGaHHQj3TlKpM6lxGXZa8hC+5KXJMb7RUgbLiwQMZ+y
 281D33a6dxZf4ihLPgOX+h+aUfr6IsvbaPuLaA/s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.128.16]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LmLoU-1hprL603IQ-00Zw3b; Sat, 26
 Oct 2019 16:12:58 +0200
References: <1572076248-43770-1-git-send-email-zhong.shiqi@zte.com.cn>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To: Zhong Shiqi <zhong.shiqi@zte.com.cn>, cocci@systeme.lip6.fr
Message-ID: <4905e8f0-6266-99b4-c3c4-9a9d29170bfc@web.de>
Date: Sat, 26 Oct 2019 16:12:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <1572076248-43770-1-git-send-email-zhong.shiqi@zte.com.cn>
Content-Language: en-US
X-Provags-ID: V03:K1:79BWvNPOg0pzpn3iMDrTDvfOhMnHcdEW2GsebM2qXprGG+vsMg+
 UUX95Ut6h5KlwXgJNvW3TvvxMgM4/utdnl3U49CzwazEQdjEhPZIbLF0Lmx0jFt0oX6VG8z
 6ERhLq7jzCf4cNBZnZGRVf0A9t381ptMkTF6siHfQtpPJwM2Nsbk/QLKs/UAAXWH86YKI58
 9CdoFVWGZSA+QPKwuWeKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yPG9bh0oOqo=:EmUCOy13dNt7nQ5dcyB7ta
 n3VS2+00Iui5+CScQG8TYYKtdLLQREsqzWCjL8SOKkRSGhRL2/trOBh5Wpd2e3kxoBzbpaTps
 FOdgeVkSMC27gN3DPHSMZyfEAqmljVfccrChh1ngHAxFRbF0C6BSKB3Pdecq8LUC96fRXfWTt
 SBighSYqyWA/TZ+b9VLKX4yUROpdnrBAia46UKY36crmcXuEm0fPz08lRHVfTy+TndDGBMuqr
 EvMAoiov3XYwX3+k5WYfXMTYOqKHy+6M4BwsD8Od1rVXLub61WhHm67zg4imi+ARxOIhGx+3y
 3AHwlGI232OpJABCwTkbnJ9/TF79+d9j1wX1SbDEKD37Ek7MZ7wtKI3MqDxuqp87Vc5hskOY0
 IwT3y7y804C8K6xK3jk3QOJXaf8ctiscPzs34NjMAmIHpJsmEwx0jvxqbpnJTTRUKWb9dAMtp
 PEvNXL/jRy7n9/gg3C/xyB7R/7gkReB0m5zYHtujGvgn0NPcVgy9ZSyXlwY24NaKeQYvLetWc
 Zr+xVPcWDsJEXU4poqIRj3HZrmxCY6clxVzN5NlcFirzbf7HcQdqU1bQvjd0nBux8wKUEaVZr
 eR8xpr22SmWw82M1cDKyzowat2yn6qH6mL9mPam5yXVyX7JyS/puKkGcH8BCb6OWfGye8zrol
 UcX5DGyTJVYF57ywAisfujdcs7TQw50lyt1qtj74JT7CB9Q6xwa5ktzGDHb+C4w31bjzcs8L7
 9Gui6xrx2iW1ZzxJ0pR63/yVuHRI90x+mDTayiasC+j4mHMqLLSfzWjutlcThBX5dxouAawrN
 E1prO5MNPThg+OHGJtGU6QvxohCSgmzfTbQCk34nsnNOU18mOZkhJSp/ezG2kAOCc5KSMAfW8
 w8L/3e+b9tBa2XHPJZN26eFJVpKg5sahhnIx9rzcsFdABnvOR9UB9zB/U6GxPCYa5gTA0t/Ok
 EDBG2PYvcj5OUoHBcEzV5nrTKhptiwPWVkFylJZ/iDULJ5Pz3MWAx2z8iJSsfVidBOJZtbXHC
 3Icvd70aJRvWtxBNQwXPxyn6KypoPn589uK4FBjtHE29qcn9X0z0He+PQ7BYr393u7FCoAgMc
 bMfdhgfMrNXiLp+HqzSTtui0a33lL8zXMi3UWIpwNAA7MRf11jSajLADGIu2o+mZPJC0/gXov
 zbJaaTjYcc9lPVdjyBzIWaZ4IUi/axUMfM0Hw1gCiakctrXULeyc7NpRvogd7+nj5vk+3K3Fo
 ftw6C2ifu549Hh28RpofUCXjfq9mGlVux8/p3lcf5nJmjKIdoDmA5t/fR1iI=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 26 Oct 2019 16:13:21 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 26 Oct 2019 16:13:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xue Zhihong <xue.zhihong@zte.com.cn>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>
Subject: Re: [Cocci] [PATCH v4] coccicheck: Support search for SmPL scripts
 within selected directory hierarchy
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

PiBBbGxvdyBkZWZpbmluZyB0aGUgZW52aXJvbm1lbnQgdmFyaWFibGUg4oCcQ09DQ0nigJ0gYXMg
YSBkaXJlY3RvcnkKPiB0byBzZWFyY2ggU21QTCBzY3JpcHRzLiBTdGFydCBhIGNvcnJlc3BvbmRp
bmcgZmlsZSBkZXRlcm1pbmF0aW9uCj4gaWYgaXQgY29udGFpbnMgYW4gYWNjZXB0YWJsZSBwYXRo
LgoKV291bGQgdGhlIHBhcmFncmFwaCBmb3JtYXR0aW5nIGJlIG5pY2VyIGFzIGFuIGVudW1lcmF0
aW9uCmFzIEkgc3VnZ2VzdGVkIGl0IHByZXZpb3VzbHk/CgoKV291bGQgeW91IGxpa2UgdG8gdXBk
YXRlIHRoZSBwcm92aWRlZCBzb2Z0d2FyZSBkb2N1bWVudGF0aW9uIHRvZ2V0aGVyIHdpdGgKdGhl
IHNtYWxsIGV4dGVuc2lvbiBvZiB0aGlzIGJhc2ggc2NyaXB0PwoKVXBkYXRlIGNhbmRpZGF0ZXM6
CioKCiogaHR0cHM6Ly9ib3R0ZXN0Lndpa2kua2VybmVsLm9yZy9jb2NjaWNoZWNrI2NvbnRyb2xs
aW5nX3doaWNoX2ZpbGVzX2FyZV9wcm9jZXNzZWRfYnlfY29jY2luZWxsZQoKUmVnYXJkcywKTWFy
a3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2Np
IG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYu
ZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
