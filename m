Return-Path: <SRS0=jsWv=J2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C23C43460
	for <cocci@archiver.kernel.org>; Thu, 29 Apr 2021 18:13:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 848F261445
	for <cocci@archiver.kernel.org>; Thu, 29 Apr 2021 18:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848F261445
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 13TIDqV0008204;
	Thu, 29 Apr 2021 20:13:53 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 69CC8780B;
	Thu, 29 Apr 2021 20:13:52 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id F340F3DD8
 for <cocci@systeme.lip6.fr>; Tue, 27 Apr 2021 21:30:38 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 13RJUc2C012552
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 27 Apr 2021 21:30:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1619551827;
 bh=HAKfhs28A0eiCHPwXoI3TiHzDHrNUNijw1CaRhaf2+4=;
 h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
 b=ad2PMIpsu51mzkiYvc1HfQc+8WVu7+j5sVCwI7apog9PpZkMI4OlyNYHMzs612w9u
 aCchLe2fy2Z2jPfIX/xjvyZxbsEQudS1B5IUQaSoJMvB6Jrl6D7DZWROdmxxN7vQw+
 hMAKm7cbjFKjpS9PHS7sDUAdAuuinacknosQKppk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.68.16]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mm9Zc-1lBB9X1dw0-00i5PZ; Tue, 27
 Apr 2021 21:30:27 +0200
To: Julia Lawall <Julia.Lawall@inria.fr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org
References: <20210427141946.2478411-1-Julia.Lawall@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <e38d8318-8384-49b4-68d9-62ea770a3151@web.de>
Date: Tue, 27 Apr 2021 21:30:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210427141946.2478411-1-Julia.Lawall@inria.fr>
Content-Language: en-GB
X-Provags-ID: V03:K1:lzhHMv4hx5VnVLZ1sTo+BOpqi5nswgDngGnGqz+hwEJr2PvytYQ
 Xj5HMPwdPV+a+7SkEPbMJlTqtLNbbb37QV277JOhxJmD8q6l/byHr4L+JOg1CcOUfqN9MEQ
 OiN8CoWabUkmH5G/gntSWCGF8wi+4AdgnZH8dBd5tCsQMs+cTKamyrDsDvzmXyimN8bqXe8
 S1UaWQcOj7PVaYqFyo/sQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5rLeZyQUw6k=:zBZaxFiClQ4ZKHxuI65kLk
 DP8f16HFq6QS8ZWLs2Xk7U3t31hL+ooHQBraZWWJR/4jk8bl7NtPPgZTnPB6NG/6ApgpP0CdL
 XA7+fTn9ITKef712nea1O1NhN9g5GcTtweA0K9s30k6FcngayDfvxs4H2j+18Y/xobLMLkqPa
 qIIRuKxY242BRa8oQ1mpGNZ9WikcnBFu51ejfaC5lHF2XVgguU9qR4aUadRjv564Cg8EunxxL
 KqzS7Q/+apgyx6zV6Qi4SflE53DlcBhqOnDzS62lAQHi6KcPCyBzsne3PfvUB2a8dqjyEfEGJ
 oIsl+wOqNPyg1WDINh7NY6kL1RMfZ0t2cVeV47VRfCXMZpo0Hj4O8udGGsAC4pdnMvGksYZHY
 +8RT2ziYnJtUuPD7NaSP7+bXbsmZK3JaeJWXObdNLfXYGce5F/XLSY5GNf5k1zhOfaHnK6s+7
 CssXXsMcK/DUK8u9KpgsVscsIxmXyZbIrOKRztp61qqSHBuo+iqJppGthMlfqQF0idpy9d81j
 WL/i3u8OqJ6HJNmFu5tr4aTOjbyteFLG4V8PjZ4Ak9yHJqJ2pCjTOpeB5gn26JRB1/V0gUwfa
 DqLP2IlKh8v/1zIFOLNvy5OJDo0eDXMLj+kfxN2ONy80COkMns77jYtoooj/w9ryGDPSQIo4q
 r2br/4aUgL37CQpFrPpLKLuPTv/TRYtw/MZDsL7hu5Yiv+QvjUVxUrSN93zkYeYWeWnMv4aeE
 dxZlZIbhb/1wORgc6+QXuofn91Cxy02aRKXsSW4qfaAaxTgiJqI5ZpfRK4Ol0OxBlCm797K5Z
 KzCp/voDd1v6xDhygWIHePWKOB9JV9yVt4KBQlhSJ7UM463gceMLEKr+o7R/4FCyM3pcQtw6X
 YuSCFw4xw4vACODognIaLX92O+wnG5Z5KzsEI6Efa/M3A5dGAAsxC30VmTDNbITiU97YNilf6
 dYStx5LdgP6CnbmzX8dlUbOSZfi011+UJIkqUU14W1ThbS50GHUsAeN8UwVNPjxvwkoLbZa33
 e4fGGy5rNWfl8oIwxJKmXQHQVI1XAMxYuUH/XT2jwGUXCo9e2au1OE4XLoU0TKNYzqlncFPya
 KeZXx2K89C/E0kCxMBLWsvO6zI0NmFjKrukxMJm/duQRX7AL0YxlXpEdj9A3RQCnf2CIFe2vn
 u7+RTLZP+J0YauOlQU1n3YlqoW/SttrN1o5Rl5k3wT6Miz80cocC39lJ5RD1QD3l6+g+HDtEM
 pWvJ7QBtwbIrDfcO0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 29 Apr 2021 20:13:53 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 27 Apr 2021 21:30:38 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Thu, 29 Apr 2021 20:13:50 +0200
