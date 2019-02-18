Return-Path: <SRS0=dehY=QZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A636C43381
	for <cocci@archiver.kernel.org>; Mon, 18 Feb 2019 08:20:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E8A4218AD
	for <cocci@archiver.kernel.org>; Mon, 18 Feb 2019 08:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="i8aXmBBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8A4218AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1I8K9P0019775
          ; Mon, 18 Feb 2019 09:20:09 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4ADF0764A;
	Mon, 18 Feb 2019 09:20:09 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E5F8575FF
 for <cocci@systeme.lip6.fr>; Mon, 18 Feb 2019 09:20:07 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1I8K6bK003691
 ; Mon, 18 Feb 2019 09:20:06 +0100 (CET)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1550477987;
 bh=Gzozkklv+IHrtUVNGXYvPX4o1QM+OQ228VE0F162nxc=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=i8aXmBBnKf73ERFLeGep9+fHFIyALksZYSXfy42o12NeV53tTxdM5zIvhHIio5XrC
 JZJ8H31M0cmk29B+jE8z/IsRg5FztL+eH2fLx83v46exDSupIGvMXh/OpBPEVGgWHt
 O+Go+F/2AeVtbyPuKxrH6saa+hwO4wwlbpI7Nc4s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.162.105]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LvB6w-1h3vai44OY-010KC0; Mon, 18
 Feb 2019 09:19:47 +0100
To: Julia Lawall <julia.lawall@lip6.fr>, Wen Yang <wen.yang99@zte.com.cn>
References: <201902181122502228026@zte.com.cn>
 <alpine.DEB.2.21.1902180740550.3111@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ab463e94-287a-6188-6795-06eeb832e861@web.de>
Date: Mon, 18 Feb 2019 09:19:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902180740550.3111@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:s0Qmnm++jcdIjGkNjhKEHp/e/fkruH15Vk30MeSnGtIxaR+5ES2
 I+nhhcnV81gqKecXZaUUSfA5Y+t7+Vj+f0GiwwuibFwgtDahkC010SXnbtLTWFFKh/JE25r
 6BkZkzhf2+qyT4ApmHP5kw7y6BnWaPxdwrVmEzuQbEvAUxbkQSeyea+z6N+PeMo3Fq1pHXf
 PRNae7VG7AHnSbNbOxoiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rqHtMltt+Ks=:kbdKVSHjB9PASC/dWqG3Cp
 kSimnsKneM743zklCXJFnyoGdIMYaVV8f5hvCQFQQnlKF3mbhcpi+LTw0dxqYCj/UR0WHgvb+
 AP5aCj/JPLwNZDFNfmTIjLMuJNJIM+GvZH3uXJJK1KITPNUVIfUb+s+n/CSU6jtX8TKyBrch9
 ka7QKHcyf8hR3pe4N3YyBYEHmGbAZXWgfFm8J9+WhxeD254gnG27Vcdb5P+pt8zuYsr0SPVAE
 nqO2wRxjlQy9PTIYgLNDjfG++6k+N96eziaoJvCfEofLay83/Q4jzdIqUoXzZUrud2OcEblmx
 j0OsFyw7Zhf3IC3J09bFwmJ4Ih1QeMaG/HmctAru4XpO7k9ld4uzGUiGKSPixONMYUXQdYLxH
 nhGYVdVoUX3te75RGzI1RBuyTv2inAh+0KtjnFUtnuhzxl9tD3tkIKyv7eS6BTYYSfBstppW4
 QLyQtY6w9LkLybjNH6BVk3/+nj0lfBUZts6yzy/qHLzQzLiZYkVMAP5Vp1BAB6Vl/c1KUuugR
 UsRiWh7lg0mrizvi32BSHVJJir8BWBQkp8le6gYAOxt+dQVaGbgxX0UAHa81VGM50pgYRu25S
 fDv06X4pzNKOxE+Lz7tIVe6NT0Rh68y8J7FHqwbB3vYJ2xmbWzanbLn3FFda28kLmCN6FMxH9
 rcD537sCkcKLlH+n7g5mZItuYK0CPIX3F4ebaDjOfXNLVZKvRu2W5XPL9XvQwwPSnxCPRl1Lm
 M2QynyczVFcBPBUxRnd+NYHXd3FKQTeocP9jjQKtTB+djXZ+roYXJRkWJMGxO9ypmIMK5zzjE
 5WpTHxh3jLBPjXMj5fn8qn+3iGNSJG8i6om++v1Te5l26kIDxc37nUzhYVh097mypKC0Ko9Xf
 vE53cOfd3bQeZxjfom/9pVvG1fBuLWGHZ5rpbt0cLilPo15ty2ZZSmM2PTA0976U1Ipnnc8Sc
 y1kzLWHy8yQ==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 18 Feb 2019 09:20:09 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 18 Feb 2019 09:20:06 +0100 (CET)
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

