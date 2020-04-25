Return-Path: <SRS0=WUls=6J=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A38FC55185
	for <cocci@archiver.kernel.org>; Sat, 25 Apr 2020 08:56:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 302A720700
	for <cocci@archiver.kernel.org>; Sat, 25 Apr 2020 08:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="bWZxTSmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 302A720700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03P8uSCq013379;
	Sat, 25 Apr 2020 10:56:28 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 17A5D781C;
	Sat, 25 Apr 2020 10:56:28 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 481EC3DC8
 for <cocci@systeme.lip6.fr>; Sat, 25 Apr 2020 10:56:26 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03P8uPXV029209
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Sat, 25 Apr 2020 10:56:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587804985;
 bh=lMKNZ1sxkehxsCGrEZfff9kRY0Mc6Dx8y8OusPbkH98=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=bWZxTSmUUUJ4Z/U18c2oWVyP3xPzJBABX40ppMDqBZ4aoxrBy1mdM0QbYWZvyovwJ
 Y752T2HeXnEBd4BALqBqzGsbaXRIfCohgYMXaZSISS8UwQziIWUWTF223S6H7xHMJB
 sE0lfZ+9S1HwgOTCuONQny2PLa7aAPk9Pdv5jAZg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.160.204]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LlWKh-1itCyU13AN-00bOIR for
 <cocci@systeme.lip6.fr>; Sat, 25 Apr 2020 10:56:25 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <41c1722f-7dc8-e2e8-aa32-387eb957a2d4@web.de>
Date: Sat, 25 Apr 2020 10:56:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:QNB+KFpKI9HPO9UM/hmy4OIb0haSvvxUllBMUohvwfTgpF55MJQ
 nQyV+AudQLF+5is1QFndBZUyNPBln8A6gS+wXGFEjILb4Sr2qmjMyODzPXWawngl1o4fAFZ
 00sSvfeZs2gOQ8tt+AhD4eS7CaRbQoFJkhm+QfFjAiZjMyGlXfr/YLkbx0GfauNELT27dY6
 yRTlfcncrisvOFDKlegAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RIZvtgV004A=:ZL8i+h+u+GVNhgEBf10Luh
 fOdqATC7L2IppFyLnEZkiPDjS+xYb//7LA7fbsF2jVETOgKEDMf/KHLhR1u1JqU9tGT2AHEVN
 mmaL2e/tPT2tAK8UqvodvKO2tczMPcn4Q8PBNINO0R/Pd4+XezIcMxo5zJPSu58KWq0lh7Pti
 uP38R3l0r3W9hK35v+EkW9h4gpYZRKGcOEVZQy1Ks/ENxKAnH4MKvT78nPNGu/kuPkARmYrkG
 0oFAlW2uyRQGcVTnohe7BZhEytQ6gz15W8jnGLzhRkHH8KBmaE9aFOwDPhoOQEt1mereDQB9u
 9RNhtYG2QeKb+z3TWlrrDH9hzGnGCQPzsgptOfBsHCoixH4PrtrtBhFXoyGI/OJk39/5dAd92
 sKmZIDzZdoHnkNDkgLvyNZ2GaJ0Tu6RF1TS5jFZvooGYPzjjT2Be1n95TMspCTblcnkUHh6/v
 ZfQEkGLK5v5KlvKqlg70/zNQY1gjeQsd954ekGc9h+hZ1K3Pl9aJoGpDY83id0q0fEKyhlfka
 RPtiTxCoPvlMKA15vn+X3/1ZHApbyYct4ZFwGhiu8q2AKU1Cr6bgepI8vCwzUCb1IMD7rvKd5
 WX5NGWwq9mmWvBw2tAKntSsh73ebeWsXAhtT5pnYa5yMxPU0EifuoGcDFvTd6b5RLNb7BeDJz
 oa9JHX86P6je8BqxyJ5dbwKT2Pz8eicynkXmABPbpbhBCwbpNFVf0B/V1/3fUAQDgHIWSGni8
 V8viZdUSZ8hDIKTq9XI1edsMGxFgPHNtk8zpVGyGkIouuZO5U30h/9MFIbV2Tk3Oug+Cm/ccE
 23dGNZu+fcQXqMjeylNjfwKh1CeaW1jsPzVqBMHsm1skmn8EgGurcguSZFC37ffUq7KQt0RS/
 4gWiqBq8WB/e2VsMwUeDoXrKUo1bucA8xFqnFczFG05S31HRDw8apJzYOWBgg2YXxzQMUnL+Z
 VgdhEJGu6j0+H0ZKhufCeZeXLULu7JLV8RvIHdn509HkCbwhUPNjqFOdiYlzfXKCrwKfRrQ8a
 3u3Q7SudONQ+mmV54Qr0Aep4NQKbnLpyEYzFFZbrF+fOK0fmhYXza31+7pghcA4av+nRqAEVw
 97x4o6d6is5YHilK4C4tM8M0PvyzI5EgjES570zgSsjw92hB+DPJqyV/deCBeA5jKkHyoM90J
 m8Cf0WdNmFSOFKzNvvlYZJ4N1s816YXKq9J1ztyy2LRneP/XRgORyrLPsPNiUnaspg8zIn+Sm
 OElw3BThIYkJ70KOC
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 25 Apr 2020 10:56:28 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 25 Apr 2020 10:56:25 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] =?utf-8?q?Evolution_around_the_information_=E2=80=9Ctry_t?=
 =?utf-8?q?o_delete_an_expanded_token=E2=80=9D=3F?=
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

