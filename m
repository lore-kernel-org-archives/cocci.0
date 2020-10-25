Return-Path: <SRS0=peAA=EA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CCDC2D0A3
	for <cocci@archiver.kernel.org>; Sun, 25 Oct 2020 02:05:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE38721707
	for <cocci@archiver.kernel.org>; Sun, 25 Oct 2020 02:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEr8Ngfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE38721707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09P24omt029118;
	Sun, 25 Oct 2020 03:04:50 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 92E4D75B4;
	Sun, 25 Oct 2020 03:04:50 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3077F4316
 for <cocci@systeme.lip6.fr>; Sun, 25 Oct 2020 03:04:49 +0100 (CET)
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:641])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09P24mL7000681
 for <cocci@systeme.lip6.fr>; Sun, 25 Oct 2020 03:04:48 +0100 (CET)
Received: by mail-ej1-x641.google.com with SMTP id k3so8291798ejj.10
 for <cocci@systeme.lip6.fr>; Sat, 24 Oct 2020 19:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=jfiC76ZXZixSmkCgyFffEerddDxHcz9z84xsuiZL8Es=;
 b=SEr8Ngfog2D/LbKlWXvg6UmdHDHonh8XxW0IgGm9Tk62twOu815yhryVB0vWOj5zCY
 iTbaYVtB02l/IG6sAz7vtE/NyoYH4eCN/vHU1WBQ8ZmP54eEgUAPGtRN+EC2P9x4bK06
 P7pNyw6vlb617yYGMv9tSpduW1sNO6aCpdRdg9aJQ1ClV3iWChaSyNuIZWEQ38sLuS96
 KnX/LSaxSV343EqGjhSob3NXvUSUEz/AwOxU8nhQ159JajWDLfPxvLaAjWZdtrtXTyb8
 Sy6LDblSR1ovCiWGyWE3rPdZ/BkpYaFQecfTzfOZtRwIc0RT3g8Z1a2dfDYUQXEiRwG4
 H7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:content-transfer-encoding;
 bh=jfiC76ZXZixSmkCgyFffEerddDxHcz9z84xsuiZL8Es=;
 b=erk7AKrZtYn1Uhe9jahrykq5p0Ew9JZUWXWaeIW7cRSlJiddrX4PBWE0ZeddRCgQzV
 UwKFxRqD+HYBlx0AvU/7koQEM7Kk/4RuoDHJ/44EhPo5Hjruz4JdIv3gigyqYuwzzY0j
 a+WwgvA0Jzb1l5Uj+9+CmPp04AL0NdJTC31r+/Dz01o6QxTqCLPDnXCt7gxYlIuy4/Da
 DjloVdUtGNFba6wZWhIMeixGDzdZfEwfpZZqbpNjikjuX+fV2F12t7/Jb3suZWwjqtTE
 /ifp89BJD/enae3aJHEdU6GbFYQtUIzpEaXmLfqi6kYT1BpjQDoki/LlghyPoFoDiEeS
 xPEQ==
X-Gm-Message-State: AOAM532u1XfgGlcD+SEWeRfdZY9HNYBxdyguD0M3wMN/4J+CmhvM4vD7
 UO9W8NF3AqWQfXpwVZzTpmKCGZOUBK/mir1EpOPa3a0W86o=
X-Google-Smtp-Source: ABdhPJxAtUXJA+sSQylzuksw0c4CKr+mmCdWoMX4JiBnOsL4ulH48BJ3cKP/Nb4d9fE7jfbY9A2i4mrsNMrvBQIjIow=
X-Received: by 2002:a17:906:fa84:: with SMTP id
 lt4mr9278599ejb.61.1603591487715; 
 Sat, 24 Oct 2020 19:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <CALogXGVr7OYtWhrsZg7gnO+czzu6eM_GGThYSCYezgUmVjwqZA@mail.gmail.com>
 <13dbaaf7-6655-7939-e173-310c45d1878e@web.de>
 <alpine.DEB.2.22.394.2010231710010.2707@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2010231710010.2707@hadrien>
