Return-Path: <SRS0=dehY=QZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E00C43381
	for <cocci@archiver.kernel.org>; Mon, 18 Feb 2019 21:41:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A3512177E
	for <cocci@archiver.kernel.org>; Mon, 18 Feb 2019 21:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="a20GanVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A3512177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1ILf0pA017779
          ; Mon, 18 Feb 2019 22:41:00 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F01E576F9;
	Mon, 18 Feb 2019 22:40:59 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1D43C764A
 for <cocci@systeme.lip6.fr>; Mon, 18 Feb 2019 22:40:58 +0100 (CET)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1ILeu6C003599
 ; Mon, 18 Feb 2019 22:40:56 +0100 (CET)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1550526037;
 bh=vJSkVEKlrv/ssvxyfKzJB2RgCHOqNWKHXy7j7pXgT2A=;
 h=X-UI-Sender-Class:Subject:Cc:References:From:To:Date:In-Reply-To;
 b=a20GanVXjx1L5tuH2kvjKSkKVbyk/6KRnyhk/cxQ/v8x04X8juod1tL14kYUzEjVf
 xirKR6gEQzqZLsYoTGBaD4waWeOpR/5IO8huqjAHrp0WcteAiVlAA0fLrHToTF4grM
 Jxk1XzLYLRepxtIxCS+sg/Gw/Rg2vlo1HiSjoZ+A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.162.105]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MLPNm-1gvIQB2elG-000c6o; Mon, 18
 Feb 2019 22:40:37 +0100
References: <201902181122502228026@zte.com.cn>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To: Wen Yang <wen.yang99@zte.com.cn>, Julia Lawall <julia.lawall@lip6.fr>
Message-ID: <730810ab-5bea-4a8d-54b9-37e1fe2d1498@web.de>
Date: Mon, 18 Feb 2019 22:40:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <201902181122502228026@zte.com.cn>
Content-Language: en-GB
X-Provags-ID: V03:K1:BxI6O3w/BQhd0JdaZbCTgi9ZFlGDu+xa9c19YFzJWO+f2XbAES8
 k3Y6GqsaCyRuXQKSetrZS6pPrDSRnqc9cEdmjgw+VuKBQSCKhk8z0NPUprCGLp/+ZW0YrMf
 CVNRl2h4mvR6dhe6iquTka/jKsGZ7NuU0ASJCeEOAFago2LZPL8OHnGOUCKyYRrNpD9SyeL
 CHKUF6TYkn5Z4ZHu2LE0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Q/A4GdK0DI=:XTDjzgW1PRjew0HJ+xaUNd
 CVAsMRaXxEkYa1M1aY7Npm7atySDXD+VrHCVWLOFdTQ74Hh0stj5MBiVMBcMZ8xG+YrR7MA2n
 NHGilpO3/dYegBtWjAMRXEFltUfnoXLuHsI+ZaCyxxtVeQmybpKz5sf/R3frKIJVCJmsoma45
 9KHV4vC2LJwx8+1+URF8SY82Esnm5qOm3bpeRdQluWiORKYD+7DFo8lxQ5350wboR2GljsXRk
 6e3wFK+sT8edSnH+Ps2YPysBC5a0XXCNspwLV3KfA5uw1RD+hfKQ0NDNpm0xdEsn6rMjWcQRS
 FF4Nj9LlWm+Y7GSn1Og6IGSg5FVwiXWGK3aUCL6fm2kEzSnVS1gNZiLQ6BhUD6I4Cafh6yBb3
 7LAStY3mBOT2czMsrCv8PHS4y/qR7PAQSmaXGfs0pMWXu2g5jUKz7FCteQJnGbiidsc3jCSP4
 8XcdWESf0gHYfSoKp720WHfxNjPLi8Ui8YTzITchiBzQJHgJfaIdq7x+1ukEGP88iQEaJoTca
 pqz2ujYIHs0qiU4cTpr1AF5kQ0iESN8It51vbIUBtT9dXf43U3GgCVbCFPJaZA6ibJUCoeH7W
 j+2b535JQDDi4wQyYwKf2CkIyxSY3Hojjo7qa1MZR1RSTNaGZV/Hb99jV+8TP1sg1yC6JMi8a
 nXpUWSjMzb/Jv/k6kVmyzTau5HGeFnXT/oe1v/2ZzERZ8fct4YU2yFvlOcapYZ6LvkFIDT5ty
 t91ZOIEwwWA1pJz5Ocdn59JhPF3ck2Ooc4S/3rIQD9ZybASiokrLCr3w2LuHYysSa7dZT2YjD
 Affo9+l3x8G31Ip1FP7eYJkMLCEC3XWnwy/DZrkikpKhec8t4ucM26kHe2rPGyumahj5CiUAF
 LeuaxKsblvY3Z5198JpJNYQhiHDZQxWPvVrRLXfoN3nxI69+jK0pGI8Ei2/rFoKnFaGEz/FAQ
 0Q8WMMKTfyQ==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 18 Feb 2019 22:41:00 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 18 Feb 2019 22:40:56 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: kernel-janitors@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>,
        Wen Yang <yellowriver2010@hotmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [v6] coccinelle: semantic code search for missing
	put_device()
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

