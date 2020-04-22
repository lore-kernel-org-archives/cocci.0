Return-Path: <SRS0=E3P4=6G=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D928CC55189
	for <cocci@archiver.kernel.org>; Wed, 22 Apr 2020 07:41:16 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE05206A2
	for <cocci@archiver.kernel.org>; Wed, 22 Apr 2020 07:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="c5A7/gqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE05206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03M7ep7I029100;
	Wed, 22 Apr 2020 09:40:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 642367459;
	Wed, 22 Apr 2020 09:40:51 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 134DB3DC8
 for <cocci@systeme.lip6.fr>; Wed, 22 Apr 2020 09:40:50 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03M7enJ5028941
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 22 Apr 2020 09:40:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587541249;
 bh=yUY35lAfJUOXnRFBsjsDF13s/IRr6AZL39aVKC3A53o=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=c5A7/gqvTdkD2RybKlr8ApmZQBZX129sx3Vtuuqw4nne7JP+6Td5YlUM3nyHr3USX
 CKVR9ncMn5YCLoPbIcK2n5Eg4P6ABA+VAbs+K/u+H59U9NoULpXc6yKjWBpLKH5M4m
 a+2CjeBZi05WUmRRp8/YMcteijzW3GzOPDVagB9Y=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.62.29]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MA5if-1jXSTB3gN7-00BMby for
 <cocci@systeme.lip6.fr>; Wed, 22 Apr 2020 09:40:48 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <67211452-a192-ba7e-054f-f7faf9656c15@web.de>
Date: Wed, 22 Apr 2020 09:40:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:AQhTKkJys8zAJ5Sl3lV93ADleaSDw5m8W3SUWYusZX/4hXtPKGz
 CU1BEcEmHDxvqik4fPzHGdvVgbUF7KDOhvikOZXou8CcwTanSSQ2nRdZRWETsy00Ug6lZtd
 QKcA4yPj2lbD+mKWz6JdWBSjybm+6SFCF5KGy7RtwhVwhCEsbKc1sNzJIvNqgPTTVPkE76n
 sApFCe/YxNOhQ1VmVZkew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HsRtDI0Ib2Y=:0/VfAIcluGhw+x63oqqdjz
 mDWxmnRvrIgheoXBJJ3y4Fpk9aOsxYTYuz+PsZ7klmOO2ZQqGq/z9W0n1oVGidBXLX/pBehKN
 MVSIWMC3na8oSwp5uV0t0+6iDiKEj9p0rN9marWh9imbpaEyg0AwP+0WqPwfOTTa4xvSZ7XP1
 uHbVRVcaHdEJLAwhy8tg4erj+5B47NKYzwCTv8lFeSIuhBXO4pE8IGIlDoRIGZYfnOudkfS7o
 LqXT169vbhysHk+DZhSH6A3nmLCTIdhxtYBBtKgKWCYEXImcKeWYmpgRfPVAnTaymEynAroGq
 i3eS3tDx5iV8x8dwi10SAlAUHP5/LcZqeCqGkhMgGj2NBHoHhpzhLTwpmBCYdaS7f+EXNBlO8
 jz1GImG3Fq+7beqTYnmtAnC22AIUjk3Mdzcb0aSmng7bvJwNy46GuxJ+1pm2juPdSjrWHHUrs
 H3YLQfh2TOmG9EhHEXqJv3CniYo/lW6A5HsQ5xGEkJXo31cKpr+h8lLe09n1qFBEX4Re7GJMW
 ywcCj8F5oGsRJb72s8MLLV60Odg8nsUeeMlRi+qcI4Zbv+Bg5eF0hnji60teOcmJA74tWw7OD
 0ncDuuNPzcyyK6J03X9T5YeMjxJxC2/fzUkXslNMXlabo+WhoxLG8HTqyXaHRt5Nz/TjNK1S/
 lFW04sFxbivveXGjNRWeHUdG9RlLtGBT5xurMUDqdxXy/0BqR42lYnL6ShJh/ZTaj+rPMOwGd
 RQ09SVBLQh7ewuRZNos43k08BkQ0qNVS95A1AZe0kHnjX7c8E7McwYJGwveuoUw1WaVbZb8cM
 a4QJWm2sBGWqYNbS2c2cAk4vWzB9TaBtanzCiWIfpauPALhzxaej8tzpo+C7MHLM6SUVpTfO8
 1Jb940V+P3LGeJ543qf36QiCpgLtU+VdiTf/fcFiYKSa7FF3lnIlghvczt9dboErzG9h2u+7k
 2Zps0AAlW+HUXVl+ig6dapcpfbC0gsQ9Q8XPfSJi2/tgBFLIDP6B3LPUhf0jmnesFlmnf+4lb
 2uWInfPnuUky5LgqzBM2TzsW19mSf0OmVobXbdmDkjo9DWPy3lKE0D0Fdydt80DMBfoEoEo72
 TCUG+LgmYbdFarjw9d9VvbkvJL5UvhkdQh0t7i1vaVqHAwFkpr5YLTwJfyC7p/ZXFC3ozUujP
 iqaYXbkePVwPJ3AapmNiOnA9bHKD0x/KonIHKybrid8nvF3qq8EPwZjhPbpcaxt1/GBxG+5Pc
 ITRFIrY7alR6Q7eD/
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 22 Apr 2020 09:40:52 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 22 Apr 2020 09:40:49 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Combining isomorphisms with source code adjustments?
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

