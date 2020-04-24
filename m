Return-Path: <SRS0=cw0N=6I=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CE6C2BA1A
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 07:47:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A6D120704
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 07:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="QXTjb2m0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6D120704
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03O7lCiv024518;
	Fri, 24 Apr 2020 09:47:12 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 19ABB7827;
	Fri, 24 Apr 2020 09:47:12 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 876F97815
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 09:47:08 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03O7l7fo005022
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 09:47:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587714414;
 bh=xMCKGIWSWfZDkzyNaAqTW8yUMH7LZKEPhEgmsf9ck/Y=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=QXTjb2m0xdxAYX9eu3Galz/MTQkGEO6bmMiYS3pbobkOBO1Twi1f54BWJ2HLAUknf
 Mqzn9a6VB1yRr6i8DW/tHgv/2wyBZKeya1Z7gM9xnLMbyEll1zD+pzkUxksRTgZ9so
 KyYe5JthYbBAC8kx274rI/mDFpEwqR7gOOvVC5lE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.129.82]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MKr7w-1jRt3009WS-0002Bf; Fri, 24
 Apr 2020 09:46:54 +0200
To: Dejin Zheng <zhengdejin5@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, Coccinelle <cocci@systeme.lip6.fr>
References: <c62ec54f-348b-2eae-59eb-374dde4d49ad@web.de>
 <20200423142909.GB1562@nuc8i5> <f054f00c-b813-e0c2-fe2e-30ccdec1ff46@web.de>
 <20200423170245.GA3417@nuc8i5>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f1d27f1b-d822-3457-7ca9-c4c5a8b98365@web.de>
Date: Fri, 24 Apr 2020 09:46:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423170245.GA3417@nuc8i5>
Content-Language: en-GB
X-Provags-ID: V03:K1:Ff0orYrWO/G7vUnpE7QCfce/w01wByslkpPcrPrWkiDMpjXAbz9
 qgKmu/4GRKvxhETQ/A1BZsm+7OfvCytJ6Sb/eJZXcnp+iPO9E1voPdLfUuG8UVRZDMhVBd5
 diucdn0b4QbNb0ZTvMirvrsgIbSEJxEIL5lQUXCM5m1VmZoY1Akde182rL1zVEA4rXDYqD8
 apIuShZ9RJpY9cVQlL7HQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J/+QIqeL3YE=:6lDLKSVKrIEOPNGdSfZgda
 FHPC/UFeCrD4kyHj/h0FGXXfNWNWhDn+yEeVqfop7VlNsRfkIfZ00VUa6Iya71XN03+54RsQa
 uKBW+rWqP12RG6DusANz8zXvtLHR7V4zP69RjYCs8o6YnUCUlHXpowcXDcyt2WP6LnkqH/D6A
 kkOI5GfNzZN/CqGJ7F8kANpQeo9k1cs3g+bEuSTxiZJSB3QwpKCTjZNsY50LrrLgoS4Hd/yjk
 8zTACZ6HuXJT1iYRI5xhw74OsPC3z3zXlTjG11VmshP1uPDaWeE3LN+lLVDMP8BaHhK5h9Ry3
 CaBk5xftjl033jr/QhTZ2ob4yxTaBJzeRhg9bfwqTZipBSOBK3109r9WvcT02daAVJka8nrzc
 KRMUa0htK6W7ZFc7KGP4ey1rOn5BbosRRuu3O9ebhQFOOKUxZhVQuVTHc1FxaOywsv7eo9jFf
 dDnRyWnUB7DIkwHpx2gqIJqqguN1MrHXbI69TP6YVo8QnqTAsLHroLcn3TJBkf6l2irU7p4Js
 9YqfhmI7Um47f4glaIdj7C2h67KWX0U72cgePbCuY+eQj09a8PmjDs+vmRMLitfiBRbYTMyak
 J6r9euiaq4BIz06+T5RSreCPc5fyN3h/bgxTKQIFzaJpU9b6Q4Dpxc6Vks2ooftQM1uhRHq0k
 DzK0Uu6jVkh025AoJLeyVl978NCcRxmJmiZUdtXdObnaBcZPmb601HHK5h7svT0wLohUjjPq1
 nwwBb/TXrojSH1LfvUGwnYw7uRLyIRrvUBUKo0/64tnxhew88XKFD2paqoGTxp7HrCFHxBxnP
 mFmjx77gQTKCEtx5VMhnTKeEnIgYZK9ezLey9vPTSZAHvLlBHQ0rQISU2Oyra8WOWmqYnpXFF
 bWczvn5ybf4Xii2lvDMN7U89VSHSF4d7byRJv5IcPBNwjIPfsNOUo37Z6UDFh4zK+nvl9Us3O
 1TvGgQ/noqqp62pZKDiQYAAVHczhsbFBOAWZgH7n42cbCf0I2HAWR2v9JWmMk3fqGtYJlesJ7
 8vBrAYwIOPhxyyeqG2S5SeGZqihkkaRqxx5HGRCes88Mph9KUzLGu2rZkWn/ensUcQS+A3Q3u
 PbtvEH5ytknb6UT2BdXQawL/k9blP6P/52padooVatmgEcnhvWy7uzc8o3RW4+gIFC8U/ghmP
 Vfirbswt2rNST+U8AdzbW23XxXioxdjXYg07fitM77Hgi2N76z4AC45QBN3Cr7i/F7woHZv0X
 Um9HtbwcALfuCxbI7
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 Apr 2020 09:47:13 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 24 Apr 2020 09:47:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: =?UTF-8?Q?Thomas_Bogend=c3=b6rfer?= <tsbogend@alpha.franken.de>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Cocci] console: Complete exception handling in newport_probe()
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

