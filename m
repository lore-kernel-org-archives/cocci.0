Return-Path: <SRS0=4B11=3Y=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA87C2D0B1
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2020 13:03:05 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A50820730
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2020 13:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="m4OBVwid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A50820730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 014D2pQA024909;
	Tue, 4 Feb 2020 14:02:51 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 70A4277EC;
	Tue,  4 Feb 2020 14:02:51 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 129E277E8
 for <cocci@systeme.lip6.fr>; Tue,  4 Feb 2020 14:02:50 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 014D2ntS021365
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 4 Feb 2020 14:02:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1580821368;
 bh=XqCKd/vsyb+/OAzFGzKsTNMajyjXApTLXjPOM3B7aK0=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=m4OBVwidRctscXTDijw7Dg++G2wLObV49aITSR/UpV0Hy2hnLU+kdm+PJ2SmJjQNj
 ShHKXOfDQtMUwmGcU4XBTnI3wDPwkcqFTz3TvOz2HTIWVw9VPVOAhpt8c5w76i082w
 CEhTrFUOdDufJQchgJtfKKlDrQhghcjplAi6tiRM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.133.16]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LdVha-1jQ0vi3Dpi-00iie6; Tue, 04
 Feb 2020 14:02:48 +0100
To: Wellington Wallace <wellingtonwallace@gmail.com>
References: <72729ef6-f8df-942f-57aa-4b3fac75a20d@web.de>
 <CAAJnyheEpd44ShTijdOAq6QZ9dyjJ387dcJDHg5qcd4aN90PYw@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5fe198eb-2e43-4ae3-f82a-e7bcfc394623@web.de>
Date: Tue, 4 Feb 2020 14:02:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAAJnyheEpd44ShTijdOAq6QZ9dyjJ387dcJDHg5qcd4aN90PYw@mail.gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:O+Fta5OFHSnQiv4g76vMPdyDRxeLMOjDih0w1WnZjHl4c2I0MbP
 eu5YhrdsDiMq7tNZJl9JTZ7wwLBpXeZlM6hY+xTxOinnpy6DfItDx0OQfViSxtgECZjzSZP
 2sBj3uTFVHd49v+iwSTwFmxEIc6rD+qkt0aQ5OMNRB8eRV5EWVlv6XVBIdctNf7E8uEiJvQ
 KdSuPeVL85LHcLeIj+Xgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kdMl2Z7+jhw=:CEPN7xIO9IXm9FHiQfcbZ9
 +Wf6iecKIwn6fVp2jAsxs9NoE8e7L6dth+V3j6rxYgAd6LwVMsQrtbnyFABSPvtXDUtngcKFD
 GUlkhUoVf4N9GRgm1KcSD2ZeHuwEmjTV/GoZ1xQEcFlg7KFqstQ+mHbSO5u/yrrW1cGhBQ9tl
 h8+3Bp3BUQ+DbMMRbUDf4Z2Vyn4pyzZqexGm0+/ZcZ9pGM5u0ulmfsdm8Li+pRgJOg5DX6H80
 Ea88lNiRL9/hR7gttwheHzH1jWk+VsawJkWnsIFUBgl5EUuyC+bXh83nliAE3EZIu2krD6OUu
 NJGsOvw1KDNpOWLpG+cSZNAB4oCR4/4wyzN5ocMFX9+rjtSfN9jNpZYjxYIUxHlZ1F3ZXCdNL
 AsoLwCd0eWCd2vx71VE+Pm+MWGr7mfVEykPx/kyfY/ztbSqpAU28nM8Z3vdjZB5yilBe1xLuj
 3EaVhu+7LvhU/9KCcgy+2T6xkb6M1kytsAFlKbgIg2QIRMzNpE/RfRWVkVosSvu3/GRVGg9FK
 CES1p5ngeVG+Gu8j0QLYYwYWHbjYZWsSnRgRLtDjAUld9/MbkVRaJJtma/gPxiQ+OiMhuwnK+
 KTmZKSqLQ8KNvXgyzx9pcTEXfXxYDREvVY+5A6OwzxWbN/oky4uGUEHX+/9rqyMzsCT3wRj98
 5XQH1wtKRNU1zcuLlBENlac/fxTbuW3K2BseuKXQ0AWifmwqf8digQs1DJX83QCprciSqvHVk
 vTDd2WLdBIgP3ogVoOkJCRxhj6PX2Q12WTu6xIU7RvRro6wF8xzObbniMMZ3DxnztQ2tT1zST
 U2QIdPAtwnMh0HlCGlL7Lucneh7XTzeWCICkHcbhf+XlAhGKags21JPtrB2eM4BGtNyyENA85
 hKBx9GTd1YoxVZqGjaJOjMrMPM27zd8I5f+DgCrwl2A44jOcdzG7/yS9MGDWY5UPgXjZdX8yY
 ZN+Mjjhi67+nqOfcHRlzDFRiUcOG8X3JEbI2niRr3Wg4g7shsK/gZcuVjF+YzCExCvE+mnY2/
 A69+ZVnIiuHO7FISmKtEAlFwEEp6yLiQIJp9hET8EbQrNLTbjYm14j70J4Mxc/zSTdlJjw5kq
 +IFCsSASRjiqLaPdWkBpeUJwtgil0rKmwYvOtuObjrzK16khpWUdvnTVQOFJZPdw9OQn7gRlf
 j051d0Z7iobQo5zUu2Gr7ZJmjeYmOxyNKnP5ySnBrR4bZjv8BT2J+c+OPEEwWba6nCGLWx7X0
 HHvWyNRtUHapyKd8W
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 04 Feb 2020 14:02:51 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 04 Feb 2020 14:02:49 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Replacing a std::string check by strcmp() with SmPL
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

> The strcmp output has to be compared to zero strcmp(src_name, "equalizer_input_level") == 0.

Would you like to let the following script for the semantic patch language
perform any changes in your source files automatically?

@replacement@
constant c;
identifier text;
statement is, es;
@@
 <+...
 if (
+    !std::strcmp(
     text
+    ,
-    == std::string(
     c
     )
    )
    is
 else
    es
 ...+>


Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