Cc: Michal Marek <michal.lkml@markovi.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [Cocci] [PATCH v4] coccinelle: api: semantic patch to use
 pm_runtime_resume_and_get
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

PuKApiBrZWVwcyBhIHJlZmVyZW5jZSBjb3VudCBvbiBmYWlsdXJlLCDigKYKCldvdWxkIHlvdSBn
ZXQgaW50byB0aGUgbW9vZCB0byBwZXJmb3JtIGEgc3lzdGVtYXRpYyBzb3VyY2UgY29kZSBzZWFy
Y2gKZm9yIHNpbWlsYXIgZnVuY3Rpb24gaW1wbGVtZW50YXRpb25zIGFjY29yZGluZyB0byByZXNv
dXJjZSBjbGVhbi11cD8KCgo+IHYyOiBiZXR0ZXIga2V5d29yZAoKSG93IGRvIHlvdSB0aGluayBh
Ym91dCB0byBhZGQgdGhlIGluZm9ybWF0aW9uIOKAnHdyYXBwZXIgZnVuY3Rpb25z4oCdIGhlcmU/
CgoK4oCmCj4gK0ByMCBkZXBlbmRzIG9uIHBhdGNoICYmICFjb250ZXh0ICYmICFvcmcgJiYgIXJl
cG9ydEAKPiArZXhwcmVzc2lvbiByZXQsZTsKPiArQEAKPiArCj4gKy0gICAgIHJldCA9IHBtX3J1
bnRpbWVfZ2V0X3N5bmMoZSk7Cj4gKysgICAgIHJldCA9IHBtX3J1bnRpbWVfcmVzdW1lX2FuZF9n
ZXQoZSk7CuKApgoKSSBzdWdnZXN0IG9uY2UgbW9yZSB0byBjb25jZW50cmF0ZSB0aGUgc3BlY2lm
aWNhdGlvbiBvZiBzdWNoIGEgY2hhbmdlCnRvIHRoZSBkZXNpcmVkIHJlcGxhY2VtZW50IG9mIHRo
ZSBtZW50aW9uZWQgZnVuY3Rpb24gbmFtZS4KCisgcmV0ID0KKy0gICAgICBwbV9ydW50aW1lX2dl
dF9zeW5jCisrICAgICAgcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldAorICAgICAgICAgICAgICAg
ICAgICAgICAgICAoZSk7CgoK4oCmCj4gKyAgICAgIGlmIChyZXQgPCAwKQo+ICstICAgICB7Cj4g
Ky0gICAgICAgICAgICAgcG1fcnVudGltZV9wdXRfbm9pZGxlKGUpOwo+ICsJICAgICAgUzEKPiAr
LSAgICAgfQo+ICsgICAgICBlbHNlIFMyCuKApgoKSSBwcm9wb3NlIHRvIHB1dCB0aGlzIGFkanVz
dG1lbnQgaW50byBhIGRpc2p1bmN0aW9uIGZvciB0aGUgc2VtYW50aWMgcGF0Y2ggbGFuZ3VhZ2Uu
CkhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgdG8gY29tYmluZSBmaXZlIFNtUEwgcnVsZXMgaW50byBv
bmU/CgoK4oCmCj4gKyogICAgIHJldEBqMCA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMoZSk7Cj4gKyAg
ICAgIGlmIChyZXQgPCAwKSB7Cj4gKyAgICAgICAgICAgICAgZiguLi4sYywuLi4pOwo+ICsqICAg
ICAgICAgICAgIHBtX3J1bnRpbWVfcHV0X25vaWRsZUBqMShlKTsKPiArCSAgICAgIC4uLgo+ICsg
ICAgICB9IGVsc2UgUwrigKYKCldvdWxkIHlvdSBsaWtlIHRvIGV4cHJlc3MgaW4gdGhlIFNtUEwg
Y29udGV4dCBydWxlcyB0aGF0IGEgbWFjcm8gb3IgZnVuY3Rpb24gY2FsbAppcyBvcHRpb25hbCBo
ZXJlPwoKQXJlIHRoZXJlIGFueSBvcHBvcnR1bml0aWVzIHRvIGNvbnNpZGVyIGZvciB0aGUgYXZv
aWRhbmNlIG9mIGR1cGxpY2F0ZSBTbVBMIGNvZGU/CgoK4oCmCj4gK21zZyA9ICJXQVJOSU5HOiBv
cHBvcnR1bml0eSBmb3IgcG1fcnVudGltZV9nZXRfc3luYyIKPiArY29jY2lsaWIub3JnLnByaW50
X3RvZG8oajBbMF0sIG1zZykK4oCmCgpDYW4gdGhlIGZvbGxvd2luZyBQeXRob24gY29kZSBiZSBt
b3JlIGFwcHJvcHJpYXRlPwoKK2NvY2NpbGliLm9yZy5wcmludF90b2RvKGowWzBdLCAiV0FSTklO
Rzogb3Bwb3J0dW5pdHkgZm9yIHBtX3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQiKQoKCldvdWxkIHlv
dSBsaWtlIHRvIHJlY29uc2lkZXIgdGhlIG1lc3NhZ2UgYWxzbyBmb3IgdGhlIFNtUEwgcmVwb3J0
IHJ1bGUgYWNjb3JkaW5nbHk/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3Rl
bWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2Np
Cg==
