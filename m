Return-Path: <SRS0=wUuY=YI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D050EECE58F
	for <cocci@archiver.kernel.org>; Tue, 15 Oct 2019 12:41:10 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C44972083B
	for <cocci@archiver.kernel.org>; Tue, 15 Oct 2019 12:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="gLqdv2j3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44972083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9FCerUZ025585;
	Tue, 15 Oct 2019 14:40:53 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 91B7B77B5;
	Tue, 15 Oct 2019 14:40:53 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7FF5A77B2
 for <cocci@systeme.lip6.fr>; Tue, 15 Oct 2019 14:40:51 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9FCeoIm018201
 for <cocci@systeme.lip6.fr>; Tue, 15 Oct 2019 14:40:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571143250;
 bh=LS04ZRuHrXsEAZx0J+p1+35uEn4e/z3fmrqVdSb76MQ=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=gLqdv2j3wJ99fxNSMM99jwLfAuykZV59M+l4JEJfNjdGSKLY1//FgY/wzFiUfyPjI
 o0sA0VncjUUq9y9vaHnoOTzr3FVZH4eEfWyIUhgPKQrQuO3oGFS0Q7twNfFXNnPrw4
 czIJYHzpQWnVLHBswEKY26vmNgSlurW3rlT+tT6c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.79.11]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LePBV-1hhNp11JEL-00qAZz for
 <cocci@systeme.lip6.fr>; Tue, 15 Oct 2019 14:40:50 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <384c6657-5ddc-ff47-14e2-2ffad31295d2@web.de>
Date: Tue, 15 Oct 2019 14:40:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:WBYuC6QFxrW/6AqDSaen75Nkbi+h7MqwIx1RaBFCd6a9fycYW/q
 FgK+dnWpuiucK9USjbsqZLQMj5EIN6ZFc3U90YmYecKPYheXBg1tqVkwIjgHItOYryyYP1R
 DvgmlRvTZ6nRrALwUPb3wjw5jhkdh5/G7lCPrFgS/GPkP+s+sRuL/PTzimAPHBKvOo9ZfoP
 /2ryKQm7AWds2mwOTrRCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:22eJrwv0uEw=:j2c8vTMo4Sq4d3IsOrWozB
 cyRUlA/rRB6lWjtCywnHN6zjIjsQcqtKzl7Ejc/bcy/C3pqpB6LaYmGB8MQpLYZ33nrY8sA84
 t1Cma0OHqmYUcXjkDqZiat6S0LkGMvBEfBmogvK6Y1IJlP9LyAxsYwJyn1yUJ0BAY/oubGNkv
 TsCHU1gtPnD/VxNKBPkEYb72F1GR8j5T5rsunEUD0JFmIuEDAVqzV8XqKetXvc2QcMlHxgM2h
 0H5r1UvlKA9m77tdfIgjax8ghXiMsR4z/YlY2tsFUJMdhaFa6rFUmySIrFDTCplMZWONZJNPF
 lKR0wykYkfeQXkOHIQ6osGWhdgNj+zet2S3v4pn0Gu4lplxBDflUlwYO6v62A6zRqlrhXGNU0
 hn9g7QCjjhj0fkciF/jg6+b99xngrmtTB26nDXpER8pDHtr40uL4KD4NVvCerGbkHQNXL7Etd
 8btmE98jqrCiDn6LYjOo95AkolFA69Zs0FPbDLAU/HoGVdyXESNXZhW8tyy3Q5XRnl+CJ/HFd
 FVIIFXlW9x6yKdMTh0WC35wJlOl/Q/OiusFRkknF6IjBAM21jFGk4E3/9JNWQkAJKf7JYsZEk
 thmgjPjjKdxYQgF8hmFlsmQjsnSh33IkDlzIdRBp9z+l3JZWlXW1GlVeHv0v5g4GUSRyZ08lz
 SPoO1rvpeuEDcfkecmiJGVNwhYynbEz5NXxkT5ZviQT2mmUzEUa1I5bUzcOl4Hw9NWqTXmuwW
 3miMCFRNjtfYOsJ4gSPQIeVYOL0/wNO6HGOFRuqRKVlvKOKcCyRZKmdDCHu4rKCdYpOm5hnOR
 C/7AI1ymFwklJzUPdJa9+ar7KzvvOOG8UBFTmpzvjXd+sJA/szV39G/njVbR3f77YKJtF/V8P
 fQoayt5PFLcyIKDAQ/i2Mg+/ySHRnEq3OTKW6wpaf3Za9gWi8LTD0Cqu0EmlakJMLIfyb8VCL
 ecRY2V0SolaTHUUa52qp+al0CK9N51GpfeRBhXBPlH/pBCwCs4OP7XhEwNXnIyD4bnlA9t1tT
 kzcevpIFPnFUIrwATxzkSeID1o/taTqHhv4GWjwRkaxeNhwB1x2UqZF7W6Ip9lBd/oJ7/j+me
 c5/fF9RjyU9guWDbe9b4zp8nVFpymaywmzPnEF6UDd15EwN+84uciUOFDtrIuxZ9iTSf/1iOd
 ljmSVsX2c+GePsx1kSRjRji2F5Tlvum6EEzqB1+svF1iHTUrH36iYz7WNkudyCpXbbSmP9dNv
 5FNP6nLGPJFpmw2udROHQGoTCvN2pkRmigMLjW0Oex7MqgjKuBhKmDsFBzWA=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 15 Oct 2019 14:40:54 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 15 Oct 2019 14:40:51 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Checking pretty-printing around a transformation for
	array_size()
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

