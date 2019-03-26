Return-Path: <SRS0=ZbCT=R5=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B0FC43381
	for <cocci@archiver.kernel.org>; Tue, 26 Mar 2019 19:05:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BF9D20823
	for <cocci@archiver.kernel.org>; Tue, 26 Mar 2019 19:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="PWE6QJcb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF9D20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2QJ5Nma010980
          ; Tue, 26 Mar 2019 20:05:23 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 84E4B7725;
	Tue, 26 Mar 2019 20:05:23 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4A8D77711
 for <cocci@systeme.lip6.fr>; Tue, 26 Mar 2019 20:05:21 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2QJ5JlA000677
 for <cocci@systeme.lip6.fr>; Tue, 26 Mar 2019 20:05:20 +0100 (CET)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1553627108;
 bh=M1CV1BswiFdYHSC0KTNQJ0k79yuvn8RGgyC3LMmnnMU=;
 h=X-UI-Sender-Class:To:References:Subject:Cc:From:Date:In-Reply-To;
 b=PWE6QJcboWL/xueD2XRE9TiSrOZQxGoHNJB+l118vS1YcWWQmmIEyRBpXaRfCJJtO
 2S1WQNIkyYbxLt0BCQYMhYYW9MXmRlyOob5AJBKt79rklk05U4Sm4jcsSHvv+NgBbs
 XnPB0DDo1dAdKZgz7QtPOP0fq0ObwwhlvliCRBlA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.159.29]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LshKH-1gyB1311ar-012Fd3; Tue, 26
 Mar 2019 20:05:08 +0100
To: Nicholas Mc Guire <der.herr@hofr.at>
References: <20190325130358.GA7492@osadl.at>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <0c6c4ab1-80dc-41a3-3b84-85d75e0ebb51@web.de>
Date: Tue, 26 Mar 2019 20:04:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190325130358.GA7492@osadl.at>
Content-Language: en-US
X-Provags-ID: V03:K1:5YYW7l97KY+AMEyzttKRfEHb9VrR4coPOGHV5fU/SzFP2MZu/sg
 XXfbVBIGSGsajs/9Hx0VJds4rNkXz2pVOS0CzCCKIqAKo8rHGSUt+tKi/CWy76zykOpUzwZ
 vIBVHAfafsCJp1HFxm3MtRMx2FwxqkjDkqxZEZeLilDyHZLEYekk9+Fg0j1/CgUod3zz/vJ
 QwtM951V5S5qbjopf+KlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gmClRUtGjpc=:AxHpkhKtyuL/DoUA3f2r7N
 AmRaAAKQPPwH0YOLo1mAeZfeEq9H58qVFfmADeQsW3XF+wo5G80VM1o5eaczYzTo4jEG2CbOK
 YXjAzWgX7Hoo9kwWD8MGB8gmQwq3JJiEDzrc76XAvaxi0P5+GWQ06X/aVGd5ijFEqO3ucMN2c
 t2QkYZGMObqQi3K6JH5+xQtO5latDimv0uROTUhAIMLlXSWQNmIUDtilgUC1kXKdVBV0ki9YE
 YOIyWb3BvHLPdYjWMhnSxqjr3gxu5sjCzEDvEYlEBHw31N9sEs8StkVtt4s+aypn/a2ENgb2e
 5UWrZDh3u/J9BlxX9k0OhHr2AqwOpdv+UTRu5zu9Fogd3LvR7aEOhbfVVZm0SdEGI7+yEFwTc
 juKPHjQEz2QZmprDBNRMp9ICdpPQbBFfLZkNT7aZ62pVu4SNij3QOb51N5qToPCLLWl4TmnbU
 l99dZTjkS6QYOwO2sEpZTBW852VwnsWXU7po3QjuqDUTgu+LFcphhwiXDMClkyF50jm/y1RQU
 skOUzrdkZ/vEj46D7JCzVx47PzOBaV7qKXR3A3hhyifzlDO+DRDcOL6AOrzhrb2R8CCfhD10h
 C91HsQVH5uWIQvADDisDOcS/JXxga87wra9GuLKfMxS5GI2HrBT3ARRIuFSWbmEJvhdyJm88c
 kcWGFK8Sk6FYSeYb+pbZ5+TORNPhZWTKq+zIWins5xv81KVxYmZsEP4a67nyZzJ8fuigjqnM4
 8ZiFNGly3WjZTpeSez4mARjBoj/wEikT/sWfccz0J+zXRNRHINz6gtU9eYv2QwHNGKGNxrEXL
 BFyLprksKehEjllNAA048pvB3TThrMkX9vhG8z6dOz120FrW7gyOnz9jpvHHODQW7PA7K9QAC
 GFw7H72P0IZoHNyuYhqi2MNf57PJuVGJ8H25ClSfvf6yT0Cx4dJlzcd/XZRfGCdv+plmfhkge
 aCOpMusW4Fg==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 26 Mar 2019 20:05:24 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 26 Mar 2019 20:05:20 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] RFC catching hidden code in if conditions
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

