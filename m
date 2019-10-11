Return-Path: <SRS0=jS6P=YE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82502C47404
	for <cocci@archiver.kernel.org>; Fri, 11 Oct 2019 07:04:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 895082084C
	for <cocci@archiver.kernel.org>; Fri, 11 Oct 2019 07:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="rKedcS+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895082084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9B73m9Q000997;
	Fri, 11 Oct 2019 09:03:48 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7AFB577B1;
	Fri, 11 Oct 2019 09:03:48 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AC5CC77AE
 for <cocci@systeme.lip6.fr>; Fri, 11 Oct 2019 09:03:47 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9B73lHm009607;
 Fri, 11 Oct 2019 09:03:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1570777426;
 bh=yWFKsCWcLAfgSRMEtAt359IMXh0D+FgSGUw6yU/fg1g=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=rKedcS+PnuMWTClCJpLYJWurzVmkF/bIme/Zp6socWryvSSDVtEqX8TrmPtyTPPL2
 O8cSLD0+29R52ZWI5DoVAIXP8M0+bci5OHOy8MTSPusBJp2uY6DuAzclUT4XwR5qrl
 PReGTiSeB43WWPtQwEOgpwyMVVE5LwoZVraDgBn4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.164.92]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lqleo-1hojKq2LYI-00eOVe; Fri, 11
 Oct 2019 09:03:46 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <24130ec6-4a20-7be4-755f-a6dfffcb6c97@web.de>
 <alpine.DEB.2.21.1910101509370.2305@hadrien>
 <8df6513d-36d3-2049-8fb0-28d84c8f9c85@web.de>
 <alpine.DEB.2.21.1910101537280.2305@hadrien>
 <293c83c3-d7b9-8c55-59e0-eaf7fd2fcc84@web.de>
 <alpine.DEB.2.21.1910101606420.2305@hadrien>
 <678d756b-a8ac-12c0-cdbe-96b49fc4eb2c@web.de>
 <alpine.DEB.2.21.1910102053440.2500@hadrien>
 <b76c96ca-4312-550a-3f56-a509c63faa0f@web.de>
 <alpine.DEB.2.21.1910110806250.2662@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c9b2c5be-455a-ad69-ad65-6efb910055b6@web.de>
