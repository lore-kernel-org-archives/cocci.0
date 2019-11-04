Return-Path: <SRS0=zAny=Y4=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70069CA9EB5
	for <cocci@archiver.kernel.org>; Mon,  4 Nov 2019 15:41:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E85B2080F
	for <cocci@archiver.kernel.org>; Mon,  4 Nov 2019 15:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="V36MwZz/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E85B2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA4Ff3ec020739;
	Mon, 4 Nov 2019 16:41:04 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D4D5377AE;
	Mon,  4 Nov 2019 16:41:03 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4FCDB454C
 for <cocci@systeme.lip6.fr>; Mon,  4 Nov 2019 16:41:02 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA4Ff0hc006622;
 Mon, 4 Nov 2019 16:41:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1572882038;
 bh=91uXF2MDnLTKRhI96RSE+7EJYA76bzEGXm7FVvuD+YA=;
 h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
 b=V36MwZz/Ap60fCE79Da56ATF4ii4osWw4189bfFKZv+oIYyWoBsfdgdkS+BW1OH39
 BmhoI6VdzslOaOpptcgNg6JLF2YybbDr2eeSkajfGVWA1yQALW33/kc16kXTLWZQzm
 Q5fzsDScMegn5pJKC92o8Ez2Pc8qdhk14T+jUKr8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.71.222]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M9GN8-1ieKyW0J3e-00ClnW; Mon, 04
 Nov 2019 16:40:38 +0100
References: <1572838555-12101-1-git-send-email-zhong.shiqi@zte.com.cn>
To: Zhong Shiqi <zhong.shiqi@zte.com.cn>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <583d2524-6b29-487b-a000-9a764b5ecdec@web.de>
Date: Mon, 4 Nov 2019 16:40:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1572838555-12101-1-git-send-email-zhong.shiqi@zte.com.cn>
Content-Language: en-US
X-Provags-ID: V03:K1:8JlTc+SZJgPY0NEDh3WeUVt1XReSBN3DjOC4N0agyj7iaslmFWl
 8iSDxJa6cdZQ6MtxSnrUJhgG2e4lKI2p+nbgKAy49gqMdCm0kBfGZh/J/9aTjMEkO5hC/h3
 WWL+vv43wTwpAbbg18ZvAoLWgrEvGAEuATQH2G+uw0voN2SYSbHducGrYJ92HcCclQhM8iK
 rapgngdI53CkA0O2vv78A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qd/Rta+2wDI=:gvCJCPLvmvhN7PCP1bDSwO
 PLCKZL0+FjGQQkjm8LwD7Zqs8GdyRH5pbdqkQ+lrDmH9iw76hg31H1S+Z0AUjzzIAWa3UcN4B
 ycu3U77i6UdSahvfcim8e0ZJ8a4dAaEOXgPXe0ujt7kwaQnl2I+Tk5O9P3NGOjImzsEtAwurF
 SnRBav5dTpS1iTHDehdY0LKShgNDUBnXagmIBnG9H3u8em7o/TCyZQfuZQrHX1gBy/+8XYaLl
 OkJpqSeUPtpkEoKAGTPa1kwHkVCX2WQhL3xJ9tp9q74B9jqQl4u4lCSxGevBFfSchxpFTsVkQ
 nlgP5QrhAam8QJoDKvI1saUZR+/XQXBHJpgDmscKgx8UXQDhODAWvT6TWFCxAUsx2WRCtvRUn
 WytUcNiq/Ly4uPK771Cg1qF3GBnospOYgmp9bSve+SMUyXq5kGaCtF55YESOaX2uSLgK6ygxW
 TklHU16eIwspNAmG/P6EA0ibsUXjI9v+7IZGI6d34TFHjN1En3WqvrG8EnZ5Xy/IrDLWixwft
 aut9YBYKnoJh4iT4xCaKN3QPFB38HwmA/cmwV7MAjRvvYGG2TPoTCpm0iTp+Lb2UKU7CFaJGt
 cruEdGxDfFVMRDng/Jq8S8f+Cs/RwCpqSoJLwa2c2CZgEvU3ivyMUf1So66L0l0jHNP+TkQTy
 KL4nnYwsdqjHj4wcolCRvgMwbTlHrN+bcog6ckcFORceb/Frn/fg+hwHAYNA47wYI8XlJ3fuv
 z1pk3mO0jvJLfTDPF2IdGVdWGYdfAtiLE9KqiAU33Ay2/8myXszmrsNuEGQb17kQcEozFeeHS
 Nzpy6J5Zz+R7BAwk1WdPih42WdBzh00O/e4ZO9oTJiyUpdbnTgU0X+qWUKqidLZLXjbLomK1L
 N7XFEcXdU0U8fbE9pWLach81fzDq1sEzO9Q94ElTemhZZql4zbiUX9gBUoUtk2MLItsngdvC9
 zQroxkvOIVlc9mPmxJgol78lH7noOU2YN8BIcjDASGsdrUVCmhyj/9JV0KU2P5urGtxMfQEbL
 GKa+a2pO11BZoH3inT1wOA90peP/wRXaWKHiMTNl63ZwLf8lbr69YvA5WxJ+oyv5bLRYwk/bP
 nUkuwzCrlzyECGl9CuNpZIf8NVkb0N6805iNxBRkB8D0Ua6ARxHyQ+WVex6j/b7FEoEhxpokh
 2jpc29yMD3kv0Y3Z6PGIt68I8rkzsI1Zhut0E0x+j+sq3hKwGMXYslbzYFkX6/BTQQPURZ8HW
 FcoBuFniqVNga1W3/cm+LUfTSayBJ6+8YjAvTMJSzM+ZwwTURy2D4Ng0qL7Y=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 04 Nov 2019 16:41:04 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 04 Nov 2019 16:41:00 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>
