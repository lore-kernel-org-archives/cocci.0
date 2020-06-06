Return-Path: <SRS0=zMkO=7T=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF28C433E0
	for <cocci@archiver.kernel.org>; Sat,  6 Jun 2020 06:00:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C43C207D5
	for <cocci@archiver.kernel.org>; Sat,  6 Jun 2020 06:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="gNCGfebt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C43C207D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05660f3V001921;
	Sat, 6 Jun 2020 08:00:41 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5B6A95D47;
	Sat,  6 Jun 2020 08:00:41 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0B04A3BAB
 for <cocci@systeme.lip6.fr>; Sat,  6 Jun 2020 08:00:39 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05660bkL010080
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Sat, 6 Jun 2020 08:00:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591423234;
 bh=H1Ao6vP9lU9EngLrseK+nBm2ub0kJKTgSlPISojb9Fc=;
 h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
 b=gNCGfebth34IK5pFJBE9pLGSTqQJ5oOHDcK6xbnOs54+Glwmobfu+iHqs6TWgy8Mv
 Tg+oyGvX+0UO3oVjx+rxcF/ORcHju56yAliVMj9ro6eGznniks3bdy0LJ3Lw0vWkqG
 faA04T7UYmIF56406SiX1L4SkTX6FNxpT1C0uQ20=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.40.239]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2BI2-1ixzPY0HuQ-013cVF; Sat, 06
 Jun 2020 08:00:34 +0200
To: Julia Lawall <julia.lawall@inria.fr>, Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <e10d3917-da30-94d6-9f41-b0343daf3e23@web.de>
Date: Sat, 6 Jun 2020 08:00:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:YRbsCH7PYA848quT921A20ta+BtCVKbtvkjQLNMZwo7UgvP3arS
 oHuP2hBrrwCnlVaRqTvnOTmPuvoFqEh6z1JmUhrU5aAU4cQkiplI9k8d3RTD+SLTQpHTT9b
 ED5mg4NfN4xxinp5O9BUr60e4P31u3MfMsAzjN3KPBriyPpZw/jqSfxzSphk6Ihunh5hvaD
 BsVxfZZUC2NS8qAZt03vg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CMT8fhY/qqs=:oHylNa2ezW901Ss5jsFNbz
 KqHJbN0AAXIwlFx6sc0SnCABecSqlWMrHLxA3JP/bi636I89HYqCOR3kqKdCelcFqMzBuuV/h
 nke0fBo4HGiXYxda7Cy2jA+GrY8pSfE0N08DOTXnl3vyNkxEXmTGMuiVX8wpMXYt9cq/7+DAj
 fmo9aiN7rkuyr4mkKSzwtbn3QZHJAgPMJuvGLytQcRgQeYa1Gu9T/6cXGy7VnKasAwTmCq9rS
 2TPAGXxcuoGtQFEYcv61H8uDlP230YaM7MDCHPifsYV7H7V5GLcD/C2Jmvneb7jMCldzbHGkL
 TjHS3EP/uzW2QKlvzR+2ikG0cxl63Vu+9Ww/rJ0mc1Q/q0mBAc6qDeV3CRxXTvzwotgJGesVW
 D4Na/k9T/8g29QuINlvPpXMMiNon9dXWA/NDLf56zwG3czQnqUSVB9V1VT8Qp51/pBtQbKKDd
 0EfmguGxtJnNSq1Af1pbbTPVD8yOif7Rvpc7ZaUm8L3kC0yLiVLltjXvPOmdIMaHwS2NGp2ez
 pJem+hmpx5AnsHnxV/uruUJzBn0hQ8kLv/41uCR9NLaegwCkuainsBK5yitE+b2UfVLnXz3jn
 TeV8YbQ9qJQnz64vA7649IKpBIlHAhKsPpYtYsUYffWehxrfXSWVmAPf3crjZd2kyyMpBrqv+
 LFAhKNSk5xpC+IsCKQoSKF4Wcjef9NSkk6YZi7bG+DO4626GGmG/phMvupnbJg8/03xIfSbc9
 6Yj4T8mvMihusUYb1oErlts7rb0hAAJ2/jXdRIlKpOcELW89VQyrnKgrbkoHDAV3t97WqrQiu
 cWIhQZuvZzLITXy6pmLoDdT5z8k9197m6SlHUgXZxv7FwSHJzXZlU5uCXf/EUFLre2EvseZUH
 zSRadRWrjrbYThocHY3s7DPzBzCAz81LvV1+prQ1hNa6/tHB+JXYBRa8MrVlWu/ehuyFKnkv4
 0GGlTY1hCC2MCpJRyGXTFR3JXAJi9CLyE0mYt/VDCxquf6zt2dDsDKxtCDB+w4JyamCiImDAj
 3agqsn8w7sCC716IBsOqs+gRl1HDdwoi6Tvc2mrGV0VahFMASaTF34q9s+aX0naFzrN3LB21x
 3gK5rfzyMrRbZbwiD+wTRLisyjuXl0qJcBrsKRbhuV8T1d96hKPwQ+OBHKgytVpgX1JLHDl+I
 IjcI/6i/3AWKATYEZdXTpkckdWdfHo4TP4xCB8Ns0vU/X7tDoHaeMErclVjQIyZSxvK/qgzXl
 yWyVdhlflLBnxwnR3
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 06 Jun 2020 08:00:41 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 06 Jun 2020 08:00:37 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] coccinelle: api: add kzfree script
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

> Is avoiding transforming the case where E is not verified to be a pointer a concern?

I imagine that answers to this question have got consequences also on
the confidence level for such SmPL scripts.
The desire and requirement to specify data type restrictions (for expressions)
can influence data processing efforts in significant ways.

* If it would be accepted to choose a simpler source code search approach,
  there are corresponding risks to consider.

* If you would like to reduce the general possibility for false positives
  according to advanced software analysis, the amount of data processing
  will increase because information from header files will probably be needed.
  The run time characteristics will become more interesting then.
  Additional program execution parameters will be relevant for this use case.

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
