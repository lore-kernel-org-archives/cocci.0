Return-Path: <SRS0=dAPZ=ZA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59F2FA372C
	for <cocci@archiver.kernel.org>; Fri,  8 Nov 2019 15:41:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD78D21D6C
	for <cocci@archiver.kernel.org>; Fri,  8 Nov 2019 15:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="WcwLtNQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD78D21D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA8Ff0Gc011897;
	Fri, 8 Nov 2019 16:41:00 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6AC4277D0;
	Fri,  8 Nov 2019 16:41:00 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7FC3E77C6
 for <cocci@systeme.lip6.fr>; Fri,  8 Nov 2019 16:40:57 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA8Feugp006610
 for <cocci@systeme.lip6.fr>; Fri, 8 Nov 2019 16:40:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1573227625;
 bh=2ywaOwHDVLlh9ifZ286y03cpxtest5b0HN74fYFRzAQ=;
 h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
 b=WcwLtNQ5ac4KUjSHIGAomiXlEPw7oOXrjpeXIRtJ8PeV1sj1Om7nofL07GyNmGJpO
 0DGm6J1wzeK2IWNj0FLh4rf1j4+37cv0T4xNMxEEW41bd3faLtVhCVa+qYu0umhRSL
 ZRb7d+EzssUE6bo5RpuPpJ9QlWa8sZPufwUMMlZ8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.72.105]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M3jwL-1hbxkn3SID-00rKDl; Fri, 08
 Nov 2019 16:40:24 +0100
To: linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leonro@mellanox.com>,
        Lijun Ou <oulijun@huawei.com>, Wei Hu <xavier.huwei@huawei.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <0e7f1ff5-eb17-530e-45e9-920ce183a10d@web.de>
Date: Fri, 8 Nov 2019 16:40:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:TT3P7eKfUrbKNROoCKeVghsllQXgcUMYfmCYC34e8vbSD3yPPM6
 ckF+xddQPOr6eC9Gd5u7na/L+FK9qEroyR7s4H6In6hXdxk7rJ+xBq3mlePagfqTCh5Qtpb
 lzjrrifmAGVzfxXe+pA1/bqJ8TxI9vagG0e840ISkP2xMfDmJXnfKBzp7143QIAhXiYYJXM
 RoFB30GY9qQqsMhWdc5UQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b51CUjWZVdM=:rCwsWWto5ES7cthTQZgnmj
 +wV45eF+3FafRLZxbmqDPZdzEeoUYbY4kZYQD2fOhYC0L+e4SE6nxLEKdwOWxQ3VrjYs0biU/
 BsG2PIsoFTgmLOOYvZHlXF9hh2OY6sqh2hgb6F8J2cfSmw3acYuQJEF9hePXoOVNLAC5hfUIK
 D++bfREgZYg65/cMKoNvwpNlB3yeuKeMuQbUkFAoee3gv4hg5Qryz2EHyyyIia/Bqyk5dOqmN
 SlAQmq3EQ5Q9wwL6CH/oSNCV5zhB7oO2QMYSD/AM3iTviHXU2EI6uX7aTE62+D1w9xam8mKFl
 lQjp4T495+nqQQhWju18d0DpAEb9LkaJH1HddoHyGM/cjSqLxp7C/KPkjFvKusitjuVd5EsgQ
 n9z1tVhCVGjI5pPj87jUMSFo+d/KLtaNcUbq0b9llIRSxlfSjZn1l2OuOFUW5Ab8KDIovkw4a
 /f9pzAF72OBm3xHL923KJhJH/BDrJVEBYyHRw1eIYfdP4ee/wdXaAbum0rRO984nHpgW4OQCW
 q16loScsDQzfg4TOI0aoViKWhjZW3RaaN8FfOYf2o4VVHvmvUJ0YT/onOJdZjOnG/6v0GlKNS
 9M+CveW1fjoNHlvitxDLYBt1Q58G1dDaESoIItMuO2utkLqkAdI4JJa6S9VxcGbgEd4WbNBIc
 KU9wvrEI1VYbMWHKvZ+wQNkovr6cMrUU9jGhyZIkRt6voZ9CdptNoiyT5uuMmBwo7LK688mE2
 l0mW8+NXVDg8lLM3zLoc01X1pMwtjK0AiNWz+2BxGu5wSneNqu5gmIOHp9vPgX137YdsjYlxn
 La2st376gSI/HP+bgzgcp1DjHFkpaLmxXoNCXRwPTvH/XgLvT3kmiAM6D5rsJhQL2VTBO93td
 regjx8mmFkoI6I0c4yCKvadB8AWEwTNrHDIMM7iiJ9TTvVLM8l+LhPXTjD5laoTKcXXaYykcN
 p+1N634YiLTF36nCZ4nm9xk6WQbflW61e5KzzI6o6Omz+MNv1IydNKQwp9zeTNbO8dNxXtQkP
 Sy9N4FfIZx4JSEHdcDTiPpEXXjfPDwRjd0F9NWv4QyWnJDTRulpN7lCb9BMrHDSNIYDQl+y/G
 qPfWSsgMeLm9/fhC57/lDUTdzHfpeBwmiUO7VLItXrA4MXeuO0fYOzW9y8gYN1qGvSku7LoGb
 crAX61+h6YWqC0lthSIKpQ4wxiwZG4QWcolmmU2x0GY8DXtrx6zKX5jSe0UnL8Q2NLv2buWB0
 Ux+7zonCEGo8QHq3YWywJlrgeTZKIXjNYBpke3ciDbUoHbay+QodiSIjx7t8=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 08 Nov 2019 16:41:01 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 08 Nov 2019 16:40:57 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [Cocci] RDMA/hns: Checking two kfree() calls in
	hns_roce_v1_release_lp_qp()
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

A coccicheck run provided information like the following.

./drivers/infiniband/hw/hns/hns_roce_hw_v1.c:901:1-6: ERROR: invalid free of structure field
./drivers/infiniband/hw/hns/hns_roce_hw_v1.c:903:1-6: ERROR: invalid free of structure field

Generated by: scripts/coccinelle/free/kfreeaddr.cocci

See also:
* Commit e39afe3d6dbd908d8fd189571a3c1561088a86c2
  ("RDMA: Convert CQ allocations to be under core responsibility" from 2019-06-11)

* Commit 619122be3d40c835eb5fad9e326780909926495d
  ("RDMA/hns: Fix PD memory leak for internal allocation" from 2019-05-21)


How would you like to handle such details further?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