From: Mansour Moufid <mansourmoufid@gmail.com>
Date: Sat, 24 Oct 2020 22:04:36 -0400
Message-ID: <CALogXGX3Xq-H_q6GvZYvubu-sR94sxjJ-f3xVmYbUNCOpAb+sw@mail.gmail.com>
To: cocci@systeme.lip6.fr
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 25 Oct 2020 03:04:51 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 25 Oct 2020 03:04:48 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: Re: [Cocci] Adjusting replacement lists with SmPL?
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

T24gRnJpLCBPY3QgMjMsIDIwMjAgYXQgMTE6MDAgQU0gTWFya3VzIEVsZnJpbmcgPE1hcmt1cy5F
bGZyaW5nQHdlYi5kZT4gd3JvdGU6Cj4KPiA+IEknZCBsaWtlIHRvIGFkZCBhIHN0YXRlbWVudCBh
ZnRlciBhbm90aGVyIHdpdGhpbiBhIHByZXByb2Nlc3NvciBleHByZXNzaW9uLAo+Cj4gSG93IGRv
IHlvdSB0aGluayBhYm91dCB0byByZWZlciB0byBhIOKAnCNkZWZpbmUgZGlyZWN0aXZl4oCdPwoK
SSBtZWFuLCBub3Qgc3BlY2lmaWNhbGx5IGluIHRoZSAjZGVmaW5lLCBidXQgYW55d2hlcmUuCgoo
SSBkb24ndCB0cnkgdG8gcGF0Y2ggcHJlcHJvY2Vzc29yIGRpcmVjdGl2ZXMgd2l0aCBzcGF0Y2gs
IEkgdXNlIHNlZCBmb3IgdGhhdC4pCgo+ID4gICAgICNkZWZpbmUgWChhKSB4KGEpOwo+ID4KPiA+
IChJIGtub3cgdGhlIGFib3ZlIGlzIG5vdCB0ZWNobmljYWxseSBjb3JyZWN0IGJ1dCBpdCdzIHN1
cGVyIGNvbW1vbi4pCj4KPiBJIHN0dW1ibGUgb24gdW5kZXJzdGFuZGluZyBkaWZmaWN1bHRpZXMg
Zm9yIHRoaXMgaW5mb3JtYXRpb24uCj4gV291bGQgeW91IGxpa2UgdG8gY2xhcmlmeSB0aGUga25v
d2xlZGdlIGFib3V0IGNvcnJlY3RuZXNzIGEgYml0IG1vcmU/CgpBIHRyYWlsaW5nIGNvbG9uIGlu
IGEgI2RlZmluZSBsZWFkcyB0byBjb2RlIGxpa2UgdGhpczoKCiAgICB7CiAgICAgICAgWCgxKQog
ICAgICAgIFgoMikKICAgICAgICAuLi4KICAgIH0KCi4uLiB3aGljaCBvZiBjb3Vyc2UgZG9lcyBu
b3QgcGFyc2UuICBJdCB3b3VsZCBiZSBiZXR0ZXIgdG8gdXNlIGEgZG8gewouLi4gfSB3aGlsZSAo
MCksIG9yIGJldHRlciB5ZXQgYW4gaW5saW5lIGZ1bmN0aW9uLiAgQnV0IHVuZm9ydHVuYXRlbHkK
dGhlIGFib3ZlIHN0eWxlIGlzIHZlcnkgY29tbW9uLgoKT24gRnJpLCBPY3QgMjMsIDIwMjAgYXQg
MTE6MTEgQU0gSnVsaWEgTGF3YWxsIDxqdWxpYS5sYXdhbGxAaW5yaWEuZnI+IHdyb3RlOgoKPiBJ
IGRvbid0IHRoaW5rIGhlIGlzIGFza2luZyB0aGF0LiAgSGUgbWVhbnMsIGlmIHRoZSBjYWxsIHRv
IHggaGFwcGVucyB0byBiZQo+IGluIGEgbWFjcm8gZGVmaW5pdGlvbiwgaG93IGNhbiBoZSBlbnN1
cmUgdGhhdCB0aGUgdHJhbnNmb3JtZWQgY29kZSB0cmVhdHMKPiBuZXdsaW5lcyBpbiB0aGUgcmln
aHQgd2F5LgoKWWVzLCBleGFjdGx5LiA6KQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZy
Cmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