SGVsbG8sCgpJIGhhdmUgdHJpZWQgYW5vdGhlciBzb3VyY2UgY29kZSB0cmFuc2Zvcm1hdGlvbiBh
cHByb2FjaCBvdXQgd2l0aAp0aGUgc29mdHdhcmUgY29tYmluYXRpb24g4oCcQ29jY2luZWxsZSAx
LjAuOC0wMDAwNC1nODQyMDc1ZjfigJ0uCgpAcmVwbGFjZW1lbnRACmV4cHJlc3Npb24gY291bnQs
IGl0ZW0sIHNvdXJjZSwgdGFyZ2V0Owp0eXBlIHQxLCB0MjsKQEAKIHRhcmdldCA9IGttZW1kdXAo
c291cmNlLAorICAgICAgICAgICAgICAgICBhcnJheV9zaXplKAooCiAgICAgICAgICAgICAgICAg
IHNpemVvZigKLSAgICAgICAgICAgICAgICAgICAgICAgIHQxCisgICAgICAgICAgICAgICAgICAg
ICAgICAqc291cmNlCiAgICAgICAgICAgICAgICAgICAgICAgICkKfAogICAgICAgICAgICAgICAg
ICBjb3VudAopCi0gICAgICAgICAgICAgICAgICoKKyAgICAgICAgICAgICAgICAgLAooCiAgICAg
ICAgICAgICAgICAgIHNpemVvZigKLSAgICAgICAgICAgICAgICAgICAgICAgIHQyCisgICAgICAg
ICAgICAgICAgICAgICAgICAqc291cmNlCiAgICAgICAgICAgICAgICAgICAgICAgICkKfAogICAg
ICAgICAgICAgICAgICBpdGVtCikKKyAgICAgICAgICAgICAgICAgKQogICAgICAgICAgICAgICAg
ICAsIC4uLik7CgoKVGhpcyBzbWFsbCBTbVBMIHNjcmlwdCBjYW4gcHJvZHVjZSBzb21lIOKAnHVz
YWJsZeKAnSByZXN1bHRzLgpCdXQgSSBmaW5kIHRoZSBzb3VyY2UgY29kZSBmb3JtYXR0aW5nIG9j
Y2FzaW9uYWxseSBxdWVzdGlvbmFibGUKYWNjb3JkaW5nIHRvIHRoZSBMaW51eCBjb2Rpbmcgc3R5
bGUuCgpFeGFtcGxlOgpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9hcmNoL2FybS9tYWNoLW9tYXAyL29tYXBfZGV2
aWNlLmM/aWQ9NWJjNTJmNjRlODg0MWM0NTI2ZDc0ZjEwNzNiZmE5NWQ0ZjYyMjRkNCNuMzQ4Cmh0
dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1LjQtcmMyL3NvdXJjZS9hcmNoL2FybS9t
YWNoLW9tYXAyL29tYXBfZGV2aWNlLmMjTDM0OAoKZWxmcmluZ0BTb25uZTp+L1Byb2pla3RlL0xp
bnV4L25leHQtcGF0Y2hlZD4gc3BhdGNoIGFyY2gvYXJtL21hY2gtb21hcDIvb21hcF9kZXZpY2Uu
YyB+L1Byb2pla3RlL0NvY2NpbmVsbGUvamFuaXRvci91c2VfYXJyYXlfc2l6ZV9mb3Jfa21lbWR1
cDIuY29jY2kK4oCmCkBAIC0zNDUsNyArMzQ1LDcgQEAgc3RydWN0IG9tYXBfZGV2aWNlICpvbWFw
X2RldmljZV9hbGxvYyhzdAogCX0KIAlvZC0+aHdtb2RzX2NudCA9IG9oX2NudDsKCi0JaHdtb2Rz
ID0ga21lbWR1cChvaHMsIHNpemVvZihzdHJ1Y3Qgb21hcF9od21vZCAqKSAqIG9oX2NudCwgR0ZQ
X0tFUk5FTCk7CisJaHdtb2RzID0ga21lbWR1cChvaHMsYXJyYXlfc2l6ZSggc2l6ZW9mKCpvaHMp
LCBvaF9jbnQpLCBHRlBfS0VSTkVMKTsKIAlpZiAoIWh3bW9kcykKIAkJZ290byBvZGFfZXhpdDI7
CuKApgoKCldvdWxkIHlvdSBsaWtlIHRvIGNsYXJpZnkgcHJldHR5LXByaW50aW5nIGNvbmNlcm5z
PwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6
Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