SGVsbG8sCgpJIGhhdmUgdGFrZW4gYW5vdGhlciBsb29rIGF0IHRoZSBmb2xsb3dpbmcgaW5mb3Jt
YXRpb24uCmh0dHBzOi8vZ2l0aHViLmNvbS9jb2NjaW5lbGxlL2NvY2NpbmVsbGUvYmxvYi82YjRi
YjY5MmYyMDhiZmU4NmU2MmE2MTY3MjQ1NzBkOTMxMGM3MTUwL3N0YW5kYXJkLmlzbyNMNTQ0Cgri
gKYKLy8gQWZmZWN0YXRpb24vaW5pdGlhbGlzYXRpb24gaXNvbW9ycGhpc20K4oCmCi8vIFRoZXkg
YXJlIGhhbmRsZWQgaW4gZW5naW5lLgovLyAnWCA9IFknICBzaG91bGQgYWxzbyBtYXRjaCAgJ3R5
cGUgWCA9IFknOwrigKYKCgpJIGhhdmUgdHJpZWQgYW5vdGhlciBzY3JpcHQgb3V0IGZvciB0aGUg
c2VtYW50aWMgcGF0Y2ggbGFuZ3VhZ2UuCgpAZGVsZXRpb25ACmV4cHJlc3Npb24gaW5wdXQsIHN0
b3JhZ2UsIHRhcmdldDsKQEAKIHN0b3JhZ2UKLSAgICAgICAgPSBpbnB1dAogLi4uIHdoZW4gIT0g
c3RvcmFnZQogdGFyZ2V0ID0gLi4uCgoKZWxmcmluZ0BTb25uZTp+L1Byb2pla3RlL0NvY2NpbmVs
bGUvamFuaXRvcj4gc3BhdGNoIC0tcGFyc2UtY29jY2kgZGVsZXRlX3VudXNlZF92YWx1ZTQuY29j
Y2kK4oCmCnRoZSBzaW1wbGUgYXNzaWdubWVudCBleHByZXNzaW9uIG9uIGxpbmUgNCBjb250YWlu
cyB0cmFuc2Zvcm1hdGlvbnMKdGhhdCBwcmV2ZW50IGl0IGZyb20gbWF0Y2hpbmcgYSBkZWNsYXJh
dGlvbiAobm90IHB1cmUpCuKApgoKCkhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgdGhlIHNvZnR3YXJl
IHNpdHVhdGlvbj8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2
LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