Subject: Re: [Cocci] [PATCH v6] coccicheck: Support search for SmPL scripts
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

PiAqQWxsb3cgZGVmaW5pbmcgdGhlIGVudmlyb25tZW50IHZhcmlhYmxlIOKAnENPQ0NJ4oCdIGFz
IGEgZGlyZWN0b3J5IHRvCj4gc2VhcmNoIFNtUEwgc2NyaXB0cy4KPgo+ICpTdGFydCBhIGNvcnJl
c3BvbmRpbmcgZmlsZSBkZXRlcm1pbmF0aW9uIGlmIGl0IGNvbnRhaW5zIGFuIGFjY2VwdGFibGUK
PiBwYXRoLgo+Cj4gKlVwZGF0ZSBjb2NjaW5lbGxlLnJzdCBkb2N1bWVudHMgZm9yIHVzZSBjb2Nj
aWNoZWNrIHdpdGggYSBkaXJlY3RvcnkKPiBzZWxlY3Rpb24KCuKAoyBEbyB5b3UgcmVhbGx5IGlu
c2lzdCB0byB1c2UgYW4gZW51bWVyYXRpb24gd2l0aG91dCBhbGlnbm1lbnQKICBpbiB5b3VyIGNo
YW5nZSBkZXNjcmlwdGlvbj8KCuKAoyBDYW4gdGhlIGZvbGxvd2luZyB0aGlyZCBpdGVtIGJlIG5p
Y2VyPwoKICAqIEFkanVzdCBzb2Z0d2FyZSBkb2N1bWVudGF0aW9uIGZvciB1c2luZyBjb2NjaWNo
ZWNrIHdpdGgKICAgIGEgc2VsZWN0ZWQgZGlyZWN0b3J5LgoKCj4gKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXYtdG9vbHMvY29jY2luZWxsZS5yc3QKPiBAQCAtMTAwLDggKzEwMCw4IEBAIFR3byBvdGhl
ciBtb2RlcyBwcm92aWRlIHNvbWUgY29tbW9uIGNvbWJpbmF0aW9ucyBvZiB0aGVzZSBtb2Rlcy4K
4oCmCj4gK1VzaW5nIENvY2NpbmVsbGUgd2l0aCBkZWZhbHV0IHZhbHVlCgpXaHkgZGlkIHlvdSBy
ZXBlYXQgYSB0eXBvPwoKSG93IGRvIHlvdSB0aGluayBhYm91dCB0byB1c2UgdGhlIHNlY3Rpb24g
dGl0bGUg4oCcVXNpbmcgQ29jY2luZWxsZQp3aXRoIHRoZSBkZWZhdWx0IGNvbmZpZ3VyYXRpb27i
gJ0/CgoK4oCmCj4gK3NlbWFudGljIHBhdGNoLiBJbiB0aGF0IGNhc2UsIHRoZSB2YXJpYWJsZSBt
dXN0IGJlIGluaXRpYWxpemVkIHdpdGgKPiArdGhlIG5hbWUgb2YgdGhlIHNlbWFudGljIHBhdGNo
IHRvIGFwcGx5LgoKSSBwcmVmZXIgYW4gb3RoZXIgd29yZGluZy4KCuKApiwgaXQgc2hvdWxkIGJl
IHNldCB0byB0aGUgZmlsZSBuYW1lIG9mIHRoZSBzZW1hbnRpYyBwYXRjaCB0byBhcHBseS4KCgri
gKYKPiArZGlyZWN0b3J5LiBJbiB0aGF0IGNhc2UsIHRoZSB2YXJpYWJsZSBtdXN0IGJlIGluaXRp
YWxpemVkIHdpdGggdGhlIG5hbWUgb2YKCuKApiwgaXQgc2hvdWxkIGJlIHNldCB0byB0aGUg4oCm
CgoKV2lsbCB0aGUgcHJlc2VudGVkIGNhc2UgZGlzdGluY3Rpb24gbmVlZCBhbm90aGVyIGFkanVz
dG1lbnQKZm9yIHRoZSBkb2N1bWVudCBvdXRsaW5lPwoKCuKApgo+ICBDb250cm9sbGluZyBXaGlj
aCBGaWxlcyBhcmUgUHJvY2Vzc2VkIGJ5IENvY2NpbmVsbGUK4oCmCgpEaWQgeW91IG92ZXJsb29r
IGFub3RoZXIgdXBkYXRlIGNhbmRpZGF0ZSAod2hpY2ggSSB0cmllZCB0byBwb2ludCBvdXQgYmVm
b3JlKT8KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9y
dmFsZHMvbGludXguZ2l0L3RyZWUvRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMvY29jY2luZWxsZS5y
c3Q/aWQ9YTk5ZDgwODBhYWYzNThkNWQyMzU4MTI0NGU1ZGEyM2IzNWUzNDBiOSNuMTg5CuKAnOKA
pgpDT0NDSSB2YXJpYWJsZSBtYXkgYWRkaXRpb25hbGx5IGJlIHVzZWQgdG8gb25seSBhcHBseSBh
IHNpbmdsZQpzZW1hbnRpYyBwYXRjaCBhcyBzaG93biBpbiB0aGUgcHJldmlvdXMgc2VjdGlvbi4K
4oCm4oCdCgoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIK
aHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