Date: Fri, 11 Oct 2019 09:03:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910110806250.2662@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:hCGObEQhypQ+dT1af5WWooUUYqS/Xgq1xhDKUcLLBVi0WOYABQa
 ME/XwORrJQbjK2UKb2Wx2PxezM4qGhd6uGHSrYTUEs82g4liaTtHIIEpRfzB6fKaMdXWR5H
 E0/tEG8wgM4AEEedVQqBWVF5fYepbDRpBxKIb3XjLWO9JDnogr+ssoRI6433MDyoMt4sud0
 3Ti7EQUareR3E5DtPAIGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zj+wINpK/r8=:m45vwXh8Cog8q4fUTy9kRz
 Ws1aKRtlitnHJhPGBNY6Yq621+pOmQC4Y7z3H8EiYNq6Iu2iIQCszAkGuAXA6rO1FDob0fu82
 5kWNmxOedOlQsMVfWMm9k3owhu5ml4XgsWSMhWNnHnHuso0QxEckcOjO/GxgJgtss5BrHPZHn
 Lgzn5x1ACtgZJeP1unziVo2193xMa7Kn01fK4Bc49t1GvAMIJKCwTZCa9Vfe8J/7HDIL1pJj7
 E0Vxq553Dg5ZJXwmEPNewI06+JB1RImtyhHK8fpMpq61Ufxi3FHNYPnd30wgC8gxSg8sPDMYw
 GTNB6TY6dSg3CZdLOmodPgtQ3ERUc6W8tIsHIl30+4eykeQxOurz9WcJyVtgqCl87PScdLF2K
 2nXvUI6Ym67fkgjgvqJIOsKi8bdIoYf1/FrRBLF1Wb1r5XN6KVwmCUQ8bjPy7TluTnqOWE6pg
 0Ku57tWGMp4sII+93/LgUVLooVn9htIQZQgAmqMZByg8oCxQK0q4HfJOlK3+GrR+iYqwPi3Cu
 dkou/lVAjWC6r/iU7YnsWfsuiHaLYWHKU14A4oQN3sbJhLB2zQZTbZBtiFg0lkl8OWH83Konk
 7f5uytK3vzlt13vnib8QxuXamLqKPCHfpQ5ynf85MVkvDDGNgl7MOe8f5qAGKFECEydwLgmnd
 RaXNCMw/Ce99Dl6AaKBvFKI7nnrC4glbUJGI1Nzul7D5p/thwK4BW8wAl3a4Ia9ne7Kr70koF
 LeH0uxURzz1EJnEV21e+cICWL0cKcv8HEZeWbOlscYYAucvU1JnMWGwdl0j5rlitBVaE6tUDm
 NB2cJrywMrETKG96+74pqUzqoxvVsIP5jfGWngxX2/zYVWpp42gqRhSI/ayLyjCowKYGiXxe/
 rw3cXbVrqLVlhLs6OqaJ9uCwGftyiKg0TDbI+fYVXKQVA/xlpUlIHQC+i6oPuc/9sJjDjOYie
 /n6XKEFt3qTOeK1R60jiAGzsmz6MjG5rOXBmkjifEAFRDa3kKCifIxMGjr/DFwenSVqq9tOj7
 eLGmM1aerUFI5zgC1ilaDmuO0q/DzUtHsyGgle9cWAveAXB5exAQ3lMSw+5ImfRRTuJ4tWQZb
 Sg11kTik8CO4ftNtmLZ01ljicjlIA2usruYe54Y0I4NhpazQy5CiUVf+W7I+xH8TZ0eugVoKd
 c6bAGNymI+Rgby44SRQvav5qRfLApEyK1pdkVk2eCQFiN/Mt75wfcRounxkft9He4MHi8sPbp
 rafCaUGavYWPQlmj5BFd9liiOWbn8h/YpM/NEIox5WsWWFypU1XshKmvnvKY=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 11 Oct 2019 09:03:49 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 11 Oct 2019 09:03:47 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Software analysis with SmPL around unchecked function
 calls
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

