Return-Path: <SRS0=M8Yn=6D=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDF7C5321D
	for <cocci@archiver.kernel.org>; Sun, 19 Apr 2020 16:19:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D9C321973
	for <cocci@archiver.kernel.org>; Sun, 19 Apr 2020 16:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="K0gD1dUb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9C321973
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03JGJUlC025702;
	Sun, 19 Apr 2020 18:19:30 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8722A7763;
	Sun, 19 Apr 2020 18:19:30 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0444C3DC8
 for <cocci@systeme.lip6.fr>; Sun, 19 Apr 2020 18:19:28 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03JGJRug026206
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 19 Apr 2020 18:19:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587313162;
 bh=of2wU8RTRYMU0kaC7Ph3S3HMYNADQMI81zLrLNzHgpI=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=K0gD1dUbJSeH83PRPy990QeZVdDtqyBAE+R1mrgOlGcdLMeYj/GmvuTJ2eUOWM6qG
 qdGDiVMFsvd5jjlx4z4ch9BRV+2xtFSEoO53eQxwZnJGdwrzSyJB64f2eCyEF8Tm1e
 WvdKhmlEtWN6mH3+/lpevit+PsZ5wrJGnEimfJA4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.85.208]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LlJzS-1iqazs0si6-00b4Sc; Sun, 19
 Apr 2020 18:19:22 +0200
To: Dejin Zheng <zhengdejin5@gmail.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <08979629-d9b8-6656-222f-4e84667651a1@web.de>
Date: Sun, 19 Apr 2020 18:19:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:Keg/E4Y7RjiqLK1+kspg/czOnv06G10YWSta4VRSEwYUJnc1WKb
 xsvVCGKOJxOSxH8UTTm+FzwIoQeoHV6TXYSp3oh4TLfyLOLZ46Wvwt2DhfgCMj7zzmcndW6
 SpJza4bZ8+ygOqEPVMrqJpJxSYLre0KexLMQEtzR4F76S8KG9OERO/tJ34JQv3lDR5tPA5H
 LrE/lfp+lrBNwd0zVutfA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3ol83GrGi6k=:w/LZwwojFVtRTWMWqr+JVg
 7EJwekt2kKO8yRCTNYQlfSnbwSHTn4wGH0tWacmthuvXRsiOOzfTsK3+lGHj8bLbhVibnbJZ0
 3s2r3EN7qNHVgYvNliymfmd0OBx3C5F9tI/vrrdlGLQJ1eju6rHmV8FE5mheVvgcWYv9WLY6H
 poDu4TuVi8vKVAW8atIW76cF/2khFT9XtpsYYf2PyfQrqdbzjyvKMpbjB3eFw4SK482lud2IL
 5Cj5PMcQ7VNhzfQP6RUEM8/r/7CjfJy/g7fvpr427xJpKQsjA4WqqDmDTsKj8QxwKkuceAnH2
 a11DILJppdsPCoMBlSiHVn9dlcG9YaAxrgP/QFxwZTX3hMX/QlBNK2e8OFeAnM+4ZCDXErZjD
 M/fa/XDQwsK6iVPE9/vMcEZVbNK/ckFj/SQWv6yAl41o/XcnYEunPXrTX3QcaiAmSMFPWBtr/
 6VtvCJwpRCUMPIRnDehWDKPotC/FwZKG4wtVYcKLM3ybjzNY11phctBqELdlp647woJYLm3L3
 hOhfInDKa/sk8CdkdQ/TF18KLb9yGCEo4pa1/qeNwiAmqnYO2svbluTvvI8FFGzOVTQjRByP6
 txpZGVMB9q0khJrTmCm8n0B/r5TgD4CnvqOWD9z1odhC4+7H2cr7727jH0Kj1QSRXLOmJ4AxV
 SDyC55jI3jmQwvy7mLTZ5bCp7I0dnPnCzqJ1NgLNpYJh+ZXknoeyGzO2MoVqh5+lkWyDS+XTH
 dJfWkYV7mpTD56Ppsk0xTgXI2uvCZmrQ7IM9QSXHkaRzY1R0XSnaqAEE2Hcp5lP+8yAYb2V/1
 E/utfoR5PpKW8K2VQs5iESq3CfUfieTkLnSYtPntNI7E2gzsXco9cTIpPMaaPbNLhS5X7poW4
 5REiPgkmUe1IKp0Xb/DB3caYpL1C5EeHHhuSGmq9plh0wC3pO/7Jbwe+S6bqj3bwXJpQF0D32
 wcnioumxdmB0XbDf7+jKyujxQ3308F2vHXW9whCj64lrAR68zYdErQVRcXkAsmmR0KwX4sTub
 Hck13c3pOh9gKMuXKsEjhLCbgWaDJo6+TGpsXGDkDTZR5HCjm0uaIL7oGji/puho5LnpioOod
 UH/SzWKJQhiF8oHRcau6yyzdSrvOQT/UXckLTfOrluVVUxFLHdul80zi9spP9ZRDXgClKjJ/i
 EMHW/M4Z/6tY2IAtPYrUS3ZsmnJPnUBXeO9UOIz98DMnTqFAuUfGFTJT6WcOkqCNo/JjN5hkR
 1CyC/uEzS1eGamOt5
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 19 Apr 2020 18:19:31 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 19 Apr 2020 18:19:27 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH net-next v1] can: ti_hecc: convert to
 devm_platform_ioremap_resource_byname()
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