SGVsbG8sCgpJIGhhdmUgdHJpZWQgYW5vdGhlciBzbWFsbCBzY3JpcHQgb3V0IGZvciB0aGUgc2Vt
YW50aWMgcGF0Y2ggbGFuZ3VhZ2UKKGFjY29yZGluZyB0byB0aGUgc29mdHdhcmUgY29tYmluYXRp
b24g4oCcQ29jY2luZWxsZSAxLjAuOC0wMDAyOS1nYTU0OWI5ZjDigJ0pLgoKCkBkaXNwbGF5QApl
eHByZXNzaW9uIGUsIHggIT0geyBQVFJfRVJSIH0sIHk7CnN0YXRlbWVudCBpcywgZXM7CnR5cGUg
dDsKQEAKKmUgPSAodCkgeCguLi4pCiAuLi4gd2hlbiAhPSBpZiAoPCsuLi4gZSAuLi4rPikgaXMg
ZWxzZSBlcwogICAgIHdoZW4gIT0geSg8Ky4uLiBlIC4uLis+KQogcmV0dXJuIGU7CgoKU291cmNl
IGZpbGUgZXhhbXBsZToKaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvZnMvcHJvYy9iYXNlLmM/aWQ9YWI1MWNhYzAw
ZWYyODU5ZjIwYTczZDMzYTUzZjNhODk4N2I2NWUxMSNuMzY0NQpodHRwczovL2VsaXhpci5ib290
bGluLmNvbS9saW51eC92NS43LXJjMi9zb3VyY2UvZnMvcHJvYy9iYXNlLmMjTDM2NDUKCi8vIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wCi8vIGRlbGV0ZWQgcGFydApzdGF0aWMgc3Ry
dWN0IHRhc2tfc3RydWN0ICpmaXJzdF90aWQoc3RydWN0IHBpZCAqcGlkLCBpbnQgdGlkLCBsb2Zm
X3QgZl9wb3MsCgkJCQkJc3RydWN0IHBpZF9uYW1lc3BhY2UgKm5zKQp7CglzdHJ1Y3QgdGFza19z
dHJ1Y3QgKnBvcywgKnRhc2s7Cgl1bnNpZ25lZCBsb25nIG5yID0gZl9wb3M7Ci8vIGRlbGV0ZWQg
cGFydAoJaWYgKG5yID49IGdldF9ucl90aHJlYWRzKHRhc2spKQoJCWdvdG8gZmFpbDsKLy8gZGVs
ZXRlZCBwYXJ0Cglwb3MgPSB0YXNrID0gdGFzay0+Z3JvdXBfbGVhZGVyOwoJZG8gewoJCWlmICgh
bnItLSkKCQkJZ290byBmb3VuZDsKCX0gd2hpbGVfZWFjaF90aHJlYWQodGFzaywgcG9zKTsKZmFp
bDoKCXBvcyA9IE5VTEw7Cglnb3RvIG91dDsKZm91bmQ6CglnZXRfdGFza19zdHJ1Y3QocG9zKTsK
b3V0OgoJcmN1X3JlYWRfdW5sb2NrKCk7CglyZXR1cm4gcG9zOwp9Ci8vIGRlbGV0ZWQgcGFydAoK
CklzIHRoZSBmb2xsb3dpbmcgZXJyb3IgbWVzc2FnZSB3b3J0aCBmb3IgZnVydGhlciBzb2Z0d2Fy
ZSBkZXZlbG9wbWVudCBjb25zaWRlcmF0aW9ucz8KCmVsZnJpbmdAU29ubmU6fi9Qcm9qZWt0ZS9D
b2NjaW5lbGxlL2phbml0b3I+IHNwYXRjaCBzaG93X3VuY2hlY2tlZF9yZXR1cm5fdmFsdWVzX2Jl
Zm9yZV9yZXR1cm4yLmNvY2NpIC4uL1Byb2JlL2ZpcnN0X3RpZC1leGNlcnB0MS5jCuKApgouLi9Q
cm9iZS9maXJzdF90aWQtZXhjZXJwdDEuYzogMTY6IHRyeSB0byBkZWxldGUgYW4gZXhwYW5kZWQg
dG9rZW46IHBvcwoKClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2
LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
