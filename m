Return-Path: <SRS0=j0GG=MN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D5EC6377A
	for <cocci@archiver.kernel.org>; Wed, 21 Jul 2021 21:45:13 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF69C61208
	for <cocci@archiver.kernel.org>; Wed, 21 Jul 2021 21:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF69C61208
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mykolab.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 16LLj6Vr009970;
	Wed, 21 Jul 2021 23:45:07 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 261BC7783;
	Wed, 21 Jul 2021 23:45:06 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BA6B541F4
 for <cocci@systeme.lip6.fr>; Wed, 21 Jul 2021 23:45:04 +0200 (CEST)
Received: from mx.kolabnow.com (mx.kolabnow.com [95.128.36.42])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 16LLj3of013602
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 21 Jul 2021 23:45:03 +0200 (CEST)
Received: from localhost (unknown [127.0.0.1])
 by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 175DD405B8;
 Wed, 21 Jul 2021 23:45:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mykolab.com; h=
 content-transfer-encoding:content-language:content-type
 :content-type:mime-version:date:date:message-id:subject:subject
 :from:from:received:received:received; s=dkim20160331; t=
 1626903901; x=1628718302; bh=clzZMhoQ8GBkNIxDPUVNVhNmVrcDv7WNd3j
 BrhLp+rg=; b=D8xrXL7WaXvDBs47lqL+qMPiGHdtBrFnSkD6784NB0VqZ2QDAkn
 msq3ssnjoDwFDmgSGs5HaBEpWglmM8Omgz05umGt6+07LAnmzKHk+5BB5JNfeEUQ
 TBx06qxCp4H4NYoW1mjTOoVp/M4P1xLrN7IrWe4A6mIhRGy1cMzDxJzlgyaUVzPI
 I2LI3woHyCMrkbu07hEAYfBWvQgL2GZNvsoT7/v0zeNDj3D0nBpP/60T8cDCDs+2
 lYhvTsdpdiaUwNicC8T9fCXhIcgnNnthJGGZwqTxc1b88N9943jFh1i4xzsXAW7f
 oVZ09rahXUWZ8W+fqHaEj82YsWMbyhodx4ZXyn8NHgbpytrtJwccxGSgCucstQAG
 KOL0tkMfk4Bx1oD8JnLV/DryU1tx1cuR9SR0EDoZbwFxpwtepzKUC+OZP1Qn6F8k
 lNO7HDKiDzQys6Wzu7bG2VqS06Un/5D3RIOqvf/o2PrulQ3R5R4nxuU0wcNee9et
 ntCGyAOIG++wWK+UxsK8CISPpGp1Aeajlm6NxGvckiZuVEiFF5HRZ5XY9H2R6co6
 kC8Ko3iPEdwzIRQj6jBgIa3tEnurz3J+nLEkU5WjUbLrggUkrjM1tfVdanOfEWN6
 8uFv7/sEJ/XdXPUurpV0Yv+JbSNYyVo6jTB+00RaerqNGEUV0YRsocaY=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iUiovKTWWPr5; Wed, 21 Jul 2021 23:45:01 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
 by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id A91FE40589;
 Wed, 21 Jul 2021 23:45:01 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
 by int-mx003.mykolab.com (Postfix) with ESMTPS id 456C5469E;
 Wed, 21 Jul 2021 23:44:59 +0200 (CEST)
To: Coccinelle <cocci@systeme.lip6.fr>,
        Thierry Martinez <thierry.martinez@inria.fr>
From: Michael Stefaniuc <mstefani@mykolab.com>
Message-ID: <f2dcf263-6c6b-9bd5-7f60-2baeb64947b4@mykolab.com>
Date: Wed, 21 Jul 2021 23:44:48 +0200
MIME-Version: 1.0
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 21 Jul 2021 23:45:08 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 21 Jul 2021 23:45:03 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Regression finding standard.iso
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

Hello,

to configure coccinelle I'm using:
./configure --prefix=/usr/local/packages/coccinelle-`git describe`
After make install I just link the binaries to /usr/bin/.

Now I'm getting following warning when running spatch:
warning: Can't find default iso file:
/usr/local/packages/coccinelle-1.1.0-50-g9e111ad5/bin/lib/coccinelle/standard.iso

standard.iso is searched now under $prefix/bin/lib instead of the correct
$prefix/lib.

Reverting this commit fixes the issue for me:

commit 5016596228804588c96f0059818dd937e636d7ab
Author: Thierry Martinez <Thierry.Martinez@inria.fr>
Date:   Tue May 25 14:26:18 2021 +0200

    Fix GH#259: Use @libdir@ for path, substituting ${exec_prefix}

    Substitution is performed in OCaml since it enables tool relocation.
    Looking for "${exec_dir}/standard.iso" first is kept since it is the
    expected behavior for running the tool without installing it.



bye
	michael
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
