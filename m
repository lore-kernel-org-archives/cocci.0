Return-Path: <SRS0=qWDJ=5C=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C83C10F29
	for <cocci@archiver.kernel.org>; Tue, 17 Mar 2020 10:33:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C43D820663
	for <cocci@archiver.kernel.org>; Tue, 17 Mar 2020 10:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="OV8Lvn2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43D820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02HAXJeb006760;
	Tue, 17 Mar 2020 11:33:19 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B7CAF7808;
	Tue, 17 Mar 2020 11:33:19 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C17D53B93
 for <cocci@systeme.lip6.fr>; Tue, 17 Mar 2020 11:33:18 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02HAXInC028033
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 17 Mar 2020 11:33:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1584441196;
 bh=4oERE7azR0OtnHb3r760SuWJ8PzvdSvWgoKM4xD75GQ=;
 h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
 b=OV8Lvn2HO3yHfdF75CV0WRXcDCDFqL8U+jorseeCISuhRL3SOwpJFIukUN1DoSgnV
 4KKTiAvUoyc5I9hGmGgMUiZT1gHlWWgpQYbHQDpEIIb/io3yCJBQxd6H/vS/BY15lx
 Z4Mjzo8Mw8QfWU4QMgGYPE8ia/AuMi1+i8dsaYbw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.173.244]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MV4TZ-1imz4A3ym5-00YUGO; Tue, 17
 Mar 2020 11:33:16 +0100
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, cocci@systeme.lip6.fr,
        linux-kernel-mentees@lists.linuxfoundation.org
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <017e523a-eee3-1e2d-c4e7-4cf0f813547a@web.de>
Date: Tue, 17 Mar 2020 11:33:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:UF4l2L6WcY6u5EoEzdiB5+ZrdVpNha3QshA5VmJienObNdmJakM
 ZiDcNX+t4seNob5ACbuIfAwy+1a9f3gCapmuqjVU0HQKhfSsgcgPIGmI3h77Au2ffPZN3Rp
 hHNk6xRKDWLu+Hx4h2VM79nsMdQxgiy9WidimqQGCWDtJU7Xv5ikh0ScrfZuUl9Ysi9yqHc
 WcZf/53k61cuZ86nEI+Ow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rTnGbq+5CEg=:NVxA79p5JPlitzn77z0hUn
 EQGW+Qz6Fk36+g4GSqRUDSWlht9w3puCM6MVwqM6xxv+UeNaBxN4EQ1bkx+072li8opRoAXjp
 FvpfGHseaGrjttbfJa22JUHBSc1i6U6qvEVZgDrG8cSFTKgcuHUIuZtwikfF14CODeEg41Kur
 Q5ep2FCFaAECcffSOYCRnPsGakxYRp7+P7jF27+SGXTRPkVfZJrTR78br6eHA875eGiS0uEQH
 Z0nMMQkGA1Vcb/gomM+Wko85n6mKTPZkGnLL7oiIRk+yBghs6utcmNkKdQPYYV9iSoqU0+Qo3
 9uvVLInnJvlJEKVLbdyhfuTrkE4rGuyHJAuw4WqEDc942iICV5UjIH6FZ4WPLGJTR3SHdkWis
 cNFbqVNatiHQ9xNX+CYYjT6dgkB9Lfho5qTnryGvAMGDRjgckSxOyWc56mK7vxngBo7FEibAR
 q4JCRCcFdTFu7ZXa3cz6xTkvtn5YdLM+FM5w7wkfQqBApCOucP2fiVm+jl7GEKHRXnzhpwbLT
 mmGiwlqxivpze3DNmIzQy+RqiTgpmgBSePCKD1QwUTzmi5mdLc7/To7QwZicpDV4grR7hsVIC
 jWgnFhO3cihkHlhKmA/sgxERw6+n74KWYig4Bev5HKF66cqXx3tBW+AzSQzY0zj9qtydfH/qs
 haX0568prWBT/d8Yv5qAbNa7MlFOgGY7CBsIKgoa/I7nWB805UvEcE0BKaxaFyzFZ1qnv7USQ
 A9ZkDTAUsrVkRA1XQUZyaMlGMjBdSLFRCmcexiDvCHkXBMPHv95m6j565O6RIu9sGk83UoavK
 suSaoZ48m5FP4vBidVjvenHX0gcYKCtPp3hNst29FsFzNrxRfOL+jLI7nnpkKFoHhFHF+52GW
 ToB17pvgiWr9+SPp+RKuex/fIg6KiSnu0lmj/0CxOHl7qBKqlvWM+R0/ffSt8GksNknRQp5Al
 eShRj4ti9fRCUt5S1411+yy/kJPYTtx265qzyviwZIF064AITbQww5Jln8XWDJdd4D4dDZG3g
 tNT8PDhsUWwIQIPfcf7Xj5XIpFzU/luKa2k5FZ1FzhhDkeTvyOO4/avV/HHyy4zCugnYiER8e
 Cy2u1rMAKhnI+D50GCeck4fyOdo6DHTxcQcf9Ld8+rG1ZAmNG6o0qjwBpNJ3UGUKok9y0/rXo
 jCDzusPyUFRMeSNxcEEohewxMrXbD1QvNb04NIiNYtuR4T8y+8JhVrNG5jKQCWTZJKA0h/P5e
 potl9NG2e0vzCMWuO
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 17 Mar 2020 11:33:20 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 17 Mar 2020 11:33:18 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: Re: [Cocci] [Linux-kernel-mentees] [v2 05/26] parsing_cocci:
 visitor_ast: Add cases for ParenType/FunctionType
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

> One of the hardest things in dealing with a community is to learn who to
> ignore when it comes to patch reviews and comments.

I suggest to reconsider also this information once more.


> Just a friendly reminder that this person is on many upstream kernel developer's
> email-block lists due to the ability to cause huge time-sinks

Some clarification attempts will trigger the usual efforts.
I hope that our communication difficulties can become more constructive
often enough.


> for no valid reason.

Please take another look at the published software development statistics.

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
