Return-Path: <SRS0=peAA=EA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D96AC55178
	for <cocci@archiver.kernel.org>; Sun, 25 Oct 2020 20:55:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A41FA22284
	for <cocci@archiver.kernel.org>; Sun, 25 Oct 2020 20:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ih5Z7rSZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41FA22284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09PKtK9Z027082;
	Sun, 25 Oct 2020 21:55:20 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7198C5C18;
	Sun, 25 Oct 2020 21:55:20 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 37B205C16
 for <cocci@systeme.lip6.fr>; Sun, 25 Oct 2020 14:26:13 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09PDQ9N6007008;
 Sun, 25 Oct 2020 14:26:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1603632368;
 bh=ymsrOB9IX3Aa+gHMr37pJ0ZwXJFlxBtl8FYVO56l0Y0=;
 h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
 b=ih5Z7rSZIhWAHrF+/Vd/rIQwT8fxYff8uCArJDR0vyHgVUawWan68gQHknSBGq9ch
 2h8or4GkTgcpnzRb8E1QSsn9USF9vSYC/sT9aAvL3EMVn+SYLorf8TYQRYTrovlwrC
 KITQADo8Popjb0xWEuSteqUTxqviyDZoLWAv3kOw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.86.219]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MfKtN-1jvfWV0XGt-00gmUA; Sun, 25
 Oct 2020 14:26:08 +0100
To: Coccinelle <cocci@systeme.lip6.fr>, Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <9a22556d-ca26-8082-b18c-52c7f0423670@web.de>
Date: Sun, 25 Oct 2020 14:25:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:zpMQHETjj118pjJCnF53cOPW+imGN1Hg5vPf9z3rhLwXIyjsNXe
 +yaJyVrytcPQFKjpdj/d2E+bCTgABXHceS6eoNcZbkxP/eeIz10L2UE0Yvv4twNuDNbaBdh
 d8vh97Nw6WibTcpVT3wILZHTCO9ehvrgMbmN/uck0n2Ird2J0jQ6GIuxtmG5D1LQ/bWmDt4
 qEVmDquvjA9PHeJeAMUaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V1tJpjk4HYc=:XQSWXv+IYndiAydPiXcyPu
 0P1iheO2rhS/eFg7x86FS901J/ejCGUbjqqTu0BNVe5q14yz753gXOkIvDLAKPpqU1xqVLIlc
 OAh/qAXjklUOERAX3WlgNsGL0UiFYXzKNllpoV86eP7iQ4lJpL5PSaM7s6P92HZS/DEWu11rf
 m7tAK3E18nAGl6svnX7wgCFrZ8E9T2X68ashx251cI/wTIL0Q/QbtYNlJrawJA6QKVSYOPnag
 Akev6s5G+XOr9EWy0DyU8Y5+DdkaIpVZEzSEiP1ptgNfrF2S4WiOfeAWVePoH1qPkaDEV+WKZ
 J5XLDsM96Pqk/IVxK4D66vDw679HAiTpLOCO2kcYreMithvx+LYddSFLOBnWHGJBjd/GXREvN
 djURcAadwcmZrDeKO9sKwyoMi0EYJtc4EY26UrwaOont5XAbbDz1KHwFf1wUvt7HxKqOSgpGC
 bLDNlS7fNg3D10012wA3CHi7WTATXXBWZ7XC5DTIRGisQNmb3RMxf+hOrmnCGLJpOsLrTQUk0
 YrWPiQ+PmC7GA2xawYCWiV/Y0aIBzH92aMA8pKxutYUTg11BJ5VILmqBD057VkoeljFzr3/vv
 4VP+Pt8P7y1G1RT76bsJWF7vLXV1vWdZBUMeFKyCHYgkN/yH/2BNrayLKm7WROCqr2BG64GU9
 BG82W0JUTse7A42G+iVxxouPmlYGvFhpZS9ypqTUL8eJFjRe7vxu48N1V0nRSZstqy5ULq+9l
 I+cs9QEn5ZL1tZLn09f2fdPe2uHSjus6/C592c4m5V6mrN8HCbPLiLmZvrcO35n1TcCACteFj
 rK6Qk/lYXRNlUsYvyOFDlJYyhDEcT62aUTvE2h0S6+bv4sGr/D8wb6e8xCWDVf0EcOVGqic+J
 6sIlQCvW/dCXpry8PBaw==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 25 Oct 2020 21:55:20 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 25 Oct 2020 14:26:09 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sun, 25 Oct 2020 21:55:18 +0100
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Cocci] =?utf-8?q?=5BPATCH=5D_Coccinelle=3A_api=3A_Optimise_disju?=
 =?utf-8?q?nction_in_SmPL_script_=E2=80=9Cpm=5Fruntime=2Ecocci=E2=80=9D?=
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