PiB1c2UgZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlX2J5bmFtZSgpIHRvIHNpbXBsaWZ5
IGNvZGUsCj4gaXQgY29udGFpbnMgcGxhdGZvcm1fZ2V0X3Jlc291cmNlX2J5bmFtZSgpIGFuZAo+
IGRldm1faW9yZW1hcF9yZXNvdXJjZSgpLCBhbmQgYWxzbyByZW1vdmUgc29tZSBkdXBsaWNhdGUg
ZXJyb3IKPiBtZXNzYWdlLgoKSG93IGRvIHlvdSB0aGluayBhYm91dCBhIHdvcmRpbmcgdmFyaWFu
dCBsaWtlIHRoZSBmb2xsb3dpbmc/CgogICBVc2UgdGhlIGZ1bmN0aW9uIOKAnGRldm1fcGxhdGZv
cm1faW9yZW1hcF9yZXNvdXJjZV9ieW5hbWXigJ0gdG8gc2ltcGxpZnkKICAgc291cmNlIGNvZGUg
d2hpY2ggY2FsbHMgdGhlIGZ1bmN0aW9ucyDigJxwbGF0Zm9ybV9nZXRfcmVzb3VyY2VfYnluYW1l
4oCdCiAgIGFuZCDigJxkZXZtX2lvcmVtYXBfcmVzb3VyY2XigJ0uCiAgIFJlbW92ZSBhbHNvIGEg
ZmV3IGVycm9yIG1lc3NhZ2VzIHdoaWNoIGJlY2FtZSB1bm5lY2Vzc2FyeSB3aXRoIHRoaXMKICAg
c29mdHdhcmUgcmVmYWN0b3JpbmcuCgoKV2lsbCBhbnkgbW9yZSBjb250cmlidXRvcnMgZ2V0IGlu
dG8gdGhlIGRldmVsb3BtZW50IG1vb2QgdG8gYWNoaWV2ZQpzaW1pbGFyIGNvbGxhdGVyYWwgZXZv
bHV0aW9uIGJ5IHRoZSBtZWFucyBvZiB0aGUgc2VtYW50aWMgcGF0Y2ggbGFuZ3VhZ2U/CldvdWxk
IHlvdSBsaWtlIHRvIGluY3JlYXNlIGFwcGxpY2F0aW9ucyBvZiB0aGUgQ29jY2luZWxsZSBzb2Z0
d2FyZT8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0
dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
