Return-Path: <SRS0=cw0N=6I=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF9CC54FD0
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 12:40:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F97620704
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2020 12:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="PvOn2cS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F97620704
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03OCehee001194;
	Fri, 24 Apr 2020 14:40:43 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BE77E7827;
	Fri, 24 Apr 2020 14:40:43 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EC3B97815
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 14:40:41 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03OCefBl014075
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Fri, 24 Apr 2020 14:40:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587732040;
 bh=vFTedv6PgCVeTHpBSeAfiYBczY1KNscpeEKav3ZPtxQ=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=PvOn2cS/WpQFeNKHuhVl8o22x6r3IQahUMcgADfApGU22MfE2Kodf7BAYswvjtEfA
 WoeC0glftcDD43lZOnjuA/384wpy6Dv0o22mUH/fT2OZAJKnLNlf4XAWCqZJvukxZ2
 m9xPY7SGbtavv8LfRP1SWcBYKT6XYvoTNDTyJlZI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.129.82]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M73WL-1jFuV329iP-00wq6o; Fri, 24
 Apr 2020 14:40:40 +0200
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <0cd63421-3708-ea22-e8ff-5563eb1784d1@web.de>
Date: Fri, 24 Apr 2020 14:40:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:vcZCLwSw0l/iGOGo/dNRbfGf29dEjZPqkbpUT/MZi3z9i904zhP
 VhbyoyLqKN71gUPnAiWGy1Fgljs9AH/YDdavyUuxDoS0WW7ROWOs9pZvORRpH0ymmI2n16R
 FN1DzJOoJDz2tCmYOzB8Ahwd3wL9g9HW+ACnkDc/tP8m28bobdz33cOaHd10J8uCVtACdCc
 wq9AQIMSN3Nj5VRYTpZQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dQFSdQ1XevI=:4lp6ohQLM0edAVldXqLv2I
 A8IXabd3zXuZ3JY86qJPKnKxzj1wM/tlfcTvT9Tr3mnMk2W1mwEeoejBfoAlyetUqgYGjswv0
 4dLKI5vhbjLBlmkTDPMqoe62FqeZOUfT3VJtDq6eRPGRn8mqvqrQpl5id7E966HKr9Bn6qtg+
 Oz8oFM8G4AXUOCQryPmyQQc3Iu5LY3R293jbl6BvD7P5EWG3khcWjvaii/qh7pscVGZY8JYRx
 8FXfl1uqktpnaS+eLzhA9PlDiAgJDRDtm3rgdQDj4t0lcAsAXWyZqTl5XBKQphRqKaqCxLTnt
 3KyM3yLOsWB6KxVJjN5vJ7YSEex6+LWCZuBPG/1OT+FFY3yftlhE6od1kfTinEEZkCiplGzHr
 MeoHiFkE7WZRcZQVXPGAvaqB7vrOERjEJbqcs6oR1s24yP6APfR0YCIZKE9HRFYEeDY+oYJXx
 qfYW7RnylOPs0KZ3ORkKJbUPr/QGR+YQ1dwV/fT7QVsFjnyGgYhw+KkNXBYa4g8TZ/L2LvUjE
 fsRG4E0+loGRDNojlIZuyL68LelVqN1zULRkwxNNJsEd0rco/rwEDcUcHQiyzb0/RVn7LZVwT
 tPfvj+dutODel6ZW29o2ckSgu3pUqoVoN5XWzNzTzixVj6CPK2n1SUcxDZmRZT02bvK7pGER0
 4O/X9RtJoaQbQE4Vwk6QTV3nYyKamj3Wab967sFSQ/2aH9znkOzh6hrG1kT2O4u/A5ZyVbXC8
 Bop1BCfCekrgUB1Oj/MEQKgYQZ2oDKScKE7eA7WZNz4Xcn47typ6NyYNBUUbQBQGKL4yoFyt0
 dxmdL9VijAwveP0xhH/xvvM0Utl29jiBoK+J5mhMytt1R3ztRt4XObiKCw82TU0+kOL2l/6nf
 lMVVnEOfkDLkZUahx9E17GlKLlUuCTCmZXaYFuhuIlfeU96eT/Ram/MYukQazT/Q1Crk1Nttk
 9OozLMVDdWt1wAsyFiDyP5f0GAo49TRg0L3vRaf34ZGQ3XTszThDT2oAtnbW3VcDiw8wzUeEk
 ePm1pO2lDakTNMPjO+9uHLWNjeiz/RhsoBvQjNPRu8jr1LKxaZHG3nunwiy2x9glmok6bEtF2
 PjvG7t6vBmriYTmPxFoHa/v/UgwUkgIfTPmICpL76hz7If/tBCVEiaSEM7oCy96jx2WCuKYf1
 QWlqElvq1FlGQv/Drs74ZDkql+fvbl97qCVjZ9TzfyZLeaOXXgWX15MvdclyFN5VpsYp3FsM5
 ot1MyCNNQBvh+Adaz
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 Apr 2020 14:40:44 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 24 Apr 2020 14:40:41 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [RFC PATCH 12/25] parsing_c: cpp_token_c: Introduce
 MACROANNOTATION hint
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

PiBBIGJldHRlciB3YXkgb2YgZGVub3RpbmcgYXR0cmlidXRlcyBpcyB0byBwYXNzIGF0dHJpYnV0
ZSBpbmZvcm1hdGlvbgo+IGZyb20gU21QTCB0byB0aGUgQyBwYXJzZXIuCgpTdWNoIGluZm9ybWF0
aW9uIHNvdW5kcyBwcm9taXNpbmcuCgoKPiBIb3dldmVyLCBhIHRlbXBvcmFyeSBzb2x1dGlvbiBp
cyB0byBpbnRyb2R1Y2UgYSBNQUNST0FOTk9UQVRJT04gaGludAo+IHRvIGNwcF90b2tlbl9jLm1s
IHNvIHRoYXQgdGhlIHBhcnNlciBjYW4gaWRlbnRpZnkgYXR0cmlidXRlcyBlYXNpbHkuCgpIYXZl
IHlvdSBnb3QgYW55IGRldmVsb3BtZW50IGlkZWFzIHdoaWNoIHdvdWxkIG5vdCBuZWVkIHRoZSBp
bnRyb2R1Y3Rpb24Kb2Yg4oCcdGVtcG9yYXJ54oCdIGFwcHJvYWNoZXM/CgoKPiBUaGlzIGhpbnQg
Y2FuIGJlIHVzZWQgYXMgZm9sbG93cyBpbiBzdGFuZGFyZC5oLCB0aGUgdXNlciBwcm92aWRlZAo+
IG1hY3JvLWRlZnMgZmlsZSBvciB0aGUgZ2l2ZW4gQyBmaWxlIGl0c2VsZjoKPgo+IAkjZGVmaW5l
IF9fYXR0cmlidXRlX25hbWUgTUFDUk9BTk5PVEFUSU9OCgpDYW4gaXQgbWFrZSBzZW5zZSB0byB3
b3JrIHdpdGggYSBmdW5jdGlvbi1saWtlIG1hY3JvIGF0IHN1Y2ggcGxhY2VzPwoKIAkjZGVmaW5l
IFVTRV9BTk5PVEFUSU9OKGluZm8pIGluZm8gSVRFTV9BTk5PVEFUSU9OCgpSZWdhcmRzLApNYXJr
dXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kg
bWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5m
ci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