Pj4+IFdoaWNoIGRhdGEgZWxlbWVudCBzaG91bGQgbm90IGdldCByZWFzc2lnbmVkIGhlcmUgKGJl
Zm9yZSBhIGNvcnJlc3BvbmRpbmcKPj4+IG51bGwgcG9pbnRlciBjaGVjayk/Cj4+Pgo+Pgo+PiBU
aGFuayB5b3UgZm9yIHlvdXIgY29tbWVudHMuCj4+IFdlIGRpZCBzb21lIGV4cGVyaW1lbnRzOgo+
PiAraWQgPSBvZl9maW5kX2RldmljZV9ieV9ub2RlQHAxKHgpCj4+ICsuLi4gd2hlbiAhPSBlID0g
aWQKPj4gLi4uCj4+IE9yOgo+PiAuLi4KPj4gKyAuLi4gd2hlbiAhPSBpZCA9IGUKPj4KPj4gVGhl
IG51bWJlciBvZiBpc3N1c2VzIGZvdW5kIGJ5IHRoZXNlIHR3byBtZXRob2RzIGlzIHRoZSBzYW1l
LgoKVGhpcyBjYW4gYmUgYmVjYXVzZSB0aGVzZSBTbVBMIHNwZWNpZmljYXRpb25zIHNoYXJlIHNv
bWUgc291cmNlIGNvZGUgc2VhcmNoIGZ1bmN0aW9uYWxpdHkuCgoKPj4gV2hlbiAhPSBlID0gaWQg
YWNoaWV2ZXMgdGhpcyBiZWhhdmlvci4KPgo+IFRoZXkgYXJlIHRoZSBzYW1lIGJlY2F1c2UgbmVp
dGhlciBpc3N1ZSBhcmlzZXMuCgpZb3UgbWlnaHQgbm90IG5vdGljZSBhIGRpZmZlcmVuY2UgZnJv
bSBhIHNwZWNpZmljIHNvdXJjZSBmaWxlIHNlbGVjdGlvbiBzbyBmYXIuCgoKPiBJIHdvdWxkIGhh
dmUgYSBoYXJkIHRpbWUgc2F5aW5nIHdoaWNoIG9uZSBpcyBtb3JlIHJlYXNvbmFibGUgdG8gdGVz
dCwKCkkgc3VnZ2VzdCB0byByZWNvbnNpZGVyIHRoZSBpbnRlcnByZXRhdGlvbiBvZiB0aGlzIHNv
ZnR3YXJlIHNpdHVhdGlvbiBvbmNlIG1vcmUuCgoKPiBzaW5jZSBib3RoIGFyZSBleHRyZW1lbHkg
dW5saWtlbHkuCgpJIGRpc2FncmVlIHRvIHRoaXMgdmlldyBiZWNhdXNlIHR3byBlbGxpcHNlcyB3
ZXJlIGludGVudGlvbmFsbHkgc3BlY2lmaWVkCmluIHB1Ymxpc2hlZCBTbVBMIHNjcmlwdHMuClNv
IHNvbWUgc29mdHdhcmUgZGV2ZWxvcGVycyBmb3VuZCB0aGVzZSDigJxzcGVjaWFsIHVzZSBjYXNl
c+KAnSBpbXBvcnRhbnQgZW5vdWdoLgoKCj4+IEluIGFkZGl0aW9uLCB3ZSBmZWVsIHRoYXQgd2Ug
c2hvdWxkIHByb2JhYmx5IGFjY2VwdCB0aGlzIHBhdGNoIGZpcnN0LAoKSSBkaXNhZ3JlZSB0byB0
aGlzIGltYWdpbmF0aW9uIGJlY2F1c2UgSSB3b3VsZCBwcmVmZXIgdG8gaW50ZWdyYXRlIGEgc291
cmNlIGNvZGUgdmFyaWFudAp3aXRob3V0IGEgYnVnICh3aGljaCB3YXMgY29waWVkIGZyb20gYSB2
ZXJzaW9uIG9uIDIwMTMtMDUtMDggYnkgUGV0ciBTdHJuYWQpLgpodHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9zY3Jp
cHRzL2NvY2NpbmVsbGUvZnJlZS9wY2lfZnJlZV9jb25zaXN0ZW50LmNvY2NpP2lkPWY3YjE2NzEx
Mzc1M2U5NWFlNjEzODNlMjM0ZjhkMTAxNDI3ODJhY2UjbjEyCgpJIGhvcGUgdGhhdCBuaWNlciBy
dW4gdGltZSBiZWhhdmlvdXIgY2FuIGJlY29tZSBhbHNvIHJlbGV2YW50IGhlcmUuCgoKPj4gdXNl
IGl0IHRvIGZpbmQgbW9yZSBtZW1vcnkgbGVha3MsIGFuZCBzb2x2ZSB0aGUgYWN0dWFsIHByb2Js
ZW1zIGluIHRoZSBrZXJuZWwgY29kZS4KCllvdXIgYXJlIG5vdCBoaW5kZXJlZCB0byBhY2hpZXZl
IHNwZWNpZmljIHNvZnR3YXJlIGltcHJvdmVtZW50cyB3aXRoIGV2b2x2aW5nCmRldmVsb3BtZW50
IGFwcHJvYWNoZXMgd2hpbGUgdGhlIGNsYXJpZmljYXRpb24gYW5kIHRoZSBmaW5hbCBpbnRlZ3Jh
dGlvbgpvZiB1c2VmdWwgc2NyaXB0cyBmb3IgdGhlIHNlbWFudGljIHBhdGNoIGxhbmd1YWdlIGNh
biB0YWtlIGEgYml0IGxvbmdlci4KCgo+PiBBcyBmb3IgdGhlIHBhdGNoIGl0c2VsZiwgd2UgY2Fu
IGNvbnRpbnVlIHRvIHB1cnN1ZSBwZXJmZWN0IGluIHRoZSBwcm9jZXNzCj4+IG9mIHVzaW5nIGl0
IHRvIHNvbHZlIHByYWN0aWNhbCBwcm9ibGVtcy4KCkkgYW0gY3VyaW91cyBvbiBob3cgeW91ciBh
dHRlbnRpb24gd2lsbCBldm9sdmUgZnVydGhlciBmb3IgdGhlIGNvcnJlc3BvbmRpbmcKc29mdHdh
cmUgY29ycmVjdG5lc3MuCgoxLiBIb3cgbXVjaCB3aWxsIHlvdSBjYXJlIGZvciB0aGUgb3JkZXIg
b2YgaWRlbnRpZmllcnMgd2l0aGluIHRoZSBhcHBsaWNhdGlvbgogICBvZiBTbVBMIGFzc2lnbm1l
bnQgZXhjbHVzaW9ucz8KCjIuIFdvdWxkIHlvdSBsaWtlIHRvIHRha2UgYWRkaXRpb25hbCBkYXRh
IHR5cGUgcmVzdHJpY3Rpb25zIGludG8gYWNjb3VudD8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxp
c3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4v
bGlzdGluZm8vY29jY2kK
