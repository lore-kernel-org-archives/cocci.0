Return-Path: <SRS0=tvbf=MX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=BAYES_05,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833CEC4338F
	for <cocci@archiver.kernel.org>; Sat, 31 Jul 2021 19:20:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA73760560
	for <cocci@archiver.kernel.org>; Sat, 31 Jul 2021 19:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CA73760560
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 16VJKTH7016116;
	Sat, 31 Jul 2021 21:20:29 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 439477779;
	Sat, 31 Jul 2021 21:20:29 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BBE7740E2
 for <cocci@systeme.lip6.fr>; Sat, 31 Jul 2021 21:20:27 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:532])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 16VJKRHA023349
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 31 Jul 2021 21:20:27 +0200 (CEST)
Received: by mail-ed1-x532.google.com with SMTP id j2so18429091edp.11
 for <cocci@systeme.lip6.fr>; Sat, 31 Jul 2021 12:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CTnBA4YVtdsQ2zueOH0k1t44+SwnqHWPPajbX5yacWQ=;
 b=kYscRaz/uIVavT0hl7gRAMY6J1gXm1f06TNVqSzspjrrnXDKItLxkQxZOluRxawSE+
 Bfo1jmYRtaTCCzuMmYrrv4evXQE9SKJWwyUQgZOHOrligsNglQWbqTUiVU9kGOED7dlm
 E40rOaaY8dEhAhbUHrp26CYyXK137vP14O59GvoLJE5zM2nYZ/mqqaYtI+hMpoottByA
 yLgQk4ojPjTjyuCPCSzQNtakebJp2q1lHtAzb5zpe810c9hA2a+0LIHrZ6lHlEu922j2
 VbFH+kqZFA0TDbr2gh2W/HSnr2Yysg0dIlhbhJgUjhS7JEgCkFT82UNJDgsVXXBjuAlp
 S0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CTnBA4YVtdsQ2zueOH0k1t44+SwnqHWPPajbX5yacWQ=;
 b=JBPhCK11hk3PNc4jmGTdC6o9tOekdWJU3jXraqRdxtvmvZuGKWw6UmLduwivIMPJ6w
 cvk0416C+L6FRRseseKkSIk9ohStupysI4cjmPEGOW18phmcwJc9syEucfLzZnOnHlSW
 Sv6Vv6sKXgnTUEshbO3N8SD6ia07bB/clFlKbGlIQBw9+lNbue8CPWGaJi82oPYhFa3c
 Wq1kNvP+Gbz0Q5n/opcxe5MbEqpWN27No8lDvSsCKRkfiMDUtbGb3WPVenULBrrCh3+R
 JNlsYcye3kA0HRpsnw2i7YsOeuyPO/Pry4rpN6hiIrjgEoPbFlN7DMYV6CqzxrHCz/P6
 oLoQ==
X-Gm-Message-State: AOAM530x8r3H7ZIL7VDY66UsEI1MpLpVQ+SfxO1/aVh9qYb3I0NKmN07
 4o6/5xc09g+G3Oe946b05hSgR79HRZf28Mny6YU=
X-Google-Smtp-Source: ABdhPJztnjN4TiwZ+F/6ck9KTcVBz4YN7fhFqbNAJLT9iZJAkoQhUXHcXmHAFmhSwAwmy1DOMaU0NL5mU1KtWlSzs/c=
X-Received: by 2002:a50:9e82:: with SMTP id a2mr5877946edf.115.1627759227094; 
 Sat, 31 Jul 2021 12:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAPi140P-O0B+BiAa7i+WbdfmG3HnA3yCZdy4+SeKa=2jRreTyg@mail.gmail.com>
In-Reply-To: <CAPi140P-O0B+BiAa7i+WbdfmG3HnA3yCZdy4+SeKa=2jRreTyg@mail.gmail.com>
From: Mansour Moufid <mansourmoufid@gmail.com>
Date: Sat, 31 Jul 2021 15:20:16 -0400
Message-ID: <CALogXGW+gRjJCo8UiUBNjxnnPEVynZvynhRAxYCr+EpAGzD_Cg@mail.gmail.com>
To: =?UTF-8?Q?Andrew_=F0=9F=91=BD_Yourtchenko?= <ayourtch@gmail.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 31 Jul 2021 21:20:31 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sat, 31 Jul 2021 21:20:27 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] how to make substitutions at the end of the function,
 vs. the end of the block ?
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

T24gRnJpLCBKdWwgMzAsIDIwMjEgYXQgNzowMCBBTSBBbmRyZXcg8J+RvSBZb3VydGNoZW5rbwo8
YXlvdXJ0Y2hAZ21haWwuY29tPiB3cm90ZToKPgo+IEhvd2V2ZXIsIHdoZW4gSSBydW4gaXQsIHRo
ZSAiZG9uZTogIiBsYWJlbCwgZXRjLiBnZXRzIGluc2VydGVkIHR3aWNlOgoKRXZlcnkgcmV0dXJu
IHN0YXRlbWVudCBpcyB0aGUgZW5kIG9mIGEgZnVuY3Rpb24uIDspCgpJIGRvbid0IGtub3cgb2Yg
YSB3YXkgdG8gbWF0Y2ggb25seSB0aGUgImxhc3QiIHJldHVybiBzdGF0ZW1lbnQgaW4gYQpmdW5j
dGlvbiwgbWF5YmUgd2l0aCBzY3JpcHRpbmcuLi4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlw
Ni5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