PiBTb3JyeSwgSSBkbyBub3Qga25vdyBob3cgdG8gdXNlIHRoZSBTbVBMIHNjcmlwdC4KCkkgd291
bGQgbGlrZSB0byB0cnkgYWdhaW4gdG8gbWFrZSB5b3UgbW9yZSBmYW1pbGlhciB3aXRoIGFwcGxp
Y2F0aW9ucwpvZiB0aGUgQ29jY2luZWxsZSBzb2Z0d2FyZS4KaHR0cHM6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvRG9jdW1l
bnRhdGlvbi9kZXYtdG9vbHMvY29jY2luZWxsZS5yc3Q/aWQ9YjRmNjMzMjIxZjBhZWFjMTAyZTQ2
M2E0YmU0NmE2NDNiMmUzYjgxOSNuOQoKQW5vdGhlciBzbWFsbCBleGFtcGxlIGFjY29yZGluZyB0
byBhIHNjcmlwdCBmb3IgdGhlIHNlbWFudGljIHBhdGNoIGxhbmd1YWdlOgpAZGlzcGxheUAKZXhw
cmVzc2lvbiBlLCB4OwpzdGF0ZW1lbnQgaXMsIGVzOwp0eXBlIHQ7CkBACiplID0gKHQpIGlvcmVt
YXAoLi4uKQogLi4uIHdoZW4gIT0gaWYoIFwoICFlIFx8IGUgPT0gTlVMTCBcfCB1bmxpa2VseSgg
XCggIWUgXHwgZSA9PSBOVUxMIFwpICkgXHwgV0FSTl9PTiggXCggIWUgXHwgZSA9PSBOVUxMIFwp
ICkgXCkgKSBpcyBlbHNlIGVzCiAgICAgd2hlbiAhPSBpb3VubWFwKGUpCiByZXR1cm4geDsKCgoK
Pj4gV291bGQgeW91IGxpa2UgdG8gbGV0IGFueSBtb3JlIHNvdXJjZSBjb2RlIGFuYWx5c2lzIHRv
b2xzIGhlbHAgeW91Cj4+IHRvIGZpbmQgcmVtYWluaW5nIHVwZGF0ZSBjYW5kaWRhdGVzPwo+Pgo+
IHllcywgYnV0IEkgdGhpbmsgdGhlIHNvdXJjZSBjb2RlIGFuYWx5c2lzIHRvb2xzIG9ubHkgY2Fu
IGZvdW5kIHRoZSBzaW1wbGUKPiByZXBldGl0aXZlIGlzc3VlLgoKVGhlIHNob3duIGFuYWx5c2lz
IGFwcHJvYWNoIGNhbiBwb2ludCAxMjcgc291cmNlIGZpbGVzIG91dCBmcm9tCnRoZSBzb2Z0d2Fy
ZSDigJxMaW51eCBuZXh0LTIwMjAwNDIz4oCdLiBUaGVzZSBmaWxlcyBjb250YWluIGZ1bmN0aW9u
IGltcGxlbWVudGF0aW9ucwp3aGljaCBtaWdodCBuZWVkIGZ1cnRoZXIgZGV2ZWxvcG1lbnQgY29u
c2lkZXJhdGlvbnMuCgoKPiBhbmQgbmVlZCBzcGVuZCBzb21lIHRpbWUgbGVhcm5pbmcgdG8gdXNl
IGl0LgoKWW91IGNhbWUgYWxvbmcgYSBmZXcgZmlsZXMgd2hlcmUgeW91IG5vdGljZWQgcXVlc3Rp
b25hYmxlIHNvdXJjZSBjb2RlLgpXb3VsZCB5b3UgYmVjb21lIGludGVyZXN0ZWQgdG8gZmluZCBz
aW1pbGFyIHBsYWNlcyBmb3IgYW5vdGhlciBjaGVjaz8KCgplbGZyaW5nQFNvbm5lOn4vUHJvamVr
dGUvTGludXgvbmV4dC1wYXRjaGVkPiBYWD0kKGRhdGUpICYmIHNwYXRjaCAtLW5vLWxvb3BzIC0t
dGltZW91dCAxMiAtaiA0IC0tY2h1bmtzaXplIDEgLWRpciB+L1Byb2pla3RlL0xpbnV4L25leHQt
cGF0Y2hlZCB+L1Byb2pla3RlL0NvY2NpbmVsbGUvamFuaXRvci9zaG93X3F1ZXN0aW9uYWJsZV9p
b3JlbWFwX3VzYWdlMy5jb2NjaSA+IH4vUHJvamVrdGUvQmF1L0xpbnV4L3NjcmlwdHMvQ29jY2lu
ZWxsZS9pb3JlbWFwLzIwMjAwNDIzL3Nob3dfcXVlc3Rpb25hYmxlX2lvcmVtYXBfdXNhZ2UzLmRp
ZmYgMj4gfi9Qcm9qZWt0ZS9CYXUvTGludXgvc2NyaXB0cy9Db2NjaW5lbGxlL2lvcmVtYXAvMjAy
MDA0MjMvc2hvd19xdWVzdGlvbmFibGVfaW9yZW1hcF91c2FnZTMtZXJyb3JzLnR4dDsgWVk9JChk
YXRlKSAmJiBlY2hvICIkWFggfCAkWVkiCkZyIDI0LiBBcHIgMDk6MDg6NDQgQ0VTVCAyMDIwIHwg
RnIgMjQuIEFwciAwOToxMDozNyBDRVNUIDIwMjAKCldvdWxkIHlvdSBsaWtlIHRvIGV4dGVuZCB5
b3VyIGxlYXJuaW5nIGV4cGVyaWVuY2VzIGFjY29yZGluZ2x5PwoKCj4gbm93LCBJIHRoaW5rIHRo
ZSBiZXN0IGZvciBtZSBtYXkgYmUgdGhhdCByZWFkIGFuZCBjaGVjayB0aGUgc291cmNlIGNvZGUu
CgpIb3cgZG8geW91IHRoaW5rIGFib3V0IHRvIHJlZHVjZSBlZmZvcnRzIGZvciBtYW51YWwgY29k
ZSBpbnNwZWN0aW9uPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxp
cDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