PiBOb3RpY2VkIHRoYXQgdGhlIG51dmVhdSBkcml2ZXIgdXNlcyBhIGZhaXIgbnVtYmVyIG9mCj4g
aWYgKHZhcj12YWwsYm9vbGVhbi1jb25kaXRpb24pe30KPiB3aGljaCB3aGlsZSBsZWdhbCBDLWNv
ZGUganVzdCBtYWtlcyBpdCBoYXJkIHRvIHJlYWQKPiAtIGFuZCBzb21lIHNlZW1zIGJ1Z2d5IGFj
dHVhbGx5LgoKRG8geW91IGZpbmQgYW5vdGhlciBhbmFseXNpcyBhcHByb2FjaCBuaWNlciBmb3Ig
dGhlIHNlbWFudGljIHBhdGNoIGxhbmd1YWdlCnRoYW4gdGhlIGV4aXN0aW5nIGNoZWNrIOKAnEFT
U0lHTl9JTl9JRuKAnSBieSBhIGtub3duIFBlcmwgc2NyaXB0PwpodHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9zY3Jp
cHRzL2NoZWNrcGF0Y2gucGw/aWQ9YTNhYzc5MTdiNzMwNzAwMTBjMDViNDQ4NWI4NTgyYTZjOWNk
NjliNiNuNDg0NwoKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvcGlwZXJtYWlsL2NvY2NpLzIwMTgt
U2VwdGVtYmVyLzAwNTMxNi5odG1sCgoKSSBzdWdnZXN0IHRvIHRha2UgYW5vdGhlciBsb29rIGF0
IHJlY3VycmluZyBpbXBsZW1lbnRhdGlvbiBkZXRhaWxzCmFsc28gd2l0aGluIFNtUEwgc2NyaXB0
cy4KCjEuIFNQRFggaWRlbnRpZmllcgoKMi4gU21QTCBkZXBlbmRlbmN5IHNwZWNpZmljYXRpb25z
CgozLiBGaW5lLXR1bmluZyBmb3IgUHl0aG9uIGNvZGUKCgpAYmFkX2lmIGRlcGVuZHMgb24gcmVw
b3J0QApwb3NpdGlvbiBQOwpzdGF0ZW1lbnQgUzEsIFMyOwpleHByZXNzaW9uIEUxLCBFMjsKQEAK
IGlmQFAgKChFMSksIEUyKSBTMSBlbHNlIFMyCgpAc2NyaXB0OnB5dGhvbiBkZXBlbmRzIG9uIHJl
cG9ydEAKcCA8PCBiYWRfaWYuUDsKQEAKY29jY2lsaWIucmVwb3J0LnByaW50X3JlcG9ydChwWzBd
LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICJ1bmNvbmRpdGlvbmFsIGNvZGUgaGlkaW5n
IGluIGlmIGNvbmRpdGlvbiIpCgpAZml4X2JhZF9pZiBkZXBlbmRzIG9uIHBhdGNoQApwb3NpdGlv
biBQOwpzdGF0ZW1lbnQgUzEsIFMyOwpleHByZXNzaW9uIEUxLCBFMjsKQEAKK0UxOwogaWZAUCAo
Ci0gICAgICAoRTEpLAogICAgICAgRTIpIFMxCiBlbHNlIFMyCgpSZWdhcmRzLApNYXJrdXMKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGlu
ZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWls
bWFuL2xpc3RpbmZvL2NvY2NpCg==
