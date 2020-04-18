Return-Path: <SRS0=jj0h=6C=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ED5C2D0EF
	for <cocci@archiver.kernel.org>; Sat, 18 Apr 2020 10:19:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D33CC21D7E
	for <cocci@archiver.kernel.org>; Sat, 18 Apr 2020 10:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33CC21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03IAJRka017362;
	Sat, 18 Apr 2020 12:19:28 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 983E5781A;
	Sat, 18 Apr 2020 12:19:27 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1A5E43DC8
 for <cocci@systeme.lip6.fr>; Sat, 18 Apr 2020 11:00:33 +0200 (CEST)
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03I90V9r005313
 for <cocci@systeme.lip6.fr>; Sat, 18 Apr 2020 11:00:32 +0200 (CEST)
Received: from linux.localdomain (unknown [113.200.148.30])
 by mail.loongson.cn (Coremail) with SMTP id AQAAf9Axb+iYwZpetVEpAA--.8S2;
 Sat, 18 Apr 2020 17:00:10 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>
Date: Sat, 18 Apr 2020 17:00:08 +0800
Message-Id: <1587200408-32602-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Axb+iYwZpetVEpAA--.8S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gry7KFW5Zw1xWFyxWrWxJFb_yoWDArXEkr
 40q3W8Xwn3KrsxJF1kJr4rtr4qkw4rAayjkw48GF4ay34xWF45ZF43XasxJF1jk3yq9FyD
 GFW0qFs5Ar1kujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
 0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4f
 MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
 0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
 wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
 W8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
 IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjwSdDUUUU
 U==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 18 Apr 2020 12:19:29 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 18 Apr 2020 11:00:32 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sat, 18 Apr 2020 12:19:26 +0200
Cc: Xuefeng Li <lixuefeng@loongson.cn>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH] scripts: coccicheck: Fix invalid download link
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

When I use coccicheck, it fails with the message "spatch is part of the
Coccinelle project and is available at http://coccinelle.lip6.fr/", but
I can not download the source code of spatch due to the URL [1] was not
found on this server.

Use the download link of GitHub mirror directly to fix it.

[1] http://coccinelle.lip6.fr/distrib/coccinelle-1.0.8.tar.gz

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 scripts/coccicheck | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index e04d328..14608a8 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -11,7 +11,7 @@ DIR="$(dirname $(readlink -f $0))/.."
 SPATCH="`which ${SPATCH:=spatch}`"
 
 if [ ! -x "$SPATCH" ]; then
-    echo 'spatch is part of the Coccinelle project and is available at http://coccinelle.lip6.fr/'
+    echo 'spatch is part of the Coccinelle project and is available at https://github.com/coccinelle/coccinelle/releases'
     exit 1
 fi
 
-- 
2.1.0

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
