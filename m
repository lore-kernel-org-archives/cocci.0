Return-Path: <SRS0=E3P4=6G=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC51AC5518A
	for <cocci@archiver.kernel.org>; Wed, 22 Apr 2020 10:53:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ADE62073A
	for <cocci@archiver.kernel.org>; Wed, 22 Apr 2020 10:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="QznrsiDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ADE62073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03MAqUr0013508;
	Wed, 22 Apr 2020 12:52:30 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B4D8B7459;
	Wed, 22 Apr 2020 12:52:30 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9F0753DC8
 for <cocci@systeme.lip6.fr>; Wed, 22 Apr 2020 12:52:29 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03MAqTXL019296
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 22 Apr 2020 12:52:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587552748;
 bh=6eQKHNyRpeN76sn1kgM2sTpkVNXY3suCyvw/ipyLz8o=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=QznrsiDmOunUIGjMhNmCj7SfyuP0AXk8xK4aa0xA3q5LmAffuCdogXuJ/3MJz8AJm
 hTQgQoXfhN8I715OVFQ9YeFm/2oPmwEPpeam99HsF2irGOnlqFrx/MREGuiRskWnE0
 /R4DXNqKP3XZwsQmVxDFtI7/iMfrQBo/JA9eTTlY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.62.29]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LZeVM-1imcts06dY-00lWgw; Wed, 22
 Apr 2020 12:52:28 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <67211452-a192-ba7e-054f-f7faf9656c15@web.de>
 <alpine.DEB.2.21.2004221237340.2425@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <dd26b45c-ef20-297b-c660-9e1bc13642b9@web.de>
Date: Wed, 22 Apr 2020 12:52:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2004221237340.2425@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:TsMt8E3OkEI480FBDg9xrWVZr0VP0CsI+yYb3sSGEfKUnC8EvVQ
 x4n+sIJrsW87DMOzQIWvr4+fcx6gdrbUP7ygjDyBLmd41hVZXk2mmKLCGaxDgxksWYHAIxV
 RsxKvh91/loVZ+CRu5cChMhcWGq5G0Nj7XseaeZGfaHsvEQaMYj0Voa1sx1ceU1x2q8FAsH
 WfaZULafSEsRvYIYrA7aw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N2WxCLbHZiI=:eEvyL4J2+q9q/ScxpPd9Vs
 SWw/MPVo4R9Hh1sg928VD1EbFJw4CLAkZZBs5IQbTw0UBp1ixiGM1TfLMCkUU+ck7RaLxxWbg
 Cs5GOcc3JDlIneO7aQffFq0ya+KVsAysE23TV1WI8DqIris0PiDpRoBPYSvjaXPlBd5Z/4UW3
 Znb+ZYTxCSAu5WfVsRi1uQbM3X3feBUHwvP/GC6qNLXrygJe6EZ+l2xAE573sRLWJHWbLy9pb
 uFRWmLufs2QOvERCW563sYG6x+jLmfah0SfkjLdu/HZjz7Xe0FFfGE4WgnSZTU308g7xd9siM
 /V0CmkDCivafhTpTBheA0NaOSTMGhNNHBxVkMUC3TAEu17vOkVo8lL2FzomdC3WAJdK0Xf06V
 3MD7ygGxDVzWbKGrYfFvNMS1OaO49aF4yIw3Ml8nIj+f9Wn0ZkfUy1MCzId9CT2ZyBp3+z3Za
 OJV/4B9Qp07HOaLDEsrnZXSphDwRypmSelNO6L8UPLWfpBQv+E0TV3qAuQH/LjiFaZXu0tWfC
 CTyUbSgak2x7ovSDuZojNcDcLUiRgT8qqdoByG8dXxrCPqD7QaOSEFSQnPTTDjl03SU1I6mv8
 0IgJlciKqaInOOve6f05AzuHnjsuwOxBPZYly0zXN092lmnMtLLs+KzlB58daGy9VAIxcjZO3
 2ae0lUTLJqaH+CLrz2A/PXnAwcNp9xBBAoBD+WkSw1sDdBl205J1urRnIPeEmfxAa5v03aokS
 8zH+/Rei1BicpeDesmPScJEcoYcIkF2CFhCzvzeNNMx+/7qm2lxZqhoy8UwN22DiqAl99ii2H
 ZM3B9Fdi441ZPWdG5mQfQEZzHB8qwgWL6R59ouIOb/kMNZXpER92xu0HfJgMZ6UZVHRGEYw3j
 yOCO2H5jqbruprnx6m+O7TceM5Cs2IqUdVi4HFs1cq8ApuRDtE1q578tWF7g2+35MORSNEma3
 Ju2/fczl1M7r3Y0fzbMNuJhf7RMCr4hesMlKv24GM/cuv3S0syDN8d1ewX8gzw4QDZWb1sE+B
 aaTNHFWDr5Ue8MnZbQtZTFA7/g9Vq2DADLE59zUmkf7S3Nnpdt3ne++kE8OYggkvYNA/kPsDh
 kf3kR3LVqmCtdt7H9y+FOJmHvWoWQHWPppUnTsN9Zv4Oo5yv4Y82hYcZjuUlR/6m/+puI4YgN
 bmsO1gPKbk8YEB/lUPppFv5c1wuq45HosrZTtXV+WxXkIDd4IL9hmRlRxNsHOrNr8aG+K70gS
 pJoAcOYaoaDt9b/xu
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 22 Apr 2020 12:52:31 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 22 Apr 2020 12:52:29 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Combining isomorphisms with source code adjustments?
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