Pj4gVGhlIHBvc3NpYmlsaXR5IHJlbWFpbnMgdGhhdCBhbHNvIHlvdXIgc2VhcmNoIHBhdHRlcm4g
c3VnZ2VzdGlvbiB3aWxsIHBvaW50Cj4+IHVwZGF0ZSBjYW5kaWRhdGVzIG91dCBhdCBvdGhlciBw
bGFjZXMgdGhhbiB0aGUgaW1wbGVtZW50YXRpb24gb2YgdGhlIG1lbnRpb25lZAo+PiBmdW5jdGlv
biDigJxpbXhfcGRfYmluZOKAnS4KPgo+IFNvIG1hbnkgd29yZHMuICBTbyBsaXR0bGUgaW5mb3Jt
YXRpb24uCgpUaGlzIGNhbiBhbHNvIG9jY2FzaW9uYWxseSBoYXBwZW4gaWYgdGhlIHNlYXJjaCBh
cHByb2FjaCBpcyBzaW1wbGVyCnRoYW4gaXQgd291bGQgYmUgcmVxdWlyZWQgZm9yIHNwZWNpZmlj
IHNvdXJjZSBjb2RlIHBsYWNlcy4KClRoZSBkaXNjdXNzaW9uIGNvbnRleHQgc2hvdWxkIGJlIHJl
c29sdmFibGUgdG9nZXRoZXIgd2l0aCBwcmV2aW91cyBtZXNzYWdlcy4KClJlcGV0aXRpb246Cmh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xp
bnV4LmdpdC90cmVlL2RyaXZlcnMvZ3B1L2RybS9pbXgvcGFyYWxsZWwtZGlzcGxheS5jP2lkPTQz
YjgxNWM2YThlN2RiY2NiNWI4YmQ5YzRiMDk5YzI0YmMyMmQxMzUjbjE5NwpodHRwczovL2VsaXhp
ci5ib290bGluLmNvbS9saW51eC92NS40LXJjMi9zb3VyY2UvZHJpdmVycy9ncHUvZHJtL2lteC9w
YXJhbGxlbC1kaXNwbGF5LmMjTDE5NwoKCj4gV2hhdCBpcyB0aGUgbmFtZSBvZiB0aGUgZmlsZSBh
bmQgdGhlIGxpbmUgbnVtYmVyIGF0IHdoaWNoIHlvdSBnZXQgYSByZXN1bHQKPiB0aGF0IHlvdSBm
aW5kIGluYWNjZXB0YWJsZSB3aXRoIG15IHJ1bGU/CgpBbm90aGVyIGV4YW1wbGU6Ck5vdyBJIHdv
bmRlciBhYm91dCBhIHBhdGNoIGh1bmsgbGlrZSB0aGUgZm9sbG93aW5nIHdoaWNoIGlzIGdlbmVy
YXRlZApmcm9tIHRoZSBkaXNjdXNzZWQgc2VhcmNoIHBhdHRlcm4gc3VnZ2VzdGlvbi4KCkBkaXNw
bGF5QApleHByZXNzaW9uIHg7CmlkZW50aWZpZXIgZjsKQEAKKiB4ID0ga21lbWR1cCguLi4pOwog
IC4uLiB3aGVuICE9IHgKKAogIHgtPmYKfAogIGYoLi4uLDwrLi4ueC4uLis+LC4uLikKKQoKCmVs
ZnJpbmdAU29ubmU6fi9Qcm9qZWt0ZS9MaW51eC9uZXh0LXBhdGNoZWQ+IHNwYXRjaCB+L1Byb2pl
a3RlL0NvY2NpbmVsbGUvamFuaXRvci9zaG93X3VuY2hlY2tlZF9rbWVtZHVwMy5jb2NjaSBuZXQv
c3VucnBjL2F1dGhfZ3NzL2F1dGhfZ3NzLmMK4oCmCkBAIC0xNDYsNyArMTQ2LDYgQEAgc2ltcGxl
X2dldF9uZXRvYmooY29uc3Qgdm9pZCAqcCwgY29uc3QgdgogCXEgPSAoY29uc3Qgdm9pZCAqKSgo
Y29uc3QgY2hhciAqKXAgKyBsZW4pOwogCWlmICh1bmxpa2VseShxID4gZW5kIHx8IHEgPCBwKSkK
IAkJcmV0dXJuIEVSUl9QVFIoLUVGQVVMVCk7Ci0JZGVzdC0+ZGF0YSA9IGttZW1kdXAocCwgbGVu
LCBHRlBfTk9GUyk7CiAJaWYgKHVubGlrZWx5KGRlc3QtPmRhdGEgPT0gTlVMTCkpCiAJCXJldHVy
biBFUlJfUFRSKC1FTk9NRU0pOwogCWRlc3QtPmxlbiA9IGxlbjsKCgpodHRwczovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9u
ZXQvc3VucnBjL2F1dGhfZ3NzL2F1dGhfZ3NzLmM/aWQ9OWUyMDhhYTA2YzIxMDliNDVlZWM2YmUw
NDlhOGU0NzAzNDc0OGMyMCNuMTQ5Cmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1
LjQtcmMyL3NvdXJjZS9uZXQvc3VucnBjL2F1dGhfZ3NzL2F1dGhfZ3NzLmMjTDE0OQoKCldpbGwg
dGhlIGNvcnJlc3BvbmRpbmcgY2xhcmlmaWNhdGlvbiBoZWxwIHNvZnR3YXJlIGRldmVsb3BlcnMg
KGJlc2lkZXMgbWUpPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxp
cDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