RnJvbTogTWFya3VzIEVsZnJpbmcgPGVsZnJpbmdAdXNlcnMuc291cmNlZm9yZ2UubmV0PgpEYXRl
OiBTdW4sIDI1IE9jdCAyMDIwIDE0OjEwOjU4ICswMTAwCgpBIGRpc2p1bmN0aW9uIGlzIGFwcGxp
ZWQgYnkgdGhpcyBzY3JpcHQgZm9yIHRoZSBzZW1hbnRpYyBwYXRjaCBsYW5ndWFnZS4KVGhpcyBj
b25zdHJ1Y3QgdXNlcyBzaG9ydC1jaXJjdWl0IGV2YWx1YXRpb24uIEl0IGhhcyBnb3QgdGhlIGNv
bnNlcXVlbmNlCnRoYXQgdGhlIGxhc3QgZWxlbWVudCBvZiB0aGUgc3BlY2lmaWVkIGNvbmRpdGlv
biB3aWxsIG9ubHkgYmUgY2hlY2tlZAppZiBhbGwgcHJldmlvdXMgcGFydHMgZGlkIG5vdCBtYXRj
aC4gU3VjaCBhIHRlY2huaWNhbCBkZXRhaWwgbGVhZHMgdG8KYSByZWNvbW1lbmRlZCBvcmRlcmlu
ZyBvZiBjb25kaXRpb24gcGFydHMgaWYgeW91IHdvdWxkIGxpa2UgdG8gY2FyZSBmb3IKb3B0aW1h
bCBydW4gdGltZSBjaGFyYWN0ZXJpc3RpY3Mgb2YgU21QTCBjb2RlLgoKQW4gdXNhZ2UgaW5jaWRl
bmNlIHdhcyBkZXRlcm1pbmVkIGZvciB0aGUgc3BlY2lmaWVkIGlkZW50aWZpZXJzIGluIHNvdXJj
ZQpmaWxlcyBmcm9tIHRoZSBzb2Z0d2FyZSDigJxMaW51eCBuZXh0LTIwMjAxMDIz4oCdIGJ5IGFu
b3RoZXIgU21QTCBzY3JpcHQuClRoaXMgYW5hbHlzaXMgcmVzdWx0IGluZGljYXRlZCB0aGF0IGEg
ZmV3IGZ1bmN0aW9ucyB3ZXJlIGNhbGxlZCBtb3JlCmZyZXF1ZW50IHRoYW4gb3RoZXJzLgpUaHVz
IHJlb3JkZXIgdGhlIFNtUEwgZGlzanVuY3Rpb24gaXRlbXMgcGFydGx5IGFjY29yZGluZyB0byB0
aGVpcgp1c2FnZSBpbmNpZGVuY2UuCgpTaWduZWQtb2ZmLWJ5OiBNYXJrdXMgRWxmcmluZyA8ZWxm
cmluZ0B1c2Vycy5zb3VyY2Vmb3JnZS5uZXQ+Ci0tLQogc2NyaXB0cy9jb2NjaW5lbGxlL2FwaS9w
bV9ydW50aW1lLmNvY2NpIHwgNDAgKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Nj
cmlwdHMvY29jY2luZWxsZS9hcGkvcG1fcnVudGltZS5jb2NjaSBiL3NjcmlwdHMvY29jY2luZWxs
ZS9hcGkvcG1fcnVudGltZS5jb2NjaQppbmRleCAxY2NjZTNmZDAwYjguLjdkOTkwOGNmMDgwMyAx
MDA2NDQKLS0tIGEvc2NyaXB0cy9jb2NjaW5lbGxlL2FwaS9wbV9ydW50aW1lLmNvY2NpCisrKyBi
L3NjcmlwdHMvY29jY2luZWxsZS9hcGkvcG1fcnVudGltZS5jb2NjaQpAQCAtMjEsMjUgKzIxLDI3
IEBAIGV4cHJlc3Npb24gcmV0OwogcG9zaXRpb24gcDsKIEBACiAoCi1yZXRAcCA9IFwocG1fcnVu
dGltZV9pZGxlXHwKLQlwbV9ydW50aW1lX3N1c3BlbmRcfAotCXBtX3J1bnRpbWVfYXV0b3N1c3Bl
bmRcfAotCXBtX3J1bnRpbWVfcmVzdW1lXHwKLQlwbV9yZXF1ZXN0X2lkbGVcfAotCXBtX3JlcXVl
c3RfcmVzdW1lXHwKLQlwbV9yZXF1ZXN0X2F1dG9zdXNwZW5kXHwKLQlwbV9ydW50aW1lX2dldFx8
Ci0JcG1fcnVudGltZV9nZXRfc3luY1x8Ci0JcG1fcnVudGltZV9wdXRcfAotCXBtX3J1bnRpbWVf
cHV0X2F1dG9zdXNwZW5kXHwKLQlwbV9ydW50aW1lX3B1dF9zeW5jXHwKLQlwbV9ydW50aW1lX3B1
dF9zeW5jX3N1c3BlbmRcfAotCXBtX3J1bnRpbWVfcHV0X3N5bmNfYXV0b3N1c3BlbmRcfAotCXBt
X3J1bnRpbWVfc2V0X2FjdGl2ZVx8Ci0JcG1fc2NoZWR1bGVfc3VzcGVuZFx8Ci0JcG1fcnVudGlt
ZV9iYXJyaWVyXHwKLQlwbV9nZW5lcmljX3J1bnRpbWVfc3VzcGVuZFx8Ci0JcG1fZ2VuZXJpY19y
dW50aW1lX3Jlc3VtZVwpKC4uLik7CisgcmV0QHAgPQorKHBtX3J1bnRpbWVfZ2V0X3N5bmMKK3xw
bV9ydW50aW1lX3NldF9hY3RpdmUKK3xwbV9ydW50aW1lX3B1dF9zeW5jX2F1dG9zdXNwZW5kCit8
cG1fcnVudGltZV9wdXRfc3luYworfHBtX3J1bnRpbWVfZ2V0Cit8cG1fcnVudGltZV9wdXQKK3xw
bV9nZW5lcmljX3J1bnRpbWVfc3VzcGVuZAorfHBtX2dlbmVyaWNfcnVudGltZV9yZXN1bWUKK3xw
bV9yZXF1ZXN0X2F1dG9zdXNwZW5kCit8cG1fcmVxdWVzdF9pZGxlCit8cG1fcmVxdWVzdF9yZXN1
bWUKK3xwbV9ydW50aW1lX2F1dG9zdXNwZW5kCit8cG1fcnVudGltZV9iYXJyaWVyCit8cG1fcnVu
dGltZV9pZGxlCit8cG1fcnVudGltZV9wdXRfYXV0b3N1c3BlbmQKK3xwbV9ydW50aW1lX3B1dF9z
eW5jX3N1c3BlbmQKK3xwbV9ydW50aW1lX3Jlc3VtZQorfHBtX3J1bnRpbWVfc3VzcGVuZAorfHBt
X3NjaGVkdWxlX3N1c3BlbmQKKykoLi4uKTsKIC4uLgogSVNfRVJSX1ZBTFVFKHJldCkKIC4uLgot
LQoyLjI5LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1l
LmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