Pj4gQGRlbGV0aW9uQAo+PiBleHByZXNzaW9uIGlucHV0LCBzdG9yYWdlLCB0YXJnZXQ7Cj4+IEBA
Cj4+ICBzdG9yYWdlCj4+IC0gICAgICAgID0gaW5wdXQKPj4gIC4uLiB3aGVuICE9IHN0b3JhZ2UK
Pj4gIHRhcmdldCA9IC4uLgo+Pgo+Pgo+PiBlbGZyaW5nQFNvbm5lOn4vUHJvamVrdGUvQ29jY2lu
ZWxsZS9qYW5pdG9yPiBzcGF0Y2ggLS1wYXJzZS1jb2NjaSBkZWxldGVfdW51c2VkX3ZhbHVlNC5j
b2NjaQo+PiDigKYKPj4gdGhlIHNpbXBsZSBhc3NpZ25tZW50IGV4cHJlc3Npb24gb24gbGluZSA0
IGNvbnRhaW5zIHRyYW5zZm9ybWF0aW9ucwo+PiB0aGF0IHByZXZlbnQgaXQgZnJvbSBtYXRjaGlu
ZyBhIGRlY2xhcmF0aW9uIChub3QgcHVyZSkKPj4g4oCmCj4+Cj4+Cj4+IEhvdyBkbyB5b3UgdGhp
bmsgYWJvdXQgdGhlIHNvZnR3YXJlIHNpdHVhdGlvbj8KPgo+IEkgdGhpbmsgd2hhdCB0aGUgbWVz
c2FnZSBzYXlzLiAgWW91IGhhdmUgcHV0IGEgLSBpbiBhbiBhd2t3YXJkIHBsYWNlIHNvIGl0Cj4g
bWF5IG5vdCBiZSBhYmxlIHRvIGFwcGx5IHNvbWUgaXNvbW9ycGhpc21zLgoKSSBnb3QgdGhlIGlt
cHJlc3Npb24gdGhhdCB0aGUgQ29jY2luZWxsZSBzb2Z0d2FyZSBjYW4gaGFuZGxlIGNoYW5nZXMK
dG9nZXRoZXIgd2l0aCBpc29tb3JwaGlzbXMgYXQgb3RoZXIgc291cmNlIGNvZGUgcGxhY2VzIGFs
cmVhZHkuCgoqIFdoeSBpcyB0aGlzIGZ1bmN0aW9uYWxpdHkgcmVzdHJpY3RlZCBoZXJlPwoKKiBU
aGUgcmVwb3J0ZWQgc29mdHdhcmUgbGltaXRhdGlvbiBjYW4gdHJpZ2dlciB1bmRlc2lyYWJsZSBj
b2RlIGR1cGxpY2F0aW9uCiAgaWYgYSBjb3JyZXNwb25kaW5nIHRyYW5zZm9ybWF0aW9uIGFwcHJv
YWNoIHdvdWxkIGJlIHJlcXVpcmVkIHNvIGZhcgogIHRvIGV4cHJlc3MgZXh0cmEgY2FzZSBkaXN0
aW5jdGlvbnMgYnkgdGhlIG1lYW5zIG9mIFNtUEwgZGlzanVuY3Rpb25zLgoKUmVnYXJkcywKTWFy
a3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2Np
IG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYu
ZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