Pj4gV2hpY2ggZGF0YSBlbGVtZW50IHNob3VsZCBub3QgZ2V0IHJlYXNzaWduZWQgaGVyZSAoYmVm
b3JlIGEgY29ycmVzcG9uZGluZwo+PiBudWxsIHBvaW50ZXIgY2hlY2spPwo+Pgo+Cj4gVGhhbmsg
eW91IGZvciB5b3VyIGNvbW1lbnRzLgo+IFdlIGRpZCBzb21lIGV4cGVyaW1lbnRzOgo+ICtpZCA9
IG9mX2ZpbmRfZGV2aWNlX2J5X25vZGVAcDEoeCkKPiArLi4uIHdoZW4gIT0gZSA9IGlkCj4gLi4u
Cj4gT3I6Cj4gLi4uCj4gKyAuLi4gd2hlbiAhPSBpZCA9IGUKPgo+IFRoZSBudW1iZXIgb2YgaXNz
dXNlcyBmb3VuZCBieSB0aGVzZSB0d28gbWV0aG9kcyBpcyB0aGUgc2FtZS4KCldvdWxkIHlvdSBs
aWtlIHRvIGNsYXJpZnkgdGhlIGNpcmN1bXN0YW5jZXMgYSBiaXQgbW9yZSB1bmRlciB3aGljaAp5
b3Ugd291bGQgbm90aWNlIGNvcnJlc3BvbmRpbmcgZGlmZmVyZW5jZXM/CgoKPiBXaGVuICE9IGUg
PSBpZCBhY2hpZXZlcyB0aGlzIGJlaGF2aW9yLgoKSSB0cnkgYW5vdGhlciBleHBsYW5hdGlvbiBh
cHByb2FjaCBmb3IgYSBwb3RlbnRpYWxseSBzYWZlciBzb3VyY2UgY29kZSBzZWFyY2guCgoKMS4g
SWYgeW91IHdvdWxkIGxvb2sgYXQgdGhlIGZvbGxvd2luZyBTbVBMIGNvZGUgbGluZXMgYWdhaW4s
CiAgIEkgaW1hZ2luZSB0aGF0IHlvdSBjYW4gZGV0ZXJtaW5lIGFsc28gYW4gdXNlZnVsIGNvbnN0
cmFpbnQgZm9yIHRoaXMgcGxhY2UuCgrigKYKKyBpZCA9IG9mX2ZpbmRfZGV2aWNlX2J5X25vZGVA
cDEoeCkKKyAuLi4gd2hlbiAhPSA/Pz8/Pz8gPSA/Pz8/Pz8KKyBpZiAoIWlkIHx8IC4uLikgeyAu
Li4gcmV0dXJuIC4uLjsgfQrigKYKCgoyLiBQZXRyIFN0cm5hZCBleHByZXNzZWQgdGhlIG5lZWQg
Zm9yIGFub3RoZXIgY29uc3RyYWludCBpbiB0aGUgY29tbWl0CiAgIOKAnHNjcmlwdHM6IENvY2Np
bmVsbGUgc2NyaXB0IGZvciBwY2lfZnJlZV9jb25zaXN0ZW50KCnigJ0gKGZyb20gMjAxMy0wNS0w
OCkuCiAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Rv
cnZhbGRzL2xpbnV4LmdpdC90cmVlL3NjcmlwdHMvY29jY2luZWxsZS9mcmVlL3BjaV9mcmVlX2Nv
bnNpc3RlbnQuY29jY2k/aWQ9ZjdiMTY3MTEzNzUzZTk1YWU2MTM4M2UyMzRmOGQxMDE0Mjc4MmFj
ZSNuMTIKCiAgIEkgZmluZCB0aGF0IHRoZXJlIGFyZSBhZGRpdGlvbmFsIHNvZnR3YXJlIGRldmVs
b3BtZW50IGNoYWxsZW5nZXMKICAgdG8gY29uc2lkZXIgYXJvdW5kIGFub3RoZXIgZGVzaXJhYmxl
IGFzc2lnbm1lbnQgZXhjbHVzaW9uIGZyb20gdGhlIHBsYWNlCiAgIG9mIHRoZSByZXR1cm4gdmFs
dWUgc3RvcmFnZSBhbmQgdGhlIGRhdGEgcHJvY2Vzc2luZyBwb3NzaWJpbGl0aWVzCiAgIGJlaGlu
ZCB0aGUgY29ycmVzcG9uZGluZyBudWxsIHBvaW50ZXIgY2hlY2suCiAgIFRoZSBwcmV2aW91cyBh
cHByb2FjaCB3b3JrZWQgd2l0aCB0aGUgbWV0YXZhcmlhYmxlcyB0eXBlcyAob3Iga2luZHMpCiAg
IOKAnGV4cHJlc3Npb27igJ0gYW5kIOKAnGxvY2FsIGlkZXhwcmVzc2lvbiBpZOKAnSB0byBzb21l
IGRlZ3JlZSBzbyBmYXIuCiAgIEJ1dCBpdCBpcyBleHBlY3RlZCB0aGF0IGFuIHVuZGVzaXJhYmxl
IG1pc3NlZCByZWZlcmVuY2UgcmVsZWFzZQogICBjYW4gYmUgc2FmZWx5IHBvaW50ZWQgb3V0IG9u
bHkgaWYgdGhlIHJlY2VpdmVkIHBsYXRmb3JtIGRldmljZSBwb2ludGVyCiAgIGlzIHVzZWQgb25s
eSB3aXRoaW4gYSBmb3VuZCBmdW5jdGlvbiBpbXBsZW1lbnRhdGlvbi4KCiAgIEkgd291bGQgaW50
ZXJwcmV0IHRoaXMgZGF0YSBmbG93IHJlcXVpcmVtZW50IGluIHRoZSB3YXkKICAgdGhhdCB0aGUg
cG9pbnRlciBzaG91bGQgbm90IGJlIGZvcndhcmRlZCB0byBhIGRhdGEgc3RydWN0dXJlCiAgIHdp
dGggYSBzY29wZSBmcm9tIG91dHNpZGUgKGdsb2JhbD8pIHRoZSBmb3VuZCBmdW5jdGlvbiBpbXBs
ZW1lbnRhdGlvbi4KICAgSG93IHdvdWxkIHlvdSBsaWtlIHRvIGV4cHJlc3Mgc3VjaCBhbiBhc3Bl
Y3QgYnkgdGhlIGN1cnJlbnQgKG9yIGZ1dHVyZSkKICAgbWVhbnMgb2YgdGhlIHNlbWFudGljIHBh
dGNoIGxhbmd1YWdlPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxp
cDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
